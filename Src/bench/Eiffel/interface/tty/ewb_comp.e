
class EWB_COMP

inherit

	EWB_CMD

feature

	name: STRING is "compile";

	execute is
		do
			init_project;
			if not error_occurred then
				if project_is_new then
					get_precompilation_directory;
					if precompiled_project_name /= Void then
						retrieve_precompiled_project
					else
						make_new_project
					end;
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
