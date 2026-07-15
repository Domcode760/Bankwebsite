import bcrypt from 'bcrypt';
import { con } from '../database/db.js';
import { AuthenticationError } from '../errors/AuthenticationError.js';
import { ValidationError } from '../errors/ValidationError.js';

function validateLoginInput(username, password) {

    if(!username) {
        throw new ValidationError(
            "Username is required",
            "/login"
        );
    }
    if(!password) {
        throw new ValidationError(
            "Password is required",
            "/login"
        )
    }
}

export async function findUser(username) {
    const [rows] = await con.query("SELECT * FROM users WHERE users.username = ?", [username]);
    return rows[0] || null;
}

export async function comparePassword(inputPassword, hash) {
    return await bcrypt.compare(inputPassword, hash);
}

export async function loginUser(username, password) {
    
    validateLoginInput(username, password);

    const user = await findUser(username);

    if(!user) {
        throw new AuthenticationError(
            "User not found",
            "/login"
        );
    }

    const isMatch = await comparePassword(password, user.password_hash);

    if(!isMatch) {
        throw new AuthenticationError(
            "Wrong Password",
            "/login"
        )
    }

    return { 
            id: user.user_id,
            username: user.username,
            first_name: user.first_name
    };
}
