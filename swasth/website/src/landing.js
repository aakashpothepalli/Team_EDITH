import React  from "react";
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import Button from '@material-ui/core/Button';

export default function Landing() {
  return (
  <div>
      <AppBar position="static">
        <Toolbar>
            <Typography variant="h6" >
            Swasth Login
            </Typography>
            <Button color="inherit">Login</Button>
        </Toolbar>
    </AppBar>

  </div>);

}