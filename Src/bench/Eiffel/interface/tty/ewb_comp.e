indexing
	description: "Melt eiffel system."
	date: "$Date$"
	revision: "$Revision $"

class
	EWB_COMP

inherit
	PROJECT_CONTEXT

	EWB_EDIT

	EWB_CMD
		redefine
			loop_action
		end

	EIFFEL_ENV

	SHARED_ERROR_BEHAVIOR

feature -- Initialization

	init is
		do
			if Eiffel_ace.file_name = Void then
				select_ace_file;
			end;
			if Eiffel_ace.file_name /= Void then
				print_header;
			end;
		end;

feature -- Properties

	name: STRING is
		do
			Result := melt_cmd_name
		end;

	help_message: STRING is
		do
			Result := melt_help
		end;

	abbreviation: CHARACTER is
		do
			Result := melt_abb
		end;

feature {NONE} -- Update

	select_ace_file is
			-- Select an Ace if it hasn't been specified.
		require
			no_lace_file: Eiffel_ace.file_name = Void
		local
			file_name, cmd: STRING;
			option: CHARACTER;
			exit: BOOLEAN;
			file, dest: PLAIN_TEXT_FILE;
		do
			from
			until
				exit
			loop
				io.putstring ("Specify the Ace file: %N%
								%C: Cancel%N%
								%S: Specify file name%N%
								%T: Copy template%N%N%
								%Option: ");
				io.readline;
				cmd := io.laststring;
				exit := True;
				if cmd.is_empty or else cmd.count > 1 then
					option := ' ';
				else
					option := cmd.item (1).lower
				end;
				inspect
					option
				when 'c' then
					Eiffel_ace.set_file_name (Void)
				when 's' then
					io.putstring ("File name (`Ace.ace' is the default): ");
					io.readline;
					file_name := io.laststring;
					if not file_name.is_empty then
						Eiffel_ace.set_file_name (clone(file_name));
					else
						!!file.make ("Ace.ace");
						if file.exists then
							Eiffel_ace.set_file_name ("Ace.ace");
						else
							!!file.make ("Ace")
							if file.exists then
								Eiffel_ace.set_file_name ("Ace")
							else
								Eiffel_ace.set_file_name ("Ace.ace");
							end
						end
					end;
					check_ace_file (Eiffel_ace.file_name);
				when 't' then
					io.putstring ("File name: ");
					io.readline;
					file_name := io.laststring;
					if file_name.is_empty then
						exit := True;
					else
						create file.make_open_read (Default_ace_name)
						create dest.make_open_write (file_name)
						file.copy_to (dest)
						file.close
						dest.close
						Eiffel_ace.set_file_name (clone(file_name));
						edit (Eiffel_ace.file_name);
					end;
				else
					io.putstring ("Invalid choice%N%N");
					exit := False;
				end;
			end;
		end;

	compile is
			-- Melt system.
		require
			non_void_lace: Eiffel_ace.file_name /= Void
		local
			exit: BOOLEAN;
		do
			from
					-- Is the Ace file still there?
				check_ace_file (Eiffel_ace.file_name)
			until
				exit
			loop
				perform_compilation;
				if Eiffel_project.successful then
					exit := True
				elseif Eiffel_project.save_error then
					save_project_again
				else
					if stop_on_error then
						lic_die (-1)
					end;
					if command_line_io.termination_requested then
						exit := True
					end
				end
			end;
		end;

	loop_action is
		do
			execute
		end;

	execute is
		require else
			can_always_be_compiled: True
		do
			if Eiffel_project.is_read_only then
				io.error.put_string ("Read-only project: cannot compile.%N")
			else
				init;
				if Eiffel_ace.file_name /= Void then
					compile;
					if Eiffel_project.successful then
						print_tail;
						if Eiffel_project.freezing_occurred then
							prompt_finish_freezing (False)
						end
					end;
				end;
			end
		end;

feature {NONE} -- Output

	prompt_finish_freezing (finalized_dir: BOOLEAN) is
			-- Display message for finish_freezing script.
		do
			io.error.putstring ("You must now run %"");
			io.error.putstring (Platform_constants.Finish_freezing_script);
			io.error.putstring ("%" in:%N%T");
			if finalized_dir then
				io.error.putstring (Final_generation_path)
			else
				io.error.putstring (Workbench_generation_path)
			end;
			io.error.new_line;
		end;

	print_header is
			-- Print header information of compilation.
		do
			Degree_output.put_header (Version_number)
		end

	print_tail is
			-- Print completion message of compilation.
		do
			Degree_output.put_system_compiled
		end

feature {NONE} -- Compilation

	perform_compilation is
			-- Melt eiffel project.
		do
			Eiffel_project.melt
		end

	save_project_again is
			-- Try to save the project again.
		require
			error: Eiffel_project.save_error
		local
			finished: BOOLEAN;
			temp: STRING
			file_name: FILE_NAME
		do
			from
			until
				finished
			loop
				if Eiffel_project.save_error then
					!! file_name.make_from_string (Eiffel_project.project_directory.name);
					if Compilation_modes.is_precompiling then 
						file_name.set_file_name (dot_workbench)
					else
						file_name.set_file_name (Eiffel_system.name)
						file_name.add_extension (Project_extension)
					end

					!! temp.make (0);
					temp.append ("Error: could not write to ");
					temp.append (file_name);
					temp.append ("%NPlease check permissions and disk space");
					io.error.putstring (temp);
					io.error.new_line;
					finished := stop_on_error or else command_line_io.termination_requested;
					if finished then
						lic_die (-1)
					else
						perform_compilation
					end;
				end
			end
		end;

	check_ace_file (fn: STRING) is
			-- Check that the Ace file exists and is readable and plain
		local
			f: PLAIN_TEXT_FILE
		do
			!! f.make (fn);
			if
				not (f.exists and then f.is_readable and then f.is_plain)
			then
				io.error.putstring ("Ace file `");
				io.error.putstring (fn);
				if f.exists then
					io.error.putstring ("' cannot be read%N");
				else
					io.error.putstring ("' does not exist%N");
				end;
				lic_die (-1)
			end
		end;

end -- class EWB_COMP
