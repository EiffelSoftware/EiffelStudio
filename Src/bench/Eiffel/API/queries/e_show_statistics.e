indexing

	description: 
		"Command to display the system statistics.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_STATISTICS

inherit

	E_OUTPUT_CMD;
	SHARED_EIFFEL_PROJECT

create

	make, do_nothing

feature -- Execution

	work is
			-- Show system statistics.
		local
			stats: SYSTEM_STATISTICS
		do
			if Eiffel_project.initialized then
				stats := Eiffel_system.statistics;
				structured_text.add_int (stats.number_of_compilations);
				if stats.number_of_compilations = 1 then
					structured_text.add_string (" compilation for system.")
				else
					structured_text.add_string (" compilations for system.")
				end;
				structured_text.add_new_line;
				structured_text.add_int (stats.number_of_clusters);
				structured_text.add_string (" clusters in the system.");
				structured_text.add_new_line;
				structured_text.add_int (stats.number_of_classes);
				structured_text.add_string (" classes in the system.");
				structured_text.add_new_line;
				structured_text.add_int (stats.number_of_melted_classes);
				if stats.number_of_melted_classes = 1 then
					structured_text.add_string (" melted class in the system.");
				else
					structured_text.add_string (" melted classes in the system.");
				end
				structured_text.add_new_line;
			end
		end;

end -- class E_SHOW_STATISTICS
