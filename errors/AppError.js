export class AppError extends Error {
    constructor(message, redirectUrl = null) {
        super(message);

        this.name = this.constructor.name;
        this.redirectUrl = redirectUrl;
    }
}