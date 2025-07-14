const { Router } = require('express');
const { check } = require('express-validator');
const { validarCampos } = require('../middlewares/validarCampos');
const { validarJWT } = require('../middlewares/validarJWT');
const { generarBalanceSumasSaldos, testConexion } = require('../controllers/reportes');

const router = Router();

// Ruta para probar la configuración de jasper
router.get('/test-conexion', [
    validarJWT
], testConexion);

// Ruta para generar el reporte Balance de Sumas y Saldos
router.get('/balance-sumas-saldos', [
    validarJWT,
    check('desde', 'La fecha desde es obligatoria').notEmpty(),
    check('hasta', 'La fecha hasta es obligatoria').notEmpty(),
    check('idempresa', 'El ID de empresa es obligatorio').notEmpty(),
    check('idempresa', 'El ID de empresa debe ser un número').isNumeric(),
    validarCampos
], generarBalanceSumasSaldos);

module.exports = router;