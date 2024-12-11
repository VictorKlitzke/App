const pool = require("../database/index")
require("dotenv").config();

exports.sales = async (req, res) => {
  try {
    const [rows] = await pool.query(`
      SELECT 
        s.id AS codigo,
        s.date_sales AS dataVenda,
        s.total_value AS totalVenda,
        fp.name AS formaDePagamento,
        c.name AS clientes,
        u.name AS usuarios
      FROM 
        sales s 
        INNER JOIN users u ON u.id = s.id_users 
        LEFT JOIN clients c ON c.id = s.id_client 
        INNER JOIN form_payment fp ON fp.id = s.id_payment_method
    `);

    const [[countResult]] = await pool.query(`
      SELECT COUNT(*) AS totalVendas
      FROM sales
    `);

    return res.status(200).json({
      authorization: true, 
      sales: rows,
      count: countResult.totalVendas,
    });
    
  } catch (error) {
    console.error("Erro na consulta:", error);
    return res.status(500).json({ message: 'Erro ao consultar vendas', error: error.message });
  }
}


exports.clients = async (req, res) => {
  try {

    const [rows] = await pool.query('SELECT * FROM clients');

    return res.status(200).json({ authorization: true, clients: rows });

  } catch (error) {
    console.error("Erro na consulta:", error);
    return res.status(500).json({ message: 'Erro ao consultar vendas', error: error.message });
  }
}