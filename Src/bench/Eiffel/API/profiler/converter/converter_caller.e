class PROF_CONVERTER

creation
	make

feature {EWB_GENERATE} -- creation

	make (arguments: ARRAY [STRING]) is
			-- creates the system
			-- command line arguments:	1) path to profiling outputfile
			--				2) "melt" or "freeze" or "finalize"
		do
			if arguments.count /= 2 then
				help
			else

					-- Check whether the profile file exists.
				check_profile_file (arguments.item (1));
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

						do_convertion (arguments.item (1), arguments.item (2))
					end
				end
			end
		end -- make

feature {PROF_CONVERTER} -- implementation

	check_profile_file(profile_name: STRING) is
			-- Checks if the file exists
		local
			file: PLAIN_TEXT_FILE
		do
			!!file.make (profile_name);
			exists := file.exists
		end -- check_profile_file

	check_project_directory (compile_type: STRING) is
			-- Checks if the TRANSLAT exists in "./EIFGEN/W_code"
			-- or in "./EIFGEN/F_code"
		local
			file: PLAIN_TEXT_FILE;
		do
			translat_dir := ".";
			if compile_type = "finalize" then
				translat_dir.append_string (Finalized_translat_const);
			else
				translat_dir.append_string (Melted_translat_const);
			end;
			!!file.make (translat_dir);
			exists := file.exists
		end -- check_project_directory
	
	do_convertion (proffile, project_dir: STRING) is
			-- creates both files and initiates conversion
		do
			!!gprof_converter.make (proffile, translat_dir);
			gprof_converter.convert_profile_listing
		end -- do_convertion

	help is
			-- generate output for command line arguments
		do
			io.error.putstring("Usage: ");
			io.error.putstring(" <profile_path> compile_type%N");
			io.error.new_line;
			io.error.putstring("%Tprofile_path: path and filename of the profiler's output file.%N");
			io.error.putstring("%Tcompile_type: `melt' or `freeze' or `finalize'.%N");
			io.error.new_line
		end -- help

feature {NONE} -- attributes

	command_name : STRING
			-- the name of the system while executing

	gprof_converter : GPROF_CONVERTER
			-- the converter for output files of `gprof'.

	exists : BOOLEAN
			-- does the file passed as argument exist?

	Melted_translat_const: STRING is "/EIFGEN/W_code/TRANSLAT"
			-- directory structure where TRANSLAT file is placed
			-- after melt or freeze.

	Finalized_translat_const: STRING is "/EIFGEN/F_code/TRANSLAT"
			-- directory structure where TRANSLAT file is stored 
			-- after finalize.

	translat_dir: STRING
			-- directory where TRANSLAT really is based upon
			-- commandline argument (2)

end -- class PROF_CONVERTER
