indexing

	description: 
		"Command to display the system statistics.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_STATISTICS

inherit

	E_OUTPUT_CMD;
	SHARED_EIFFEL_PROJECT

creation

	make, do_nothing

feature -- Execution

	execute is
			-- Show system statistics.
		do
			if Eiffel_project.initialized then
				output_window.put_int (Eiffel_system.number_of_classes);
				output_window.put_string (" classes in the system.");
				output_window.new_line
			end
		end;

end -- class E_SHOW_STATISTICS
