
class EWB_COMP

inherit

	EWB_CMD

feature

	name: STRING is "compile";

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
			end;
		end;

end
