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
import {useCookies} from "react-cookie";
import AddPackage from "./components/addPackage";
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
export default function TravelAgencyPage() {
  let [bookings,setBookings] = React.useState([]);
  let [loading,setLoading] = React.useState(true);
  const [cookie, setCookie, removeCookie] = useCookies(['travel-auth']);

  async function getBookings() {

    const response = await axios.get('https://team-edith.glitch.me/travel/listBookings?travelAgencyId='+cookie['travel-auth']);
    console.log(response.data);
    setBookings(response.data);
  }  
  const classes = useStyles();

  useEffect(  () => {
    getBookings().then(()=>setLoading(false));
    setTimeout(() => {
      getBookings()
    },3000)
  },[])
  return (
  <div >
      <div className={classes.root}>

        <AppBar position="static">
          <Toolbar >
              <Typography variant="h6" className={classes.title} >
              Swasth Travel Agency Portal
              </Typography>
              <AddPackage travelAgencyId = {cookie['travel-auth']}/>
          </Toolbar>
      </AppBar>
      </div>
      {loading==true
      ?<CircularProgress/>:
      (
        <div style={{margin:20}}>
        <List component="nav" aria-label="main mailbox folders">
            {bookings.map(p => 
            <PatientCard 
            patientName={p.customerName}
            patientId = {p.customerId}
            category = {p.category}
            description = {p.description??""}
            bookings = {[p]??[]}
            isTravel = {true}

            />)}
            {/* <PatientCard patientName= {'aakash'}/> */}
            {/* <PatientCard />
            <PatientCard />
            <PatientCard /> */}

          </List>
        </div>
        )}
  </div>);

}