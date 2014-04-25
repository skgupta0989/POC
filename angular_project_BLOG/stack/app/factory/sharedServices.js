var myModule = angular.module('stackApp');
myModule.service('sharedService', function($cookies) {

//        var property = "";

        return {
            get: function (key) {
                var value=$cookies[key] ;
                return value ? angular.fromJson(value) : value;
                
            },
            put: function(key,value) {
               $cookies[key] = angular.toJson(value);
//               alert("$cookies"+$cookies[key]);
//               property = $cookies[key];
            },
            remove: function (key){
                delete $cookies[key];
            }
        };
       
     
        

});


