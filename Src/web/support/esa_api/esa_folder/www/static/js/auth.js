var loginURL = "/login";
var logoutURL = "/logoff";
var userAgent = navigator.userAgent.toLowerCase();
var firstLogIn = true;
 
var login = function() {
    var form = document.forms[0];
    var username = form.username.value;
    var password = form.password.value;
	var host = form.host.value;
  	var _login = function(){

    var redirectURL = form.redirect && form.redirect.value || "";   


    $("#imgProgress").show();  

    if  (document.getElementById('myModalFormId') !== null ) {
        remove ('myModalFormId');
    }


	if (username === "" || password === "") {
             if (document.getElementById('myModalFormId') === null ) {		
                    var newdiv = document.createElement('div');
	                  newdiv.innerHTML = "<br>Invalid Credentials</br>";
                    newdiv.id = 'myModalFormId';
                    document.getElementById("myModalForm").appendChild(newdiv);
                     $("#imgProgress").hide();
               } 
	}else{  
         
          //Instantiate HTTP Request
          var request = ((window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP"));
    	    request.open("GET", host.concat(loginURL), true, username, password);
	        request.send(null);
    
          //Process Response
          request.onreadystatechange = function(){
             if (request.readyState == 4) {
                 if (request.status==200) {
                     if (redirectURL === "") {   
                        window.location=host.concat("/");
                    } else {
                        window.location=host.concat(redirectURL);
                    }

 		}
                else{
                  if (navigator.userAgent.toLowerCase().indexOf("firefox") != -1){                       
                     }
                   
		  if (document.getElementById('myModalFormId') === null ) {		
                    var newdiv = document.createElement('div');
	                   newdiv.innerHTML = "<br>Invalid Credentials</br>";
                    newdiv.id = 'myModalFormId';
                    document.getElementById("myModalForm").appendChild(newdiv);
                     $("#imgProgress").hide();    
                   } 

                  }
               }
            }
        }
    }
 
    var userAgent = navigator.userAgent.toLowerCase();
    if (userAgent.indexOf("firefox") != -1){ //TODO: check version number
        if (firstLogIn) _login();
        else logoff(_login);
    }
    else{
        _login();
    }
 
    if (firstLogIn) firstLogIn = false;
};
 
 
var logoff = function(callback){
	   var form = document.forms[0];
     var host = form.host.value;
	  
    if (userAgent.indexOf("msie") != -1) {
        document.execCommand("ClearAuthenticationCache");
    }
    else if (userAgent.indexOf("firefox") != -1){ //TODO: check version number
 
        var request1 = new XMLHttpRequest();
        var request2 = new XMLHttpRequest();
 
      //Logout. Tell the server not to return the "WWW-Authenticate" header
        request1.open("GET", host.concat(logoutURL) + "?prompt=false", true);
        request1.send("");
        request1.onreadystatechange = function(){
            if (request1.readyState == 4) {
 
              //Sign in with dummy credentials to clear the auth cache
                request2.open("GET", host.concat(logoutURL), true, "logout", "logout");
                request2.send("");
 
                request2.onreadystatechange = function(){
                    if (request2.readyState == 4) {
                        if (callback!=null) { callback.call();  } else { window.location=host.concat(logoutURL);}
                    } 
                }
                 
            }
        }
    }
    else {
        var request = ((window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP"));
        request.open("GET", host.concat(logoutURL), true, "logout", "logout");
        request.send("");
        request.onreadystatechange = function(){
                   if (request.status==401 || request.status==403 ) { window.location=host.concat(logoutURL);
                } 
            }
    }
};


function remove(id)
{
   var element = document.getElementById(id);
   element.outerHTML = "";
   delete element;
   return;
};


$("#password").pressEnter( function() {

     login();
}); 


$(document).ready(function() {

    progressive_loging();
 
});


var progressive_loging = function () {

    var host = $('#host_pe').val();
     var user = $('#user_pe').val();
     console.log(host);
     console.log(user);

     var elem = '<li  class="dropdown">  <a class="dropdown-toggle" data-toggle="dropdown">';
     elem = elem.concat(user);
     elem = elem.concat('<b Class="caret"></b></a><ul class="dropdown-menu"><li><a href="');
     elem = elem.concat(host);
     elem = elem.concat('/account" itemprop="account_information" rel="account_information">Account Information</a></li><li class="divider"></li><li><a href="');
     elem = elem.concat(host);
     elem = elem.concat('/email" itemprop="change_email" rel="change_email">Change Email</li><li><a href="');
     elem = elem.concat(host);
     elem = elem.concat('/password" itemprop="change_password" rel="change_password">Change Password</a></li></ul></li>' );
     console.log (elem);


    $('#login_pe').after('<li><a class="login pull-right" data-toggle="modal"  data-target="#myModalSignIn">Sign in</a></li>').remove();
    $('#logoff_pe').after('<li><a class="login pull-right" data-toggle="modal"  data-target="#myModalSignOut" rel="logoff" itemprop="logoff">Sign out</a></li>').remove();
    $('#dropdown_pe_2').remove();
    $('#dropdown_pe_3').remove();
    $('#dropdown_pe_4').remove();
    $('#dropdown_pe_1').after(elem).remove(); 

};



