const { exec } = require('child_process');
const path = require('path');
const fs = require('fs');

const generarBalanceSumasSaldos = async (req, res) => {
    try {
        const { desde, hasta, idempresa } = req.query;

        // Validar parámetros obligatorios
        if (!desde || !hasta || !idempresa) {
            return res.status(400).json({
                ok: false,
                msg: 'Los parámetros desde, hasta e idempresa son obligatorios'
            });
        }

        // Validar formato de fechas (YYYY-MM-DD)
        const fechaRegex = /^\d{4}-\d{2}-\d{2}$/;
        if (!fechaRegex.test(desde) || !fechaRegex.test(hasta)) {
            return res.status(400).json({
                ok: false,
                msg: 'Las fechas deben estar en formato YYYY-MM-DD'
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

        // Rutas de archivos
        const jasperFile = path.join(__dirname, '../reports/BalanceSumasSaldos.jasper');
        const outputDir = path.join(__dirname, '../temp');
        const outputFile = `balance_${Date.now()}.pdf`;
        const outputPath = path.join(outputDir, outputFile);

        // Crear directorio temporal si no existe
        if (!fs.existsSync(outputDir)) {
            fs.mkdirSync(outputDir, { recursive: true });
        }

        // Verificar que el archivo .jasper existe
        if (!fs.existsSync(jasperFile)) {
            return res.status(404).json({
                ok: false,
                msg: 'Archivo de reporte no encontrado: BalanceSumasSaldos.jasper'
            });
        }

        // Construir comando JasperStarter
        const jasperStarterPath = 'C:\\jasperstarter\\bin\\jasperstarter.exe'; // Ajusta esta ruta según tu instalación
        const jdbcPath = 'C:\\jdbc\\mysql-connector-j-9.3.0.jar';
        
        const command = `"${jasperStarterPath}" process "${jasperFile}" ` +
            `-f pdf ` +
            `-o "${outputDir}" ` +
            `-n "${outputFile.replace('.pdf', '')}" ` +
            `-t mysql ` +
            `-H localhost ` +
            `-u root ` +
            `-p 1234 ` +
            `-n n_siete_bd ` +
            `--jdbc-dir "C:\\jdbc" ` +
            `-P DESDE="${desde}" ` +
            `-P HASTA="${hasta}" ` +
            `-P IDEMPRESA=${empresaId}`;

        console.log('Ejecutando comando:', command);

        // Ejecutar JasperStarter
        exec(command, { timeout: 30000 }, (error, stdout, stderr) => {
            if (error) {
                console.error('Error ejecutando JasperStarter:', error);
                console.error('stderr:', stderr);
                return res.status(500).json({
                    ok: false,
                    msg: 'Error al generar el reporte',
                    error: error.message,
                    details: stderr
                });
            }

            console.log('JasperStarter stdout:', stdout);

            // Verificar que el archivo PDF se generó
            if (!fs.existsSync(outputPath)) {
                return res.status(500).json({
                    ok: false,
                    msg: 'El archivo PDF no se generó correctamente'
                });
            }

            try {
                // Leer el archivo PDF
                const pdfBuffer = fs.readFileSync(outputPath);

                // Configurar headers para descarga
                res.set({
                    'Content-Type': 'application/pdf',
                    'Content-Disposition': `attachment; filename="balance_sumas_saldos_${desde}_${hasta}.pdf"`,
                    'Content-Length': pdfBuffer.length
                });

                // Enviar el PDF
                res.send(pdfBuffer);

                // Limpiar archivo temporal después de un breve delay
                setTimeout(() => {
                    try {
                        if (fs.existsSync(outputPath)) {
                            fs.unlinkSync(outputPath);
                            console.log('Archivo temporal eliminado:', outputPath);
                        }
                    } catch (cleanupError) {
                        console.error('Error al limpiar archivo temporal:', cleanupError);
                    }
                }, 1000);

                console.log('Reporte generado y enviado exitosamente');

            } catch (readError) {
                console.error('Error al leer el archivo PDF:', readError);
                return res.status(500).json({
                    ok: false,
                    msg: 'Error al leer el archivo PDF generado',
                    error: readError.message
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

module.exports = {
    generarBalanceSumasSaldos
};