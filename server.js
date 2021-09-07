const express = require("express")
const app = express()
app.use(express.json())
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

const { Deta } = require('deta'); // import Deta

const deta = Deta(process.env.DETA_KEY); 

const db = deta.Base('edith'); 

/// Main
app.get("/",async (req,resp)=>{
  // await db.put("from Malibu Mansion","test")
  // let data = await db./get("test")
  // console.log(data)
  // callme()
  resp.status(200).send("hello world! This is E.D.I.T.H from Malibu Mansion");
  
})
async function callme(){
    let data = await db.get('patients')
  
     // data['12106']['bookings'][0]['packageId'] = "29224"
    // data['29224']['rating'] = '4'
    delete data['12106']
    // tpackage['rating'] = 5
    // data['52831'] = tpackage
    await db.put(data,"patients")
}


/// Doctor/admin
app.post("/doctor/login",(req,res)=>{
  // TODO (may not be required)  
  
})

app.post("/doctor/addPatient",async (req,res)=>{
  /*
    patientName:"aakash",
    category:"",
  */
  console.log(req.body)
  let {patientName,category} = req.body;
  let patientId = String(Math.floor(Math.random()*100000));
  let pass = Math.random().toString(36).slice(-4);
  let data = await db.get("patients")
  
  
  if(data==null){
    data = {}
  }
  
  data[patientId] = {patientName,category,patientId,pass}; 
  /*
    patientName:"aakash",
    category:"",
    patientId:123456,
    pass:"sdf2"
  */
  await db.put(data,"patients" );
  
  res.status(200).json(data[patientId])
})

app.post("/doctor/confirmPackage",async (req,res)=>{
  //TODO
  
  let {patientId, packageId} = req.body;
  if(patientId===undefined ||  packageId===undefined ){
        res.status(400).send("patient id or packageId not entered")
  }
  else{
    // TODO
    
    console.log(req.body)
    let data = (await db.get("patients"))
    let patientDetails  = data[patientId]
    for(let i in patientDetails['bookings']){
      let DBpackageId = patientDetails['bookings'][i]['packageId'];
      if(DBpackageId==packageId){
        patientDetails['bookings'][i]['confirmed'] = true;
      }
    }
    data[patientId] = patientDetails;
    await db.put(data,"patients")
    res.send('package confirmed')
  }
  
})

app.get("/doctor/listPatients",async (req,res)=>{
  let data = await db.get("patients")
  let patients = []
  let packages = (await db.get("packages"))
  for(let key in data){
    if(key!='key'){
      let bookings = data[key]['bookings']
      for(let i in bookings){
        // console.log(bookings)
        let packageId = bookings[i]['packageId']
        let packageInfo  = packages[packageId]
        bookings[i]['package'] = packageInfo
      }
      data[key]['bookings'] = bookings

      patients.push(data[key])
    }
  }
  res.status(200).send(patients)
})

app.get("/doctor/patientDetails",async (req,res)=>{
    let {patientId} = req.query;
    console.log(patientId)
    
    let patientDetails =( await db.get("patients"))[patientId];
    console.log(patientDetails)
    let packages = await db.get("packages")
    
  if(patientDetails!==undefined  && patientDetails !==null){
    for(let i in patientDetails['bookings']){
        let packageId = patientDetails['bookings'][i]['packageId']
        let tpackage = packages[packageId]
        patientDetails['bookings'][i]['package'] = tpackage
    }
    res.status(200).send(patientDetails)
  }
  else 
    res.status(404).send("No patient with "+patientId + " found")
  
})




/// Customer

app.post("/customer/login",async (req,res)=>{
    let {patientId,pass} = req.body
    // console.log("custome")
    if(patientId===undefined ||  pass===undefined ){
        res.status(400).send("patient id or pass not entered")
    }
    else{
      let data = (await db.get("patients"))[patientId];
      
      if(data == undefined || data['patientId']!== patientId || data['pass']!==pass){
        res.status(404).send("invalid Patient ID or pass")
      }
      else{
        res.status(200).send({patientId,status:"logged in"})
      }
    }
})

app.get("/customer/listPackages",async (req,res)=>{
    let {patientId} = req.query;
    if(!patientId){
        res.status(400).send("patientId not provided")
      return;
    }
    let patientDetails = (await db.get("patients"))
    if(patientDetails[patientId]==undefined){
      res.status(404).status("No patient with ID found")
      return;
    }
    let category = (await db.get("patients"))[patientId]['category'];
  
    let data= await db.get("packages");
    
    let packages = []
    
    for(let key in data){
        console.log(key)
        let pk = data[key];
        if(key!=="key" &&pk !=undefined && pk['category']==category){
          packages.push(pk)
        }
    }
    // array of packages
    res.status(200).send({"list":packages})
    
})

app.get("/customer/viewPackage",async (req,res)=>{
    
    let {packageId} = req.query;
    if(packageId==undefined){
        res.status(400).send("Package ID missing")
    }
  
    let data = (await db.get("packages"))[packageId]
    if(data==null){
      res.status(404).send("Package not found")
      
    }
  else
    res.status(200).send(data)
})

