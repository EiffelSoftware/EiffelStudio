
-- Root class of the Eiffelbench system.

class EWB

inherit

	WINDOWS;
	EIFFEL_ENV;
	ISED_X_SLAVE

creation

	make

	
feature 

	make is
			-- Create and map the first window: the system window.
		do
			init_connection;
			init_windowing;
			iterate
		end;
	
feature {NONE}

	init_windowing is
			-- Initialize the windowing environment.
		do
			if project_tool = Void then end;
			if name_chooser = Void then end;
			if confirmer = Void then end;
			if font_window = Void then end
		end
 
end
