import { AppError } from "./AppError";

export class AuthError extends AppError {
    constructor(message) {
        super(message);

        this.name = this.constructor.name;
    }
}