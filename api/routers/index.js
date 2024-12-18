const express = require("express");
const router = express.Router();

const authPost = require('../controllers/post');
const authget = require('../controllers/get');
const authPut = require('../controllers/put');
const auth = require('../middleware/auth');

router.post('/register', authPost.register);
router.post('/login', authPost.login);
router.post('/registerCategory', auth, authPost.registerCategory);
router.post('/registerAccounts', auth, authPost.registerAccounts);
router.post('/registerExpense', auth, authPost.registerExpense);
router.post('/logout', auth, authPost.logout);

router.put('/updatepassword', auth, authPut.updatepassword);
router.put('/updateemail', auth, authPut.updateemail);

router.get('/users', auth, authget.user);
router.get('/getCategorys', auth, authget.getCategorys);
router.get('/getAccounts', auth, authget.getAccounts);
router.get('/getTransition', auth, authget.getTransition);

module.exports = router;