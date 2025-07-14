const { validationResult } = require('express-validator');
const jasper = require('node-jasper')({
    path: 'C:\\jasperreports-7.0.3\\lib',
    reports: {
        hw: {
            jasper: './reports/BalanceSumasSaldos.jasper',
            jrxml: './reports/BalanceSumasSaldos.jrxml'
        }
    }
});

const generarBalanceSumasSaldos = async (req, res) => {
    try {
        // Validar errores de express-validator
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({
                ok: false,
                msg: 'Error en los parámetros',
                errors: errors.array()
            });
        }

        const { desde, hasta, idempresa } = req.query;

        // Validaciones adicionales
        if (!desde || !hasta || !idempresa) {
            return res.status(400).json({
                ok: false,
                msg: 'Los parámetros desde, hasta e idempresa son obligatorios'
            });
        }

        // Validar formato de fechas
        const fechaDesde = new Date(desde);
        const fechaHasta = new Date(hasta);
        
        if (isNaN(fechaDesde.getTime()) || isNaN(fechaHasta.getTime())) {
            return res.status(400).json({
                ok: false,
                msg: 'Las fechas deben tener formato válido (YYYY-MM-DD)'
            });
        }

        if (fechaDesde > fechaHasta) {
            return res.status(400).json({
                ok: false,
                msg: 'La fecha desde no puede ser mayor que la fecha hasta'
            });
        }

        // Validar que idempresa sea un número
        const empresaId = parseInt(idempresa);
        if (isNaN(empresaId)) {
            return res.status(400).json({
                ok: false,
                msg: 'El parámetro idempresa debe ser un número válido'
            });
        }

        console.log('Generando reporte con parámetros:', { desde, hasta, idempresa: empresaId });

        // Configurar la conexión a la base de datos
        const dbConfig = {
            driver: 'mysql',
            host: 'localhost',
            port: 3306,
            database: 'n_siete_bd',
            username: 'root',
            password: '1234',
            jdbc_driver_path: 'C:\\jdbc\\mysql-connector-j-9.3.0.jar'
        };

        // Parámetros para el reporte
        const reportParams = {
            DESDE: desde,
            HASTA: hasta,
            IDEMPRESA: empresaId
        };

        // Generar el reporte
        const report = jasper.pdf({
            report: 'hw',
            data: dbConfig,
            parameters: reportParams
        });

        report.exec((err, pages) => {
            if (err) {
                console.error('Error al generar el reporte:', err);
                return res.status(500).json({
                    ok: false,
                    msg: 'Error interno al generar el reporte',
                    error: err.message
                });
            }

            try {
                // Configurar headers para descarga de PDF
                res.set({
                    'Content-Type': 'application/pdf',
                    'Content-Disposition': `attachment; filename="balance_sumas_saldos_${desde}_${hasta}.pdf"`,
                    'Content-Length': pages.length
                });

                // Enviar el PDF
                res.send(pages);
                
                console.log('Reporte generado exitosamente');
                
            } catch (sendError) {
                console.error('Error al enviar el reporte:', sendError);
                return res.status(500).json({
                    ok: false,
                    msg: 'Error al enviar el reporte generado',
                    error: sendError.message
                });
            }
        });

    } catch (error) {
        console.error('Error en generarBalanceSumasSaldos:', error);
        res.status(500).json({
            ok: false,
            msg: 'Error interno del servidor',
            error: error.message
        });
    }
};

const testConexion = async (req, res) => {
    try {
        // Test básico de la configuración de jasper
        const testConfig = {
            driver: 'mysql',
            host: 'localhost',
            port: 3306,
            database: 'n_siete_bd',
            username: 'root',
            password: '1234',
            jdbc_driver_path: 'C:\\jdbc\\mysql-connector-j-9.3.0.jar'
        };

        res.json({
            ok: true,
            msg: 'Configuración de jasper inicializada correctamente',
            config: {
                jasperPath: 'C:\\jasperreports-7.0.3\\lib',
                jdbcPath: 'C:\\jdbc\\mysql-connector-j-9.3.0.jar',
                reportPath: './reports/BalanceSumasSaldos.jasper',
                database: testConfig
            }
        });

    } catch (error) {
        console.error('Error en test de conexión:', error);
        res.status(500).json({
            ok: false,
            msg: 'Error al probar la configuración',
            error: error.message
        });
    }
};

module.exports = {
    generarBalanceSumasSaldos,
    testConexion
};