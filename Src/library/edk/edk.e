indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	EDK

create
	make

feature -- Initialization

	make is
			-- Run application.
		local
			display_manager: EDK_DISPLAY_MANAGER

			message: EDK_MESSAGE
			n: NATURAL
			l_thread: WORKER_THREAD
			i: ANY
		do
			i := [1, "a", Void]
			i := {NATURAL_8} 1
			create display_manager

			display := display_manager.display

			from
				n := 1
			until
				n = 2
			loop
				create l_thread.make (agent create_window)
				l_thread.launch
				n := n + 1
			end


--			l_thread.join_all
			create_window

		end

		display: EDK_DISPLAY

		window: EDK_WINDOW

		create_window
			local
				l_window: EDK_WINDOW
				n: NATURAL
				message: EDK_MESSAGE
				native_message: EDK_MESSAGE
			do
				create l_window.make_with_style ({WINDOW_ATTRIBUTES}.toplevel_window)
				create message
				message.set_window (l_window)
				message.set_id ({EDK_MESSAGE_IDS}.edk_window_map)
				display.event_manager.put_message_on_queue (message)
				from

				until
					False
				loop
					display.event_manager.get_message_from_queue (message)
					print (message.id.to_hex_string + "%N")
					display.event_manager.process_message_from_queue (message)
					display.event_manager.wait_for_next_message (100)
				end
			end

end -- class EDK
