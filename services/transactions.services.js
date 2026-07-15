import { con } from '../database/db.js';
import { getBankAccounts, getBankAccount } from './bankAccount.services.js';
import { TransactionError } from '../errors/TransactionError.js'

export async function getTransactions(userID) {

    const rows = await getBankAccounts(userID);
    const ids = rows.map(r => r.bank_account_id)

    const [transactions] = await con.query("SELECT * FROM transactions WHERE to_account IN (?) OR from_account IN (?)", [ids, ids]);

    return transactions;
}

export async function getTransactionsByAccount(bankAccountID) {

    const [transactions] = await con.query("SELECT * FROM transactions WHERE to_account = ? OR from_account = ?", [bankAccountID, bankAccountID]);

    return transactions;
}

function validateTransactionAmount(amount, redirectUrl) {
    const numericAmount = Number(amount);

    if (!Number.isFinite(numericAmount) || numericAmount <= 0) {
        throw new TransactionError(
            "Amount must be greater than zero",
            redirectUrl
        );
    }

    return numericAmount;
}

export async function processATMTransaction(bankAccountId, amount, type) {

    amount = validateTransactionAmount(amount, "/atm")

    const connection = await con.getConnection();
    console.log(`Processing transaction: ${type} of amount ${amount} for bank account ID ${bankAccountId}`);

    try {
        await connection.beginTransaction();

        const [account] = await getBankAccount(connection, bankAccountId);
        if(type === 'withdraw' && account.balance < amount) {
            throw new TransactionError(
                "Insufficient funds",
                "/atm"
            )
        }

        if(type === 'withdraw') {
            await connection.query("UPDATE bank_account SET balance = balance - ? WHERE bank_account_id = ?", [amount, bankAccountId]);
            await connection.query("INSERT INTO transactions(from_account, to_account, amount, type, status, created_at) VALUES(?, NULL, ?, ?, 'completed', NOW())", [bankAccountId, amount, type]);
        } else if(type === 'deposit') {
            await connection.query("UPDATE bank_account SET balance = balance + ? WHERE bank_account_id = ?", [amount, bankAccountId]);
            await connection.query("INSERT INTO transactions(from_account, to_account, amount, type, status, created_at) VALUES(NULL, ?, ?, ?, 'completed', NOW())", [bankAccountId, amount, type]);
        }
        
        await connection.commit();

    } catch (err) {
        await connection.rollback();
        console.error(err);
        throw err;
    } finally {
        connection.release();
    }

}

export function validateAccountsForTransfer(fromAccount, toAccount) {

    if(fromAccount.status !== "active" || toAccount.status !== "active") {
        throw new TransactionError(
            "One of the accounts is not active",
            "/transfer"
        )
    }

    if(fromAccount.bank_account_id === toAccount.bank_account_id) {
        throw new TransactionError(
            "Can not transfer to the same account",
            "/transfer"
        )
    }
}

export async function processTransfer(fromAccountId, toAccountId, amount) {

    amount = validateTransactionAmount(amount, "/transfer");
    
    const connection = await con.getConnection();

    try {

        await connection.beginTransaction();
        const [fromAccount] = await getBankAccount(connection, fromAccountId)
        const [toAccount] = await getBankAccount(connection, toAccountId)

        console.log(fromAccount)
        console.log(toAccount)

        if(!fromAccount || !toAccount) {
            throw new TransactionError(
                "Bank account does not exist",
                "/transfer"
            )
        }
        
        validateAccountsForTransfer(fromAccount, toAccount);

        if(fromAccount.balance < amount) {
            throw new TransactionError("Insufficent funds", "/transfer")
        }

        await connection.query("UPDATE bank_account SET balance = balance - ? WHERE bank_account_id = ?", [amount, fromAccountId]);

        await connection.query("UPDATE bank_account SET balance = balance + ? WHERE bank_account_id = ?",[amount, toAccountId]);

        await connection.query(`INSERT INTO transactions (from_account, to_account, amount, type, status, created_at)VALUES (?, ?, ?, 'transfer', 'completed', NOW())`, [fromAccountId, toAccountId, amount]);

        await connection.commit();

    } catch(err) {
        await connection.rollback();
        console.error(err);
        throw err;
    } finally {
        connection.release();
    }
}

