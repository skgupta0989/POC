'use strict';

angular.module('projectApp')
  .controller('MainCtrl', function ($scope) {
              
              $("#signature").jSignature({color:"#00f",lineWidth:2});
              
              $scope.saveSignature = function(){
                var imageString = $("#signature").jSignature("getData","base30");
                alert(imageString);
              };
              
              $scope.resetSignature = function(){
              
                $("#signature").jSignature("clear");
                $("#imageDiv").html("");
             
              };
              
              $scope.signatureImage = function(){
                var $sigdiv = $("#signature");
              
                var datapair = $sigdiv.jSignature("getData", "svgbase64");
                var i = new Image();
                i.src = "data:" + datapair[0] + "," + datapair[1];
                $(i).appendTo($("#imageDiv")); // append the image (SVG) to DOM.

              };
        });