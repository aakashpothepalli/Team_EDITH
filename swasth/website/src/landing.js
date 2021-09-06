import React,{useEffect}  from "react";
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import Button from '@material-ui/core/Button';
import List from '@material-ui/core/List';
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from '@material-ui/icons/Menu';
import PatientCard from "./components/patientCard"
import axios from "axios";
import { makeStyles } from '@material-ui/core/styles';
import AddPatient from "./components/addPatient";
import { CircularProgress } from "@material-ui/core";
const useStyles = makeStyles({
  root: {
    flexGrow: 1,
  },
  menuButton: {
    marginRight: 20
  },
  title: {
    flexGrow: 1,
    marginLeft:50
  },

});
export default function Landing() {
  let [patients,setPatients] = React.useState([]);
  let [loading,setLoading] = React.useState(true);
  async function getPatients() {

    const response = await axios.get('https://team-edith.glitch.me/doctor/listPatients');
    // console.log(response.data);
    setPatients(response.data);
  }  
  const classes = useStyles();

  useEffect(  () => {
    getPatients().then(()=>setLoading(false));
    setTimeout(() => {
      getPatients()
    },3000)
  },[])
  return (
  <div >
      <div className={classes.root}>

        <AppBar position="static">
          <Toolbar >
              <Typography variant="h6" className={classes.title} >
              Swasth Doctor
              </Typography>
              <AddPatient/>

          </Toolbar>
      </AppBar>
      </div>
      {loading==true
      ?<CircularProgress/>:
      (
        <div style={{margin:20}}>
        <List component="nav" aria-label="main mailbox folders">
            {patients.map(p => 
            <PatientCard 
            patientName={p.patientName}
            patientId = {p.patientId}
            category = {p.category}
            description = {p.description??""}
            bookings = {p.bookings??[]}/>)}
            {/* <PatientCard patientName= {'aakash'}/> */}
            {/* <PatientCard />
            <PatientCard />
            <PatientCard /> */}

          </List>
        </div>
        )}
  </div>);

}