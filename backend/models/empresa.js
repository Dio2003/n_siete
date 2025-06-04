const { DataTypes } = require("sequelize");
const db = require("../db/connection");
const Periodo = require("./periodo"); // Asegurate que exista este modelo
const Usuario = require("./usuario"); // Asegurate que exista este modelo

const Empresa = db.define('Empresa', {
    id_empresa: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nombre: { type: DataTypes.STRING, allowNull: false },
    sigla: { type: DataTypes.STRING, allowNull: false },
    id_periodo: { type: DataTypes.INTEGER, allowNull: false },
    id_usuario: { type: DataTypes.INTEGER, allowNull: false },
    estado: { type: DataTypes.BOOLEAN, allowNull: true }
}, {
    timestamps: false,
    tableName: 'empresa'
});

Empresa.belongsTo(Periodo, {
    foreignKey: 'id_periodo'
});
Empresa.belongsTo(Usuario, {
    foreignKey: 'id_usuario'
});

module.exports = Empresa;
