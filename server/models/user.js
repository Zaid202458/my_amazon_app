const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,

    },
    email: {
        type: String,
        required: true,
        trim: true,
        Validate: {
            validator: (val) => {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return val.match(emailRegex)
            },
            message:"Please Enter Valid Email.",
        },

    },
    password: {
        type: String,
        required: true,

    },
    name: {
        type: String,
        default:"",

    },
    type: {
        type: String,
        default:"user",

    },
});

const User=mongoose.model("User",userSchema);

module.exports=User;