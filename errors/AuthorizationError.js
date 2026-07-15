import { AppError } from "./AppError.js";

export class AuthorizationError extends AppError {
    constructor(message, redirectUrl = null) {
        super(message, redirectUrl);
    }
}