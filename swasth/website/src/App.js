import logo from './logo.svg';
import './App.css';
import Landing from './landing';
import DoctorPage from './doctorPage';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
} from "react-router-dom";
import TravelAgencyPage from './travelLanding';
import TravelLoginPage from './travelLogin';

import { MuiThemeProvider, createTheme } from '@material-ui/core/styles';

function App() {
  const theme = createTheme({
    palette: {
      primary: {
        main: '#274937'
      }
    }
  });
  
  return (
    <MuiThemeProvider theme={theme}>

    <Router>
    <Switch>
          <Route path="/doctor">
            <DoctorPage />
          </Route>
          <Route path="/travel/landing">
            < TravelAgencyPage/>
          </Route>
          <Route path="/travel/login">
            < TravelLoginPage/>
          </Route>
          <Route path="/">
            <Landing />
          </Route>
        </Switch>
    </Router>
    </MuiThemeProvider>

  );
}

export default App;
