indexing

	description: 
		"Command to build a precomplie eiffel system.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_PRECOMP

inherit

	EWB_COMP
		redefine
			name, help_message, abbreviation,
			execute
		end

creation

	make 

feature -- Properties

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

feature {NONE} -- Execution

	execute is
		do
			print_header;
			if project.project_is_new then
				Workbench.system.set_precompilation (True);
					---- Do not call the once function `System' directly
					---- since it's value may be replaced during the first
					---- compilation (as soon as we figured out whether the
					---- system describes a Dynamic Class Set or not).
				compile;
				if Workbench.successfull then
					System.save_precompilation_info;
					project.save_project;
					print_tail;
					prompt_finish_freezing (False)
				end;
			else
				io.error.putstring ("The project %"");
				io.error.putstring (project.project_name);
				io.error.putstring ("%" already exists.%N%
					%It needs to be deleted before a precompilation.%N");
			end
		end;

end -- class EWB_PRECOMP
