
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
					suggest_precompilation_retrieval;
					if precompiled_project_name /= Void then
						retrieve_precompiled_project
					else
						make_new_project
					end;
				else
					suggest_precompilation_retrieval;
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

	suggest_precompilation_retrieval is
		do
			io.putstring ("Do you wish to include precompiled information?[y/n] ");
			io.readline;
			if (io.laststring.item (1) = 'y') then
				io.putstring ("Name of precompiled project (full path): ");
				io.readline;
				precompiled_project_name := io.laststring.duplicate;
				io.putstring ("Importing precompiled information from: ");
				io.putstring (precompiled_project_name);
				io.new_line;
			end;
		end;

end
