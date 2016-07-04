app.service('ControlGastosService', function($http) {
    return {
        login: function(usuario, callback) {
            $http.post('/login/' + usuario.nombre + '/' + usuario.password).success(callback);
        },
        registracion: function(usuario, callback) {
            $http.put('/registracion/'+ usuario.nombre + '/' + usuario.password).success(callback);
        },
        logout: function(usuario, callback){
            $http.post('/logout/' + usuario.id).success(callback)
        },
        gastos: function(usuario, callback){
            $http.get('/gastos/' + usuario.id).then(callback)
        },
        submitGasto: function (usuario, gasto, callback) {
            $http.put('/gastos/' + gasto.descripcion + "/" + gasto.monto + "/" + usuario.id).then(callback)
        },
        submitFiltro: function (usuario, descripcion, callback) {
            $http.get('/gastos/' + descripcion + "/" + usuario.id).then(callback)
        },
        submitCalculoIndice: function (usuario, indice, callback) {
            $http.get('/indice/' + indice.anio + '/' + indice.descripcion + '/' + usuario.id).then(callback)
        }
    }
});
