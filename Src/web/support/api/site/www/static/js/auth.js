var loginURL = "/login_session";
var logoutURL = "/logoff_session";
var logout = "logoff"
var userAgent = navigator.userAgent.toLowerCase();
var firstLogIn = true;
 
var login = function() {
    var form = document.forms[0];
    var username = form.username.value;
    var password = form.password.value;
    var remember_me = form.remember_me.checked;
  	var host = form.host.value;
  	var path_name = window.location.pathname;
    
    var reshost = host.split("/");
    var res = path_name.split("/");
    if (reshost[reshost.length - 1] === res[1]) {
      path_name = path_name.replace("/"+res[1], "");
    }

    var _login = function(){

 
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
    	    //request.open("GET", host + loginURL, true, username, password);
	        //request.send(null);
          request.open("POST", host + loginURL, true);
          request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
          request.send("username="+username+"&password="+password+"&remember_me="+remember_me);
    
          //Process Response
          request.onreadystatechange = function(){
             if (request.readyState == 2) {
                 if (request.status==200) {
                           window.location=host.concat(path_name);
                }
                else{
                  if (navigator.userAgent.toLowerCase().indexOf("firefox") !==-1){                       
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
    if (userAgent.indexOf("firefox") !== -1){ //TODO: check version number
        if (firstLogIn) _login();
        else logoff(_login);
    }
    else{
        _login();
    }
 
    if (firstLogIn) firstLogIn = false;
};


var login_with_redirect = function() {
    var form = document.forms[0];
    var username = form.username.value;
    var password = form.password.value;
    var remember_me = form.remember_me.checked;

    var host = form.host.value;
    var _login = function(){

    var redirectURL = form.redirect && form.redirect.value || "";   

    var reshost = host.split("/");
    var res = redirectURL.split("/");
    if (reshost[reshost.length - 1] === res[1]) {
      redirectURL = redirectURL.replace("/"+res[1], "");
    }


    $("#imgProgressRedirect").show();  

    if  (document.getElementById('myModalFormId') !== null ) {
        remove ('myModalFormId');
    }


    if (username === "" || password === "") {
             if (document.getElementById('myModalFormId') === null ) {      
                    var newdiv = document.createElement('div');
                      newdiv.innerHTML = "<br>Invalid Credentials</br>";
                    newdiv.id = 'myModalFormId';
                    document.getElementById("redirecLoginForm").appendChild(newdiv);
                     $("#imgProgressRedirect").hide();
               } 
    }else{  
         
          //Instantiate HTTP Request
          var request = ((window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP"));
          //request.open("GET", host.concat(loginURL), true, username, password);
          //request.send(null);
    
          request.open("POST", host + loginURL, true);
          request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
          request.send("username="+username+"&password="+password+"&remember_me="+remember_me);
    
          //Process Response
          request.onreadystatechange = function(){
             if (request.readyState == 2) {
                 if (request.status==200) {
                     if (redirectURL === "") {   
                        window.location=host.concat("/");
                    } else {
                        window.location=host.concat(redirectURL);
                    }

        }
                else{
                  if (navigator.userAgent.toLowerCase().indexOf("firefox") !== -1){                       
                     }
                   
          if (document.getElementById('myModalFormId') === null ) {     
                    var newdiv = document.createElement('div');
                       newdiv.innerHTML = "<br>Invalid Credentials</br>";
                    newdiv.id = 'myModalFormId';
                    document.getElementById("redirecLoginForm").appendChild(newdiv);
                     $("#imgProgressRedirect").hide();    
                   } 

                  }
               }
            }
        }
    }
 
    var userAgent = navigator.userAgent.toLowerCase();
    if (userAgent.indexOf("firefox") !== -1){ //TODO: check version number
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
	  
    if (userAgent.indexOf("msie") !== -1) {
        document.execCommand("ClearAuthenticationCache");
    }
    else if (userAgent.indexOf("firefox") != -1){ //TODO: check version number
 
        var request1 = new XMLHttpRequest();
        var request2 = new XMLHttpRequest();
 
      //Logout. Tell the server not to return the "WWW-Authenticate" header
        request1.open("GET", host.concat(logoutURL) + "?prompt=false", true);
        request1.send("");
        request1.onreadystatechange = function(){
            if (request1.readyState === 4) {
 
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

$("#password_redirect").pressEnter( function() {
     login_with_redirect();
}); 



$(document).ready(function() {

    progressive_loging();
    if (document.getElementById('guest_reports_page_size') !== null) {
        progressive_guest_page_resize();
    }
    if (document.getElementById('user_reports_page_size') !== null) {
        progressive_user_page_resize();
    }
    if (document.getElementById('responsible_reports_page_size') !== null) {
        progressive_responsible_page_resize();
    }
 
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


    $('#login_pe').after('<li><a class="login pull-right" data-toggle="modal"  data-target="#myModalSignIn">Sign In</a></li>').remove();
    $('#logoff_pe').after('<li><a class="login pull-right" data-toggle="modal"  data-target="#myModalSignOut" rel="logoff" itemprop="logoff">Sign Out</a></li>').remove();
    $('#dropdown_pe_2').remove();
    $('#dropdown_pe_3').remove();
    $('#dropdown_pe_4').remove();
    $('#dropdown_pe_1').after(elem).remove(); 

};



var progressive_guest_page_resize = function () {

          var host = $('#host_pe').val();
          var index = $('#page_pe').val();
          var category = $('#category_pe').val();
          var orderBy = $('#orderBy_pe').val();
          var dir = $('#dir_pe').val();
          var status =  $('#status_pe').val();
          var filter =  $('#filter_pe').val();
          var filter_content =  $('#filter_content_pe').val();
          var pages = $('#pages_pe').val();
          var size  = $('#size_pe').val();
          var count_bugs = $('#count_bugs_pe').val();


          console.log (host);
          console.log (index);
          console.log (category);
          console.log (orderBy);
          console.log (dir);
          console.log (status);
          console.log (filter);
          console.log (filter_content);
          console.log (pages);
          
          var elem = '<div class="col-xs-12"><div class="col-xs-2"><label class="control-label-api" itemprop="report_number" data-original-title="The number of reports you want to see.">Current page ';
          elem = elem.concat(index);
          elem = elem.concat(' of ');
          elem = elem.concat(pages);
          elem = elem.concat ('</label></div>');   
          elem = elem.concat('<div class="col-xs-1"> <label class="control-label-api" itemprop="report_number" data-original-title="The number of reports you want to see.">Size</label> </div>') ; 
          elem = elem.concat('<div class="col-xs-1"> <input type="number" name="quantity" min="1" max="9999" value="');
          elem = elem.concat(size);
          elem = elem.concat ('" id="changesize"/>');
          elem = elem.concat('<input type="hidden" name="current" value="');
          elem = elem.concat (host);
          elem = elem.concat ('/reports?page=');
          elem = elem.concat (index);
          elem = elem.concat ('&amp;size=');
          elem = elem.concat (size);
          elem = elem.concat ('&amp;category=');
          elem = elem.concat (category);
          elem = elem.concat ('&amp;orderBy=');
          elem = elem.concat (orderBy);
          elem = elem.concat ('&amp;dir=');  
          elem = elem.concat (dir);  
          elem = elem.concat ('&amp;status='); 
          elem = elem.concat (status);
          elem = elem.concat ('&amp;filter='); 
          elem = elem.concat (filter);
          elem = elem.concat ('&amp;filter_content='); 
          elem = elem.concat (filter_content);
          elem = elem.concat ('" id="currentPage"/>');
          elem = elem.concat ('<img src="');
          elem = elem.concat (host);
          elem = elem.concat ('/static/images/ajax-loader.gif" alt="Loading..." style="display: none;" id="pageLoad" /> ');
          elem = elem.concat ('</div>' ); 
          elem = elem.concat('<div class="col-xs-1"><label class="control-label-api" itemprop="report_number" data-original-title="The number of reports you want to see."># of Bugs</label></div>') ; 
          elem = elem.concat('<div class="col-xs-1">');
          elem = elem.concat (count_bugs); 
          elem = elem.concat ('</div></div>' ); 
 
          console.log (elem);

          $('#guest_reports_page_size').after(elem).remove();
       
};


var progressive_user_page_resize = function () {

          var host = $('#host_pe').val();
          var user = $('#user_pe').val();
          var index = $('#page_pe').val();
          var category = $('#category_pe').val();
          var orderBy = $('#orderBy_pe').val();
          var dir = $('#dir_pe').val();
          var status =  $('#status_pe').val();
          var filter =  $('#filter_pe').val();
          var filter_content =  $('#filter_content_pe').val();
          var pages = $('#pages_pe').val();
          var size  = $('#size_pe').val();
          var count_bugs = $('#count_bugs_pe').val();

          console.log (host);
          console.log (index);
          console.log (category);
          console.log (orderBy);
          console.log (dir);
          console.log (status);
          console.log (filter);
          console.log (filter_content);
          console.log (pages);
          
          var elem = '<div class="col-xs-12"><div class="col-xs-2"><label class="control-label-api" itemprop="report_number" data-original-title="The number of reports you want to see.">Current page ';
          elem = elem.concat(index);
          elem = elem.concat(' of ');
          elem = elem.concat(pages);
          elem = elem.concat ('</label></div>');   
          elem = elem.concat('<div class="col-xs-1"> <label class="control-label-api" itemprop="report_number" data-original-title="The number of reports you want to see.">Size</label> </div>') ; 
          elem = elem.concat('<div class="col-xs-1"> <input type="number" name="quantity" min="1" max="9999" value="');
          elem = elem.concat(size);
          elem = elem.concat ('" id="changesize"/>');
          elem = elem.concat('<input type="hidden" name="current" value="');
          elem = elem.concat (host);
          elem = elem.concat ('/user_reports/');
          elem = elem.concat (user);
          elem = elem.concat ('?page=');
          elem = elem.concat (index);
          elem = elem.concat ('&amp;size=');
          elem = elem.concat (size);
          elem = elem.concat ('&amp;category=');
          elem = elem.concat (category);
          elem = elem.concat ('&amp;orderBy=');
          elem = elem.concat (orderBy);
          elem = elem.concat ('&amp;dir=');  
          elem = elem.concat (dir);  
          elem = elem.concat ('&amp;status='); 
          elem = elem.concat (status);
          elem = elem.concat ('&amp;filter='); 
          elem = elem.concat (filter);
          elem = elem.concat ('&amp;filter_content='); 
          elem = elem.concat (filter_content);
          elem = elem.concat ('" id="currentPage"/>');
          elem = elem.concat ('<img src="');
          elem = elem.concat (host);
          elem = elem.concat ('/static/images/ajax-loader.gif" alt="Loading..." style="display: none;" id="pageLoad" /> ');
          elem = elem.concat ('</div>' ); 
          elem = elem.concat('<div class="col-xs-1"><label class="control-label-api" itemprop="report_number" data-original-title="The number of reports you want to see."># of Bugs</label></div>') ; 
          elem = elem.concat('<div class="col-xs-1">');
          elem = elem.concat (count_bugs); 
          elem = elem.concat ('</div></div>' ); 
 
          console.log (elem);

          $('#user_reports_page_size').after(elem).remove();
       
};


var progressive_responsible_page_resize = function () {

          var host = $('#host_pe').val();
          var user = $('#user_pe').val();
          var index = $('#page_pe').val();
          var category = $('#category_pe').val();
          var orderBy = $('#orderBy_pe').val();
          var dir = $('#dir_pe').val();
          var status =  $('#status_pe').val();
          var filter =  $('#filter_pe').val();
          var filter_content =  $('#filter_content_pe').val();
          var pages = $('#pages_pe').val();
          var size  = $('#size_pe').val();
          var submitter = $('#submitter_pe').val();
          var severity  = $('#severity_pe').val();
          var priority  = $('#priority_pe').val();
          var responsible  = $('#responsible_pe').val();
          var count_bugs = $('#count_bugs_pe').val();

          console.log (host);
          console.log (index);
          console.log (category);
          console.log (orderBy);
          console.log (dir);
          console.log (status);
          console.log (filter);
          console.log (filter_content);
          console.log (pages);

          var elem = '<div class="col-xs-12"><div class="col-xs-2"><label class="control-label-api" itemprop="report_number" data-original-title="The number of reports you want to see.">Current page ';
          elem = elem.concat(index);
          elem = elem.concat(' of ');
          elem = elem.concat(pages);
          elem = elem.concat ('</label></div>');   
          elem = elem.concat('<div class="col-xs-1"> <label class="control-label-api" itemprop="report_number" data-original-title="The number of reports you want to see.">Size</label> </div>') ; 
          elem = elem.concat('<div class="col-xs-1"> <input type="number" name="quantity" min="1" max="9999" value="');
          elem = elem.concat(size);
          elem = elem.concat ('" id="changesize"/>');
          elem = elem.concat('<input type="hidden" name="current" value="');
          elem = elem.concat (host);
          elem = elem.concat ('/reports?page=');
          elem = elem.concat (index);
          elem = elem.concat ('&amp;size=');
          elem = elem.concat (size);
          elem = elem.concat ('&amp;category=');
          elem = elem.concat (category);
          elem = elem.concat ('&amp;submitter=');
          elem = elem.concat (submitter);
          elem = elem.concat ('&amp;severity=');
          elem = elem.concat (severity);
          elem = elem.concat ('&amp;priority=');
          elem = elem.concat (priority);
          elem = elem.concat ('&amp;responsible=');
          elem = elem.concat (responsible);
          elem = elem.concat ('&amp;orderBy=');
          elem = elem.concat (orderBy);
          elem = elem.concat ('&amp;dir=');  
          elem = elem.concat (dir);  
          elem = elem.concat ('&amp;status='); 
          elem = elem.concat (status);
          elem = elem.concat ('&amp;filter='); 
          elem = elem.concat (filter);
          elem = elem.concat ('&amp;filter_content='); 
          elem = elem.concat (filter_content);
          elem = elem.concat ('" id="currentPage"/>');
          elem = elem.concat ('<img src="');
          elem = elem.concat (host);
          elem = elem.concat ('/static/images/ajax-loader.gif" alt="Loading..." style="display: none;" id="pageLoad" /> ');
          elem = elem.concat ('</div>' ); 
          
          elem = elem.concat('<div class="col-xs-1"><label class="control-label-api" itemprop="report_number" data-original-title="The number of reports you want to see."># of Bugs</label></div>') ; 
          elem = elem.concat('<div class="col-xs-1">');
          elem = elem.concat (count_bugs); 
          elem = elem.concat ('</div></div>' ); 
          console.log (elem);

          $('#responsible_reports_page_size').after(elem).remove();
       
}

