const Empresa = require("../models/empresa");
const { Op } = require('sequelize')
const bcryptjs = require("bcryptjs");
const Periodo = require("../models/periodo");


const getIdController = async (req, res) => {
    try{
        let idEmpresa = req.params.id;
        let empresa= await Empresa.findOne({
            attributes:['id_empresa', 'nombre', 'sigla','estado', 'id_periodo','id_Usuario', 'createdAt', 'updatedAt'],
            where:{
                id_empresa:idEmpresa
            },
            include:[
                {
                    model:Periodo,
                    attributes:['nombre_periodo']
                }
            ]
        });
        console.log(empresa)
        res.json(empresa);
    } catch (error) {
        console.log(error);
        res.status(500).json({ msg: 'Hable con el administrador' });
    }
}
const getIdControllerUser = async (req, res) => {
    try{
        let idUser = req.params.id;
        let empresa= await Empresa.findOne({
            attributes:['id_empresa', 'nombre', 'sigla','estado', 'id_periodo','id_Usuario', 'createdAt', 'updatedAt'],
            where:{
                id_Usuario:idUser
            },
            include:[
                {
                    model:Periodo,
                    attributes:['nombre_periodo']
                }
            ]
        });
        console.log(empresa)
        res.json(empresa);
    } catch (error) {
        console.log(error);
        res.status(500).json({ msg: 'Hable con el administrador' });
    }
}

const getContoller = async (req, res) => {
    let { desde, limite } = req.query;

    try{
        limite = parseInt(limite);
        desde = parseInt(desde);
        let empresas, total;
        if (desde > -1 && limite > 0) {
            [total, empresas] = await Promise.all([
                Empresa.count(),
                Empresa.findAll({
                    where: { estado: true }, // traer solo las activas
                    offset: desde,
                    limit: limite,
                })
            ]);
        } else {
            [total, empresas] = await Promise.all([
                Empresa.count({ where: { estado: true } }),
                // Empresa.findAll()
                Empresa.findAll({
                    where: { estado: true }, // traer solo las activas
                    attributes:['id_empresa', 'nombre', 'sigla','id_periodo','id_usuario',  'estado','createdAt', 'updatedAt'],
                    include:[//para obtener el nombre del periodo
                        {
                            model:Periodo,
                            attributes:['nombre_periodo']
                        }
                    ]
                })
            ]);
        }

        res.json({ total, empresas });
    } catch (error) {
        console.log(error);
        res.status(500).json({ msg: 'Hable con el administrador' });
    }
}

const postController = async (req, res) => {
    
    const { estado, ...body } = req.body; //TODO: el campo estado puede tener valor por defecto true
    try {

        
        
        const empresa = new Empresa(body);
        await empresa.save();
        // setTimeout(() => {
            res.json(empresa);
        // }, 5000);
    } catch (error) {
        console.log(error);
    }
}

const putController = async (req, res) => {
    const { id } = req.params;
    const { estado, ...body } = req.body; //TODO: el campo estado puede tener valor por defecto true
    try {
        const empresa = await Empresa.findByPk(id);

        

        await empresa.update(body);

        res.json(empresa);
    } catch (error) {
        console.log(error);
        res.status(500).json({ msg: 'Hable con el administrador' });
    }
}

const deleteController = async (req, res) => {
    try{
        const { id } = req.params;
        const empresa = await Empresa.findByPk(id);
        if (!empresa) {
            return res.status(404).json({ msg: `No existe empresa con id ${id}` });
        }
        await empresa.update({ estado: false });
        res.json({ mensaje: "Empresa eliminada" });
    } catch (error) {
        console.log(error);
        res.status(500).json({ msg: 'Hable con el administrador' });
    }
}

// para asignar la empresa a un usuario
const actualizarUsuarioEmpresa = async (req, res) => {
  const { id } = req.params;
  const { id_usuario } = req.body;

  try {
    const empresa = await Empresa.findByPk(id);

    if (!empresa) {
      return res.status(404).json({ msg: 'Empresa no encontrada' });
    }

    // Verificar si el usuario ya está asignado a otra empresa
    const empresaExistente = await Empresa.findOne({
      where: { id_usuario }
    });

    // Si ya está asignado y no es la misma empresa, impedirlo
    if (empresaExistente && empresaExistente.id_empresa !== empresa.id_empresa) {
      return res.status(400).json({ msg: 'Este usuario ya está asignado a otra empresa' });
    }

    // Solo actualizamos el campo id_usuario
    await empresa.update({ id_usuario });

    res.json({ msg: 'Usuario asignado correctamente a la empresa', empresa });
  } catch (error) {
    console.error(error);
    res.status(500).json({ msg: 'Error del servidor' });
  }
};



module.exports = {
    getContoller,
    postController,
    putController,
    deleteController,
    getIdController,
    actualizarUsuarioEmpresa,
    getIdControllerUser
}