indexing

	description: 
		"Melt eiffel system.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_COMP

inherit

	PROJECT_CONTEXT;
	EWB_CMD
		redefine
			loop_action
		end;
	EIFFEL_ENV;
	SHARED_MELT_ONLY;
	SHARED_ERROR_BEHAVIOR

creation

	make

feature -- Initialization

	make (proj: COMMAND_LINE_PROJECT) is
		require
			valid_proj: proj /= Void
		do
			project := proj
		ensure
			project = proj
		end;

	init is
		do
			if Lace.file_name = Void then
				select_ace_file;
			end;
			if Lace.file_name /= Void then
				print_header;
			end;
		end;

feature -- Properties

	project: COMMAND_LINE_PROJECT;
			-- Command line project for current command

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
			no_lace_file: Lace.file_name = Void
		local
			file_name, cmd: STRING;
			option: CHARACTER;
			exit: BOOLEAN;
			file: PLAIN_TEXT_FILE;
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
				if cmd.empty or else cmd.count > 1 then
					option := ' ';
				else
					option := cmd.item (1).lower
				end;
				inspect
					option
				when 'c' then
					Lace.set_file_name (Void)
				when 's' then
					io.putstring ("File name (`Ace' is the default): ");
					io.readline;
					file_name := io.laststring;
					if not file_name.empty then
						Lace.set_file_name (clone(file_name));
					else
						!!file.make ("Ace.ace");
						if file.exists then
							Lace.set_file_name ("Ace.ace");
						else
							!!file.make ("Ace")
							if file.exists then
								Lace.set_file_name ("Ace")
							else
								Lace.set_file_name ("Ace.ace");
							end
						end
					end;
					project.check_ace_file (Lace.file_name);
				when 't' then
					io.putstring ("File name: ");
					io.readline;
					file_name := io.laststring;
					if file_name.empty then
						exit := True;
					else
						!!cmd.make (0);
						cmd.append (Copy_cmd);
						cmd.extend (' ');
						cmd.append (Default_ace_name);
						cmd.extend (' ');
						cmd.append (file_name);
						Execution_environment.system (cmd);
						Lace.set_file_name (clone(file_name));
						edit (Lace.file_name);
					end;
				else
					io.putstring ("Invalid choice%N%N");
					exit := False;
				end;
			end;
		end;

	compile is
			-- Melt system.
		local
			exit: BOOLEAN;
			str: STRING
		do
			from
					-- Is the Ace file still there?
				project.check_ace_file (Lace.file_name)
			until
				exit
			loop
				Workbench.recompile;
				if not Workbench.successfull then
					if stop_on_error then
						lic_die (-1);
					end;
					if command_line_io.termination_requested then
						--lic_die (0);
						-- es3 -loop does NOT like lic_die(0)
						exit := True
					end
				else
					exit := True
				end
			end;
		end;

	loop_action is
		do
			execute
		end;

	execute is
		do
			if Project_read_only.item then
				io.error.put_string ("Read-only project: cannot compile.%N")
			else
				init;
				if Lace.file_name /= Void then
					compile;
					if Workbench.successfull then
						project.save_project;
						print_tail;
						if System.is_dynamic then
							dle_link_system
						end;
						if System.freezing_occurred then
							prompt_finish_freezing (False)
						else
							link_driver
						end
					end;
				end;
			end
		end;

	link_driver is
		local
			uf: PLAIN_TEXT_FILE;
			app_name: STRING
			file_name: FILE_NAME;
		do
			if
				not melt_only and then
				System.uses_precompiled and then
				not System.is_dynamic
			then
-- FIXME: check Makefile.SH
-- FIXME: check Makefile.SH
-- FIXME: check Makefile.SH
-- FIXME: check Makefile.SH

					-- Target
				!!file_name.make_from_string (Workbench_generation_path);
				app_name := clone (System.system_name);
				app_name.append (Executable_suffix);
				file_name.set_file_name (app_name);

				!!uf.make (file_name);
				if not uf.exists then
					eif_link_driver (Workbench_generation_path.to_c, System.system_name.to_c,
						Prelink_command_name.to_c, Precompilation_driver.to_c);
				end;
			end;
		end;

feature {NONE} -- Output

	prompt_finish_freezing (finalized_dir: BOOLEAN) is
			-- Display message for finish_freezing script.
		do
			io.error.putstring ("You must now run %"");
			io.error.putstring (Finish_freezing_script);
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
			io.putstring ("%
				%Eiffel compilation manager%N%
				%  (version ");
			io.putstring (Version_number);
			io.putstring (")%N");
		end;

	print_tail is
			-- Print completion message of compilation.
		do
			io.error.putstring ("System recompiled.%N")
		end;

feature {NONE} -- Externals

	eif_link_driver (c_code_dir, system_name, prelink_cmd_name, driver_name: ANY) is
		external
			"C"
		end

feature {NONE} -- DLE

	dle_link_system is
			-- Link executable and melted.eif files from the static system.
		require
			dynamic_system: System.is_dynamic
		local
			uf: PLAIN_TEXT_FILE;
			app_name: STRING;
			file_name: FILE_NAME
		do
			!!file_name.make_from_string (Workbench_generation_path);
			app_name := clone (System.system_name);
			app_name.append (Executable_suffix);
			file_name.set_file_name (app_name);
			!!uf.make (file_name);
			if not uf.exists then
				!! file_name.make_from_string (Extendible_W_code);
				app_name := clone (System.dle_system_name);
				app_name.append (Executable_suffix);
				file_name.set_file_name (app_name);
				eif_link_driver (Workbench_generation_path.to_c,
					System.system_name.to_c,
					Prelink_command_name.to_c,
					file_name.to_c);
				!! file_name.make_from_string (Extendible_W_code);
				file_name.set_file_name (Updt);
				eif_link_driver (Workbench_generation_path.to_c,
					Updt.to_c,
					Prelink_command_name.to_c,
					file_name.to_c)
			end
		end;

end
