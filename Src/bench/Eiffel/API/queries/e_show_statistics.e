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
		local
			stats: SYSTEM_STATISTICS
		do
			if Eiffel_project.initialized then
				stats := Eiffel_system.statistics;
				structured_text.add_int (stats.number_of_compilations);
				structured_text.add_string (" compilations for system.");
				structured_text.add_new_line;
				structured_text.add_int (stats.number_of_clusters);
				structured_text.add_string (" clusters in the system.");
				structured_text.add_new_line;
				structured_text.add_int (stats.number_of_classes);
				structured_text.add_string (" classes in the system.");
				structured_text.add_new_line;
				structured_text.add_int (stats.number_of_melted_classes);
				structured_text.add_string (" melted classes in the system.");
				structured_text.add_new_line;
			end
		end;

end -- class E_SHOW_STATISTICS
