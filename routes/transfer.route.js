import express from "express";
import { transferViewModel } from "../viewModels/transfer.viewModel.js";
import { getBankAccounts } from "../services/bankAccount.services.js";
import { processTransfer } from "../services/transactions.services.js";
import { asyncHandler } from "../utils/asyncHandler.js";

const router = express.Router();

router.get("/", asyncHandler( async (req, res) => {

    const bankAccounts = await getBankAccounts(req.session.user.id)

    const viewModel = transferViewModel({
        bankAccounts: bankAccounts
    })

    res.render("transfer", viewModel)

}))

router.post("/", asyncHandler( async (req, res) => {

    const {toAccount, amount, selectedAccount} = req.body;

    await processTransfer(selectedAccount, toAccount, amount);
    req.session.success = "Transfer completed successfully"

    res.redirect("/transfer");

}))

export default router;