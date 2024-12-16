const pool = require("../database/index")
require("dotenv").config();
exports.user = async (req, res) => {
  try {
    pool.all('SELECT * FROM usuarios', [], (err, rows) => {
      if (err) {
        return res.status(500).json({ message: 'Erro ao consultar clientes', error: err.message });
      }

      return res.status(200).json({ authorization: true, user: rows });
    });
  } catch (error) {
    console.error('Erro na consulta:', error);
    return res.status(500).json({ message: 'Erro interno no servidor', error: error.message });
  }
};

exports.getCategorys = (req, res) => {
  try {
    const userId = req.user.id;

    pool.all('SELECT * FROM categorias WHERE usuario_id = ?', [userId], (err, rows) => {
      if (err) {
        console.error('Erro na consulta:', err);
        return res.status(500).json({ message: 'Erro interno no servidor', error: err.message });
      }

      if (rows.length === 0) {
        return res.status(404).json({ message: 'Nenhuma categorias encontrada para o usuário logado.' });
      }

      return res.status(200).json({ getCategorys: rows });
    });
  } catch (error) {
    console.error('Erro na consulta:', error);
    return res.status(500).json({ message: 'Erro interno no servidor', error: error.message });
  }
};

exports.getAccounts = (req, res) => {
  try {
    const userId = req.user.id;

    pool.all('SELECT id, nome, saldo_inicial FROM contas WHERE usuario_id = ?', [userId], (err, result) => {
      if (err) {
        console.error('Erro na consulta:', err);
        return res.status(500).json({ message: 'Erro interno no servidor', error: err.message });
      } else if (result.length === 0) {
        return res.status(404).json({ message: 'Nenhuma conta encontrada para o usuário logado.' });
      }
      return res.status(200).json({ getAccounts: result });
    })
  } catch (error) {
    console.error('Erro na consulta:', error);
    return res.status(500).json({ message: 'Erro interno no servidor', error: error.message });
  }
}