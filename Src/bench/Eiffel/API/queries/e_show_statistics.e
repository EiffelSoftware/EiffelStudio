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
				structured_text.add_int (Eiffel_system.number_of_classes);
				structured_text.add_string (" classes in the system.");
				structured_text.add_new_line;
			end
		end;

end -- class E_SHOW_STATISTICS
