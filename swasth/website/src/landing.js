import { Button } from '@material-ui/core';
import React from 'react';
import DoctorPage from './doctorPage';

export default function Landing() {
  return (
    <div>
      <Button onClick={()=>{
        window.location.href = '/doctor';
      }}>Doctor</Button>
      <Button onClick={()=>window.location.href='/travel/login'}>Travel Agency</Button>
    </div>
  )

}