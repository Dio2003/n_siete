/* PASO 2 */
/* ESTE CONTENIDO Y TODO LO RELACIONADO ES PARA QUE EL ALUMNO PUEDA INGRESAR A UNA SALA DE ESTUDIO 03/06/2025 */
const Detallesala = require("../models/ModelIngresarSala");
const { Op } = require("sequelize");
const bcryptjs = require("bcryptjs");
const Usuario = require("../models/usuario");
const Sala = require("../models/ModelSala");
const { existeSalaId } = require("../helpers/validacionesBD");

/* inicio */

/* funcion de guardar en la bd*/
const postController = async (req, res) => {
 /* const { estado = true, ...body } = req.body; // si no viene estado, por defecto true
  try {
    const detallesala = new Detallesala({ ...body, estado });
    await detallesala.save();
    // setTimeout(() => {
    res.json(detallesala);
    // }, 5000);
  } catch (error) {
    console.log(error);
  } */
 const { estado = true, id_sala, id_usuario, ...body } = req.body; // Desestructurar para tener id_sala y id_usuario

  try {
    // Validar si ya existe un registro activo (baja: true) con ese usuario y sala
    const yaExiste = await Detallesala.findOne({
      where: {
        id_sala,
        id_usuario,
        baja: true
      }
    });

    if (yaExiste) {
      return res.status(400).json({
        msg: 'El usuario ya está ingresado en esta sala.'
      });
    }

    // Si no existe, se crea normalmente
    const detallesala = new Detallesala({ ...body, id_sala, id_usuario, estado });
    await detallesala.save();
    res.json(detallesala);
  } catch (error) {
    console.log(error);
    res.status(500).json({ msg: 'Error al ingresar a la sala. Intente nuevamente.' });
  }
};


/* FUNCION PARA TRAER LAS SALAS EN las que está el alumno*/
const getContoller = async (req, res) => {
  const { desde = 0, limite = 10 } = req.query;
  const idusuario = req.params.id; // id del alumno

  try {
    const [total, detallesala] = await Promise.all([
      Detallesala.count({
        where: {
          id_usuario: idusuario,
          baja: true,
          estado: true
        }
      }),
      Detallesala.findAll({
        where: {
          id_usuario: idusuario,
          baja: true,
          estado: true
        },
        offset: parseInt(desde),
        limit: parseInt(limite),
        attributes: [
          "id_detallesala",
          "id_sala",
          "id_usuario",
          "estado",
          "createdAt",
          "updatedAt"
        ],
        include: [
          {
            model: Sala,
            attributes: ["id_sala", "sala", "id_usuario"],
            include: [
              {
                model: Usuario,
                attributes: ["nombre"]
              }
            ]
          }
        ]
      })
    ]);

    res.json({ total, detallesala });
  } catch (error) {
    console.error(error);
    res.status(500).json({ msg: "Hable con el administrador" });
  }
};

//FUNCION PARA TRAER LOS ALUMNOS POR SALA
const getControllerAlumSala = async (req, res) => {
  const { desde = 0, limite = 10 } = req.query;
  const idSala = req.params.id; // este es el id_sala

  try {
    const [total, detallesala] = await Promise.all([
      Detallesala.count({
        where: {
          id_sala: idSala,
          baja: true,
          estado: true
        }
      }),
      Detallesala.findAll({
        where: {
          id_sala: idSala,
          baja: true,
          estado: true
        },
        offset: parseInt(desde),
        limit: parseInt(limite),
        attributes: ["id_detallesala", "id_sala", "id_usuario", "estado"],
        include: [
          {
            model: Usuario, // Incluí los usuarios directamente
            attributes: ["id_usuario","cedula","nombre"] // Solo traé el nombre del usuario
          }
        ]
      })
    ]);

    res.json({ total, detallesala });
  } catch (error) {
    console.error(error);
    res.status(500).json({ msg: "Hable con el administrador" });
  }
};


// ELIMINAR SALA
const deleteController = async (req, res) => {
  try {
    const { id } = req.params;
    const detallesala = await Detallesala.findByPk(id);
    if (!detallesala) {
      return res.status(404).json({ msg: `No existe sala con id ${id}` });
    }
    await detallesala.update({ baja: false }); // baja es para salir de la sala, no es eliminar
    res.json({ mensaje: " Dada de baja con exito" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ msg: "Hable con el administrador" });
  }
};

// Exportar las funciones
module.exports = {
  postController,
  getContoller,
  deleteController,
  getControllerAlumSala
};
