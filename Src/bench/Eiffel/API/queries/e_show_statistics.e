indexing

	description: 
		"Command to display the system statistics.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_STATISTICS

inherit

	E_CMD;
	SHARED_WORKBENCH

creation

	make, do_nothing

feature -- Execution

	execute is
			-- Show system statistics.
		do
			if System.id_array /= Void then
					-- The system has to be compiled.
				output_window.put_int (System.nb_of_classes);
				output_window.put_string (" classes in the system.");
				output_window.new_line
			end
		end;

end -- class E_SHOW_STATISTICS
