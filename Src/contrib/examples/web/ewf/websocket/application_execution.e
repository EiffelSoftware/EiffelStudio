note
	description : "simple application execution"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION_EXECUTION

inherit
	WSF_WEBSOCKET_EXECUTION

	WEB_SOCKET_EVENT_I
		redefine
			on_timer
		end

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
			if request.path_info.same_string_general ("/favicon.ico") then
				response.put_header ({HTTP_STATUS_CODE}.not_found, <<["Content-Length", "0"]>>)
			else
				if request.path_info.same_string_general ("/app") then
					s := websocket_app_html (request.server_name, request.server_port)

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
				if request.is_keep_alive_http_connection then
					response.header.put_connection_keep_alive
				end
				response.put_string (s)
			end
		end

feature -- Websocket execution

	new_websocket_handler (ws: WEB_SOCKET): WEB_SOCKET_HANDLER
		do
			create Result.make (ws, Current)
		end

feature -- Websocket execution

	on_open (ws: WEB_SOCKET)
		do
			initialize_commands
			set_timer_delay (1) -- Every 1 second.

			ws.put_error ("Connecting")
			ws.send (Text_frame, "Hello, this is a simple demo with Websocket using Eiffel. (/help for more information).%N")
		end

	on_binary (ws: WEB_SOCKET; a_message: READABLE_STRING_8)
		do
			ws.send (Binary_frame, a_message)
		end

	on_text (ws: WEB_SOCKET; a_message: READABLE_STRING_8)
		local
			i: INTEGER
			cmd_name: READABLE_STRING_8
		do
			if a_message.starts_with_general ("/") then
				from
					i := 1
				until
					i >= a_message.count or else a_message[i + 1].is_space
				loop
					i := i + 1
				end
				cmd_name := a_message.substring (2, i)
				if attached command (cmd_name) as cmd then
					cmd (ws, a_message.substring (i + 1, a_message.count))
				elseif a_message.same_string_general ("/help") then
					on_help_command (ws, Void)
				else
					ws.send (Text_frame, "Error: unknown command '/" + cmd_name + "'!%N")
				end
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

	on_timer (ws: WEB_SOCKET)
			-- <Precursor>.
			-- If ever the file ".stop" exists, stop gracefully the connection.
		local
			fut: FILE_UTILITIES
			f: RAW_FILE
		do
			if fut.file_exists (".stop") then
				ws.send_text ("End of the communication ...%N")
				ws.send_connection_close ("")
				create f.make_with_name (".stop")
				f.delete
			end
		end

feature -- Command

	initialize_commands
		do
			register_command (agent on_help_command, "help", "Display this help.")
			register_command (agent on_time_command, "time", "Return the server UTC time.")
			register_command (agent on_shutdown_command, "shutdown", "Shutdown the service (ends the websocket).")
		end

	register_command (a_cmd: attached like command; a_name: READABLE_STRING_8; a_description: READABLE_STRING_8)
		local
			tb: like commands
		do
			tb := commands
			if tb = Void then
				create tb.make_caseless (1)
				commands := tb
			end
			tb.force ([a_cmd, a_name, a_description], a_name)
		end

	commands: detachable STRING_TABLE [TUPLE [cmd: attached like command; name, description: READABLE_STRING_8]]

	command (a_name: READABLE_STRING_GENERAL): detachable PROCEDURE [TUPLE [ws: WEB_SOCKET; args: detachable READABLE_STRING_GENERAL]]
		do
			if
				attached commands as tb and then
				attached tb.item (a_name) as d
			then
				Result := d.cmd
			end
		end

	on_help_command (ws: WEB_SOCKET; args: detachable READABLE_STRING_GENERAL)
		local
			s: STRING
		do
			create s.make_from_string ("Help: available commands:%N")
			if attached commands as tb then
				across
					tb as ic
				loop
					s.append ("<li> /")
					s.append (ic.item.name)
					s.append (" : ")
					s.append (ic.item.description)
					s.append ("</li>%N")
				end
			end
			ws.send_text (s)
		end

	on_time_command (ws: WEB_SOCKET; args: detachable READABLE_STRING_GENERAL)
		do
			ws.send_text ("Server time is " + (create {HTTP_DATE}.make_now_utc).string)
		end

	on_shutdown_command (ws: WEB_SOCKET; args: detachable READABLE_STRING_GENERAL)
		local
			f: RAW_FILE
		do
			ws.send_text ("Active websockets will end soon.%N")
			create f.make_create_read_write (".stop")
			f.put_string ("stop%N")
			f.close
		end

feature -- HTML Resource				

	websocket_app_html (a_host: STRING; a_port: INTEGER): STRING
		do
			Result := "[
<!DOCTYPE html>
<html>
<head>
<script src="##HTTPSCHEME##://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {

	var socket;

	function connect(){

			var host = "##WSSCHEME##://##HOSTNAME##:##PORTNUMBER##/app";

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
			Result.replace_substring_all ("##HOSTNAME##", a_host)
			Result.replace_substring_all ("##PORTNUMBER##", a_port.out)
			if request.is_https then
				Result.replace_substring_all ("##HTTPSCHEME##", "https")
				Result.replace_substring_all ("##WSSCHEME##", "wss")
			else
				Result.replace_substring_all ("##HTTPSCHEME##", "http")
				Result.replace_substring_all ("##WSSCHEME##", "ws")
			end
		end

end
