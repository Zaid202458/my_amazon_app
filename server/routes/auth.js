const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

const authRouter = express.Router();

// SIGN UP
authRouter.post("/api/signup", async (req, res) => {
    try {
        const { name, email, password, address } = req.body;

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "Email already exists" });
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({
            name,
            email,
            password: hashedPassword,
            address,
        });

        user = await user.save();
        res.status(200).json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// SIGN IN
authRouter.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "User with this email does not exist!" });
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect password." });
        }

        const token = jwt.sign({ id: user._id }, "passwordKey");
        res.json({ token, ...user._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
    
});

// VALIDATE TOKEN
authRouter.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) return res.json(false);

        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if (!user) return res.json(false);

        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// GET USER DATA
authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});


module.exports = authRouter;