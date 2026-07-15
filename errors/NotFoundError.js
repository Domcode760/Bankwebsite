import { AppError } from "./AppError.js";

export class NotFoundError extends AppError {
    constructor(message, redirectUrl = null) {
        super(message, redirectUrl);
    }
}