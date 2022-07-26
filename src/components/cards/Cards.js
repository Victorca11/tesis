import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardActionArea from '@material-ui/core/CardActionArea';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import { Grid } from '@material-ui/core';

import Owner from '../images/owner.png';
import Supplier from '../images/Supplier.png';
import Manufacturer from '../images/Manufacturer.png';
import Transporter from '../images/Transporter.png';

import SignIn from '../login/SignIn';
import {BrowserRouter as Router, NavLink} from 'react-router-dom';

const useStyles = makeStyles({
    root1: {
    maxWidth: 200,
    marginLeft: 15,
    marginBottom: 10,
    marginTop: 50,
  },
  root2:{
    marginTop: 50,
    marginBottom: 10,
    maxWidth: 200,
    marginLeft: 15,
  },
  root3:{
    marginTop: 50,
    marginBottom: 10,
    maxWidth: 200,
    marginLeft: 15,
  },
  root4:{
    marginBottom: 10,
    maxWidth: 200,
    marginLeft: 15,
    marginTop: 50,
  },
  root5:{
    marginBottom: 10,
    maxWidth: 200,
    marginLeft: 15,
    marginTop: 50,
  },
  root6:{
    marginBottom: 10,
    maxWidth: 200,
    marginLeft: 15,
    marginTop: 50,
  },
  media: {
    height: 200,
    paddingLeft: 20,
  },
});

const handleClick =()=>{
  return(
    <div>
      <SignIn/>
    </div>
  );
}
function Cards() {
  const classes = useStyles();

  return (
    <Router>
    <Grid container>
      <Grid item md={2}>
        <Card className={classes.root1}>
        <a href="/owner">
          <CardActionArea>
            <CardMedia className={classes.media} image={Owner} title="Owner"/>
            <CardContent>
              <Typography gutterBottom variant="h5" component="h2" >Owner </Typography>
              {/* <Typography variant="body2" color="textSecondary" component="p">
                Lizards are a widespread group of squamate reptiles, with over 6,000 species, ranging across all continents except Antarctica
              </Typography> */}
            </CardContent>
          </CardActionArea>
        </a>
        </Card>
      </Grid>

      

      <Grid item md={2}>
        <Card className={classes.root3}>
        <a href="/transporter">
          <CardActionArea>
            <CardMedia className={classes.media}image={Transporter}title="Transporter"/>
            <CardContent>
              <Typography gutterBottom variant="h5" component="h2">Transporter</Typography>
            </CardContent>
          </CardActionArea>
        </a>
        </Card>
      </Grid>

      <br/>
      <Grid item md={2}>
        <Card className={classes.root4}>
          <a href="/manufacturer">
            <CardActionArea>
              <CardMedia className={classes.media}image={Manufacturer}title="Manufacturer"/>
              <CardContent>
                <Typography gutterBottom variant="h5" component="h2">Mining</Typography>
              </CardContent>
            </CardActionArea>
          </a>
        </Card>
      </Grid>

      <Grid item md={2}>
        <Card className={classes.root2}>
        <a href="/supplier">
          <CardActionArea>
            <CardMedia className={classes.media}image={Supplier}title="supplier"/>
            <CardContent>
              <Typography gutterBottom variant="h5" component="h2">Repair center</Typography>
            </CardContent>
          </CardActionArea>
        </a>
        </Card>
      </Grid>

    </Grid>
    </Router>
  );
}
export default Cards