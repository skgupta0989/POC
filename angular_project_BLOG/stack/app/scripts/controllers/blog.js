'use strict';

angular.module('stackApp')
  .controller('BlogCtrl', function ($scope,$http,sharedService,$location,$cookies) {
      
     $scope.property = sharedService.get('logger');        
     $scope.username = $scope.property;
     $scope.uId =  sharedService.get('userid');  

        
                var postMsg = {
                    "uid":$scope.uId
                            };
                $http({url: 'http://127.0.0.1:8080/posts',method: "POST",data: postMsg
                    }).success(function (data, status) {
                      $scope.posts = data;
                    }).error(function (data, status) {                   
                        alert("failure"+status); 
                    });
      
      
      
//      logout button function-------------------------------
     $scope.logout = function(){
         sharedService.remove('logger');
         sharedService.remove('userid');
         $location.path('/logout');
           
     };
     

       
//     post blog bbutton ---------------------------------------
     $scope.postBlog = function(){

            if ($scope.postText === "" || $scope.postText ===null || $scope.postText === undefined){
                
              alert("put some content first");
            }else{
                
                var postData = {
                        "userId":$scope.uId,
                        "name": $scope.property,
                        "blog": $scope.postText,
                        "like": 0,
                        "buttonName":"Like",
                        "comments": []
                         
                        };
//                    alert("hi" +postData);
                    $http({
                        url: 'http://127.0.0.1:8080/posts/blogPost',
                        method: "POST",
                        data: postData
                    }).success(function (data, status) {
                                 $scope.postText='';
                                 alert(""+data.name);
                                var postMsg = {
                                    "uid":$scope.uId
                                     };
                                    $http({url: 'http://127.0.0.1:8080/posts',method: "POST",data: postMsg
                                 }).success(function (data, status) {
                                        $scope.posts = data; 
                                    }).error(function (data, status) {                   
                                alert("failure"+status); 
                                    });
                    }).error(function (data, status) {
                        alert("failure"+status); 
                    });
            }
     };
     
//     like button function ---------------------------------------
    
        $scope.likePostOrUnlike = function(value){
            var name = value.buttonName;
          
            if(name === "Like"){
                var count = value.like;
                var y = count+1;
             
                var postLikeValue = {
                    "id":value._id,
                    "like":y,
                    "buttonName":"Unlike"
                            };
                            
                            $http({
                            url: 'http://127.0.0.1:8080/posts/updateLike',
                            method: "POST",
                            data: postLikeValue                          
                             }).success(function (data, status) {
                                   var postMsg = {
                                    "uid":$scope.uId
                                    };
                                    $http({url: 'http://127.0.0.1:8080/posts',method: "POST",data: postMsg
                                     }).success(function (data, status) {
                                            $scope.posts = data;
                                    }).error(function (data, status) {                   
                                            alert("failure"+status); 
                                    });
                             }).error(function (data, status) {                   
                                 alert("failure outer"+status); 
                            });
            }else{
                var count = value.like;
                var y = count-1;
                var postLikeValue = {
                    "id":value._id,
                    "like":y,
                    "buttonName":"Like"
                            };
                            
                            $http({
                            url: 'http://127.0.0.1:8080/posts/updateLike',
                            method: "POST",
                            data: postLikeValue                          
                             }).success(function (data, status) {
                                   var postMsg = {
                                    "uid":$scope.uId
                                            };
                                        $http({url: 'http://127.0.0.1:8080/posts',method: "POST",data: postMsg
                                         }).success(function (data, status) {
                                             $scope.posts = data;
                                        }).error(function (data, status) {                   
                                            alert("failure"+status); 
                                        });
                             }).error(function (data, status) {                   
                                 alert("failure outer"+status); 
                            });
            }
            
        };
        
//        postComment function ------------------------------------
        
        $scope.postComment = function(val,value){           
            var x = $scope.property;
            var z = ":";
            var y = x.concat(z,val);

            if(val ==='' || val ===null || val === undefined){
                  alert("enter your comments"); 
            }
            else
            {
                    var commentMsg = {
                    "id":value._id,
                    "comment":y
                            };
                            
                            $http({
                            url: 'http://127.0.0.1:8080/posts/commentBlog',
                            method: "POST",
                            data: commentMsg                          
                             }).success(function (data, status) {
                                 value.comments.push(y);  
                             }).error(function (data, status) {                   
                                 alert("not able to post comment.Failure status:"+status); 
                            });
              }
         };
        
        $scope.commentLike = function(){
            $scope.commentLikes = 1;
        };
    
  });
       


