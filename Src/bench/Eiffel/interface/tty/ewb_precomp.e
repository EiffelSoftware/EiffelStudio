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
			execute, perform_compilation,
			save_project_again
		end

creation
	make

feature -- Initialization

	make (check_license: BOOLEAN) is
			-- Set `licensed' to `check_license'
		do
			licensed := check_license
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

	licensed: BOOLEAN
			-- Is this precompilation protected by a license?

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
			Eiffel_project.precompile (licensed)
		end;

	save_project_again is
			-- Try to save the project again.
		local
			finished: BOOLEAN;
			temp: STRING
		do
			from
			until
				finished
			loop
				if Eiffel_project.precomp_save_error then
					!! temp.make (0);
					temp.append ("Error: could not write to ");
					temp.append (Precompilation_file_name);
					temp.append ("%NPlease check permissions and disk space");
					io.error.putstring (temp);
					io.error.new_line;
					finished := stop_on_error or else
						command_line_io.termination_requested;
					if finished then
						lic_die (-1)
					else
						Eiffel_project.save_precomp (licensed)
					end;
				else
					{EWB_COMP} Precursor 
				end
			end
		end;

end -- class EWB_PRECOMP
