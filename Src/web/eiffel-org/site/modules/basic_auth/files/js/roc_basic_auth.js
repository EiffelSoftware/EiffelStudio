var ROC_AUTH = ROC_AUTH || { };

var loginURL = "/roc-basic-login";
var logoutURL = "/roc-basic-logoff";

var userAgent = navigator.userAgent.toLowerCase();
var firstLogIn = true;
 
ROC_AUTH.login = function() {
	var form = document.forms['cms_basic_auth'];
	var username = form.username.value;
	var password = form.password.value;
	//var host = form.host.value;
	var origin = window.location.origin + window.location.pathname;
	var _login = function(){
		if  (document.getElementById('myModalFormId') !== null ) {
			ROC_AUTH.remove ('myModalFormId');
		}

		if (username === "" || password === "") {
			if (document.getElementById('myModalFormId') === null ) {
				var newdiv = document.createElement('div');
				newdiv.innerHTML = "<br>Invalid Credentials</br>";
				newdiv.id = 'myModalFormId';
				$(".login-box").append(newdiv);
			} 
		}else{  
			//Instantiate HTTP Request
			var request = ((window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP"));
			request.open("GET", loginURL, true, username, password);
			request.send(null);

			//Process Response
			request.onreadystatechange = function(){
				if (request.readyState == 4) {
					if (request.status==200) {
						delete form;
						window.location=window.location.origin;
					} else {
						if (navigator.userAgent.toLowerCase().indexOf("firefox") != -1){                       
							// .. ?
						}
						if (document.getElementById('myModalFormId') === null ) {
							var newdiv = document.createElement('div');
							newdiv.innerHTML = "<br>Invalid Credentials</br>";
							newdiv.id = 'myModalFormId';
							$(".login-box").append(newdiv);
						} 
					}
				}
			}
		}
	}

	var userAgent = navigator.userAgent.toLowerCase();
	if (userAgent.indexOf("firefox") != -1) { //TODO: check version number
		if (firstLogIn) {
			_login();
		} else {
			ROC_AUTH.logoff(_login);
		}
	} else {
		_login();
	}

	if (firstLogIn) {
		firstLogIn = false;
	}
};


ROC_AUTH.login_with_redirect = function() {
	var form = document.forms[2];
	var username = form.username.value;
	var password = form.password.value;
	var host = form.host.value;
	var _login = function(){
		var redirectURL = form.redirect && form.redirect.value || "";   
		$("#imgProgressRedirect").show();  

		if  (document.getElementById('myModalFormId') !== null ) {
			ROC_AUTH.remove ('myModalFormId');
		}
		if (username === "" || password === "") {
			if (document.getElementById('myModalFormId') === null ) {      
				var newdiv = document.createElement('div');
				newdiv.innerHTML = "<br>Invalid Credentials</br>";
				newdiv.id = 'myModalFormId';
				$(".login-box").append(newdiv);
				$("#imgProgressRedirect").hide();
			} 
		} else {  
			//Instantiate HTTP Request
			var request = ((window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP"));
			request.open("GET", host + loginURL, true, username, password);
			request.send(null);

			//Process Response
			request.onreadystatechange = function() {
				if (request.readyState == 4) {
					if (request.status==200) {
						if (redirectURL === "") {   
							window.location=host + "/";
						} else {
							window.location=host + redirectURL;
						}
					} else{
						if (navigator.userAgent.toLowerCase().indexOf("firefox") != -1){                       
						}
						if (document.getElementById('myModalFormId') === null ) {     
							var newdiv = document.createElement('div');
							newdiv.innerHTML = "<br>Invalid Credentials</br>";
							newdiv.id = 'myModalFormId';
							$(".login-box").append(newdiv);
							$("#imgProgressRedirect").hide();    
						} 
					}
				}
			}
		}
	}

	var userAgent = navigator.userAgent.toLowerCase();
	if (userAgent.indexOf("firefox") != -1){ //TODO: check version number
		if (firstLogIn) {
			_login();
		} else {
			ROC_AUTH.logoff(_login);
		}
	} else{
		_login();
	}
	if (firstLogIn) {
		firstLogIn = false;
	}
};

ROC_AUTH.getQueryParameterByName = function (name) {
	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
	return results === null ? " " : decodeURIComponent(results[1].replace(/\+/g, " "));
} 
 
ROC_AUTH.logoff = function(callback){
	var form = document.forms[0];
	var host = form.host.value;

	if (userAgent.indexOf("msie") != -1) {
		document.execCommand("ClearAuthenticationCache");
	} else if (userAgent.indexOf("firefox") != -1){ //TODO: check version number
		var request1 = new XMLHttpRequest();
		var request2 = new XMLHttpRequest();

		//Logout. Tell the server not to return the "WWW-Authenticate" header
		request1.open("GET", host + logoutURL + "?prompt=false", true);
		request1.send("");
		request1.onreadystatechange = function(){
			if (request1.readyState == 4) {
				//Sign in with dummy credentials to clear the auth cache
				request2.open("GET", host + logoutURL, true, "logout", "logout");
				request2.send("");
				request2.onreadystatechange = function(){
					if (request2.readyState == 4) {
						if (callback!=null) {
							callback.call();  
						} else { 
							window.location=host + logoutURL;
						}
					} 
				}
			}
		}
	} else {
		var request = ((window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP"));
		request.open("GET", host + logoutURL, true, "logout", "logout");
		request.send("");
		request.onreadystatechange = function(){
			if (request.status==401 || request.status==403 ) { 
				window.location=host + logoutURL;
			} 
		}
	}
};


ROC_AUTH.remove = function (id) {
	var element = document.getElementById(id);
	element.outerHTML = "";
	delete element;
	return;
};



$(document).ready(function() {
	if (typeof String.prototype.contains != 'function') {
		String.prototype.contains = function (str){
			return this.indexOf(str) != -1;
		};
	}
	ROC_AUTH.progressive_loging();
});


ROC_AUTH.progressive_loging = function () {
	ROC_AUTH.login_href();
};


$(document).keypress(function(e) {
	if ((e.which === 13) && (e.target.localName === 'input' &&  e.target.id === 'password')) {
		ROC_AUTH.login();
	}
});

ROC_AUTH.OnOneClick = function(event) {
	event.preventDefault();
	if  ( document.forms[0] === undefined ) {
		ROC_AUTH.create_form();
	}
	return false;
};

ROC_AUTH.login_href = function() {
	var els = document.getElementsByTagName("a");
	for (var i = 0, l = els.length; i < l; i++) {
		var el = els[i];
		if (el.href.contains(loginURL + "?destination")) {
//			loginURL = el.href;
			var OneClick = el;
			OneClick.addEventListener('click', ROC_AUTH.OnOneClick, false);
		}
	}
};


ROC_AUTH.create_form = function() {

	// Fetching HTML Elements in Variables by ID.
	var createform = document.createElement('form'); // Create New Element Form
	createform.setAttribute("action", ""); // Setting Action Attribute on Form
	createform.setAttribute("method", "post"); // Setting Method Attribute on Form
	$("body").append(createform); 

	var heading = document.createElement('h2'); // Heading of Form
	heading.innerHTML = "Login Form ";
	createform.appendChild(heading);

	var line = document.createElement('hr'); // Giving Horizontal Row After Heading
	createform.appendChild(line);

	var linebreak = document.createElement('br');
	createform.appendChild(linebreak);

	var namelabel = document.createElement('label'); // Create Label for Name Field
	namelabel.innerHTML = "Username : "; // Set Field Labels
	createform.appendChild(namelabel);

	var inputelement = document.createElement('input'); // Create Input Field for UserName
	inputelement.setAttribute("type", "text");
	inputelement.setAttribute("name", "username");
	inputelement.setAttribute("required","required");
	createform.appendChild(inputelement);

	var linebreak = document.createElement('br');
	createform.appendChild(linebreak);

	var passwordlabel = document.createElement('label'); // Create Label for Password Field
	passwordlabel.innerHTML = "Password : ";
	createform.appendChild(passwordlabel);

	var passwordelement = document.createElement('input'); // Create Input Field for Password.
	passwordelement.setAttribute("type", "password");
	passwordelement.setAttribute("name", "password");
	passwordelement.setAttribute("id", "password");
	passwordelement.setAttribute("required","required");
	createform.appendChild(passwordelement);


	var passwordbreak = document.createElement('br');
	createform.appendChild(passwordbreak);


	var submitelement = document.createElement('button'); // Append Submit Button
	submitelement.setAttribute("type", "button");
	submitelement.setAttribute("onclick", "ROC_AUTH.login();");
	submitelement.innerHTML = "Sign In ";
	createform.appendChild(submitelement);

};


var password = document.getElementById("password");
var confirm_password = document.getElementById("confirm_password");

ROC_AUTH.validatePassword =function(){
	if ((password != null) && (confirm_password != null)) {
		if(password.value != confirm_password.value) {
			confirm_password.setCustomValidity("Passwords Don't Match");
		} else {
			confirm_password.setCustomValidity('');
		}
	} 
}

if ((password != null) && (confirm_password != null)) {
	password.onchange = ROC_AUTH.validatePassword();
	confirm_password.onkeyup = ROC_AUTH.validatePassword;
}
