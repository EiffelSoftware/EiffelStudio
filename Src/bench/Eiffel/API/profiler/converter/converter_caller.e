indexing

	description:
		"Initialized the PROFILE_CONVERTER and does extra checks.";
	date: "$Date$";
	revision: "$Revision$"

class CONVERTER_CALLER

inherit
	PROJECT_CONTEXT

create
	make

feature {EWB_GENERATE} -- Initialization

	make (arguments: ARRAY [STRING]; shared_prof_config: SHARED_PROF_CONFIG) is
			-- Initialize the converter with the `arguments'. The first argument
			-- should be the profiler's output file, the second the compile type used.
		do
			config := shared_prof_config;
			if arguments.count /= 2 then
				help
			else
					-- Create the directory needed for the conversion
				Create_profiler_directory;

					-- Check whether the profile file exists.
				check_profile_file (arguments.item (1), arguments.item (2));
				if not exists then
					conf_load_error := true
				else

					if config.get_config_name.is_equal ("eiffel") then
							-- We don't care about the project directory:
							-- The eiffel profiler is smarter than external
							-- tools.
						do_conversion
					else
							-- Check whether the specified project directory
							-- is valid.
							-- Ie. check whether there is a TRANSLAT file in
							-- ./EIFGEN/W_code/. We need this to translate
							-- cryptic names back to human readable ones.
						check_project_directory (arguments.item (2));
						if not exists then
								-- Too bad. Either the user has been smart:
								-- he's been using precompiles *or*
								-- he's been stupid and removed TRANSLAT by
								-- by hand.
								-- What do we do??? ***** FIXME *****
							io.putstring (arguments.item (2));
							io.putstring (": File `TRANSLAT' does not exist in this directory.%N%N")
						else
								-- Cool! Everything is fine!
							do_conversion
						end
					end
				end
			end
		end -- make

feature {PROF_CONVERTER} -- Implementation

	check_profile_file (profile_name: STRING; comp_type: STRING) is
			-- Checks if the file exists.
		local
			file: PLAIN_TEXT_FILE
		do
			create profile_out_file.make_from_string (Eiffel_gen_path);
			if comp_type.is_equal ("workbench") then
				profile_out_file.extend (W_code);
			else
				profile_out_file.extend (F_code);
			end;
			profile_out_file.set_file_name (profile_name);
			create file.make (profile_out_file);
			exists := file.exists
		end -- check_profile_file

	check_project_directory (comp_type: STRING) is
			-- Checks wether the project directory exists.
		local
			file: PLAIN_TEXT_FILE;
		do
			create translat_file.make_from_string (Eiffel_gen_path);
			if comp_type.is_equal ("workbench") then
				translat_file.extend (W_code);
			else
				translat_file.extend (F_code);
			end;
			translat_file.set_file_name (Translation_log_file_name);
			create file.make (translat_file);
			exists := file.exists
		end -- check_project_directory

	do_conversion is
			-- Creates both files and initiates conversion.
		do
			create profile_converter.make (profile_out_file, translat_file, config);
			profile_converter.convert_profile_listing
			is_last_conversion_ok := profile_converter.is_conversion_ok
		end;

	help is
			-- Generate output for command line arguments.
		do
			io.error.putstring("Usage: ");
			io.error.putstring(" <profile_path> compile_type%N");
			io.error.new_line;
			io.error.putstring("%Tprofile_path: path and filename of the profiler's output file.%N");
			io.error.putstring("%Tcompile_type: `workbench' or `final'.%N");
			io.error.new_line
		end;

feature -- Access

	is_last_conversion_ok: BOOLEAN
			-- Has the last conversion worked properly?

	conf_load_error: BOOLEAN
			-- configuration load error

feature {NONE} -- attributes

	command_name : STRING
			-- The name of the system while executing.

	profile_converter : PROFILE_CONVERTER
			-- The converter for output files of `profile'.

	exists : BOOLEAN
			-- Does the file passed as argument exist?

	profile_out_file: FILE_NAME
			-- File name where the output file is written

	translat_file: FILE_NAME
			-- File name where TRANSLAT really is; is based upon
			-- commandline argument (2).

	config: SHARED_PROF_CONFIG
			-- Object to hold the configuration values.

end -- class CONVERTER_CALLER
