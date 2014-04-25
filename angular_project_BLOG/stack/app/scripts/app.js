'use strict';

angular.module('stackApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config(function ($routeProvider) {
    $routeProvider.when('/', {templateUrl: 'views/main.html',controller: 'MainCtrl'});
    $routeProvider.when('/blog', {templateUrl: 'views/blog.html',controller: 'BlogCtrl'});
    $routeProvider.when('/logout', {templateUrl: 'views/main.html',controller: 'MainCtrl'})
      .otherwise({
        redirectTo: '/'
      });
  });
