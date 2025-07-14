# Directorio de Reportes

Este directorio contiene los archivos .jasper necesarios para la generación de reportes.

## Archivos requeridos:

### BalanceSumasSaldos.jasper
- **Descripción**: Reporte de Balance de Sumas y Saldos
- **Parámetros requeridos**:
  - `DESDE` (Date): Fecha de inicio del período
  - `HASTA` (Date): Fecha de fin del período  
  - `IDEMPRESA` (Integer): ID de la empresa

## Configuración:

### JasperReports
- **Ruta de instalación**: `C:\jasperreports-7.0.3`
- **Librería utilizada**: node-jasper

### Base de datos
- **Motor**: MySQL
- **Host**: localhost:3306
- **Base de datos**: n_siete_bd
- **Conector JDBC**: `C:\jdbc\mysql-connector-j-9.3.0.jar`

## Uso:

1. Colocar el archivo `BalanceSumasSaldos.jasper` en este directorio
2. El endpoint estará disponible en: `GET /api/reportes/balance-sumas-saldos`
3. Parámetros de consulta requeridos: `desde`, `hasta`, `idempresa`

## Ejemplo de uso:
```
GET /api/reportes/balance-sumas-saldos?desde=2025-01-01&hasta=2025-12-31&idempresa=1
```