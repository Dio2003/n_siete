# Directorio de Reportes JasperStarter

Este directorio debe contener los archivos .jasper compilados.

## Archivo requerido:
- `BalanceSumasSaldos.jasper` - Reporte de Balance de Sumas y Saldos

## Parámetros del reporte:
- `DESDE` (String) - Fecha de inicio en formato YYYY-MM-DD
- `HASTA` (String) - Fecha de fin en formato YYYY-MM-DD  
- `IDEMPRESA` (Integer) - ID de la empresa

## Configuración JasperStarter:
- JasperStarter: C:\jasperstarter\bin\jasperstarter.exe
- MySQL JDBC: C:\jdbc\mysql-connector-j-9.3.0.jar
- Base de datos: n_siete_bd (localhost:3306)
- Usuario: root / Contraseña: 1234

## Uso del endpoint:
```
GET /api/reportes/balance-sumas-saldos?desde=2025-01-01&hasta=2025-12-31&idempresa=1
```

## Instalación JasperStarter:
1. Descargar desde: https://sourceforge.net/projects/jasperstarter/
2. Extraer en C:\jasperstarter\
3. Asegurar que jasperstarter.exe esté en C:\jasperstarter\bin\