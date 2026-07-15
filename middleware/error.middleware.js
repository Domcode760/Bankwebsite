import { AppError } from "../errors/AppError.js";
import { ValidationError } from "../errors/ValidationError.js";
import { AuthenticationError } from "../errors/AuthenticationError.js";

export function errorMiddleware(err, req, res, next) {
    console.error(err);
    console.log(err instanceof AppError)

    if(err instanceof AppError) {

        req.session.error =  err.message;
        if(err.redirectUrl) {
                return res.redirect(err.redirectUrl);
        }

        return res.render("error", {
            message: err.message
        })
    }

    if(res.headersSent) { // Überprüft ob schon eine res gestartet hat
        return next(err); // Geht zur nächsten err Middleware (Express default error handler)/nächsten gegebener error Middleware im server
    }


    res.render("error", {
        message: "An unexpected error occurred, please try again later."
    })
}