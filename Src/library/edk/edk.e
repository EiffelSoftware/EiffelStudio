note
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	EDK

create
	make

feature -- Initialization

	make
			-- Run application.
		local
			l_app_server: EDK_APPLICATION_SERVER
			app: EDK_APPLICATION
			n: NATURAL
			l_thread: WORKER_THREAD
		do
			create l_app_server
			app := l_app_server.application_from_namespace ("app")

			display := app.display

			from
				n := 1
			until
				n = 2
			loop
				create l_thread.make (agent create_window)
				l_thread.launch
				n := n + 1
			end
			create_window
		end

		display: EDK_DISPLAY

		create_window
			local
				l_window: NATIVE_WINDOW
				message: EDK_MESSAGE
			do
				create l_window.make_with_style ({WINDOW_ATTRIBUTES}.toplevel_window)
				create message
				message.set_window (l_window)
				message.set_id ({EDK_MESSAGE_IDS}.edk_window_map)
				display.message_manager.put_message_on_queue (message)
				from

				until
					False
				loop
					display.message_manager.get_message_from_queue (message)
					print (message.id.to_hex_string + "%N")
					display.message_manager.process_message_from_queue (message)
					display.message_manager.wait_for_next_message (100)
				end
			end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
