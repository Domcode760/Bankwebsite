import { AppError } from "./AppError.js";

export class AuthenticationError extends AppError {
    constructor(message, redirectUrl = null) {
        super(message, redirectUrl);
    }
}