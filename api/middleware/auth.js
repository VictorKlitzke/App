const jwt = require('jsonwebtoken');
const pool = require('../database/index');

module.exports = async (req, res, next) => {
  const token = req.cookies['token'];

  if (!token) {
    return res.status(401).json({ message: '[AVISO] - TOKEN NÃO INFORMADO' });
  }

  try {
    const decoded = jwt.verify(token, process.env.TOKEN);
    const userId = decoded.id;
    
    const [result] = await pool.query("SELECT * FROM users WHERE id = ?", [userId]);

    if (!result || result.length === 0) {
      return res
        .status(404)
        .json({ message: '[AVISO] - USUÁRIO NÃO ENCONTRADO' });
    }
    req.user = result[0];
    next();
  } catch (error) {
    if (error instanceof jwt.JsonWebTokenError) {
      return res
        .status(403)
        .json({ message: '[AVISO] - AUTENTICAÇÃO NÃO VALIDADA' });
    } else {
      console.error('[AVISO] - ERRO AO VERIFICAR USUÁRIO:', error);
      return res
        .status(500)
        .json({ message: '[AVISO] - ERRO INTERNO DO SERVIDOR' });
    }
  }
};