
class EWB_FINALIZE

inherit

	EWB_CMD

feature

	name: STRING is "finalize";

	execute is
		do
			if confirmed then
				print_header;
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
						retrieve_project
					end;
				end;
				if not error_occurred then
					compile;
						-- Save the project before the finalization in order to
						-- be able to use the project for other melting/freezing
						-- or finalization afterwards.
					terminate_project;
					System.finalized_generation;
				end;
				print_tail;
			end;
		end;

end
