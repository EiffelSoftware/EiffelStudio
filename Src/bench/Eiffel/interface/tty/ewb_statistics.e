-- Statistics

class EWB_STATISTICS

inherit

	EWB_CMD
		rename
			name as statistics_cmd_name, 
			help_message as statistics_help, 
			abbreviation as statistics_abb
		end;

	SHARED_SERVER
		export {NONE} all end

feature

	execute is
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
					display
				end;
			end;
		end;

	display is
			-- Show system statistics.
		do
			if System.id_array /= Void then
					-- The system has to be compiled.
				output_window.put_int (System.nb_of_classes);
				output_window.put_string (" classes in the system.");
				output_window.new_line
			end
		end;

end -- class EWB_STATISTICS
