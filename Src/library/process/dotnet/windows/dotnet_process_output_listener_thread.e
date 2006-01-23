indexing
	description:
		"[
			Object defining a listener for output data from another process.		
			It is used when you redirect output of a process to an agent. 
			It listens to process's output pipe, if data arrives, 
			it will call the agent specified in output_handler in PROCESS.
		 ]"
	legal: "See notice at end of class."
	status: "See notice at end of class."	
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_PROCESS_OUTPUT_LISTENER_THREAD

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
			sleep_time := initial_sleep_time			
			create mutex		
		ensure
			process_launched_set: prc_launcher = prc_launcher
			should_exit_signal_set_to_false: not should_exit_signal	
			sleep_time_set: sleep_time = initial_sleep_time					
		end

	
feature -- Run

	execute is
			-- 
		local
			output_file: PLAIN_TEXT_FILE
			done: BOOLEAN
		do
			if process_launcher.output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
				create output_file.make_create_read_write (process_launcher.output_file_name)				
			end
			from
			until
				done	
			loop
				process_launcher.read_output_stream
				if process_launcher.last_output /= Void and then 
				   not process_launcher.last_output.is_empty 
				then
					if process_launcher.output_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_file then
						output_file.put_string (process_launcher.last_output)
					else
						process_launcher.output_handler.call ([process_launcher.last_output])
					end
				end
				if should_exit_signal and then process_launcher.last_output = Void then
					done := True
				elseif (process_launcher.last_output = Void) or (process_launcher.last_output /= Void and then process_launcher.last_output.is_empty) then
					sleep (sleep_time)									
				end
			end
			if output_file /= Void and then not output_file.is_closed then
				output_file.close
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
