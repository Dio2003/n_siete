/* PASO 2 */
/* ESTE CONTENIDO Y TODO LO RELACIONADO CON SALAS ES UNA PRUEBA PARA
OBTENER LA EMPRESA DEL USUARIO Y ASIGINARLE UNA EMPRESA AL ALUMNO
, ES UNA IDEA QUE PUEDE FUNCIONAR 03/06/2025 */
const { Sequelize } = require('sequelize');
const Sala = require("../models/ModelSala");
const DetalleSala = require("../models/ModelIngresarSala");
const { Op } = require('sequelize')
const bcryptjs = require("bcryptjs");
const Usuario = require("../models/usuario");

/* inicio */

/* funcion de guardar en la bd*/
const postController = async (req, res) => {
    const { estado = true, ...body } = req.body; // si no viene estado, por defecto true
  try {
    const sala = new Sala({ ...body, estado }); // agregar estado a los datos
    await sala.save();
    res.json(sala);
  } catch (error) {
    console.log(error);
    res.status(500).json({ msg: 'Hable con el administrador' });
  }
}

/* FUNCION PARA TRAER LAS SALAS */
const getContoller = async (req, res) => {
    let { desde, limite } = req.query;

    try{
        limite = parseInt(limite);
        desde = parseInt(desde);
        let salas, total;
        if (desde > -1 && limite > 0) {
            [total, salas] = await Promise.all([
                Sala.count(),
                Sala.findAll({
                   // where: { estado: true }, // traer solo las activas
                    offset: desde,
                    limit: limite,
                })
            ]);
        } else {
            [total, salas] = await Promise.all([
                Sala.count({ where: { estado: true } }),
                // Empresa.findAll()
                Sala.findAll({
                    where: { estado: true }, // traer solo las activas
                    attributes:['id_sala', 'sala', 'contra', 'id_usuario', 'estado','createdAt', 'updatedAt',
                        // Contador de cuántas veces se repite cada id_sala (con estado = true y baja = true)
            [
              Sequelize.literal(`(
            SELECT COUNT(*) 
            FROM detallesala AS d 
            WHERE d.id_sala = Sala.id_sala AND d.baja = true AND d.estado = true
        )`),
              "contador",
            ],
                    ],
                    include:[//para obtener el nombre del usuario profesor
                        {
                            model:Usuario,
                            attributes:['nombre']
                        }
                    ]
                })
            ]);
        }

        res.json({ total, salas });
    } catch (error) {
        console.log(error);
        res.status(500).json({ msg: 'Hable con el administrador' });
    }
}

// MODIFICAR SALA
const putController = async (req, res) => {
    const { id } = req.params;
    const { estado, ...body } = req.body; //TODO: el campo estado puede tener valor por defecto true
    try {
        const sala = await Sala.findByPk(id);
        await sala.update(body);

        res.json(sala);
    } catch (error) {
        console.log(error);
        res.status(500).json({ msg: 'Hable con el administrador' });
    }
}


// ELIMINAR SALA
const deleteController = async (req, res) => {
    try{
        const { id } = req.params;
        const sala = await Sala.findByPk(id);
        if (!sala) {
            return res.status(404).json({ msg: `No existe sala con id ${id}` });
        }
        await sala.update({ estado: false });
        res.json({ mensaje: "Sala eliminada" });

        // Marcar también como inactivos todos los registros en detallesala que tengan ese id_sala
        await DetalleSala.update(
            { estado: false },
            { where: { id_sala: id } }
        );

        res.json({ mensaje: "Sala eliminada junto con sus registros en detallesala" });
    } catch (error) {
        console.log(error);
        res.status(500).json({ msg: 'Hable con el administrador' });
    }
}

// obetener la contraseña por id para compararla
const getIdController = async (req, res) => {
    try{
        let idSala = req.params.id;
        let sala= await Sala.findOne({
            attributes:['contra'],
            where:{
                id_sala:idSala
            },
        });
        console.log(sala)
        res.json(sala);
    } catch (error) {
        console.log(error);
        res.status(500).json({ msg: 'Hable con el administrador' });
    }
}


// Exportar las funciones
module.exports = { 
    postController,
    getContoller,
    putController,
    deleteController,
    getIdController
}