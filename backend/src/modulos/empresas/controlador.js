const db = require('../../DB/mysql');

const TABLA = 'empresas';      //tabla que se quiere acceder

function todos(){
    return db.todos(TABLA)
}


function uno(id){
    return db.uno(TABLA, id)
}

function insertar(body){
    return db.insertar(TABLA, body)
}
function actualizar(body){
    return db.actualizar(TABLA, body)
}



function eliminar(body){
    return db.eliminar(TABLA, body)
}

module.exports = {
    todos,
    uno,
    insertar,
    actualizar,
    eliminar
}