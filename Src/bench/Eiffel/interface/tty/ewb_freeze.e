class EWB_FREEZE 

inherit

	EWB_CMD

feature

	name: STRING is "freeze";

	execute is
		do
			if confirmed then
				print_header;
				init_project;
				if not error_occurred then
					if project_is_new then
						make_new_project
					else
						retrieve_project
					end
				end;
				if not error_occurred then
					System.set_freeze (True);
					compile;
					terminate_project;
					print_tail;
				end;
			end
		end;

end
