import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import axios from 'axios';

const useStyles = makeStyles({
  root: {
    minWidth: 275,
    margin:20
  },
  bullet: {
    display: 'inline-block',
    margin: '0 2px',
    transform: 'scale(0.8)',
  },
  title: {
    fontSize: 14,
  },
  pos: {
    marginBottom: 12,
  },
});

export default function PatientCard({patientId,patientName,bookings,category,description,isTravel}) {
  const classes = useStyles();
  const bull = <span className={classes.bullet}>•</span>;
  let [confirmLoading, setConfirmLoading] = React.useState(false);
  async function getDetails(){
    let response = await fetch(`https://team-edith.glitch.me/doctor/patientDetails?patientId=`+patientId);
    let data = await response.json();
    console.log(data);

    alert("PatientId - "+data.patientId + "\n Password - "+ data.pass)
  }
  async function confirmPackage(packageId){
    setConfirmLoading(true);
    let response = await axios.post(`https://team-edith.glitch.me/doctor/confirmPackage`,{
      packageId,
      patientId
    });
    if(response.status==200){
      alert("Package confirmed successfully");
      window.location.reload();
    }

  }
  async function CompleteTour(packageId){
    setConfirmLoading(true);
    let response = await axios.post(`https://team-edith.glitch.me/travel/completeTour`,{
      patientId,packageId
    });
    if(response.status==200){
      alert("Tour completed successfully");
      window.location.reload();
    }
  }
  return (
    <Card className={classes.root}>
      <CardContent>
        {/* <Typography className={classes.title} color="textSecondary" gutterBottom>
          Word of the Day
        </Typography> */}
        <Typography variant="h5" component="h2">
          {patientName}
        </Typography>
        <Typography variant="h5" component="h2">
          {description}
        </Typography>
        <Typography className={classes.pos} color="textSecondary">
          Category  <div style={{color:category}}>{category}</div>
        </Typography>
        <h5>Packages selected</h5>

        {bookings.map(booking => (
          <div>
          <Typography variant="body2" component="p">
            {booking['package']['description']}
          <br />
          
        </Typography>
        <div style={{display:"flex",alignItems:"center",justifyContent:"center"}}>

          <CardActions>
            {isTravel==true?(
            <Button size="small" color="primary" variant="contained"
            disabled={booking['completed']}
             style={{backgroundColor:(booking['completed']!=true)?'null':'green'}}
              onClick = {()=>CompleteTour(booking['packageId'])}

            >{(booking['completed']!=true)?'Complete Tour':'Tour Completed'}
            </Button>):(
              <Button size="small" color="primary" variant="contained"
              disabled={booking['confirmed']}
               style={{backgroundColor:booking['confirmed']==false?null:'green'}}
                onClick = {()=>confirmPackage(booking['packageId'])}
              >{booking['confirmed']==false?'Confirm':'Confirmed'}
              </Button>
            )}
            
        </CardActions>
        </div>
        <br/>
        </div>))
        }
        
      </CardContent>
      <div style={{display:"flex",alignItems:"center",justifyContent:"center"}}>
      
      <CardActions>
        {isTravel==true?<div/>:<Button size="small" color="primary" variant="contained"
          onClick={getDetails}
        >View Credentials</Button>}
      </CardActions>
      </div>
    </Card>
  );
}
