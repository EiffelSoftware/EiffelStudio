Indexing

	description: 
		"Print window that allows printing to the printer or to%
		%a file.";
	date: "$Date$";
	revision: "$Revision $"

class BROWSE_FILE

inherit

	EV_COMMAND;

	CONSTANTS

	ONCES

creation

	make

feature -- Initialization

	make (p: like parent_window) is
		do
			parent_window := p
		end;


feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			project_load_box	: EV_FILE_OPEN_DIALOG
		do 
			project_load_box	:= windows_manager.open_file_browser (parent_window)
			project_load_box.show
		end

feature -- Properties
	
	parent_window: EV_WINDOW
end -- class PRINT_WINDOW
