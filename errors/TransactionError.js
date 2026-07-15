import { AppError } from "./AppError.js";

export class TransactionError extends AppError {
    constructor(message, redirectUrl = null) {
        super(message, redirectUrl);
    }
}