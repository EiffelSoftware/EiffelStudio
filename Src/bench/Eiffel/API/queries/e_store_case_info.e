indexing

	description: 
		"Command to store Eiffelcase readable format of system.";
	date: "$Date$";
	revision: "$Revision $"

class E_STORE_CASE_INFO 

inherit

	E_CMD
		redefine
			executable
		end

creation

	make, do_nothing

feature -- Initialization

	make (display: like output_window; rew: like reverse_engineering_window) is
			-- Initialize Current with `output_window' is `display'.
		require
			valid_display: display /= Void
		do
			output_window := display;
			reverse_engineering_window := rew
		end;

feature -- Properties

	executable: BOOLEAN is
			-- May `execute' be called?
		do
			Result := output_window /= Void
		end;
			
feature -- Execution

	execute_back is
		local
--			format_storage: FORMAT_CASE_STORAGE
		do
			--!! format_storage.make (output_window, reverse_engineering_window);
			--format_storage.execute
		end;

	execute is
		do
			if case_interface /= Void then
				if case_interface.is_iconic_state then
					case_interface.set_normal_state
				end
				case_interface.show
				case_interface.raise
			else
				!! case_interface.make (output_window, reverse_engineering_window)	
			end
		end;

feature {NONE} -- Properties

	reverse_engineering_window: DEGREE_OUTPUT;
			-- Output window of the reverse engineering

	output_window: OUTPUT_WINDOW;
			-- Output window used to display during the
			-- execution of Current.

	case_interface: CASE_INTERFACE
			-- Reverse engineer tool window.

end -- class E_STORE_CASE_INFO
