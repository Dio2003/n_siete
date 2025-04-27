const { DataTypes } = require("sequelize");
const db = require("../db/connection");
const Periodo = require("./periodo"); // Asegurate que exista este modelo

const Empresa = db.define('Empresa', {
    id_empresa: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    empresa: { type: DataTypes.STRING, allowNull: false },
    sigla: { type: DataTypes.STRING, allowNull: false },
    id_periodo: { type: DataTypes.INTEGER, allowNull: false },
    estado: { type: DataTypes.BOOLEAN, allowNull: true }
}, {
    timestamps: false,
    tableName: 'empresas'
});

Empresa.belongsTo(Periodo, {
    foreignKey: 'id_periodo'
});

module.exports = Empresa;
