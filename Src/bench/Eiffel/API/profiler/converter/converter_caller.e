class PROF_CONVERTER

inherit
	PROJECT_CONTEXT

creation
	make

feature {EWB_GENERATE} -- creation

	make (arguments: ARRAY [STRING]; shared_prof_config: SHARED_PROF_CONFIG) is
			-- creates the system
			-- command line arguments:	1) path to profiling outputfile
			--							2) "workbench" or "final"
		do
			config := shared_prof_config;
			if arguments.count /= 2 then
				help
			else

					-- Check whether the profile file exists.
				check_profile_file (arguments.item (1), arguments.item (2));
				if not exists then
					io.putstring (arguments.item (1));
					io.putstring (": File does not exist.%N%N")
				else

						-- Check whether the specified project directory
						-- is valid.
					check_project_directory (arguments.item (2));
					if not exists then
						io.putstring (arguments.item (2));
						io.putstring (": File `TRANSLAT' does not exist in this directory.%N%N")
					else
						do_convertion
					end
				end
			end
		end -- make

feature {PROF_CONVERTER} -- implementation

	check_profile_file(profile_name: STRING; comp_type: STRING) is
			-- Checks if the file exists
		local
			file: PLAIN_TEXT_FILE
		do
			profile_output_dir := clone (Eiffel_gen_path);
			profile_output_dir.extend (Platform_constants.Directory_separator);
			if comp_type.is_equal ("workbench") then
				profile_output_dir.append (W_code);
			else
				profile_output_dir.append (F_code);
			end;
			profile_output_dir.extend (Platform_constants.Directory_separator);
			profile_output_dir.append (profile_name);
			!!file.make (profile_output_dir);
			exists := file.exists
		end -- check_profile_file

	check_project_directory (comp_type: STRING) is
		local
			file: PLAIN_TEXT_FILE;
		do
			translat_dir := clone (Eiffel_gen_path);
			translat_dir.extend (Platform_constants.Directory_separator);
			if comp_type.is_equal ("workbench") then
				translat_dir.append (W_code);
			else
				translat_dir.append (F_code);
			end;
			translat_dir.extend (Platform_constants.Directory_separator);
			translat_dir.append (Translation_log_file_name);
			!!file.make (translat_dir);
			exists := file.exists
		end -- check_project_directory
	
	do_convertion is
			-- creates both files and initiates conversion
		do
			!!profile_converter.make (profile_output_dir, translat_dir, config);
			profile_converter.convert_profile_listing
		end -- do_convertion

	help is
			-- generate output for command line arguments
		do
			io.error.putstring("Usage: ");
			io.error.putstring(" <profile_path> compile_type%N");
			io.error.new_line;
			io.error.putstring("%Tprofile_path: path and filename of the profiler's output file.%N");
			io.error.putstring("%Tcompile_type: `workbench' or `final'.%N");
			io.error.new_line
		end -- help

feature {NONE} -- attributes

	command_name : STRING
			-- the name of the system while executing

	profile_converter : PROFILE_CONVERTER
			-- the converter for output files of `profile'.

	exists : BOOLEAN
			-- does the file passed as argument exist?

	profile_output_dir: STRING
			-- Directory where the output file is written.

	translat_dir: STRING
			-- directory where TRANSLAT really; is based upon
			-- commandline argument (2)

	config: SHARED_PROF_CONFIG
			-- Object to hold the configuration values.

end -- class PROF_CONVERTER
