
class EWB_PRECOMP

inherit

	EWB_COMP
		redefine
			name, help_message, abbreviation,
			execute
		end

feature

	name: STRING is
		do
			Result := precompile_cmd_name
		end;

	help_message: STRING is
		do
			Result := precompile_help
		end;

	abbreviation: CHARACTER is
		do
			Result := precompile_abb
		end;

feature

	execute is
		do
			print_header;
			init_project;
			if project_is_new then
				make_new_project;
				if not error_occurred then
						-- Do not call the once function `System' directly
						-- since it's value may be replaced during the first
						-- compilation (as soon as we figured out whether the
						-- system describes a Dynamic Class Set or not).
					Workbench.system.set_precompilation (True);
					compile;
					if Workbench.successfull then
						System.save_precompilation_info;
						terminate_project;
						print_tail;
						prompt_finish_freezing (False)
					end;
				end;
			else
				io.error.putstring ("The project %"");
				io.error.putstring (project_name);
				io.error.putstring ("%" already exists.%N%
					%It needs to be deleted before a precompilation.%N");
			end
		end;

end
