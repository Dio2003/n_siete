const express = require('express');
const morgan = require('morgan');
const cors = require('cors');

const config = require('./config');

const empresas = require('./modulos/empresas/rutas')
const error = require('./red/errors');

const app = express();

// Milddeware
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());

// configuracion
app.set('port', config.app.port);
//rutas
app.use('/api/empresas',empresas)
app.use(error);

module.exports = app;

