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
			execute, perform_compilation
		end

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
			if Eiffel_project.is_new then
				compile;
				if Eiffel_project.successful then
					print_tail;
					prompt_finish_freezing (False)
				end
			else
				io.error.putstring ("The project %"");
				io.error.putstring (Eiffel_project.name);
				io.error.putstring ("%" already exists.%N%
					%It needs to be deleted before a precompilation.%N");
			end
		end;

	perform_compilation is
		do
			Eiffel_project.precompile
		end;

end -- class EWB_PRECOMP
