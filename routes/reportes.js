const { Router } = require('express');
const { check } = require('express-validator');
const { validar } = require('../middlewares/validarCampos');
const { validarJWT } = require('../middlewares/validarJWT');
const { generarBalanceSumasSaldos } = require('../controllers/reportes');

const router = Router();

// Endpoint para generar el reporte Balance de Sumas y Saldos
router.get('/balance-sumas-saldos', [
    validarJWT,
    check('desde', 'La fecha desde es obligatoria y debe tener formato YYYY-MM-DD').matches(/^\d{4}-\d{2}-\d{2}$/),
    check('hasta', 'La fecha hasta es obligatoria y debe tener formato YYYY-MM-DD').matches(/^\d{4}-\d{2}-\d{2}$/),
    check('idempresa', 'El ID de empresa es obligatorio y debe ser un número').isNumeric(),
    validar
], generarBalanceSumasSaldos);

module.exports = router;