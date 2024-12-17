function formmater(valor) {
  return parseFloat(valor.replace(/\./g, '').replace(',', '.').trim()); 
}

module.exports = { formmater };