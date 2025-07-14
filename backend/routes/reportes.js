const { Router } = require("express");
const { generarBalanceSumasSaldos, probarConexion } = require("../controllers/reportes");
const { validarJWT } = require("../middlewares/validarJWT");

const router = Router();

// Ruta para generar el reporte de Balance de Sumas y Saldos
// GET /api/reportes/balance-sumas-saldos?desde=2025-01-01&hasta=2025-12-31&idempresa=1
router.get('/balance-sumas-saldos', [
    validarJWT // Validar que el usuario esté autenticado
], generarBalanceSumasSaldos);

// Ruta para probar la configuración de JasperReports
router.get('/test-conexion', [
    validarJWT
], probarConexion);

module.exports = router;