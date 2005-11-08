indexing
	description: "Object which is responsable for printing c compiler or external command output and error when idle."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_IDLE_PRINTING_MANAGER

inherit
	EB_SHARED_MANAGERS

	EB_SHARED_PROCESS_IO_DATA_STORAGE

create
	make

feature{NONE} -- Initialization
	make is
		do
			is_printing_freezing := False
			is_printing_finalizing := False
		ensure
			is_printing_freezing_set_to_false: is_printing_freezing = False
			is_printing_finalizing_set_to_false: is_printing_finalizing = False
		end
		
feature -- Timer initialization

	initiate_timer is
			-- Initiate `timer'.
		once
			create timer.make_with_interval (100)
			timer.actions.extend (agent print_when_idle)
		end		
		
feature -- Printing

	print_when_idle is
			-- Print c compiler or external command output and error, if any.
		do
			print_freezing
			print_finalizing
			print_external			
		end
		

	print_freezing is	
			-- Print output and error, if any, of the c compiler which is working on workbench mode.
		local
			gm: EB_C_COMPILATION_OUTPUT_MANAGER
			data_block:	EB_PROCESS_IO_DATA_BLOCK			
		do
			gm := c_compilation_output_manager
			if not is_printing_finalizing then
				if 
				   (not freezing_storage.has_new_block)
				then
					if freezing_launcher.has_exited then 
						is_printing_freezing := False
						if has_printed_anything then
							gm.scroll_to_end
							has_printed_anything := False						
						end
					end
				else
					data_block := freezing_storage.all_blocks (True)
					gm.process_block_text (data_block)
					has_printed_anything := True
					is_printing_freezing := True													
				end					
			end
		end
		
	print_finalizing is	
			-- Print output and error, if any, of the c compiler which is working on finalization mode.
		local
			gm: EB_C_COMPILATION_OUTPUT_MANAGER
			data_block:	EB_PROCESS_IO_DATA_BLOCK
		do
			gm := c_compilation_output_manager
			if not is_printing_freezing then
				if 
				   (not finalizing_storage.has_new_block)
				then
					if finalizing_launcher.has_exited then 
						is_printing_finalizing := False
						if has_printed_anything then
							gm.scroll_to_end
							has_printed_anything := False							
						end
					end
				else
					data_block := finalizing_storage.all_blocks (True)
					gm.process_block_text (data_block)
					has_printed_anything := True
					is_printing_finalizing := True							
				end					
			end
		end		
		
	print_external is
			-- Print output and error if any, of external command which is running.
		local
			b: EB_PROCESS_IO_DATA_BLOCK
		do
			if external_storage.has_new_block then
				b := external_storage.all_blocks (True)					
				external_output_manager.process_block_text (b)
				if b.is_end then
					external_launcher.on_ouput_print_session_over
				end
			end	
		end

feature{NONE} -- Implementation

	is_printing_freezing: BOOLEAN
			-- Is freezing information being printed now?
			
	is_printing_finalizing: BOOLEAN
			-- Is finalizing information being printed now?
	
	has_printed_anything: BOOLEAN
			-- Has anything from c-compiler been printed already?

feature{NONE}

	timer: EV_TIMEOUT
			-- Timer to call an agent to print output and error from another process
end
