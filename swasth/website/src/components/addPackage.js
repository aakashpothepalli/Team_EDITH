import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Button from '@material-ui/core/Button';
import Dialog from '@material-ui/core/Dialog';
import ListItemText from '@material-ui/core/ListItemText';
import ListItem from '@material-ui/core/ListItem';
import List from '@material-ui/core/List';
import Divider from '@material-ui/core/Divider';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import IconButton from '@material-ui/core/IconButton';
import Typography from '@material-ui/core/Typography';
import CloseIcon from '@material-ui/icons/Close';
import Slide from '@material-ui/core/Slide';
import AddIcon from '@material-ui/icons/Add';
import { TextField } from '@material-ui/core';
import Select from '@material-ui/core/Select';
import MenuItem from '@material-ui/core/MenuItem';
import InputLabel from '@material-ui/core/InputLabel';
import CircularProgress from '@material-ui/core/CircularProgress';

const useStyles = makeStyles((theme) => ({
  appBar: {
    position: 'relative',
  },
  title: {
    marginLeft: theme.spacing(2),
    flex: 1,
  },
}));

const Transition = React.forwardRef(function Transition(props, ref) {
  return <Slide direction="up" ref={ref} {...props} />;
});

export default function AddPackage({travelAgencyId}) {
  const classes = useStyles();
  const [open, setOpen] = React.useState(false);
  let [category, setCategory] = React.useState('');
  let [infoText, setInfoText] = React.useState('');
  let [patientName, setPatientName] = React.useState('');

  let [price, setPrice] = React.useState(999);
  let [description, setDescription] = React.useState('');
  let [name, setName] = React.useState('');
  let [number   , setNumber] = React.useState('');
  let [email, setEmail] = React.useState('');
  let [packageTitle, setPackageTitle] = React.useState('');
  let [duration, setDuration] = React.useState('');

  let [loading, setLoading] = React.useState(false);
  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };
  async function submitDetails(){
    setLoading(true);
    let response = await fetch('https://team-edith.glitch.me/travel/addPackage', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        travelAgencyId,
        contactDetails:{
          name,email,number
        },
        price,
        category,
        description,
        packageTitle,
        duration,        

      }),
    });
    let data = await response.json();
    console.log(data);
    alert("package added successfully")
    setOpen(false);
  }

  return (
    <div>
      {/* <SimpleDialog selectedValue={selectedValue} open={open} onClose={handleClose} /> */}
      <IconButton className = {classes.menuButton}edge="start"  color="inherit" aria-label="menu"
                onClick={handleClickOpen}
              >
              <AddIcon />
      </IconButton>
      <Dialog fullScreen open={open} onClose={handleClose} TransitionComponent={Transition}>
        <AppBar className={classes.appBar}>
          <Toolbar>
            <IconButton edge="start" color="inherit" onClick={handleClose} aria-label="close">
              <CloseIcon />
            </IconButton>
            <Typography variant="h6" className={classes.title}>
              Add Package
            </Typography>
            <Button autoFocus color="inherit" onClick={submitDetails}>
              {(loading==false)?'save':(<CircularProgress style={{color:"white"}} />)}
            </Button>
          </Toolbar>
        </AppBar>
        <List>
            
          {/* <ListItem>
            <TextField 
            onChange={(e) => setPatientName(e.target.value)}

            id="outlined-basic" label="Patient Name" variant="outlined" />

          </ListItem> */}
          <Divider />
          <ListItem text>
          <InputLabel id="demo-simple-select-label">Category</InputLabel>

            <Select
              labelId="demo-simple-select-label"
              id="demo-simple-select"
              value={category}
              label="Category"
              onChange={(e) =>{
                let cat = e.target.value
                if(cat === 'green'){
                  setInfoText('Green: Patient is healthy, They are allowed to do all activities')
                }
                else if(cat === 'yellow'){
                  setInfoText(
`Yellow: Care required, but can venture out
General constraints: 
  Physical activity must be avoided
  Crowds must be avoided
Possible activities:
  City landmarks drive-through
  Drive-in theatres
  Historical/themed city drive
                  `)}
                  else if(cat === 'red'){
                    setInfoText(
`Red: Utmost care required
General constraints: 
  Patient must avoid getting out of bed for most part
  Minimal contact with outsiders
Possible activities:
  Local radio stations/programmes
  Local T.V channels/programmes
  Essential bollywood binge`)
                  }
                
                setCategory(e.target.value)
                
                }}
            >
              <MenuItem value={'red'}>Red</MenuItem>
              <MenuItem value={'yellow'}>Yellow</MenuItem>
              <MenuItem value={'green'}>Green</MenuItem>
            </Select>         
         </ListItem>
         {/* <Divider /> */}

         <ListItem text style={{whiteSpace:'pre-wrap'}}>
          {infoText}
         </ListItem>
         <Divider />

         <ListItem text style={{whiteSpace:'pre-wrap'}}>
          <TextField 
          onChange= {(e)=>{
            setPackageTitle(e.target.value)
          }}
          variant="outlined" multiline style={{width:'40%'}} label="Package name"></TextField>
         </ListItem>

         <Divider />

         <ListItem text style={{whiteSpace:'pre-wrap'}}>
          <TextField
            onChange={(e)=>{
                setDescription(e.target.value)
            }}
          variant="outlined" multiline style={{width:'40%'}} label="description"></TextField>
         </ListItem>

         <Divider />

         <ListItem text style={{whiteSpace:'pre-wrap'}}>
          <TextField
            onChange={(e)=>{
                setPrice(e.target.value)
            }}
          variant="outlined" multiline style={{width:'40%'}} label="Cost"></TextField>
         </ListItem>
         <Divider />

         <ListItem text style={{whiteSpace:'pre-wrap'}}>
          <TextField 
          onChange={(e)=>{
            setDuration(e.target.value)
          }}

          variant="outlined" multiline style={{width:'40%'}} label="Duration"></TextField>
         </ListItem>

         <Divider />

         <ListItem text style={{whiteSpace:'pre-wrap'}}>
          <TextField
            onChange={(e)=>{
                setName(e.target.value)
            }}

          variant="outlined"  style={{width:'40%'}} label="Travel Agency name"></TextField>
         </ListItem>
         <Divider />

         <ListItem text style={{whiteSpace:'pre-wrap'}}>
          <TextField 
          onChange={(e)=>{
            setNumber(e.target.value)
          }}

          variant="outlined"  style={{width:'40%'}} label="Contact Number"></TextField>
         </ListItem>
         <Divider />

         <ListItem text style={{whiteSpace:'pre-wrap'}}>
          <TextField 
          onChange={(e)=>{
            setEmail(e.target.value)
          }}

          variant="outlined"  style={{width:'40%'}} label="contact Email"></TextField>
         </ListItem>
        </List>
      </Dialog>
    </div>
  );
}
