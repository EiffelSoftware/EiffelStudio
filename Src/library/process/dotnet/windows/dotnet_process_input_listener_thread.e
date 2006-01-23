indexing
	description:
		"[
			Object used when redirect input of a process to a file.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_PROCESS_INPUT_LISTENER_THREAD

inherit
	PROCESS_IO_LISTENER_THREAD

create
	make
	
feature{NONE} -- Initialization

	make (prc_launcher: PROCESS_IMP) is
		require
			process_launcher_not_null: prc_launcher /= Void
		do
			process_launcher := prc_launcher
			should_exit_signal:= False	
			create mutex		
		ensure
			process_launched_set: prc_launcher = prc_launcher
			should_exit_signal_set_to_false: not should_exit_signal			
		end

feature -- Run

	execute is
			-- 
		local
			input_file: RAW_FILE
			done: BOOLEAN
		do
			if process_launcher.input_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
				create input_file.make_open_read (process_launcher.input_file_name)
				from
					done := False
				until
					done
				loop
					if not process_launcher.has_exited and then not input_file.end_of_file then
						input_file.read_stream (process_launcher.buffer_size)
						if input_file.last_string /= Void then
							process_launcher.put_string (input_file.last_string)
						end
					end
					if should_thread_exit or process_launcher.has_exited then
						done := True
					end
				end			
				if not input_file.is_closed then
					input_file.close				
				end
			else
				set_exit_signal
			end
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