app.get("/customer/history",async (req,res)=>{
    let {patientId} = req.query
    let data = await db.get("patients")
    if(data[patientId]==undefined){
      res.status(404).send("Patient Id not found")
    }  
    else{
      let bookings = data[patientId]['bookings']
      if(bookings == undefined){
        bookings  =[]
      }
      for(let i in bookings){
        // console.log(bookings)
        let packageId = bookings[i]['packageId']
        let packageInfo  = (await db.get("packages"))[packageId]
        bookings[i]['package'] = packageInfo
      }
      
      res.status(200).send(bookings)
    }

})

app.post("/customer/book",async (req,res)=>{
    let {patientId,packageId} = req.body
    console.log("customer/book",req.body)
    let data = await db.get("patients")
    if(data[patientId]==undefined){
      res.status(404).send("Patient Id not found")
    }
    else{
      let pdata = data[patientId]
      console.log(pdata)
      let bookings= pdata['bookings'];
      if(bookings === undefined){
          bookings = []
      }
      bookings.push({packageId, "confirmed":false,date : new Date().toString(),completed:false});
      pdata['bookings'] = bookings  
      data[patientId] = pdata;
      await db.put(data,"patients")
      
      res.status(200).send(pdata)
    }
})



/// Travel agency
// app.get("/travel/booking",async(req,res)=>{
//     // get individual bookings
// })

app.get("/travel/listBookings",async (req,res)=>{
    let TAID = req.query['travelAgencyId']
    console.log(TAID)
    let packages = await db.get("packages")
    let patients = await db.get("patients")
    let mybookings = []
    for(let key in patients){
      if(key=='key')continue;
      
      // console.log(key)
      let bookings = patients[key]['bookings']
      if(bookings == undefined){
        continue;
      }
      
      for(let det of bookings){
          // packages[det['packageId']]['completed'] = det
          if(det['confirmed']==true ){
              mybookings.push({
                customerName:patients[key]['patientName'],
                description : det['description'],
                // price:det['price'],
                completed:det['completed'],
                customerId:key,
                
                category: patients[key]['category'],
                packageId:det['packageId'],
                package:packages[det['packageId']]
              })
          }
      }
    }
    res.status(200).send(mybookings)
})

app.post("/travel/login",async (req,res)=>{
   /*
        "username": 11.23,
        "pass": 11.23,
        "location": "----------",
        "contactDetails": {
            "name": "Jane Doe",
            "number": "1234567890",
            "email": "janedoe@example.com"
        },
        "travelAgencyName":"Something"
  */
  let params = ['username','pass']
  
  for(let p of params){
    if(req.body[p]==undefined){
      res.status(400).send(p + " not found")
    }
  }
  
  let data = req.body
  let tdetails = (await db.get("travelAgencies"))
  if(tdetails==null){
    tdetails={}
  }
  let isNewUser = true
  let travelAgent;
  for(let key in tdetails){
      let det =tdetails[key]
            console.log(det)

      if(det['username']==data['username']){
        isNewUser = false;
        travelAgent = det;
        break;
      }
  }
  
  if(isNewUser == true){
      // new user - register
      let travelAgencyId = String(Math.floor(Math.random()*10000))
      data['travelAgencyId'] = travelAgencyId
      tdetails[travelAgencyId]= data
      await db.put(tdetails,"travelAgencies")
      res.status(200).send(data)
  }
  else{
    // old user check password
    if(travelAgent['pass'] == data['pass']){
      // login success
      console.log("login success")
          res.status(200).send(travelAgent)
    }
    else{
      res.status(401).send("invalid Password");
    }
  }
})
app.post("/travel/addPackage",async (req,res)=>{
  
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

  let agencies = await db.get("travelAgencies")

  if(agencies==null || agencies[req.body.travelAgencyId]==undefined){
    res.status(404).send("Travel agency not registered")
    return;
  }
  
  let params = ['travelAgencyId','price','category','description','contactDetails','packageTitle','duration']

  for(let i in params){
    if(req.body[params[i]]==undefined){
        res.status(400).send(params[i] + " is missing")
        return;
    }
  }
  let data = await db.get("packages")
  if(data==null){
    data = {}
  }
  let newdata = req.body;
  //random package id
  let packageId = String(Math.floor(Math.random()*100000)) 
  let rating = "4"
  newdata['packageId'] = packageId
  newdata['rating'] = rating
  
  data[packageId] = newdata;
  await db.put(data,"packages")
  
  res.status(200).send(newdata)
  
})
app.get("/travel/history",async (req,res)=>{
  
})

app.post("/travel/completeTour",async (req,res)=>{
  let {patientId,packageId} = req.body
  console.log(req.body)
  let patients = await db.get("patients")
  
  for (let i in patients[patientId]['bookings']){
    console.log(patients[patientId]['bookings'][i])
      if(patients[patientId]['bookings'][i]['packageId']==packageId){
        patients[patientId]['bookings'][i]['completed'] = true
      }
  }
  await db.put(patients,"patients")
  res.status(200).send("ok")
})

app.listen(3000,(req,res)=>{
  console.log("app is listening")
})