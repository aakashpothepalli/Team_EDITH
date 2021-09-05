const express = require("express")
const app = express()

const { Deta } = require('deta'); // import Deta

const deta = Deta(process.env.DETA_KEY); 

const db = deta.Base('edith'); 

/// Main
app.get("/",async (req,resp)=>{
  // await db.put("from Malibu Mansion","test")
  // let data = await db./get("test")
  // console.log(data)
  
  resp.status(200).send("hello world! This is E.D.I.T.H from Malibu Mansion");
  
})


/// Doctor/admin
app.post("/doctor/login",(req,res)=>{
  
})

app.post("/doctor/addPatient",async (req,res)=>{
  /*
    patientName:"aakash",
    category:"",
  */
  let {patientName,category} = req.body;
  let patientId = Math.floor(Math.Random()*100000);
  let data = await db.get("patients")
  if(data==null){
    data = {}
  }
  data[patientId] = {patientName,category,patientId}; 
  await db.put({patientName,category,patientId},"patients" );
  
  res.status(200).send("Patient Added")
})

app.post("/doctor/comfirmPackage",(req,res)=>{
  
})

app.get("/doctor/patients",(req,res)=>{
  
})




/// Customer

app.post("/customer/login",(req,res)=>{
  
})
app.get("/customer/listPackages",(req,res)=>{
  
})

app.get("/customer/viewPackage",(req,res)=>{
  
})

app.get("/customer/history",(req,res)=>{
  
})

app.post("/customer/book",(req,res)=>{
  
})

/*
        "packageId": "987654321",
        "travelAgencyId": "dfe45919-89ce-4d89-9f76-b5c5b073cf84",
        "price": 11.23,
        "category": "red",
        "description": "----------",
        "contactDetails": {
            "name": "Jane Doe",
            "number": "1234567890",
            "email": "janedoe@example.com"
        },
        "packageTitle":"Something"
        "rating"
  */

/// Travel agency
app.get("/travel/booking",async(req,res)=>{
  
})

app.get("/travel/listBookings",async (req,res)=>{

})

app.post("/travel/register",async (req,res)=>{
   /*
        "username": 11.23,
        "pass": 11.23,
        "location": "----------",
        "contactDetails": {
            "name": "Jane Doe",
            "number": "1234567890",
            "email": "janedoe@example.com"
        },
        "companyName":"Something"
  */
})
app.post("/travel/addPackage",async (req,res)=>{
   /*
        "price": 11.23,
        "travelAgencyId":"something"
        "category": "red",
        "description": "----------",
        "packageTitle":"Something"
  */
})
app.get("/travel/history",async (req,res)=>{
  
})



app.listen(3000,(req,res)=>{
  console.log("app is listening")
})