'use strict';

angular.module('stackApp')
  .controller('MainCtrl', function ($scope,$location,$rootScope,sharedService,$http,$cookies) {
      
      $scope.validate = function(){
          var msg = $scope.login;
           $http({
                        url: 'http://127.0.0.1:8080/user/login',
                        method: "POST",
                        data: msg
                       
                    }).success(function (data, status) {
                       

                        sharedService.put('logger',data.name);
                        sharedService.put('userid',data._id);
                        $location.path('/blog');
                     console.log(data.name);
                    }).error(function (data, status) {                   
                        alert("failure"+status); 
                    });

            };
            
            $scope.register = function(){
               
                var pass = $scope.regPass;
                var cpass = $scope.regConfPass;
               
                if(pass === cpass){
                    
                    var postData = {"name":$scope.regName,"phonenumber":$scope.regNum,"emailId":$scope.regEmail,"password":$scope.regPass};
//                    alert("hi" +postData);
                    $http({
                        url: 'http://127.0.0.1:8080/user',
                        method: "POST",
                        data: postData
                       
                    }).success(function (data, status) {
                       
                        $scope.regName='';$scope.regNum ='';$scope.regEmail='';$scope.regPass ='';$scope.regConfPass='';
                        sharedService.put('logger',data.name);
                        sharedService.put('userid',data._id);
                        $location.path('/blog');
//                     
                    }).error(function (data, status) {
//                    
                        alert("failure"+status); 
                    });
                }else{
                    alert("password does not match ");
                    $scope.regPass ='';$scope.regConfPass='';
                }
                 
               
                
                
            };
         
             
  });



