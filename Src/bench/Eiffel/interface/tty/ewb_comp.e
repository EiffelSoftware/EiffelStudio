
class EWB_COMP

inherit

	EWB_CMD
		rename
			name as melt_cmd_name,
			help_message as melt_help,
			abbreviation as melt_abb
		end

feature

	loop_execute is
		do
			execute
		end;

	execute is
		do
			init_project;
			if not error_occurred then
				if project_is_new then
					make_new_project
				else
					retrieve_project;
				end;
			end;
			if not error_occurred then
				print_header;
				compile;
				terminate_project;
				print_tail;
				if System.freezing_occurred then
					prompt_finish_freezing (False)
				end;
			end;
		end;

end
