import dotenv from 'dotenv';
dotenv.config();
import mysql from 'mysql2';

const pool = mysql.createPool({
    host: "localhost",
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    connectionLimit: 10
})

export const con = pool.promise();




