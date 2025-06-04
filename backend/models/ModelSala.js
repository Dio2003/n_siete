/* PASO 1 */
/* ESTE CONTENIDO Y TODO LO RELACIONADO CON SALAS ES UNA PRUEBA PARA
OBTENER LA EMPRESA DEL USUARIO Y ASIGINARLE UNA EMPRESA AL ALUMNO
, ES UNA IDEA QUE PUEDE FUNCIONAR 03/06/2025 */

const { DataTypes } = require("sequelize");
const db = require("../db/connection");
//sala se conecta con usuarios
const Usuarios = require("./usuario"); 

const Sala = db.define('Sala', {
    id_sala: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    sala: { type: DataTypes.STRING, allowNull: false },
    contra: { type: DataTypes.STRING, allowNull: false },
    id_usuario: { type: DataTypes.INTEGER, allowNull: false },
    estado: { type: DataTypes.BOOLEAN, allowNull: true }
}, {
    timestamps: false,
    tableName: 'sala'
});

Sala.belongsTo(Usuarios, {
    foreignKey: 'id_usuario'
});

module.exports = Sala;