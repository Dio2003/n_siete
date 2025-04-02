const mysql = require("mysql");
const config = require("../config");

const dbconfig = {
  host: config.mysql.host,
  user: config.mysql.user,
  password: config.mysql.password,
  database: config.mysql.database,
};
let conexion;

function conMysql() {
  conexion = mysql.createConnection(dbconfig);

  conexion.connect((err) => {
    if (err) {
      console.log("[db err]", err);
      setTimeout(conMysql, 200);
    } else {
      console.log("DB Conectada!!");
    }
  });

  conexion.on("error", (err) => {
    console.log("[db err]", err);
    if (err.code === "PROTOCOL_CONNECTION_LOST") {
      conMysql();
    } else {
      throw err;
    }
  });
}
conMysql();
// funcion para ver todos los datos de la tabla
function todos(tabla) {
  return new Promise((resolve, reject) => {
    conexion.query(`SELECT * FROM ${tabla}`, (error, result) => {
      return error ? reject(error) : resolve(result);
    });
  });
}
// funcion para ver solo una empresa especifica
function uno(tabla, id) {
  return new Promise((resolve, reject) => {
    conexion.query(`SELECT * FROM ${tabla} WHERE id_empresa = ?`, [id],(error, result) => {
      return error ? reject(error) : resolve(result);
    });
  });
}


// Función para insertar en la tabla
function insertar(tabla, data) {
  return new Promise((resolve, reject) => {
    conexion.query(`INSERT INTO ${tabla} SET ?`, data, (error, result) => {
      return error ? reject(error) : resolve(result);
    });
  });
}

function actualizar(tabla, data) {
  return new Promise((resolve, reject) => {
    // Validamos si `data.id_empresa` es null o undefined antes de realizar la consulta
    if (data.id_empresa === null || data.id_empresa === undefined) {
      return reject(new Error("El id_empresa es inválido o no está definido"));
    }
    
    // Utilizamos placeholders para evitar inyecciones SQL
    conexion.query('UPDATE ?? SET ? WHERE id_empresa = ?', [tabla, data, data.id_empresa], (error, result) => {
      return error ? reject(error) : resolve(result);
    });
  });
}

// funcion para eliminar la empresa dentro de la tabla
function eliminar(tabla, data) {
  return new Promise((resolve, reject) => {
    conexion.query(`DELETE FROM ${tabla} WHERE id_empresa = ?`, data.id, (error, result) => {
      return error ? reject(error) : resolve(result);
    });
  });
}

module.exports = {
  todos,
  uno,
  insertar,
  actualizar,
  eliminar
};
