@@ .. @@
        this.salasR = '/api/crearsalas'; // de salas paso 4 03/06/2025
         this.ingresarsalasR = '/api/ingresarsalas'; // de detallesalas paso 4 03/06/2025
-        this.reportesR = '/api/reportes'; // para reportes con JasperReports
+        this.reportesR = '/api/reportes'; // para reportes con JasperStarter
         this.dbConnection();
@@ .. @@
         this.app.use(this.salasR, require('./../routes/RoutesSala')); // de salas paso 4 03/06/2025
         this.app.use(this.ingresarsalasR, require('./../routes/RoutesIngresarSala')); // de detallesalas paso 4 03/06/2025
-        this.app.use(this.reportesR, require('./../routes/reportes')); // para reportes
+        this.app.use(this.reportesR, require('./../routes/reportes')); // para reportes con JasperStarter
     }