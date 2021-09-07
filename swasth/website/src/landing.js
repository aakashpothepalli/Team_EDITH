import DoctorPage from './doctorPage';
import React,{useEffect} from 'react';
import Avatar from '@material-ui/core/Avatar';
import Button from '@material-ui/core/Button';
import CssBaseline from '@material-ui/core/CssBaseline';
import TextField from '@material-ui/core/TextField';
import FormControlLabel from '@material-ui/core/FormControlLabel';
import Checkbox from '@material-ui/core/Checkbox';
import Link from '@material-ui/core/Link';
import Grid from '@material-ui/core/Grid';
import Box from '@material-ui/core/Box';
import LockOutlinedIcon from '@material-ui/icons/LockOutlined';
import Typography from '@material-ui/core/Typography';
import { makeStyles } from '@material-ui/core/styles';
import Container from '@material-ui/core/Container';
import axios from 'axios';
import {useCookies} from "react-cookie"
const useStyles = makeStyles((theme) => ({
  paper: {
    marginTop: theme.spacing(20),
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
  },
  avatar: {
    margin: theme.spacing(1),
    backgroundColor: theme.palette.secondary.main,
  },
  form: {
    width: '100%', // Fix IE 11 issue.
    marginTop: theme.spacing(1),
  },
  submit: {
    margin: theme.spacing(3, 0, 2),
  },
}));
export default function Landing() {
  const classes = useStyles();

  return (
    <Container component="main" maxWidth="xs">
    <CssBaseline />
    <h1 style={{textAlign:"center"}}>Swasth - Team E.D.I.T.H</h1>
    <div className={classes.paper}>
    <div>

      <form className={classes.form} noValidate>
      <Button 
      fullWidth 
      variant="contained"
      color="primary"
      className={classes.submit}

      onClick={()=>{
          window.location.href = '/doctor';
        }}>Doctor</Button>

          <Button 
            fullWidth 
            variant="contained"
            color="secondary"
            className={classes.submit}
          onClick={()=>window.location.href='/travel/login'}>Travel Agency</Button>

      
        {/* <Button
          // type="submit"
          fullWidth
          variant="contained"
          color="primary"
          className={classes.submit}
          onClick={handleSubmit}
        >
          Sign In / Register
        </Button> */}
        <Grid container>
          <Grid item xs>
            {/* <Link href="#" variant="body2">
              Forgot password?
            </Link> */}
          </Grid>
          <Grid item>
            {/* <Link href="#" variant="body2">
              {"Don't have an account? Sign Up"}
            </Link> */}
          </Grid>
        </Grid>
      </form>
    </div>
    </div>
  </Container>
  
  )

}