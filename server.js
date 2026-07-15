import express from 'express';
import session from 'express-session';

import { localsMiddleware } from './middleware/locals.middleware.js';
import { authMiddleware } from './middleware/auth.middleware.js';
import { errorMiddleware } from './middleware/error.middleware.js';

import atmRouter from './routes/atm.route.js';
import authRouter from './routes/auth.route.js';
import transactionsRouter from './routes/transactions.route.js';
import transferRouter from './routes/transfer.route.js';

const app = express();

app.use(express.static("public"));
app.use(express.urlencoded({ extended: true }));
app.set("view engine", "ejs");

app.use(session({
    secret: 'mySecretWord',
    resave: false,
    saveUninitialized: false
}));

app.use(localsMiddleware);

app.use("/login", authRouter);

app.use(authMiddleware);

app.get("/index", (req, res) => {
    res.render("index");
})

app.use("/atm", atmRouter);

app.use("/transactions", transactionsRouter);

app.use("/transfer", transferRouter);

app.use(errorMiddleware);

app.listen(3000);