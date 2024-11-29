

//ِAPI
const express =require("express");

const PORT=3000;

const app =express();

app.get("/Yemen-devs",(req,res)=>{
res.send("Welcome to Yemen Devs")
});


app.listen(PORT,"0.0.0.0",function(){
    console.log(`Connected o Port: ${PORT}`);
})