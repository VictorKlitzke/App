const pool = require("../database/index");
const bcrypt = require("bcrypt");
require("dotenv").config();

exports.updatepassword = async (req, res) => {
  const { currentpassword, newpassword, confirmpassword } = req.body;
  const userId = req.user.id;

  if (!req.user || req.user.id !== userId) {
    return res.status(401).json({ error: "Usuário não autenticado." });
  }
  

  if (!currentpassword || !newpassword || !confirmpassword) {
    return res.status(400).json({ error: "Campos estão vazios!" });
  }

  if (newpassword !== confirmpassword) {
    return res.status(400).json({ error: "Nova senha e confirmação não coincidem!" });
  }

  try {
    pool.get("SELECT * FROM usuarios WHERE id = ?", [userId], async (error, user) => {
      if (error) {
        console.error("Erro na consulta ao banco:", error.message);
        return res.status(500).json({ error: "Erro interno no servidor." });
      }

      if (!user) {
        return res.status(401).json({ error: "Usuário não encontrado." });
      }

      const isMatch = await bcrypt.compare(currentpassword, user.senha);
      if (!isMatch) {
        return res.status(401).json({ error: "Senha atual está incorreta!" });
      }

      if (currentpassword === newpassword) {
        return res.status(400).json({ error: "A nova senha não pode ser igual à senha atual!" });
      }

      const hashedPassword = await bcrypt.hash(newpassword, 10);
      pool.run(
        "UPDATE usuarios SET senha = ? WHERE id = ?",
        [hashedPassword, userId],
        (updateErr) => {
          if (updateErr) {
            console.error("Erro ao atualizar a senha:", updateErr.message);
            return res.status(500).json({ error: "Erro ao atualizar a senha." });
          }

          return res.status(200).json({ message: "Senha atualizada com sucesso!" });
        }
      );
    });
  } catch (error) {
    console.error("Erro ao atualizar senha do usuario:", error.message);
    return res.status(500).json({ error: "Erro interno no servidor." });
  }
};

exports.updateemail = (req, res) => {
  const { email } = req.body;
  const userId = req.user.id;

  if (!req.user || req.user.id !== userId) {
    return res.status(401).json({ error: "Usuário não autenticado." });
  }
  try {

  } catch (error) {

  }
}
