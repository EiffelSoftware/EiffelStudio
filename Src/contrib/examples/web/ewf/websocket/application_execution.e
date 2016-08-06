note
	description : "simple application execution"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION_EXECUTION

inherit
	WSF_WEBSOCKET_EXECUTION

	WEB_SOCKET_EVENT_I

create
	make

feature -- Basic operations

	execute
		local
			s: STRING
			dt: HTTP_DATE
 		do
 			-- To send a response we need to setup, the status code and
 			-- the response headers.
			if request.path_info.same_string_general ("/app") then
				s := websocket_app_html (9090)
			else
	 			s := "Hello World!"
				create dt.make_now_utc
				s.append (" (UTC time is " + dt.rfc850_string + ").")
				s.append ("<p><a href=%"/app%">Websocket demo</a></p>")
			end
			response.put_header ({HTTP_STATUS_CODE}.ok, <<["Content-Type", "text/html"], ["Content-Length", s.count.out]>>)
			response.set_status_code ({HTTP_STATUS_CODE}.ok)
			response.header.put_content_type_text_html
			response.header.put_content_length (s.count)
			if attached request.http_connection as l_connection and then l_connection.is_case_insensitive_equal_general ("keep-alive") then
				response.header.put_header_key_value ("Connection", "keep-alive")
			end
			response.put_string (s)
		end

feature -- Websocket execution

	new_websocket_handler (ws: WEB_SOCKET): WEB_SOCKET_HANDLER
		do
			create Result.make (ws, Current)
		end

feature -- Websocket execution

	on_open (ws: WEB_SOCKET)
		do
			ws.put_error ("Connecting")
			ws.send (Text_frame, "Hello, this is a simple demo with Websocket using Eiffel. (/help for more information).%N")
		end

	on_binary (ws: WEB_SOCKET; a_message: READABLE_STRING_8)
		do
			ws.send (Binary_frame, a_message)
		end

	on_text (ws: WEB_SOCKET; a_message: READABLE_STRING_8)
		do
			if a_message.same_string_general ("/help") then
					-- Echo the message for testing.
				ws.send (Text_frame, "Help: available commands%N  - /time : return the server UTC time.%N")
			elseif a_message.starts_with_general ("/time") then
				ws.send (Text_frame, "Server time is " + (create {HTTP_DATE}.make_now_utc).string)
			else
					-- Echo the message for testing.
				ws.send (Text_frame, a_message)
			end
		end

	on_close (ws: WEB_SOCKET)
			-- Called after the WebSocket connection is closed.
		do
			ws.put_error ("Connection closed")
		end

feature -- HTML Resource				

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


end
