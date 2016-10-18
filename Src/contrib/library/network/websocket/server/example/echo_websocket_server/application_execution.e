note
	description: "[
			Implementation of {WEB_SOCKET_EXECUTION} specific for this application.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_EXECUTION

inherit
	WEB_SOCKET_EXECUTION

create
	make

feature -- Request processing

	is_verbose: BOOLEAN = True

	execute
			-- Process request ...
		local
			s: STRING
		do
			if
				request.is_get_request_method and then
				request.request_uri.is_case_insensitive_equal_general ("/app")
			then
				s := websocket_app_html ({APPLICATION}.default_port_number)
			else
				s := "Open the websocket client example: <a href=%"/app%">click here</a>."
			end
			response.header.put_content_type_text_html
			response.header.put_content_length (s.count)
			response.put_string (s)
		end

	on_open (ws: WEB_SOCKET)
		do
			if is_verbose then
				log ("Connecting", {HTTPD_LOGGER_CONSTANTS}.debug_level)
			end
		end

	on_binary (ws: WEB_SOCKET; a_message: READABLE_STRING_8)
		do
			ws.send (Binary_frame, a_message)
		end

	on_text (ws: WEB_SOCKET; a_message: READABLE_STRING_8)
		do
--			if is_verbose then
--				log ("On text (message length=" + a_message.count.out + ")", {HTTPD_LOGGER_CONSTANTS}.debug_level)
--			end
			ws.send (Text_frame, a_message)
		end

	on_close (ws: WEB_SOCKET)
			-- Called after the WebSocket connection is closed.
		do
			if is_verbose then
				log ("Connection closed", {HTTPD_LOGGER_CONSTANTS}.debug_level)
			end
		end

	log (m: READABLE_STRING_8; lev: INTEGER)
		do
			response.put_error (m)
		end

	websocket_app_html (a_port: INTEGER): STRING
		do
			Result := "[
<!DOCTYPE html>
<html>
<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {

	var socket;

	function connect(){

			var host = "ws://127.0.0.1:##PORTNUMBER##";

			try{
				socket = new WebSocket(host);
				message('<p class="event">Socket Status: '+socket.readyState);
				socket.onopen = function(){
						message('<p class="event">Socket Status: '+socket.readyState+' (open)');
					}
				socket.onmessage = function(msg){
						message('<p class="message">Received: '+msg.data);
					}
				socket.onclose = function(){
						message('<p class="event">Socket Status: '+socket.readyState+' (Closed)');
					}
			} catch(exception){
				message('<p>Error'+exception);
			}
	}

	function send(){
		var text = $('#text').val();
		if(text==""){
			message('<p class="warning">Please enter a message');
			return ;
		}
		try{
			socket.send(text);
			message('<p class="event">Sent: '+text)
		} catch(exception){
			message('<p class="warning">');
		}
		$('#text').val("");
	}

	function message(msg){
		$('#chatLog').append(msg+'</p>');
	}//End message()

	$('#text').keypress(function(event) {
		  if (event.keyCode == '13') {
			 send();
		   }
	});

	$('#disconnect').click(function(){
		socket.close();
	});

	if (!("WebSocket" in window)){
		$('#chatLog, input, button, #examples').fadeOut("fast");
		$('<p>Oh no, you need a browser that supports WebSockets. How about <a href="http://www.google.com/chrome">Google Chrome</a>?</p>').appendTo('#container');
	}else{
		//The user has WebSockets
		connect();
	}

});
</script>
<meta charset="utf-8" />
<style type="text/css">
body {font-family:Arial, Helvetica, sans-serif;}
#container { border:5px solid grey; width:800px; margin:0 auto; padding:10px; }
#chatLog { padding:5px; border:1px solid black; }
#chatLog p {margin:0;}
.event {color:#999;}
.warning { font-weight:bold; color:#CCC; }
</style>
<title>WebSockets Client</title>
</head>
<body>
  <div id="wrapper">
  	<div id="container">
    	<h1>WebSockets Client</h1>
        <div id="chatLog"></div>
    	<input id="text" type="text" />
        <button id="disconnect">Disconnect</button>
	</div>
  </div>
</body>
</html>
			]"
			Result.replace_substring_all ("##PORTNUMBER##", a_port.out)
		end

note
	copyright: "2011-2016, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
