const pool = require("../database/index")
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
require("dotenv").config();

exports.login = async (req, res) => {
    const { username, password } = req.body;

    console.log("Usuário:", username);

    try {
        pool.get("SELECT * FROM usuarios WHERE nome = ?", [username], async (err, user) => {
            if (err) {
                console.error("Erro na consulta ao banco:", err.message);
                return res.status(500).json({ error: "Erro interno no servidor" });
            }

            if (!user) {
                return res.status(401).json({ error: "Usuário ou senha inválidos" });
            }

            user.senha = user.senha.replace("$2y$", "$2a$");
            const isPasswordValid = await bcrypt.compare(password, user.senha);
            if (!isPasswordValid) {
                return res.status(401).json({ error: "Senha incorreta" });
            }
            const token = jwt.sign({ id: user.id }, process.env.TOKEN, { expiresIn: "3h" });

            res.cookie('token', token, {
                httpOnly: true,
                secure: false,
                sameSite: 'lax',
                maxAge: 18000000
            });

            return res.json({
                authorization: true,
                token: token,
                message: "Login realizado com sucesso",
                UserId: user.id
            });
        });

    } catch (error) {
        console.error("Erro ao realizar login:", error.message);
        return res.status(500).json({ error: "Erro interno no servidor" });
    }
};

exports.logout = async (req, res) => {
    const token = req.cookies['token'] || req.headers['authorization'];

    if (token) {
        res.cookie('token', '', {
            expires: new Date(0),
            path: '/',
            httpOnly: true, // Garantir que o cookie seja acessível apenas pelo servidor
        });
    }
    res.status(200).json({ authorization: false, message: 'Logout realizado com sucesso' });
}

exports.register = async (req, res) => {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
        return res.status(400).json({ error: 'Nome, email e senha são obrigatórios' });
    }

    try {
        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(password, saltRounds);

        const stmt = pool.prepare('INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)');
        const result = stmt.run(name, email, hashedPassword);

        return res.status(201).json({ message: 'Usuário criado com sucesso!' });

    } catch (error) {
        console.error("Erro ao registrar usuário:", error.message);
        return res.status(500).json({ error: 'Erro interno no servidor' });
    }
};

exports.registerCategory = (req, res) => {
    const { category, type } = req.body;
    const userId = req.user.id;

    console.log(category, type);


    if (!category) {
        return res.status(400).json({ error: 'Nome da categoria vazio!' });
    }
    if (!userId) {
        return res.status(400).json({ error: 'ID do usuário não encontrado!' });
    }
    try {

        const existCategories = pool.get('SELECT * FROM categorias WHERE nome = ? AND usuario_id = ?', [category, userId]);
        console.log(existCategories)
        if (!existCategories) {
            return res.status(400).json({ error: 'Essa categoria já existe para esse usuário' });
        }

        const stmt = pool.prepare('INSERT INTO categorias (nome, tipo, usuario_id) VALUES (?, ?, ?)');
        const result = stmt.run(category, type, userId);

        return res.status(201).json({ message: 'Categoria criado com sucesso!' });

    } catch (error) {
        console.error("Erro ao registrar categoria do usuario:", error.message);
        return res.status(500).json({ error: 'Erro interno no servidor' });
    }
};