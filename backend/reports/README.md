# Directorio de Reportes JasperReports

Este directorio debe contener los archivos .jasper compilados.

## Archivos requeridos:
- `BalanceSumasSaldos.jasper` - Reporte de Balance de Sumas y Saldos

## Parámetros del reporte BalanceSumasSaldos:
- `DESDE` (String) - Fecha de inicio en formato YYYY-MM-DD
- `HASTA` (String) - Fecha de fin en formato YYYY-MM-DD  
- `IDEMPRESA` (Integer) - ID de la empresa

## Configuración:
- JasperReports: C:\jasperreports-7.0.3
- MySQL JDBC: C:\jdbc\mysql-connector-j-9.3.0.jar
- Base de datos: n_siete_bd

## Uso del endpoint:
```
GET /api/reportes/balance-sumas-saldos?desde=2025-01-01&hasta=2025-12-31&idempresa=1
```