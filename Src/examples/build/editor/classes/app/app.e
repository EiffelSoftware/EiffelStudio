class APPLICATION

inherit
	SHARED_CONTROL;
	STATES;
	WINDOWS

creation 
	make

feature 

	make is
		do
			control.put (basic, exit_from_application, "quit");
			control.put (basic, viewing, "view");
			control.put (basic, editing, "modify");
			control.put (viewing, return_to_previous, "back");
			control.put (editing, basic, "save");
			control.put (editing, viewing, "view");
			control.set_initial_state (basic);
			init_windowing
		end;
	
end -- class APPLICATION
