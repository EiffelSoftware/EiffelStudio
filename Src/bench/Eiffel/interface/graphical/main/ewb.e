-- Root class of the Eiffelbench system.

class EWB

inherit

	SHARED_ERROR_BEHAVIOR;
	WINDOWS;
	EIFFEL_ENV;
	ISED_X_SLAVE;
	ARGUMENTS

creation

	make

	
feature 

	make is
			-- Create and map the first window: the system window.
		local
			screen: SCREEN;
		do
			if argument_count = 2 and then
				argument (1).is_equal ("-bench")
			then
				set_batch_mode (False);
				init_connection;
				init_windowing;
				iterate
			elseif argument_count = 2 and then
				argument (1).is_equal ("-stop")
			then
				set_batch_mode (True);
				set_stop_on_error (True);
				!!batch_compiler.make
			else
				set_batch_mode (True);
				set_stop_on_error (False);
				!! batch_compiler.make
			end;
		end;
	
feature {NONE}

	batch_compiler: ES;

	init_windowing is
			-- Initialize the windowing environment.
		do
			if project_tool = Void then end;
			if name_chooser = Void then end;
			if confirmer = Void then end;
			project_tool.popup_file_selection;
		end
 
end
