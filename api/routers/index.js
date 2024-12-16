const express = require("express");
const router = express.Router();

const authPost = require('../controllers/post');
const authget = require('../controllers/get');
const auth = require('../middleware/auth');

router.post('/register', authPost.register)
router.post('/login', authPost.login);
router.post('/registerCategory', auth, authPost.registerCategory);
router.post('/logout', auth, authPost.logout);

router.get('/users', auth, authget.user);
router.get('/getCategorys', auth, authget.getCategorys);
router.get('/getAccounts', auth, authget.getAccounts);

module.exports = router;