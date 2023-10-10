// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("bootstrap");

document.addEventListener("turbolinks:load", function () {
  $(function () {
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="popover"]').popover();
  });
});

document.addEventListener('click', handleLike);
   
function handleLike(e){
 if(e.target.className==='like-button'){      
   var micropostId = e.target.getAttribute('id');
   var buttonText = e.target.innerText;
    var likes_count= document.getElementById(micropostId)
   console.log(likes_count)
   
     var xhr = new XMLHttpRequest();        
     xhr.open('POST', '/microposts/' + micropostId + '/toggle_like', true);
     xhr.setRequestHeader('Content-Type', 'application/json');

     xhr.onload = function() {          
       if (xhr.status === 200) {
         var responseData = JSON.parse(xhr.responseText);            
         if (responseData.liked) {
           e.target.innerText = 'Dislike';
           if(responseData.likes_count!=undefined){
           likes_count.innerText=responseData.likes_count;
           }
         } else {
           e.target.innerText = 'Like';
           if(responseData.likes_count!=undefined){
           likes_count.innerText=responseData.likes_count;
           }
         }
       }
     };

     xhr.send();
  
 }

}