const express = require("express");

const respuesta = require("../../red/respuesta");
const controlador = require("./controlador");

const router = express.Router();

//este es la api GET para optener los datos
router.get("/", todos);
router.get("/:id", uno);

//este es la api POST agregar o guardar los datos
router.post("/", insertar);

//este es la api PUT para actualizar los datos
router.put("/", actualizar);
//este es la api DELETE para eliminar
router.delete("/", eliminar);

//este es la api GET para optener todos los datos
async function todos(req, res, next) {
  try {
    const items = await controlador.todos(req.params.id);
    respuesta.success(req, res, items, 200);
  } catch (err) {
    next(err);
  }
}
//este es la api GET para optener solo un dato de la tabla empresas
async function uno(req, res, next) {
  try {
    const items = await controlador.uno(req.params.id);
    respuesta.success(req, res, items, 200);
  } catch (err) {
    next(err);
  }
}

// Función para insertar un nuevo registro
async function insertar(req, res, next) {
    try {
      console.log('Datos recibidos en el backend:', req.body);
      await controlador.insertar(req.body);
      respuesta.success(req, res, "Item Guardado con Exito", 201);
    } catch (err) {
      next(err);
    }
  }

// Función para actualizar un registro existente
async function actualizar(req, res, next) {
    try {
        console.log(req.body); // Verifica qué datos estás recibiendo
        await controlador.actualizar(req.body);
        respuesta.success(req, res, 'Item actualizado con éxito', 200);
    } catch (err) {
        console.error('Error en el backend:', err);
        next(err);
    }
}
// este es la api de eliminar
async function eliminar(req, res, next) {
  try {
    const items = await controlador.eliminar(req.body);
    respuesta.success(req, res, "Item eliminado exitosamente", 200);
  } catch (err) {
    next(err);
  }
}

module.exports = router;
