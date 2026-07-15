import express from "express";
import { getTransactions, getTransactionsByAccount } from "../services/transactions.services.js";
import { getBankAccounts } from "../services/bankAccount.services.js";
import { transactionsViewModel } from "../viewModels/transactions.viewModel.js";

const router = express.Router();

router.get("/", async (req, res) => {
    const accountID = Number(req.query.accountID);

    try {

        const bankAccounts = await getBankAccounts(req.session.user.id);

        const transactions = accountID 
            ? await getTransactionsByAccount(accountID)
            : await getTransactions(req.session.user.id);

        const viewModel = transactionsViewModel ({
            bankAccounts,
            transactions,
            selectedAccount : accountID
        });
    
        res.render("transactions", viewModel);

    } catch(err) {
        console.log(err);
        return res.render("transactions", transactionsViewModel({
            errors: ["Something went wrong"]
        }));
    }
})


export default router;
