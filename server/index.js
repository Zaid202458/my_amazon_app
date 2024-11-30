

//ِAPI
const express = require("express");
const PORT = 3000;
const app = express();
const mongoose = require("mongoose");
const DB = "mongodb+srv://egyptdevs:uKv4W6oiyvSqWRdC@cluster0.pfwr9.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";


const authRouter = require("./routes/auth");

app.use(express.json());
app.use(authRouter);

mongoose.connect(DB).then(() => {
console.log("Connection Successful");

}).catch((e)=>{
    console.log(e);
});
app.get("/Yemen-devs", (req, res) => {
    res.send("Welcome to Yemen Devs")
});


app.listen(PORT, "0.0.0.0", function () {
    console.log(`Connected o Port: ${PORT}`);
})