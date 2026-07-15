import { con } from "../database/db.js"

export async function getBankAccounts(userId) {
    const [accounts] = await con.query("SELECT * FROM bank_account WHERE user_id = ?", [userId]);
    return accounts;
}

export async function getBankAccount(connection = con, bankAccountId) {
    const [account] = await connection.query("SELECT * FROM bank_account WHERE bank_account_id = ? FOR UPDATE", [bankAccountId]);
    return account;
}



