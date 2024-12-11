const express = require("express");
const router = express.Router();

const authPost = require('../controllers/post');
const authget = require('../controllers/get');
const auth = require('../middleware/auth');

router.post('/login', authPost.login);

router.post('/logout', auth, authPost.logout);

router.get('/sales', auth, authget.sales);
router.get('/clients', auth, authget.clients);

module.exports = router;