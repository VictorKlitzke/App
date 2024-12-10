const pool = require("../database/index")
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
require("dotenv").config();

exports.login = async (req, res) => {
    const { username, password } = req.body;

    try {
        const [rows] = await pool.query("SELECT * FROM users WHERE name = ?", [username]);

        if (!rows || rows.length === 0) {
            return res.status(401).json({ error: "Usuário ou senha inválidos" });
        }

        const user = rows[0];
        if (!user.password) {
            return res.status(500).json({ error: "Senha não encontrada para o usuário" });
        }

        user.password = user.password.replace("$2y$", "$2a$");
        const isPasswordValid = await bcrypt.compare(password, user.password);
        if (!isPasswordValid) {
            return res.status(401).json({ error: "Senha incorreta" });
        }

        const token = jwt.sign({ id: user.id }, process.env.TOKEN, { expiresIn: "3h" });

        res.cookie('token', token, {
            httpOnly: true,
            secure: false,
            sameSite: 'strict',
            maxAge: 18000000
        })

        return res.json({ authorization: true, message: "Login realizado com sucesso", UserId: user.id });

    } catch (error) {
        console.error("Erro ao realizar login:", error.message);
        return res.status(500).json({ error: "Erro interno no servidor" });
    }
};

exports.logout = async (req, res) => {
    const token = req.cookies['token']
    console.log(req.cookies['token']);

    if (token) {
        res.cookie('token', '', { expires: new Date(0), path: '/' });
    }
    res.status(200).json({ authorization: false, message: 'Logout realizado com sucesso' });
}