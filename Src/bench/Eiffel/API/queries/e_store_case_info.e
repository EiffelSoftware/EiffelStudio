indexing

	description: 
		"Command to store Eiffelcase readable format of system.";
	date: "$Date$";
	revision: "$Revision $"

class E_STORE_CASE_INFO 

inherit

	E_OUTPUT_CMD
		redefine
			executable
		end

creation

	make_with_window, do_nothing

feature -- Initialization

	make_with_window (display: like output_window) is
			-- Initialize Current with `output_window' is `display'.
		require
			valid_display: display /= Void
		do
			output_window := display
		ensure
			output_window_set: equal (output_window, display)
		end;

feature -- Properties

	executable: BOOLEAN is
			-- May `execute' be called?
		do
			Result := output_window /= Void
		end;
			
feature -- Execution

	execute is
		local
			format_storage: FORMAT_CASE_STORAGE
		do
			!! format_storage.make (output_window);
			format_storage.execute
		end;

feature {NONE} -- Properties

	output_window: OUTPUT_WINDOW;
			-- Output window used to display during the
			-- execution of Current.

end -- class E_STORE_CASE_INFO
