var app = angular.module('controlGastosApp', ['ngRoute', 'ngResource', 'ngToast']);

app.config(['ngToastProvider', function(ngToast) {
    ngToast.configure({
        verticalPosition: 'top',
        horizontalPosition: 'center',
        maxNumber: 3
    });
}]);

app.config(function($routeProvider, $httpProvider) {
    $httpProvider.interceptors.push('httpRequestInterceptor');
    $routeProvider.when('/', { templateUrl : 'pages/login.html', controller  : 'LoginCtrl'})
        .when('/registracion', {templateUrl : 'pages/registracion.html',controller  : 'RegistracionCtrl'})
        .when('/controlGastos', {templateUrl : 'pages/controlGastos.html', controller : 'ControlGastosCtrl'})
        .otherwise({redirectTo: '/'});
});

app.factory('httpRequestInterceptor', function ($q, ngToast) {
    return {
        'requestError':function (rejection) {
            dangerToast(rejection.data, ngToast);
            return $q.reject(rejection);
        },
        'responseError': function(rejection) {
            dangerToast(rejection.data, ngToast);
            return $q.reject(rejection);
        }
    };
});

var dangerToast = function (message, ngToast) {
    ngToast.create({
        className:'danger',
        content:message
    });
};