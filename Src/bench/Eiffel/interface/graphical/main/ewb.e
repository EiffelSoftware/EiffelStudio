-- Root class of the Eiffelbench system.

class EWB

inherit

	WINDOWS;
	EIFFEL_ENV;
	ISED_X_SLAVE;
	ARGUMENTS

creation

	make

	
feature 

	make is
			-- Create and map the first window: the system window.
		do
			if argument_count = 1 and then
				argument (1).is_equal ("-bench")
			then
				set_batch_mode (False);
				init_connection;
				init_windowing;
				iterate
			else
				set_batch_mode (True);
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
			if font_window = Void then end
		end
 
end
