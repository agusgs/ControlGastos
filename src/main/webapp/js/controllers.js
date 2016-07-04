app.controller('LoginCtrl', function ($rootScope, $scope, $location, ControlGastosService, ngToast) {
    $scope.usuario = {'nombre': '', 'password': ''};
    $scope.autenticar = function () {
        if(($scope.usuario.nombre == "") || ($scope.usuario.password == "")){
            dangerToast("Complete usuario y contraseña", ngToast)
        }
        else{
            ControlGastosService.login($scope.usuario, function (data) {
                $rootScope.usuarioLogueado = data;
                $location.path('controlGastos');
            });
        }
    };
    $scope.registrarse = function () {
        $location.path('registracion')
    };
});

app.controller('RegistracionCtrl', function ($rootScope, $scope, $location, ControlGastosService, ngToast) {
    $scope.usuario = {'nombre': '', 'password': ''};
    $scope.registrar = function () {
        if(($scope.usuario.nombre == "") || ($scope.usuario.password == "")){
            dangerToast("Complete usuario y contraseña", ngToast)
        }
        else{
            ControlGastosService.registracion($scope.usuario, function (data) {
                $rootScope.usuarioLogueado = data;
                $location.path('controlGastos');
            });
        }

    };
});

app.controller('ControlGastosCtrl', function ($rootScope, $scope, $location, ControlGastosService, ngToast) {
    $scope.nuevoGasto = {'descripcion':"", 'monto':""};
    $scope.descripcionAFiltrar = "";
    $scope.indice = {'anio':"", 'descripcion':""};

    $scope.usuario = $rootScope.usuarioLogueado;


    ControlGastosService.gastos($rootScope.usuarioLogueado, function (response) {
        $scope.gastos = response.data;
        $scope.gastosFiltro = response.data;
    });

    $scope.logout = function () {
        ControlGastosService.logout($scope.usuario, function () {
            $rootScope.usuarioLogueado = {};
            $location.path('/');
        })
    };

    $scope.agregarGasto = function () {
        if(($scope.nuevoGasto.descripcion == "") || ($scope.nuevoGasto.monto == "")){
            dangerToast("Debe ingresar descripcion y monto", ngToast)
        }
        else{
            ControlGastosService.submitGasto($scope.usuario, $scope.nuevoGasto, function (response) {
                $scope.gastos = response.data;
                $scope.gastosFiltro = response.data;
            })
        }

    };

        $scope.filtrarGastos = function () {
        if($scope.descripcionAFiltrar){
            ControlGastosService.submitFiltro($scope.usuario, $scope.descripcionAFiltrar, function (response) {
                $scope.gastosFiltro = response.data;
            })
        }else{
            ControlGastosService.gastos($scope.usuario, function (response) {
                $scope.gastosFiltro = response.data;
            });
        }
    };

    $scope.calcularIndice = function () {
        if(($scope.indice.anio == "") || ($scope.indice.descripcion == "")){
            dangerToast("Debe ingresar año y descripcion", ngToast)
        }
        else {
            ControlGastosService.submitCalculoIndice($scope.usuario, $scope.indice, function (response) {
                $scope.resultado = response.data;
            })
        }
    }
});
