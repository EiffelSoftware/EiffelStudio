note
	description: "[
			To implement websocket handling, provide a `callbacks` object implementing the {WEB_SOCKET_EVENT_I} interface.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_SOCKET_HANDLER

inherit
	WEB_SOCKET_CONSTANTS

	REFACTORING_HELPER

	HTTPD_LOGGER_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (ws: WEB_SOCKET; a_callbacks: WEB_SOCKET_EVENT_I)
		do
			web_socket := ws
			callbacks := a_callbacks
		end

feature -- Access		

	web_socket: WEB_SOCKET
			-- Associated websocket.

	callbacks: WEB_SOCKET_EVENT_I

feature -- Execution

	frozen execute
		do
			callbacks.on_open (web_socket)
			execute_websocket
		end

	execute_websocket
		local
			exit: BOOLEAN
			l_frame: detachable WEB_SOCKET_FRAME
			l_client_message: detachable READABLE_STRING_8
			l_utf: UTF_CONVERTER
			ws: like web_socket
			s: STRING
		do
			from
					-- loop until ws is closed or has error.
				ws := web_socket
			until
				exit
			loop
				debug ("dbglog")
					dbglog (generator + ".execute_websocket (loop) WS_REQUEST_HANDLER.process_request {" + ws.socket_descriptor.out + "}")
				end
				if ws.is_ready_for_reading then
					l_frame := ws.next_frame
					if l_frame /= Void and then l_frame.is_valid then
						if attached l_frame.injected_control_frames as l_injections then
								-- Process injected control frames now.
								-- FIXME
							across
								l_injections as ic
							loop
								if ic.item.is_connection_close then
										-- FIXME: we should probably send this event .. after the `l_frame.parent' frame event.
									callbacks.on_event (ws, ic.item.payload_data, ic.item.opcode)
                      				exit := True
                      			elseif ic.item.is_ping then
                      					-- FIXME reply only to the most recent ping ...
                      				callbacks.on_event (ws, ic.item.payload_data, ic.item.opcode)
                      			else
                      				callbacks.on_event (ws, ic.item.payload_data, ic.item.opcode)
								end
							end
						end

						l_client_message := l_frame.payload_data
						if l_client_message = Void then
							l_client_message := ""
						end

						debug ("ws")
							create s.make_from_string ("%NExecute: %N")
							s.append (" [opcode: "+ opcode_name (l_frame.opcode) +"]%N")
							if l_frame.is_text then
								s.append (" [client message: %""+ l_client_message +"%"]%N")
							elseif l_frame.is_binary then
								s.append (" [client binary message length: %""+ l_client_message.count.out +"%"]%N")
							end
							s.append (" [is_control: " + l_frame.is_control.out + "]%N")
							s.append (" [is_binary: " + l_frame.is_binary.out + "]%N")
							s.append (" [is_text: " + l_frame.is_text.out + "]%N")
							dbglog (s)
						end

						if l_frame.is_connection_close then
							callbacks.on_event (ws, l_client_message, l_frame.opcode)
                      		exit := True
						elseif l_frame.is_binary then
 							callbacks.on_event (ws, l_client_message, l_frame.opcode)
 						elseif l_frame.is_text then
 							check is_valid_utf_8: l_utf.is_valid_utf_8_string_8 (l_client_message) end
 							callbacks.on_event (ws, l_client_message, l_frame.opcode)
 						else
 							callbacks.on_event (ws, l_client_message, l_frame.opcode)
 						end
 					else
						debug ("ws")
							create s.make_from_string ("%NExecute: %N")
							s.append (" [ERROR: invalid frame]%N")
							if l_frame /= Void and then attached l_frame.error as err then
								s.append (" [Code: "+ err.code.out +"]%N")
								s.append (" [Description: "+ err.description +"]%N")
							end
							dbglog (s)
						end
						callbacks.on_event (ws, "", connection_close_frame)
 						exit := True -- FIXME: check proper close protocol
					end
				else
					debug ("ws")
						dbglog (generator + ".WAITING WS_REQUEST_HANDLER.process_request {" + ws.socket_descriptor.out + "}")
					end
				end
			end
		end

feature {NONE} -- Logging		

	dbglog (m: READABLE_STRING_8)
		do
			web_socket.log (m, debug_level)
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
