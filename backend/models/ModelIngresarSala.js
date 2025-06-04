/* PASO 1 */
/* ESTE CONTENIDO Y TODO LO RELACIONADO ES PARA QUE EL ALUMNO PUEDA INGRESAR A UNA SALA DE ESTUDIO 03/06/2025 */

const { DataTypes } = require("sequelize");
const db = require("../db/connection");
//sala se conecta con usuarios y salas
const Usuarios = require("./usuario"); 
const Salas = require("./ModelSala"); 

const DetalleSala = db.define('DetalleSala', {
    id_detallesala: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    id_sala: { type: DataTypes.STRING, allowNull: false },
    id_usuario: { type: DataTypes.INTEGER, allowNull: false },
    baja: { type: DataTypes.BOOLEAN, allowNull: true },
    estado: { type: DataTypes.BOOLEAN, allowNull: true }
}, {
    timestamps: false,
    tableName: 'detallesala'
});

DetalleSala.belongsTo(Usuarios, {
    foreignKey: 'id_usuario'
});
DetalleSala.belongsTo(Salas, {
    foreignKey: 'id_sala'
});

module.exports = DetalleSala;