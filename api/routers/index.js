const express = require("express");
const router = express.Router();

const authPost = require('../controllers/post');
const auth = require('../middleware/auth');

router.post('/login', authPost.login);
router.post('/logout', auth, authPost.logout);

module.exports = router;