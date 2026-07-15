import express from 'express';
import session from'express-session';
import { loginUser } from '../services/auth.services.js';
import { loginViewModel } from '../viewModels/login.viewModel.js';
import { asyncHandler } from '../utils/asyncHandler.js';
const router = express.Router();

router.get("/", (req, res) => {
    const viewmodel = loginViewModel({
            username: req.session.username || ""
    });

    res.render("login", viewmodel);
})

router.post("/", asyncHandler( async (req, res) => {
    const { username, password } = req.body;
    req.session.username = username;
    
        const user = await loginUser(username, password);

        req.session.user = user;
        
        res.redirect("/index");
}));

export default router;