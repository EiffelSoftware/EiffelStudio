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
 
	
      //Instantiate HTTP Request
        var request = ((window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP"));
    	var tok = "Basic " + btoa(username + ':' + password);
    	request.open("GET", host.concat(loginURL), true, username, password);
	    request.send(null);
    
      //Process Response
        request.onreadystatechange = function(){
            if (request.readyState == 4) {
                if (request.status==200) { window.location=host.concat("/");
                }
                else{
                    if (navigator.userAgent.toLowerCase().indexOf("firefox") != -1){
                        logoff();
                    }
                    alert("Invalid Credentials!");
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
}
 
 
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
 
              //Login with dummy credentials to clear the auth cache
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
}