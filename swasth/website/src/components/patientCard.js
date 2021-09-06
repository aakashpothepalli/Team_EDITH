import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';

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

export default function PatientCard({patientId,patientName,bookings,category,description}) {
  const classes = useStyles();
  const bull = <span className={classes.bullet}>•</span>;

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
        {bookings.map(booking => (
          <Typography variant="body2" component="p">
            {booking['package']['description']}
          <br />
          
        </Typography>))
        }
        
      </CardContent>
      <CardActions>
        <Button size="small" color="primary" variant="contained">Confirm</Button>
      </CardActions>
    </Card>
  );
}
