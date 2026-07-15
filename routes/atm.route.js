import express from "express";
import { atmViewModel } from "../viewModels/atm.viewModel.js";
import { processATMTransaction } from "../services/transactions.services.js";
import { getBankAccounts } from "../services/bankAccount.services.js";
import { asyncHandler } from "../utils/asyncHandler.js";

const router = express.Router();

router.get("/", asyncHandler( async (req, res) => {
    const { selectedId, type } = req.query;   

        const bankAccounts = await getBankAccounts(req.session.user.id);

        const viewModel = atmViewModel({
            bankAccounts,
            selectedId,
            type
        });
        return res.render("atm", viewModel);
    } 
));

router.post("/transaction", asyncHandler(async (req, res) => {
    const { selectedId, type, amount } = req.body;

    try {
        await processATMTransaction(selectedId, amount, type);
        req.session.success = "Transaction completed succesfully";

        return res.redirect("/atm");
    }
    catch (err) {
        req.session.error = err.message;

        return res.redirect(`/atm?selectedId=${selectedId}&type=${type}`);
    }
}));

export default router;