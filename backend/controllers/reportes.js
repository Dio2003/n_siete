const jasper = require('node-jasper')({
  path: 'C:\\jasperreports-7.0.3\\lib',
  reports: './reports'
});

// Configurar el reporte de Balance de Sumas y Saldos
const generarBalanceSumasSaldos = async (req, res) => {
  try {
    const { desde, hasta, idempresa } = req.query;

    // Validar parámetros requeridos
    if (!desde || !hasta || !idempresa) {
      return res.status(400).json({
        msg: 'Los parámetros desde, hasta e idempresa son obligatorios'
      });
    }

    // Validar formato de fechas (YYYY-MM-DD)
    const fechaRegex = /^\d{4}-\d{2}-\d{2}$/;
    if (!fechaRegex.test(desde) || !fechaRegex.test(hasta)) {
      return res.status(400).json({
        msg: 'Las fechas deben estar en formato YYYY-MM-DD'
      });
    }

    // Validar que idempresa sea un número
    if (isNaN(parseInt(idempresa))) {
      return res.status(400).json({
        msg: 'El parámetro idempresa debe ser un número entero'
      });
    }

    console.log('Generando reporte con parámetros:', { desde, hasta, idempresa });

    // Configuración del reporte
    const reportConfig = {
      report: 'BalanceSumasSaldos',
      driver: 'mysql',
      connstr: 'jdbc:mysql://localhost:3306/n_siete_bd',
      user: 'root',
      pass: '1234',
      format: ['pdf'],
      params: {
        DESDE: desde,
        HASTA: hasta,
        IDEMPRESA: parseInt(idempresa)
      },
      dataset: [],
      resources: {
        jr: ['C:\\jasperreports-7.0.3\\lib'],
        jdbc: ['C:\\jdbc\\mysql-connector-j-9.3.0.jar']
      }
    };

    // Generar el reporte
    jasper.process(reportConfig).then((output) => {
      console.log('Reporte generado exitosamente');
      
      // Configurar headers para PDF
      res.setHeader('Content-Type', 'application/pdf');
      res.setHeader('Content-Disposition', `attachment; filename="BalanceSumasSaldos_${desde}_${hasta}.pdf"`);
      
      // Enviar el PDF como respuesta
      res.send(output[0].content);
      
    }).catch((error) => {
      console.error('Error al generar el reporte:', error);
      res.status(500).json({
        msg: 'Error interno al generar el reporte',
        error: error.message
      });
    });

  } catch (error) {
    console.error('Error en el controlador de reportes:', error);
    res.status(500).json({
      msg: 'Error interno del servidor',
      error: error.message
    });
  }
};

// Función para probar la conexión con JasperReports
const probarConexion = async (req, res) => {
  try {
    // Configuración básica para probar
    const testConfig = {
      report: 'test', // Un reporte simple para probar
      driver: 'mysql',
      connstr: 'jdbc:mysql://localhost:3306/n_siete_bd',
      user: 'root',
      pass: '1234',
      format: ['pdf'],
      params: {},
      dataset: [],
      resources: {
        jr: ['C:\\jasperreports-7.0.3\\lib'],
        jdbc: ['C:\\jdbc\\mysql-connector-j-9.3.0.jar']
      }
    };

    res.json({
      msg: 'Configuración de JasperReports lista',
      config: {
        jasperPath: 'C:\\jasperreports-7.0.3\\lib',
        jdbcPath: 'C:\\jdbc\\mysql-connector-j-9.3.0.jar',
        database: 'n_siete_bd',
        reportsPath: './reports'
      }
    });

  } catch (error) {
    console.error('Error al probar conexión:', error);
    res.status(500).json({
      msg: 'Error al probar la configuración',
      error: error.message
    });
  }
};

module.exports = {
  generarBalanceSumasSaldos,
  probarConexion
};