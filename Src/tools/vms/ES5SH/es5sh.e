indexing
	description: "System for converting Unix Makefile.SH files to VMS Makefile. files"
	name: "EIFFEL_SRC:[ES5SH]ES5SH.E"
	author: "David Morgan"
	original: 01,Jan,1995
	last: 22,Aug,1998
	modified_by: "David Schwartz (davids), VMS diehard"
	Version: "V6.2-001"
	Date: "$Date$"
	Revision: "$Revision$"
	ID:		"$ID: $"
	Notes: "*** be sure to update pretty_version string in ES5SH_COMMON to match the Version here"

--
-- working:
--
-- changes for Eiffel 6.x
--  remove enclosing quotes from -I specifiers
--  update big_file generation (just make it a bunch of #includes), use .c for finalized (no more big_file*.x)
--
-- changes for Eiffel 5.7.65176
-- 		
-- put config file name into link.com (already in Makefile)
-- add Makefile dependency:
--  $(OBJECTS) :: Makefile
--
--
-- Done: handle new gtk commands used in Eiffel 5.5.1126 INCLUDE_PATH and EXTERNALS macros:
--	`$EIFFEL_SRC/library/vision2/implementation/gtk/Clib/vision2-gtk-config --devel --include_path`
--	`$(EIFFEL_SRC)/library/vision2/implementation/gtk/Clib/vision2-gtk-config --devel --object`
--
--
--
-- todo:
--
-- evaluate EXTERNALS recursively so that a symbol like $ISE_PLATFORM will be replaced by the platform in link.com (instead of hard coding it in CONFIG.EIF file)
--
--  use value_macro_SUBDIRS to generate dependent_subdirectories, rather than on the fly in process_subdirectory_rule
--
--
-- working: process_agruments,
-- process externals list to allow object, library, or option (done, needs testing)
--
-- working: use ISE_PLATFORM with whatever definition
-- as written, must use whatever is defined, not whatever is in Makefile
-- *** I think this is not an issue, but I don't remember what it means ***
--
--
--
--

class ES5SH

inherit
	ES5SH_COMMON

create make

feature -- Initialization

	make is
			-- convert makefiles taking into account config.eif file
		local
			l_finished_file: PLAIN_TEXT_FILE
			l_val, l_cwd: STRING
			l_make_cmd: STRING
		do
			start_time := (create{DATE_TIME}.make_now).formatted_out (default_date_time_format)
			print_output_message (pretty_version + " starting at " + start_time + ".%N")
			print_output_message (" current working directory: " + execution_environment_.current_working_directory + "%N")
			--generate_object_libraries := True -- default: upwards compatibility
			--generate_object_libraries := False -- default: better performance
			generate_object_libraries := generate_object_libraries_default

			-- check for -h (-help) argument; if found, display help message and ignore others.
			--if arguments_.argument_count >= 1 and then (arguments_.index_of_character_option ('?') > 0
			if arguments_.argument_count >= 1 and then ( ("#/#/?#/h#/help#").has_substring ("#" + arguments_.argument(1) +"#")
					or else arguments_.index_of_character_option ('?') > 0
					or else arguments_.index_of_character_option ('h') > 0
					or else arguments_.index_of_word_option ("help") > 0	) then
				will_process_makefiles := False
				print_help()
			else
				will_process_makefiles := True
				process_arguments()
			end

			if will_process_makefiles then
				debug ("nocompile")
					if will_perform_make then
						print_output_message ("DEBUG(nocompile): inhibiting C compilation.%N")
						will_perform_make := False
					end
				end -- debug

				-- determine values of ISE_EIFFEL, ISE_PLATFORM
				symbol_eiffel := "ISE_EIFFEL"
				value_eiffel := execution_environment_.get (symbol_eiffel)
				if is_nonblank (value_eiffel) then
					do_nothing
				else
					value_eiffel := execution_environment_.get ("EIFFEL5")
					if is_nonblank (value_eiffel) then
						symbol_eiffel := "EIFFEL5"
						print_warning_message ("ISE_EIFFEL is not defined; obsolete EIFFEL5 used.%N")
					else
						value_eiffel := execution_environment_.get ("EIFFEL4")
						if is_nonblank (value_eiffel) then
							symbol_eiffel := "EIFFEL4"
							print_warning_message ("ISE_EIFFEL is not defined; obsolete EIFFEL5 used.%N")
						else
							print_warning_message ("ISE_EIFFEL, EIFFEL5, EIFFEL4 are undefined.%N")
							value_eiffel := "<undefined>"
						end
					end
				end
				value_eiffel_string := symbol_eiffel + "=" + value_eiffel
				if value_eiffel.is_equal (symbol_eiffel) or else value_eiffel.is_equal ("/" + symbol_eiffel) then
						-- if Eiffel 5.7 "hack" that returns getenv("foo") as "/foo") is in effect
					value_eiffel := execution_environment_.get_native (symbol_eiffel)
					value_eiffel_string.append (" (" + value_eiffel + ")")
				end
				value_platform := execution_environment_.get ("ISE_PLATFORM")
				debug ("windows")
					if value_platform.is_case_insensitive_equal ("windows") then
						value_platform := "VMSAlpha99"
					end
				end
				if value_platform = Void or else value_platform.is_empty then
					value_platform := execution_environment_.get("PLATFORM")
					if value_platform /= Void  and then not value_platform.is_empty then
						print_warning_message ("ISE_PLATFORM is not defined; obsolete PLATFORM used.%N")
					else
						print_warning_message ("neither ISE_PLATFORM nor PLATFORM defined.%N")
						value_platform := "$(ISE_PLATFORM_undefined)"
					end
				end

				l_cwd := execution_environment_.current_working_directory
				l_val := as_vms_filespec (l_cwd)  -- ***debug***
				if value_platform.substring_index ("VMS", 1) > 0 and then not is_vms_filespec (l_cwd) then
					l_cwd := as_vms_filespec (l_cwd + "/")
				end
				l_val := as_vms_filespec (l_cwd)  -- ***debug***

				if base_directory = Void then
					create base_directory.make_from_string (l_cwd)
					--print ("debug: base_directory set to default: " + base_directory + "%N")
				elseif base_directory = Void then
					-- UNREACHABLE: save this code temporarily until I figure out what to do
					print_error_message ("UNREACHABLE exeucted!%N")
					l_val := execution_environment_.current_working_directory
					create base_directory.make_from_string (l_val)
					if value_platform.substring_index ("VMS", 1) > 0 and then not is_vms_filespec (base_directory) then
						l_val.append_character (operating_environment_.directory_separator)
						l_val := as_vms_filespec (l_val)
						create base_directory.make_from_string (as_vms_filespec(l_val))
						l_val := as_vms_filespec (l_val)
					else
					end
				elseif is_relative_filespec (base_directory) then --AND THEN FALSE then
					--print (" debug: base_directory is_relative: " + base_directory + "%N")
--					l_val := execution_environment_.current_working_directory
--					create base_directory.make_from_string (execution_environment_.current_working_directory)
--					if starts_with (l_val, "./") or else starts_with (l_val, ".\") then
--						base_directory.extend (l_val.substring (3, l_val.count))
--					else
--						base_directory.extend (l_val)
--					end
					create base_directory.make_from_string (make_absolute_filespec (base_directory))
				end

				--print (" debug: base_directory: " + printable_value (base_directory) + "%N")
				print_output_message ("Processing options: "  + value_eiffel_string + ", "
									+ symbol_platform + "=" + value_platform + "%N")
				-- read configuration from configuration file
				if configuration_file_name = Void then
					-- check for logical name to specify configuration file
					l_val := execution_environment_.get ("ES5SH_CONFIG")
					if l_val /= Void and then not l_val.is_empty then
						create configuration_file_name.make_from_string (l_val)
						print_warning_message ("use of ES5SH_CONFIG logical name is deprecated, use -c <config_file>%N")
						-- **TBS** do a VMS-style parse, using the value as the default name
					else
						-- platform specific configuration file name: ISE_EIFFEL:[studio.config.$(ISE_PLATFORM)]config.eif
						configuration_file_name := platform_specific_file_name (<<"studio","config">>, << >>, "config.eif")
					end
				end
				create configuration.make (configuration_file_name, Current)

				print_output_message ("Processing files in " + base_directory + " at "
							+ (create {TIME}.make_now).formatted_out (default_time_format) + "%N")
				process_makefiles
				print_output_message ("Processing complete at "
							+ (create {TIME}.make_now).formatted_out (default_time_format) + "%N")

				if will_perform_make then
					create l_finished_file.make ("complete.eif")
					l_make_cmd := configuration.item ("make")
					print_output_message ("Commencing C compilation  -- MAKE = " + l_make_cmd + "%N")
					execution_environment_.system (l_make_cmd)
					if execution_environment_.return_code /= 0 then
						print_error_message ("Error from call to " + l_make_cmd + " -- return code: " + execution_environment_.return_code.out + "%N")
					end
					if not l_finished_file.exists then
						print_output_message ("C compilation terminated with errors at " + (create {TIME}.make_now).formatted_out (default_time_format)
							+ ".%NRun " + l_make_cmd + " in directory  " + base_directory + "  to see what has gone wrong.%N")
					else
						print_output_message ("C compilation completed successfully at " + (create {TIME}.make_now).formatted_out (default_time_format) +"%N")
					end
				end -- if will_perform_make
			end -- if will_process_makefiles
		end; -- make

--
-----------------------------
feature -- Attributes
-----------------------------

--	generate_object_libraries: BOOLEAN
--		-- if True, generate object libraries (.olb); else generate object modules (.obj)
--		-- used for transitioning/testing from object library to concatenated object module generation

--	generated_object_file_type: STRING is
--		once
--			if generate_object_libraries then
--				Result := ".olb"
--			else
--				Result := ".obj"
--			end
--		end

	application_name: STRING
		-- Application name (from all: target rule in top level Makefile)

	finalized: BOOLEAN
		-- Is this a finalized (as opposed to workbench) application?

	precompiled_library: STRING
		-- If not Void, the precompiled library this application uses.

	build_precompile: BOOLEAN
		-- Is this building a precompile?

	application_dependencies: ES5SH_SET[STRING]   --LINKED_LIST [STRING]LINKED_LIST [STRING]
		-- The prerequisites (objects, libraries) of the application (from the top level application target rule definition),
		-- less emain, preobj. Used to generate link.com list of objects/libraries

	dependent_subdirectories: ES5SH_SET[STRING]   --LINKED_LIST [STRING]
		-- Names of the subdirectories in the subdirectory object targets in top level Makefile.SH

	cecil_dependencies: STRING	-- should be LINKED_LIST[STRING]  ***FIXME***

	externals_list:	ES5SH_SET[STRING]   --ARRAYED_LIST[STRING]
		-- The externals (libraries, objects and options) if any are present (EXTERNALS macro found).
		-- Options are VMS LINK option files, not Unix link (-L) options.
		-- if none present, it is empty (never Void)

	externals_options: STRING
		-- externals options (Unix link options) from EXTERNALS macro.

	eiffel_library: STRING
		-- the eiffel runtime (runtime/finalized/workbench) object library (VMS filespec);
		-- from EIFLIB macro definition (or deduced from the cecil target???)

	start_time: STRING
		-- will be the date/time string processing started ***TBS***

	will_process_makefiles: BOOLEAN
		-- process makefiles in base_directory tree

	will_perform_make: BOOLEAN
		-- if true, perform make after processing makefiles

	will_concatenate_source_files: BOOLEAN
		-- if true, generate concatenated (big) source file in each subdirectory

	command_option_verbose: BOOLEAN
		-- -v command line option

-- macro definitions encountered in each Makefile.SH (reset in open_files)
	value_macro_OBJECTS, value_macro_OLDOBJECTS, value_macro_INCLUDE_PATH: STRING

-- macro definitions encountered (expected) in top Makefile.SH
	value_macro_EOBJ1: STRING
	value_macro_SUBDIRS: STRING



	precompile_tag: STRING  is	"driver.exe"
	-- The tag that is used to determine that we are processing a precompile.
	-- it was "precompile" in Eiffel3; it is "driver.exe" in Eiffel4 and Eiffel5


--	ignored_macro_definitions: ARRAY [STRING] is
--		-- macro definitions that, when empty, are not written to output Makefile because they are considered nugatory
--		-- ***FIXME*** this should be a configuration option
--	once
--		--Result := << "LDFLAGS", "LDSHAREDFLAGS", "LIBS", "AR", "LD", "MKDEP", "MV", "CP", "RANLIB", "SHELL" >>
--		Result := << "LDFLAGS", "LDSHAREDFLAGS", "LIBS", "AR", "LD", "RANLIB", "SHELL" >>
--		Result.compare_objects
--	end

	suppressed_macro_definitions: ARRAY [STRING] is
			-- macro definitions that are suppressed in the output Makefile
			-- (unless handled as a special case in process_macro_definition)
		once
			Result := << "SHELL", "AR", "RANLIB" >>
			Result.compare_objects
		end

	echoed_unprocessed_macro_definitions: ARRAY [STRING] is
			-- macro definitions that are always shown with unpreprocessed definition as a comment,
			-- even if comment_prefix configuration option is not defined
			-- includes suppressed_macro_definitions
			-- ***FIXME*** this should be a configuration option
		local
			l_res: EXTENDABLE_BOUNDED_ARRAY[STRING]
		once
			create l_res.make_empty
			Result := l_res
			l_res.compare_objects
			l_res.append_array (<< "INCLUDE_PATH", "CC", "CFLAGS", "EIFLIB", "OBJECTS", "OLD_OBJECTS", "EOBJ1", "X2C" >>)
			l_res.append_array (suppressed_macro_definitions)
		end

	unechoed_unprocessed_commands: ARRAY [STRING] is
			-- commands that are not echoed unprocessed as comments to output Makefile
		once
				Result := << "$(CC)","$(CPP)","$(X2C)", "$(RM)" >>
				Result.compare_objects
		end

	unprocessed_targets: ES5SH_SET [STRING] is
			-- targets that are echoed without processing to  output Makefile
		once
			create Result.make_from_array (<< "sub_clean", "sub_clobber" >>)
			--default: Result.compare_objects
		end

----------------------------------------------------------------------------
feature -- Input/Output files
--------------------------------------------------------------------------

	open_files (a_subdirectory : STRING) is
			-- open input Makefile.SH and new Makefile in "current" (sub) directory
			-- open in top level directory if a_subdirectory is Void
		require
			subdirectory_valid:	a_subdirectory = Void or else not a_subdirectory.is_empty
		local
			file_name  : FILE_NAME
			file_usage : STRING
			file_path : DIRECTORY_NAME
			l_msg, l_tag: STRING
		do
			-- (re)initialize all per-file values
			value_macro_OBJECTS := Void
			value_macro_OLDOBJECTS := Void
			value_macro_INCLUDE_PATH := Void

			-- open input file (Makefile.SH)
			file_usage := "input"
			create file_path.make_from_string (base_directory)
			if a_subdirectory /= Void and then not a_subdirectory.is_empty then
				file_path.extend (a_subdirectory)
			end
			create file_name.make_from_string (file_path)
			file_name.set_file_name ("Makefile.SH")
			create in_makefile.make_open_read (file_name)
			print_output_message ("  Processing " + in_makefile.name + "%N")
			in_makefile.read_line

			-- output file (Makefile.)
			file_usage := "output"
			create file_name.make_from_string (file_path)
			file_name.set_file_name ("Makefile")
			create out_makefile.make_open_write (file_name)
			out_makefile.put_string (default_comment_prefix + " " + file_name + "%N")
			out_makefile.put_string (default_comment_prefix + " generated by " + pretty_version + " at " + start_time + "%N")
			out_makefile.put_string (default_comment_prefix + "   configuration file: " + configuration.file_name + "%N")
			out_makefile.put_string (default_comment_prefix + "   " + value_eiffel_string
									+ "  " + symbol_platform + "=" + value_platform + "%N%N")
			put_comment_prefixed_line (" for replacing spaces with commas, viz. $(subst $(SPACE),$(COMMA),$(OBJECTS))")
			out_makefile.put_string ("EMPTY =%NSPACE = $(EMPTY) $(EMPTY)%NCOMMA =,%N%N")

		rescue
			l_msg := "Unable to open " + file_usage + " file " + file_name
					if a_subdirectory /= Void and then not a_subdirectory.is_empty then
				l_msg.append (" in " + a_subdirectory)
					end
			print_error_message (l_msg + "%N")
			l_tag := exceptions_.tag_name
			if l_tag = Void then
				l_tag := ""
			end
			l_tag.append (" : " + exceptions_.meaning (exceptions_.exception))
			print ("  " + l_tag + "%N")
		end; -- open_files


	close_files is
		-- close old and new makefile
		do
			in_makefile.close
			out_makefile.close
		end; -- close_files


	current_input_file_name : STRING is
		-- the name of the current input file including the path ([.c1]Makefile.SH)
		do
			if in_makefile = Void then
				print_error_message ("current_input_filename: in_makefile = Void!!!!%N")
				Result := "<none>"
			else
				Result := in_makefile.name
			end
		end; -- current_input_file_name



--------------------------------------------------------------------------
feature -- Process arguments and configuration options
--------------------------------------------------------------------------

-- Note: the original behavior of this program was to accept a single optional argument:
-- the path of the top level directory to process, default is the current directory.
-- If the path argument is specified, it generates Makefiles but does not perform the make.
-- That behavior is still preserved, even after adding the processing of additional option arguments.

	process_arguments is
		require
			argument_0_is_command_name: arguments_.argument_array.lower = 0
			argument_count_matches_array_upper: arguments_.argument_count = arguments_.argument_array.upper
		local
			ii, jj: INTEGER
			l_arg: STRING
			l_cmd, l_val: STRING
			l_obj_file, l_obj_lib: BOOLEAN
		do
			will_process_makefiles := True
			will_perform_make := (arguments_.argument_count = 0)
			will_concatenate_source_files := True
			l_cmd := arguments_.command_line	-- debug
			if arguments_.argument_count > 0 then
				print ("command: " + l_cmd + "%N")
			end
			-- check for -h (-help) argument; if found, display help message and ignore others.
			if arguments_.argument_count >= 1 and then (arguments_.index_of_character_option ('?') > 0
						or else arguments_.index_of_character_option ('h') > 0
						or else arguments_.index_of_word_option ("help") > 0 ) then
				print_help()
				will_process_makefiles := False
			else
				from
					ii := 1		-- arguments_.argument_array.lower (arg[0] is command)
				until
					ii > arguments_.argument_count 	-- arguments_.argument_array.upper
				loop
					l_val := arguments_.argument_array.item(ii)
					l_arg := arguments_.argument(ii)
					--***tbs***
					debug ("arguments")
						print ("  debug: process argument " + ii.out + ": %"" + l_arg + "%" (" +  l_arg.count.out + ")%N")
						from jj := 1; create l_val.make(l_arg.count * 2)
						until jj >  l_arg.count
						loop
							l_val.append_character(l_arg @ jj); l_val.append_character(' ')
							jj := jj + 1
						end
						print ("    " + l_arg.count.out + " characters: " + l_val + "%N")
					end
					if l_arg.count = 2 and then l_arg @ 1 = arguments_.option_sign then
						inspect l_arg @ 2
						when 'h' then	--	-help
							print_help()
							will_process_makefiles := False
						when 'b' then	--	-build (synonyum for -make)
							will_perform_make := True
						when 'm' then	--	-make (synonym for -build)
							will_perform_make := True
						when 'c' then	--  -config <file>
							if ii < arguments_.argument_count then
								ii := ii + 1
								create configuration_file_name.make_from_string (arguments_.argument(ii) )
							else
								print_error_message ("-c option requires <configuration_file>%N")
								will_process_makefiles := False
							end
						when 'l' then
							if l_obj_file then
								print_warning_message ("-l option conflicts with -o; -o ignored%N")
								print_usage()
							end
							generate_object_libraries := True
							l_obj_lib := True
						when 'o' then
							if l_obj_lib then
								print_warning_message ("-o option conflicts with -l; -l ignored%N")
								print_usage()
							end
							generate_object_libraries := False
							l_obj_file := True
						when 'q' then
							command_option_verbose := False
						when 't' then	--	-test
							will_process_makefiles := False
							will_perform_make := False
							test()
						when 'v' then	--	-verbose
							command_option_verbose := True
						when 'z' then	--	-z (dont concatenate source files)
							will_concatenate_source_files := False
						else
							print_error_message ("invalid option: " + l_arg + "%N")
							print_usage()
							will_process_makefiles := False
						end -- inspect
					else
						if ii = arguments_.argument_count then
							create base_directory.make_from_string (arguments_.argument(ii))
						else
							print_error_message ("invalid argument #" + ii.out + ": " + l_arg + "%N")
							print_usage()
							will_process_makefiles := False
						end
					end
					ii := ii + 1
				end -- loop
			end -- if -help not found in arguments
		end; -- process_arguments


-------------------------------------------------------------------------
feature --  Process Makefile.SH files
-----------------------------------------------------------------------

	process_makefiles is
		do
			create application_dependencies.make_empty
			create dependent_subdirectories.make_empty
			create externals_list.make_empty
			create externals_options.make_empty
			create cecil_dependencies.make_empty
			process_top_level_makefile
			process_subdirectory_makefiles
		end


	process_top_level_makefile is
			-- create a new Makefile for the top level
		require
			no_current_input_file:	in_makefile = Void
		local
			l_spit2_tag : STRING
		do
			check
				dependent_subdirectories_off_initially: dependent_subdirectories.off
			end
			open_files (Void)
			process_case_stmt ()
			process_case_stmt ()
			process_echo_stmt ()
			check
				dependent_subdirectories_off_after_process_echo: dependent_subdirectories.off
			end
			process_spit1_block ()
			check
				dependent_subdirectories_off_after_process_spit1: dependent_subdirectories.off
			end
			l_spit2_tag := get_spitshell_end_tag
			check
				dependent_subdirectories_off_after_get_spitshell_end_tag: dependent_subdirectories.off
			end
			process_spit2_block (l_spit2_tag)
			check
				dependent_subdirectories_off_after_process_spit2: dependent_subdirectories.off
			end
			--process_remainder()
			close_files
			produce_link_dot_com
		end -- process_top_level_makefile


	process_subdirectory_makefiles is
			-- process Makefiles in each of `dependent_subdirectories'
		local
			l_saved_index: INTEGER
		do
			from
				dependent_subdirectories.start
			until
				dependent_subdirectories.off
			loop
				l_saved_index := dependent_subdirectories.index	-- ***debug***
				open_files (dependent_subdirectories.item)
				process_case_stmt ()
				process_case_stmt ()
				process_echo_stmt ()
				process_spit1_block ()
				process_spit2_block (Void)
				out_makefile.flush
				--process_remainder ()
				close_files
				--produce_make_dot_com (dependent_subdirectories.item)
				if will_produce_concatenated_source_file_in (dependent_subdirectories.item) then
					produce_concatenated_source_file (dependent_subdirectories.item)
				end
				check
					dependent_subdirectories_position_unchanged:
						l_saved_index = dependent_subdirectories.index
				end
				dependent_subdirectories.forth
			end
		end; -- process_subdirectory_makefiles



--------------------------------------------------------------------------
feature -- Process elements of Makefile.SH
--------------------------------------------------------------------------

	process_case_stmt () is
			-- process a case block by ignoring it
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
		local
			token1 : STRING
		do
			-- skip to next token in input
			from
				token1 := first_token (in_makefile.last_string)
			until
				--starts_with_symbol (in_makefile.last_string, "case")
				not token1.is_empty
			loop
				out_makefile.put_string (in_makefile.last_string + "%N")
				in_makefile.read_line
				token1 := first_token (in_makefile.last_string)
			end

			-- if token1.is_equal ("case") then
			if starts_with_symbol (in_makefile.last_string, "case") then
			else
				-- scream bloody murder
				print ("Error: looking for case statement, found: '" + token1
					+ "' on line:%N" + in_makefile.last_string
					+ "%N  in file " + in_makefile.name + "%N")
				exceptions_.raise ("case label not found")
			end

			from
			until
				starts_with_symbol (in_makefile.last_string, "esac")
			loop
				in_makefile.read_line
			end
			in_makefile.read_line
		end; -- process_case_stmt


	process_echo_stmt  is
			-- process an echo statement by ignoring it
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			-- in_makefile.last_string.startswith ("echo")
			is_echo_statement:
			in_makefile.last_string /= Void and then starts_with_symbol (in_makefile.last_string, "echo")

		local
			token1 : STRING
		do
			debug ("echo")
				token1 := first_token (in_makefile.last_string);
				-- tok2 := second_token (in_makefile.last_string, token1);
			end -- debug

			in_makefile.read_line
		end


	get_spitshell_end_tag : STRING is
			-- the tag that ends the spitshell block on the current line of the input makefile
			-- if the tag is quoted (with single quotes), remove the enclosing quote characters
			-- read the next input line
		require
			not_end_of_file:		not in_makefile.end_of_file
			is_spitshell_block:		starts_with (in_makefile.last_string, "$spitshell")
		local
			l_pos : INTEGER
		do
			l_pos := in_makefile.last_string.substring_index ("<<", 1)
			if l_pos > 0 then
			Result := in_makefile.last_string.substring (l_pos +2, in_makefile.last_string.count)
			if Result.count >= 2 then
				if (Result @ 1 = '%'') and then Result @ 1 = Result @ Result.count then
					Result.remove (Result.count)
					Result.remove (1)
				end
			end
			in_makefile.read_line
			end
		end; -- get_spitshell_end_tag


	process_spit1_block () is
			-- process the first spitshell block (contains macro definitions)
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
		local
			l_end_tag : STRING
		do
			from
				l_end_tag := get_spitshell_end_tag
					-- usually the tag is !GROK!THIS! (I think!)
			until
				--in_makefile.end_of_file or else
				in_makefile.last_string.is_equal (l_end_tag)
			loop
				if in_makefile.last_string.is_empty then
					out_makefile.put_new_line
					in_makefile.read_line
				elseif in_makefile.last_string @ 1 = '#' then
					out_makefile.put_string (in_makefile.last_string + "%N")
					in_makefile.read_line
				elseif (is_macro_definition (in_makefile.last_string)) then
					process_macro_definition()
				else -- not a macro definition, just comment and continue
					put_comment_prefixed_line (in_makefile.last_string)
					in_makefile.read_line
				end -- is_macro_definition
			end -- read loop

			if not in_makefile.end_of_file then
				in_makefile.read_line	-- consume line with spitshell end tag
			else
				print ("Unexpected end of file encountered.%N")
			end
			out_makefile.put_new_line()
			debug
				print ("Done with first spitshell block..." + in_makefile.last_string + "%N")
			end -- debug
		end;  -- process_spit1_block


	process_spit2_block (a_end_tag: STRING) is
			-- process second spitshell block (contains dependency rules)
			-- for top level makefile, this is called after the objects and subdirectories and stuff
			-- to process the rest of the block.
			-- for subdirectory makefile it is called at the start of the block
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			output_file_writable:   out_makefile /= Void and then out_makefile.is_open_write
		local
			l_tag: STRING
		do
			check
				a_end_tag = Void implies
					in_makefile.last_string.substring (1,10).is_equal ("$spitshell")
			end

			from
				if a_end_tag /= Void then
					l_tag := a_end_tag
				else
					l_tag := get_spitshell_end_tag
				end
			until
				in_makefile.end_of_file or else in_makefile.last_string.is_equal(l_tag)
			loop
				if in_makefile.last_string.is_empty then
					out_makefile.put_new_line
					in_makefile.read_line
				elseif in_makefile.last_string @ 1 = '#' then
					out_makefile.put_string (in_makefile.last_string + "%N")
					in_makefile.read_line
				elseif is_macro_definition (in_makefile.last_string) then
					process_macro_definition ()
				elseif not is_whitespace (in_makefile.last_string @ 1) and then in_makefile.last_string.has (':') then
					process_rule ()
				else
					-- what else could this line be? Don't know; just output it as a comment
					print_makefile_warning ("process_spit2_block: unprocessed line")
					out_makefile.put_string (default_comment_prefix + " Warning: unprocessed: " + in_makefile.last_string + "%N")
					in_makefile.read_line
				end
			end -- loop until end of file or end of spitshell block

			if not in_makefile.end_of_file then
				in_makefile.read_line -- consume spitshell block end tag
			end

			-- add default rule if it is in the config file
			out_makefile.new_line
			if configuration.has ("default_rule") then
				put_comment_prefixed_line ("default_rule (from configuration file " + configuration.file_name + ")")
				out_makefile.put_string (configuration.item ("default_rule"))
				out_makefile.new_line
				put_comment_prefixed_line ("end default_rule")
				out_makefile.new_line
			end	-- default rule
			--out_makefile.put_string ("%N%N")
		end -- process_spit2_block


--	process_remainder is
--		do
--			from
--				out_makefile.put_new_line
--			until
--				in_makefile.end_of_file
--			loop
--				put_comment_prefixed_line (in_makefile.last_string)
--				in_makefile.read_line
--			end
--		end


	process_rule () is
			-- process target definition:    <target>... : [ <prerequisite>... ]
			-- and following command and comment lines
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			output_file_writable:   out_makefile /= Void and then out_makefile.is_open_write
			current_line_nonblank:  not in_makefile.last_string.is_empty
			is_target_rule:
				in_makefile.last_string.count > 2 and then not is_whitespace (in_makefile.last_string @ 1)
					and then in_makefile.last_string.index_of (':', 2) > 0
		local
			l_colon_pos: INTEGER
			l_target, l_prereq, l_con_src: STRING
		do
			l_colon_pos := in_makefile.last_string.index_of (':', 1)
			--if not is_whitespace (in_makefile.last_string @ 1) and then in_makefile.last_string.has (':') then
			if l_colon_pos <= 0 or else is_whitespace (in_makefile.last_string @ 1) then
				print_makefile_error ("process_rule: non target rule encountered")
				out_makefile.put_string (in_makefile.last_string + "%N")
			else
					-- a rule (dependency specification):  <target>... : [ <prerequisite>... ] (colon may be double)
				l_target := in_makefile.last_string.substring (1, l_colon_pos -1)
				if l_colon_pos < in_makefile.last_string.count then
					l_prereq := in_makefile.last_string.substring (l_colon_pos +1, in_makefile.last_string.count)
					if l_prereq.count > 1 and then l_prereq @ 1 = ':' then
						l_prereq.remove (1)
					end
					l_prereq.left_adjust
				else
					l_prereq := ""
				end
				if l_target.is_equal (".SUFFIXES") then
					put_comment_prefixed_line (in_makefile.last_string)
					delimit_target_colon (in_makefile.last_string)
					in_makefile.last_string.append_character (' ')
					in_makefile.last_string.replace_substring_all (".o ", ".obj ")
					in_makefile.last_string.right_adjust
					out_makefile.put_string (in_makefile.last_string + "%N")
					in_makefile.read_line	-- consume current line
				elseif l_target.is_equal ("all")  then
					process_rule_all (l_target, l_prereq)
				elseif l_target.is_equal ("cecil") then
					process_rule_cecil (l_target, l_prereq)
				elseif application_name /= Void and then l_target.is_equal (application_name) then
					-- ***FIXME*** what if application_name is Void already found and l_target = application_name ?
					process_rule_application (l_target, l_prereq)
				elseif l_target @ 1 = '.' and then l_target.index_of ('.', 3) > 0 then
					process_suffix_rule	(l_target)
				elseif l_target.index_of ('/', 1) > 0 then
						-- i.e.  C1/Cobj1.o   in top level Makefile line:  C1/Cobj1.o: Makefile
						-- should only occur in top level file
					process_subdirectory_rule (l_target, l_prereq)
				elseif is_current_subdirectory_object_file (l_target) then
						-- i.e.  Cobj1.o in subdirectory C1 -- from C1/Makefile.SH line:  Cobj1.o: $(OBJECTS) Makefile
						-- should only occur in subdirectory file
					put_comment_prefixed_line (in_makefile.last_string)
					--delimit_target_colon (in_makefile.last_string)
					--l_colon_pos := in_makefile.last_string.index_of (':', 1)
					--in_makefile.last_string.replace_substring_all (".o", generated_object_file_type)
					l_target.replace_substring_all (".o", generated_object_file_type)
					if generate_object_libraries or else dependent_subdirectories.off then
						--out_makefile.put_string (in_makefile.last_string + "%N")
					else
						l_con_src := concatenated_source_file_name (dependent_subdirectories.item)
						--in_makefile.last_string.replace_substring_all ("$(OBJECTS)", l_con_src + ".c")
						--out_makefile.put_string (in_makefile.last_string + "%N")
						l_prereq.replace_substring_all  ("$(OBJECTS)", l_con_src + ".c")
					end
					out_makefile.put_string (l_target + " : " + l_prereq + "%N")
					skip_rule_commands
					if generate_object_libraries or else dependent_subdirectories.off then
						if configuration.target_gnu_make then
							out_makefile.put_string ("%Tlibrary/create $@ $(subst $(SPACE),$(COMMA),$(OBJECTS))%N")
						else
							out_makefile.put_string ("%Tlibrary/create $@ *.obj%N")
							if l_target.substring_index ("Eobj1.olb", 1) > 0 then
								out_makefile.put_string ("%T- if f$search(%"emain.obj%") .nes. %"%" then library/delete=emain $@%N")
							end
						end
					else
						--out_makefile.put_string ("#%T$(CP) $(subst $(SPACE),$(COMMA),$(OBJECTS)) $@%N")
						out_makefile.put_string ("%T$(CC) $</obj=$@ $(CFLAGS)%N")
					end
					if configuration.has ("create_test") then
						out_makefile.put_string ("%T$(CREATE_TEST)%N")
					end
					out_makefile.put_new_line
				elseif FALSE AND THEN unprocessed_targets.has (l_target) then
					delimit_target_colon (in_makefile.last_string)
					out_makefile.put_string (in_makefile.last_string +"%N")
					echo_rule_commands
				else
						-- generic target
					delimit_target_colon (in_makefile.last_string)
					--perform_inchoate_replacements (in_makefile.last_string)
					out_makefile.put_string (in_makefile.last_string +"%N")
					process_rule_commands (l_target, l_prereq)
				end
			end -- (is target definition)
		end; -- process_rule


	process_suffix_rule (a_target: STRING) is
			-- process a suffix rule (eg.  .c.o:)
		require
			input_file_readable: in_makefile /= Void  and then in_makefile.is_open_read
			output_file_ready:   out_makefile /= Void and then out_makefile.extendible
			is_suffix_rule:
				in_makefile.last_string.count >= 5 and then
					in_makefile.last_string @ 1 = '.' and then in_makefile.last_string.index_of ('.', 3) > 0
					and then in_makefile.last_string.index_of (':', 3) > in_makefile.last_string.index_of ('.', 3)

		local
			l_dot2_pos: INTEGER
			l_source, l_target: STRING
		do
			l_dot2_pos := a_target.index_of ('.', 2)
			l_source := a_target.substring (1, l_dot2_pos - 1)
			l_target := a_target.substring (l_dot2_pos, a_target.count)
			if l_source.is_equal (".x") then
				finalized := True
			end
			if l_target.is_equal (".o") then
				l_target := ".obj"
			end
			out_makefile.put_string (l_source + l_target + " :%N")
			if True then
				process_rule_commands (l_source + l_target, "")
--			else
--				from
--					in_makefile.read_line
--				until
--					in_makefile.end_of_file or else in_makefile.last_string.is_empty
--						or else not is_space_or_tab (in_makefile.last_string @ 1)
--				loop
--					in_makefile.last_string.replace_substring_all (" -c", "")
--					--perform_inchoate_replacements (in_makefile.last_string)
--					out_makefile.put_string (in_makefile.last_string + "%N")
--					in_makefile.read_line
--				end -- loop
			end
		end -- end process_suffix_rule


	process_subdirectory_rule (a_target, a_prerequisite: STRING) is
			-- process a subdirectory rule (eg.  X99/Xobj99.o: Makefile)
		require
			input_file_readable: in_makefile /= Void  and then in_makefile.is_open_read
			output_file_ready:   out_makefile /= Void and then out_makefile.extendible
			is_dependency_definition:
				in_makefile.last_string.count > 5 and then not is_whitespace (in_makefile.last_string @ 1)
					and then in_makefile.last_string.index_of (':', 2) > 0
			target_exists_nonblank: a_target /= Void and then not a_target.is_empty
			target_is_subdirectory: a_target.index_of ('/', 1) > 0
		local
			l_target, l_prereq: STRING
			l_slash_pos, l_dot_pos : INTEGER
			l_target_dir, l_target_file,l_target_dir_vms: STRING
		do
			put_comment_prefixed_line (in_makefile.last_string)
			l_target := a_target.twin
			to_vms_filespecs (l_target, 1);
			if is_nonblank (a_prerequisite) then
				l_prereq := a_prerequisite.twin
				to_vms_filespecs (l_prereq, 1)
			else
				l_prereq := ""
			end
			-- GNU make requires colons in VMS filespecs to be escaped
			if configuration.target_gnu_make then   -- quote_colon_in_VMS_dependencies
				l_target.replace_substring_all (":", "\:")
				l_prereq.replace_substring_all (":", "\:")
			end
			-- get the path and file name of the (first) target
			l_slash_pos := a_target.index_of ('/', 1) -- must be > 0 from require target_is_subdirectory
			l_target_dir := a_target.substring (1, l_slash_pos -1)	-- ***FIXME*** make it work even with terminating slash
			l_target_dir_vms := as_vms_filespec (a_target.substring (1, l_slash_pos))
			l_dot_pos := a_target.index_of ('.', l_slash_pos +1)
			if l_dot_pos > l_slash_pos then
				l_target_file := a_target.substring (l_slash_pos +1, l_dot_pos -1)
			else
				l_target_file := a_target.substring (l_slash_pos +1, a_target.count)
			end

			if not l_target_dir.is_empty then
				dependent_subdirectories.extend (l_target_dir)
			end
			if l_target_dir.is_empty then
				-- skip rule if empty target directory or target file
				print_makefile_warning ("process_subdirectory_rule: target directory is empty!")
				skip_rule_commands
				out_makefile.put_new_line
			elseif l_target_file.is_empty then
				-- skip rule if empty target file
				print_makefile_warning ("process_subdirectory_rule: target file is empty!")
				skip_rule_commands
				out_makefile.put_new_line
			elseif l_target_file.is_equal (subdirectory_object_filename(l_target_dir)) then
					-- emit the commands for building the target subdirectory object,
					-- skip past the current line and all its directives
				out_makefile.put_string (l_target + " : " + l_prereq + "%N")
				skip_rule_commands
				--out_makefile.put_string ("%T" + configuration.ignore_prefix + ...
						--+ platform_specific_file_name (<<"studio","spec">>, <<"bin">>, "make.vms ") + " "
						--+ "ISE_EIFFEL:[studio.spec." + value_platform + ".bin]make.vms " + l_target_dir_vms + "%N")
				out_makefile.put_string (subdirectory_make_command (l_target_dir_vms, Void) + "%N")
			elseif l_target_file.is_equal ("Makefile") then	-- ****FIXME**** make case insensitive comparison??
					-- skip this subdirectory rule, output comment
				--put_comment_prefixed_line (l_target + " : " + l_prereq)
				out_makefile.put_string (l_target + " : " + l_prereq + "%N")
				skip_rule_commands
				put_comment_prefixed_line ("%T(Makefile generated by finish_freezing/" + pretty_name + ")")
			elseif l_target_file.is_equal ("emain") then
				-- emit copy command for emain template
				out_makefile.put_string (l_target + " : " + l_prereq + "%N")
				skip_rule_commands
				-- force target extension to uppercase to workaround MMS suffix rule case sensitivity bug:
				-- MMS does not run .c.obj: or .C.obj: rule for .c file (must be .C) on ODS5 volume
				--out_makefile.put_string ("%TCOPY  "
				--		+ platform_specific_file_name (<<"studio","config">>, <<"templates">>, "emain.template")
				--		+ "  " + l_target_dir_vms + "emain.C %N")
				--out_makefile.put_string ("%T- COPY  " + emain_vms + "  " + l_target_dir_vms + "emain.C %N")
				out_makefile.put_string ("%T" + configuration.ignore_prefix
						+ "$(CP) ISE_EIFFEL:[studio.config.$(ISE_PLATFORM).templates]emain.template [.E1]emain.c%N")
				out_makefile.put_string (subdirectory_make_command ("[.E1]", "emain.obj") + "%N")
			else
				out_makefile.put_string (l_target + " : " + l_prereq + "%N")
				--process_target_prerequisites
				process_rule_commands (l_target, l_prereq)
				end
		end; -- process_subdirectory_rule


	process_rule_all (a_target, a_prerequisite: STRING) is
			-- process all: target
			-- If this is the top level makefile, it will be  all: <appl>  (all: hello)
			-- If a subdirectory, it will be   all: <subdirectory_object>  (all: Cobj1.o)
			-- process lines starting with all target rule and all command and comment lines
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			line_starts_with_all_colon: starts_with (in_makefile.last_string, "all") and then in_makefile.last_string.has (':')
			--***FIXME*** need an abstraction for is_dependency_definition (target) to check that target occurs to the left of ':'
		local
			l_line: STRING
			l_pos: INTEGER
			l_appl_exe: STRING
		do
			put_comment_prefixed_line (in_makefile.last_string)
			l_line := in_makefile.last_string.twin -- ***fixme*** does it really need to twin?
			delimit_target_colon (l_line)
			l_pos := l_line.index_of (':', 4) 	-- can't occur before "all"
			if l_line @ l_pos = ':' then l_pos := l_pos + 1 end
			-- ***FIXME*** this is kinda hokey:
			if application_name = Void then
					-- processing top level Makefile
				--application_name := in_makefile.last_string.substring (("all:").count +1, in_makefile.last_string.count)
				application_name := in_makefile.last_string.substring (l_pos, in_makefile.last_string.count)
				application_name.left_adjust; application_name.right_adjust
				if application_name.is_equal (precompile_tag) then
					build_precompile := True
					l_appl_exe := "driver.exe"
				else
					l_appl_exe := application_name + ".exe"
				end
				out_makefile.put_string ("all : " + l_appl_exe + "%N")
				skip_rule_commands
				out_makefile.put_string ("%Topen/write fn complete.eif%N")
				-- out_makefile.put_string ("%Tclose/nolog fn%N")
				-- (file will be closed automatically, and this makes GNU make burp)
				-- (because it spawns a new subprocess for each command)

			else
					-- processing for (sub)directory makefiles
				l_line.replace_substring_all (".o", generated_object_file_type)
				l_line.replace_substring_all ("emain.olb", "emain.obj")
				-- special handling for Eobj1 (in [.E1]) to add a dependency on emain.obj
				if l_line.substring_index ("Eobj1" + generated_object_file_type, 1) > l_pos
						and then l_line.substring_index ("emain.obj", 1) = 0 then
					l_line.replace_substring_all ("Eobj1" + generated_object_file_type, "Eobj1" + generated_object_file_type + " emain.obj")
				end
				out_makefile.put_string (l_line + "%N")
				skip_rule_commands
				-- adding this line keeps MMS (and MMK?) from printing a warning. No effect with GNU make. ***FIXME*** MMS/MMK specific
				if not configuration.target_gnu_make then
					out_makefile.put_string ("%Tcontinue%N")
				end
			end
		end -- process_rule_all


	process_rule_application (a_target, a_prerequisite: STRING) is
			-- Process application target, eg:  <appl>: $(OBJECTS) E1/emain.o Makefile
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			appl_nonblank:		application_name /= Void and then not application_name.is_empty
			appl_has_target:		in_makefile.last_string.index_of (':', 1) > 0
			appl_has_dependencies:	in_makefile.last_string.index_of (':', 1) < in_makefile.last_string.count
			is_appl_target_definition:	starts_with_symbol (in_makefile.last_string, application_name)
						and then first_token (in_makefile.last_string). is_equal (application_name)
						and then second_token (in_makefile.last_string, application_name). is_equal (":")
		local
			l_line, l_target, l_word : STRING
			l_appl_rule: STRING
			l_colon_pos, l_pos: INTEGER
			unfinished_remove_colon_pos: INTEGER
		do
			-- No longer using option from config.eif file
			-- Replace appl with appl.exe, unless precompile

			if configuration.comment_prefix /= Void then
					-- output dependent_subdirectories and application_dependencies
				out_makefile.put_string ("%N" + configuration.comment_prefix + " dependent_subdirectories:");
				from  dependent_subdirectories.start
				until dependent_subdirectories.after
				loop
					out_makefile.put_string (" " + dependent_subdirectories.item)
					dependent_subdirectories.forth
				end -- loop to print out dependent_subdirectories
				out_makefile.put_string ("%N" + configuration.comment_prefix + " application_dependencies:");
				from  application_dependencies.start
				until application_dependencies.after
				loop
					out_makefile.put_string (" " + application_dependencies.item)
					application_dependencies.forth
				end -- loop to print out application_dependencies
				out_makefile.put_string ("%N%N")
			end

			put_comment_prefixed_line (in_makefile.last_string)
			--out_makefile.put_string (l_appl_rule + "%N")
			create l_appl_rule.make_from_string (in_makefile.last_string)
			l_target := first_token (l_appl_rule)
			if l_target.is_equal (precompile_tag) then
				l_target := "driver"
			end
			l_line := l_target + ".exe : "

			-- rearrange prerequisites to place E1/emain first
			l_colon_pos := l_appl_rule.index_of (':', 1)
			l_pos := l_appl_rule.substring_index ("E1/emain.o", l_colon_pos +1)
			if l_pos > 0 then
				l_appl_rule.replace_substring ("", l_pos, l_pos + ("E1/emain.o").count -1)
				-- this will fail if ":" is last char in string
				l_appl_rule.insert_string (" [.E1]emain.obj ", l_colon_pos +1)
			end

			process_target_prerequisites (l_appl_rule, l_colon_pos)

			-- replace target string <appl>.exe or preobj_tag
			l_colon_pos := l_appl_rule.index_of (':', 1)
			l_appl_rule.replace_substring (l_line, 1, l_colon_pos)
			out_makefile.put_string (l_appl_rule + "%N")

			-- position at first space

			-- loop: skip target commands
			-- this loop reads the file until an empty line
			-- to suck up the rest of the commands for building the target appl
			-- it looks for precompiled objects and does stuff with "word"
			-- that is probably left over from an earlier incarnation, and that's why
			-- it doesn't just call skip_rule_commands
			from
				if not in_makefile.last_string.is_empty then
					l_pos := in_makefile.last_string.substring_index ("preobj", 1)
				else l_pos := 0
				end
				-- if l_pos > 0 and not build_precompile then
				if l_pos > 0 then
					precompiled_library := in_makefile.last_string.twin -- ***fixme*** does it really need to twin?
				end
				in_makefile.read_line
			until
				in_makefile.end_of_file or else in_makefile.last_string.is_empty -- **FIXME** s.b. until non-whitespace first char?
			loop
					-- MMS chokes on comments that end with continuation character, so
					-- remove any such
				if is_continued_line (in_makefile.last_string) then
					strip_continuation (in_makefile.last_string)
				end
				if configuration.comment_prefix /= Void then
					out_makefile.put_string (configuration.comment_prefix + in_makefile.last_string + "%N")
				end

				l_pos := in_makefile.last_string.index_of ('#', 1);
				if l_pos > 0 then	-- remove comment
					in_makefile.last_string.keep_head (l_pos - 1)
				end
				l_word := in_makefile.last_string.twin -- ***fixme*** does it need to twin?
				l_word.left_adjust
				if not l_word.is_empty then
					if not l_word.is_equal ("Makefile") then
						if l_word.count >= 10 and then
								not l_word.substring_index ("runtime", 1).is_equal(0) then
							application_dependencies.extend ("eiflib:runtime.olb")
						elseif l_word.count >= 10 and then
							not l_word.substring_index ("wkbench", 1).is_equal(0) then
							application_dependencies.extend ("eiflib:wkbench.olb")
						elseif
								-- ignore lines starting with $
							not l_word.substring(1,1).is_equal("$") and then
							not starts_with (l_word, "ld ")
						then
							-- this is totally bizarre - it can be a whole line!
							application_dependencies.extend (l_word)
							debug ("appl")
					 print ("DEBUG(appl): Adding " + l_word + " to application_dependencies%N")
							end -- debug
						end
					end	-- not Makefile
					l_pos := l_word.substring_index ("preobj", 1)
				else
					l_pos := 0
				end -- l_word.is_empty
				-- if l_pos > 0 and not build_precompile then
				if l_pos > 3 and then not l_word.substring (l_pos-3, l_pos-1).is_equal ("-o ") then
					precompiled_library := l_word.twin
				end
				in_makefile.read_line
			end -- loop

			-- write out the the action lines to build the appl
			out_makefile.put_string ("%T" + configuration.commandfile + "link.com%N")
			if precompiled_library /= Void then
				precompiled_library.left_adjust
				precompiled_library.replace_substring_all ("\", "")
				precompiled_library.right_adjust
			end -- precompiled_library found
			debug ("appl")
				print ("DEBUG(appl): application_dependencies: %N")
				from
					application_dependencies.start
				until
					application_dependencies.after
				loop
					print (" %"" + application_dependencies.item + "%"%N")
					application_dependencies.forth
				end
			end -- debug
		end;  -- process_rule_application


	process_rule_cecil (a_target, a_prerequisite: STRING) is
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			is_cecil_target_definition:	starts_with (in_makefile.last_string, "cecil:")
						or else starts_with (in_makefile.last_string, "cecil") and then
							second_token (in_makefile.last_string, "cecil").is_equal (":")
		local
			deletable_objects: STRING
		do
			if True then
					-- ***FIXME*** comment out all the cecil related targets and definitions
				from
				until
					starts_with_symbol (in_makefile.last_string, "clean")
				loop
					out_makefile.put_string ("#! " + in_makefile.last_string + "%N")
					in_makefile.read_line
				end --
				out_makefile.put_new_line
			else
				if not in_makefile.end_of_file and then not in_makefile.last_string.is_empty then
					delimit_target_colon (in_makefile.last_string)
					out_makefile.put_string (in_makefile.last_string)
				end
			end
			out_makefile.put_new_line

			if starts_with_symbol (in_makefile.last_string, "cecil") then
				-- first, process the cecil: line, converting C1/cobj1.o to [.c1]cobj1.olb etc.
				-- (just use the dependencies that we got before)

				out_makefile.put_string ("cecil : ")
				if cecil_dependencies /= Void then
					out_makefile.put_string (cecil_dependencies)
				else out_makefile.put_string ("  #  none found")
				end
				out_makefile.put_new_line
				-- next extract the objects from runtime.olb or wkbench.olb
				-- skip the cecil : <object> (eiffel3) or cecil: lib<appl>.a (eiffel4) line
				in_makefile.read_line
				-- skip the new Eiffel4 lib<appl.a> : <objects> line
				in_makefile.read_line
				if eiffel_library = Void then
					if not in_makefile.last_string.substring_index ("wkbench", 1).is_equal(0)  then
						eiffel_library := "wkbench"
					elseif not in_makefile.last_string.substring_index("runtime", 1).is_equal(0) then
						eiffel_library := "runtime"
					else -- neither workbench nor runtime - something is wrong
						eiffel_library := "UNDEFINED_EIFFEL_RUNTIME_LIBRARY"
						-- panic - neither workbench nor runtime recognized
					end 		-- workbench or runtime
				end
				deletable_objects := eiffel_library + ".obj;*"
				-- extract modules from eiffel runtime library (finalized, mtfinalized, wkbench, runtime, or whatever)
				out_makefile.put_string ("%Tlibrary/extract=*/output=eifrtlib.obj ")
				--out_makefile.put_string (eiffel_library + ".obj " + eiffel_library_filespec + "%N")
				out_makefile.put_string ("$(EIFLIB)%N")

				-- next line is "ar cr lib<appl>.a ...", ignore
				in_makefile.read_line
				-- next line is precompile lib, if used
				in_makefile.read_line
				if not in_makefile.last_string.substring_index ("preobj", 1).is_equal (0) then
					out_makefile.put_string ("%Tlibr/extract=*/output=preobj.obj  ")
					in_makefile.last_string.replace_substring_all ("\", "")
					in_makefile.last_string.replace_substring_all ("%T", " ")
					in_makefile.last_string.replace_substring_all ("  ", " ")
					-- GNU make on vms/alpha again, requires this
					replace_eiffel_symbols (in_makefile.last_string)
					out_makefile.put_string (in_makefile.last_string)
					out_makefile.put_new_line
					deletable_objects.append (",preobj.obj;*")
				end
				out_makefile.put_string ("%Tlibrary/create ")
				out_makefile.put_string (application_name); out_makefile.put_string (".olb  *.obj,[.*]*.obj %N")
				--out_makefile.put_string ("%T- if f$$search(%"emain.obj%") .nes. %"%" then library/delete=emain $@%N")
				out_makefile.put_string ("%T- if ")
				out_makefile.put_string (DCL_quoted_word ("f$search"))
				out_makefile.put_string ("(%"emain.obj%") .nes. %"%" then library/delete=emain $@%N")
				if deletable_objects /= Void then
					out_makefile.put_string ("%T-delete " + deletable_objects + "%N")
				end

				-- ignore remaining lines...
				--if not externals_present then 		NEEDED?
				--	l_line.replace_substring_all ("$(EXTERNALS)", "")
				--end

				-- read until eof or next empty line
				from
				until
					in_makefile.end_of_file or else in_makefile.last_string.is_empty
				loop
					in_makefile.read_line
				end
			end
		end; -- process_rule_cecil


	process_target_prerequisites (a_dependents : STRING; initial_pos : INTEGER) is
			-- process prerequisites (dependents) of a target:
			--  replace macro references with their values;
			--  for each "word", translate filespec to VMS syntax if it is a unix filespec and
			--    append to application dependencies
			-- ***FIXME*** return a value, don't update application_dependencies
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read

		local
			start_pos, end_pos: INTEGER
			word: STRING
		do
			--make_vms_filespecs (a_dependents, initial_pos)
			from
				start_pos := next_word_index (a_dependents, initial_pos)
			until
				start_pos = 0 or else start_pos > a_dependents.count
			loop
				end_pos := end_word_index (a_dependents, start_pos)
				word := a_dependents.substring (start_pos, end_pos)

				if a_dependents @ start_pos = '#' then
					end_pos := a_dependents.count
				elseif value_macro_OBJECTS /= Void and then word.is_equal ("$(OBJECTS)") then
					process_target_prerequisites (value_macro_OBJECTS, 0)
					-- a_dependents.replace_substring (value_macro_OBJECTS, start_pos, end_pos)
					-- end_pos := start_pos -1
				elseif word.is_equal ("Makefile") then
					-- skip Makefile
				elseif word.is_equal ("EMAIN_SPECIAL") then
					-- special processing for Emain
				elseif starts_with (word, "$(") then
					-- special processing for unknown macro
					print_warning_message ("process_target_prerequisites: Don't know how to process macro in file: ")
					print (current_input_file_name() + "%N macro: %"" + word + "%" at position: " + start_pos.out
						+ " in %N  line: %"" + a_dependents + "%"%N")
				else
					if ends_with (word, ".o") then
						word := as_vms_filespec (word)
						if starts_with_symbol (word, "[.E1]emain.o") then
							word.append ("bj")
						else
							word.append ("lb")
						end
						a_dependents.replace_substring (word, start_pos, end_pos)
						end_pos := start_pos - word.count
					end
					--if not word.is_equal ("[.E1]emain.obj")
					if not word.as_lower.is_equal ("[.e1]emain.obj") then
						application_dependencies.extend (word)
					end
				end -- special word handling
				start_pos := next_word_index (a_dependents, end_pos)
			end -- loop: for each word in a_dependents
		end; -- process_target_prerequisites


	process_rule_commands (a_target, a_prerequisite: STRING) is
			-- process the commands of the current target definition:
			-- skip the current line (target rule dependency definition),
			-- process successive lines (commands) that begin with comment or whitespace character.
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			output_file_writable:   out_makefile /= Void and then out_makefile.extendible
			target_exists_nonblank: a_target /= Void and then not a_target.is_empty
		local
			l_words: ROSE_DELIMITED_TEXT
			l_cmd, l_source, l_target, l_directory: STRING
		do
			if unprocessed_targets.has (a_target) then
				echo_rule_commands
			else
					-- process lines beginning with whitespace or comment char
				from
					in_makefile.read_line
				until
					in_makefile.end_of_file or else in_makefile.last_string.is_empty or else
						not (in_makefile.last_string @ 1 = '#' or else is_space_or_tab (in_makefile.last_string @ 1))
				loop
					create l_words.make_ignoring_repeats (in_makefile.last_string, space_character)
					if not unechoed_unprocessed_commands.has (trimmed(l_words.first)) then
						put_comment_prefixed_line (in_makefile.last_string)
					end
--					perform_inchoate_replacements (in_makefile.last_string)
--					out_makefile.put_string (in_makefile.last_string + "%N")
					from
						l_words.start
						l_directory := ""
					until
						l_words.is_empty
					loop
						l_cmd := trimmed (l_words.first)
						l_words.remove
						if l_cmd.is_equal ("$(X2C)") then
							l_source := l_words.first
							l_words.remove
							l_target := l_words.first
							l_words.remove
							out_makefile.put_string ("%T" + l_cmd + " " + l_source + " " + l_target + "%N")
						elseif l_cmd.is_equal (";") then
							do_nothing
						elseif l_cmd.is_equal ("cd") then
							l_directory := as_vms_filespec (l_words.first + "/")
							l_words.remove
						elseif l_cmd.is_equal ("$(MAKE)") then
							l_target := l_words.first
							l_words.remove
							if ends_with (l_target, ".o") then
								l_target.remove_tail (2)
								if l_directory.is_equal ("[.E1]") then
									l_target.append (".obj")
								else
									l_target.append (generated_object_file_type)
								end
							end
							out_makefile.put_string (subdirectory_make_command (l_directory, l_target) + "%N")
						elseif l_cmd.is_equal ("$(RM)") then
							from
								l_target := ""
								l_words.start
							until
								l_words.is_empty
							loop
								l_source := l_words.first
								l_words.remove
								if ends_with (l_source, ".o") then
									l_source.remove_tail (2)
									l_source.append (generated_object_file_type)
								end
								if not l_target.is_empty then
									l_target.append (", ")
								end
								l_target.append (l_source + ";*")
							end
							out_makefile.put_string ("%T" + l_cmd + " " + l_target + "%N")
						else
							--print_makefile_error ("process_rule_commands: unknown command %"" + l_cmd + "%"")
							--skip_rule_commands
							perform_inchoate_replacements (in_makefile.last_string)
							out_makefile.put_string (in_makefile.last_string + "%N")
							l_words.wipe_out
						end
					end -- loop on words
					in_makefile.read_line
				end -- loop on in_makefile
			end
		end; -- process_rule_commands


	echo_rule_commands is
			-- skip past the current target definition and echoes its commands
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			output_file_writable:   out_makefile /= Void and then out_makefile.extendible
		do
			from
				in_makefile.read_line
			until
				in_makefile.end_of_file or else in_makefile.last_string.is_empty or else
						not is_whitespace (in_makefile.last_string @ 1)
			loop
				out_makefile.put_string (in_makefile.last_string + "%N")
				in_makefile.read_line
			end -- read in_makefile loop
		end; -- echo_rule_commands


	skip_rule_commands is
			-- skip past the current target definition and its commands:
			-- skip successive lines (directives) until we come to the next target entry -
			-- (a line beginning with nonblank/noncomment character)
			-- writes skipped lines as comments to output file if comment_prefix is set
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			output_file_writable:   out_makefile /= Void and then out_makefile.extendible
		do
			-- skip lines beginning with whitespace or comment char
			from
				in_makefile.read_line
			until
				in_makefile.end_of_file or else in_makefile.last_string.is_empty or else
					--not in_makefile.last_string.is_empty and then
						not (in_makefile.last_string @ 1 = '#' or is_whitespace (in_makefile.last_string @ 1))
			loop
				if configuration.comment_prefix /= Void then
					out_makefile.put_string (configuration.comment_prefix + in_makefile.last_string + "%N")
				end
				in_makefile.read_line
			end -- read in_makefile loop
		end; -- skip_rule_commands



	perform_inchoate_replacements (a_str : STRING) is
			-- Perform general replacements that are needed because we don't parse the makefile lines
			-- and act on them intelligently, just blindly perform replacements.
			-- these are done in process_externals, process_spit2_line, etc.
			-- no i/o is done here.
		require
			line_exists: a_str /= Void
		local
			l_orig: STRING
		do
			if not a_str.is_empty() then
				l_orig := a_str.twin
				-- process suffix rules
				a_str.replace_substring_all ("$(CC) $(CFLAGS) -c", "$(CC) $(CFLAGS)")
				a_str.replace_substring_all ("$(CPP) $(CPPFLAGS) -c", "$(CPP) $(CPPFLAGS)")
				if False then
					-- these are from process_externals
					a_str.replace_substring_all (".c.o:", ".c.obj:")
					a_str.replace_substring_all (".cpp.o:", ".cpp.obj:")
					a_str.replace_substring_all (".x.o:", ".x.obj:")
					a_str.replace_substring_all (".xpp.o:", ".xpp.obj:")
					-- append ";*" to delete commands
					--if a_str.substring_index("$(RM)", 1) > 1 and then
					--	options.has ("rm") and then
					--	options.item ("rm").substring_index ("del", 1) > 0 then
					--	a_str.append (";*")
					--end
				end
				-- these are from process_spit2_line
				--a_str.replace_substring_all ("  ", " ") -- collapse multiple spaces to one space
				a_str.replace_substring_all (" < $< > $*.c", " $< $*.c")
				a_str.replace_substring_all ("$(RM) core *.o", "$(RM) *.obj")
				a_str.replace_substring_all ("$(RM) $(OBJECTS)", "$(RM) *.obj")
				a_str.replace_substring_all ("$(RM) $(EOBJ1)", "$(RM)/EXCL=emain.obj *.obj")
				if a_str.substring_index ("$(RM)", 1) > 1 and then
						configuration.has ("rm") and then
						configuration.item ("rm").substring_index ("del" , 1) > 0 then
					if build_precompile then
						a_str.replace_substring_all ("%T$(RM)", "#%T$(RM)")
						out_makefile.put_string ("#%T-- files not deleted for precompile...%N")
					else
						a_str.append (";*")
					end
				end
				--replace_eiffel_symbols (a_str)
				--**only if a shell line** replace_macros (line)
				debug
					if a_str.is_equal (l_orig) then
						do_nothing -- debug: nothing was changed
					else
						do_nothing -- debug: something changed
					end
				end
			end -- a_str not is_empty
		end; -- perform_inchoate_replacements


	subdirectory_name (a_subdir: STRING): STRING is
			-- returns a subdirectory name, stripped of all path delimiters
		require
			subdirectory_exists: a_subdir /= Void
			subdirectory_long_enough: a_subdir.count > 1
		local
			ii: INTEGER
		do
			create Result.make_from_string (a_subdir)   -- n.b. pre 5.3 {STRING}make_from_string doesn't clone, can return descendant of STRING
			from
				ii := 1
			until
				ii > Result.count
			loop
				if Result @ ii = '.' or else path_delimiters.has (Result @ ii) then
					Result.remove (ii)
				else
					ii := ii + 1
				end
			end -- loop
		end;


	subdirectory_object_filename (a_subdir: STRING): STRING is
			-- the file name (less extension) of the object file for a subdirectory (eg. Cobj1 for subdirectory C1/)
		require
			subdirectory_nonblank: a_subdir /= Void and then not a_subdir.is_empty
		do
			--create Result.make_from_string (a_subdir)
			Result := subdirectory_name (a_subdir)
			Result.insert_string ("obj", 2)
		end


	is_current_subdirectory_object_file (a_fil: STRING): BOOLEAN is
			-- is `a_file' the object filename (including extension) for the current subdirectory (eg. Cobj3.o for C3/)?
		do
			if not dependent_subdirectories.off then
				--Result := a_file.is_equal (subdirectory_object_filename (dependent_subdirectories.item) + ".o")
				Result := is_subdirectory_object_file (a_fil, dependent_subdirectories.item)
			end
		end

	is_subdirectory_object_file (a_fil, a_subdir: STRING): BOOLEAN is
			-- is `a_fil' the object file for `a_subdir' (eg. Cobj99.o of C99/)?
		do
			Result := a_fil.is_equal (subdirectory_object_filename (a_subdir) + ".o")
		end


--------------------------------------------------------------------------
feature -- Produce output files
--------------------------------------------------------------------------

	produce_link_dot_com is
			-- generate link.com (DCL command procedure) from application_dependencies
		require
			application_dependencies_exists:	application_dependencies /= Void
			dependent_subdirectories_exists:	dependent_subdirectories /= Void
			--eiffel_library_exists_nonblank: eiffel_library /= Void and then not eiffel_library.is_empty
		local
			l_fname : FILE_NAME
			l_file: PLAIN_TEXT_FILE
			l_cmd: STRING
			l_preobj, l_dep, l_opt: STRING
			l_dep_max, ii: INTEGER
			l_vms_file : STRING
			l_ext_prefix: STRING
			l_tmp: STRING
		do
			create l_fname.make_from_string (base_directory)
			l_fname.set_file_name ("LINK.COM")
			create {ES5SH_TEXT_FILE}l_file.make_open_write (l_fname)
			l_file.put_string ("$!-- " + l_fname + " -- generated by " + pretty_version + " at " + start_time + "%N$!--%N")
			l_cmd := "$ write sys$output %"Linking " + application_name
			if build_precompile then
				if not application_name.is_equal ("driver.exe") then
					l_cmd.append (" (changing name from " + application_name + " to driver for precompile) ")
				end
				application_name := "driver"
			end
			l_file.put_string (l_cmd + " ''p1' ''p2' ...%"%N$!%N")
			if build_precompile then
				l_file.put_string ("$ write sys$output %"build precompile object library starting at %'%'f$time()%'%"%N")
				l_file.put_string ("$! Create the precompile object library file preobj.olb... %N")
				create l_preobj.make (dependent_subdirectories.count * 10)
				l_preobj.append ("$ library/object/create preobj.olb ")
				from
					dependent_subdirectories.start
				until
					dependent_subdirectories.after
				loop
					--if not dependent_subdirectories.item.is_equal (e1_subdirectory_name) then
					if not dependent_subdirectories.item.is_equal ("E1") then
					l_dep := as_vms_filespec (dependent_subdirectories.item + "/")
					l_preobj.append (l_dep); l_preobj.append ("*.obj,")
					end -- not "E1"
					dependent_subdirectories.forth
				end -- loop
				if l_preobj @ l_preobj.count = ',' then
					l_preobj.remove_tail (1)		-- remove trailing comma
				end
				l_file.put_string (l_preobj + "%N")
			end -- build_precompile

			l_file.put_string ("$ write sys$output %"link started at %'%'f$time()%'%"%N")
            l_cmd := "$ link/exe=[]" + application_name + ".exe'p1' sys$input:" + application_name + ".opt/option"
			-- append any externals that are options files to the link command
			-- (VMS link does not support nested options files).
			from externals_list.start
			until externals_list.off
			loop
				debug ("externals") -- David debug
					print_output_message ("DEBUG(externals): %N  External item - in: %"" + externals_list.item + "%"%N")
				end -- rend debug
				if ends_with (externals_list.item.as_lower, ".opt") then
					l_cmd.append ("," + externals_list.item + "/options")
				end
				externals_list.forth
			end -- loop externals_list
			l_file.put_string (l_cmd + " 'p2'%N")
			l_file.put_string ("[.E1]emain.obj%N")
			l_file.put_string (eiffel_library_filespec.out + "/include=EIF_PROJECT%N")

			-- preprocess application_dependencies: prepend SYS$DISK if no device (prevent defaulting from Eiffel library)
			from
				if command_option_verbose then
					l_file.put_string ("! application_dependencies: (option verbose present) %N")
				end
				application_dependencies.start
			until
				application_dependencies.after
			loop
				debug ("link")
					print (application_dependencies.item + "%N")
				end
				if command_option_verbose then
					l_file.put_string ("!  " + application_dependencies.item)
				end
				--if application_dependencies.item = application_dependencies.first then
				application_dependencies.item.replace_substring_all ("[.", "sys$disk:[.")
				--end
				if command_option_verbose then
					l_file.put_string ("  -->  " + application_dependencies.item + "%N")
				end
				application_dependencies.forth
			end -- application_dependencies loop

			-- generate 3 instances of each list of application objects/libraries, eiffel runtime, and dependent libraries
			-- if finalizing on VMS/Alpha, make it 4?
			from
				ii := 1
				if generate_object_libraries then
					if finalized then
						l_dep_max := 3
					else
						l_dep_max := 2
					end
				else
					l_dep_max := 1
				end
			until
				ii > l_dep_max
			loop
					-- now loop through the application_dependencies list
				from
					application_dependencies.start
					create l_opt.make_empty
				until
				   application_dependencies.after
				loop
					debug ("link")
						print (application_dependencies.item + "%N")
					end
					l_dep := application_dependencies.item.as_lower
					l_opt.wipe_out
					if starts_with (l_dep, "emain.") or else starts_with (l_dep, "preobj.") then
						do_nothing -- don't write the line that has emain.obj or preobj in it
					elseif ends_with (l_dep, ".olb") then
						   l_file.put_string (application_dependencies.item + "/libr%N")
					elseif ends_with (l_dep, ".obj") then
						if ii = 1 then
							l_file.put_string (application_dependencies.item + "%N")
						end
					elseif ends_with (l_dep, ".exe") then
						if ii = 1 then
							l_file.put_string (application_dependencies.item + "/share%N")
						end
					else
						l_file.put_string (application_dependencies.item + "%N")
					end
					application_dependencies.forth
				end -- application_dependencies loop
				-- emit eiffel library
				l_file.put_string (eiffel_library_filespec.out + "/library%N")
				ii := ii + 1
			end -- dependency instances loop

			-- if precompile used, emit the precompiled object library plus another instance of eiffel library
			if precompiled_library /= Void then
				l_vms_file := as_vms_filespec (precompiled_library)
				replace_eiffel_symbols (l_vms_file)
				l_file.put_string (l_vms_file + "/library%N")
				l_file.put_string (eiffel_library_filespec.out + "/library%N")
			end

			-- emit externals
			if not externals_list.is_empty then
				l_file.put_string ("! EXTERNALS:  (== external_prefix")
				if configuration.has ("external_prefix") then
					l_ext_prefix := configuration.item ("external_prefix")
					l_file.put_string (": %"" + l_ext_prefix + "%")%N")
				else
					l_ext_prefix := ""
					l_file.put_string (" not defined)%N")
				end
				from externals_list.start
				until externals_list.off
				loop
					l_tmp := externals_list.item.as_lower
					if ends_with (l_tmp, ".opt") then
						l_file.put_string ("! " + externals_list.item + " -- option file in LINK command, above%N")
					else
						l_file.put_string (l_ext_prefix + externals_list.item)
						if ends_with (l_tmp, ".olb") then
							l_file.put_string ("/libr%N")
						elseif ends_with (l_tmp, ".exe") then
							l_file.put_string ("/share%N")
						else
							l_file.put_new_line
						end
					end
					externals_list.forth
				end -- loop thru externals list
				l_file.put_string ("! end EXTERNALS%N")
			end -- not externals_list.is_empty

			-- emit options for shareable images (should be last options)
			if configuration.has ("eiffel_shareable") then
					-- Eiffel shareable image(s) (generally, VMS_JACKETS)
				l_tmp := configuration.item ("eiffel_shareable")
				l_file.put_string ("! option == eiffel_shareable: %'" + l_tmp + "%'%N")
				replace_eiffel_symbols (l_tmp)
				l_file.put_string ( replace_macros (l_tmp) + "%N")
			end
			if True or else not externals_options.is_empty then
					-- DECWindows shareable images
				l_file.put_string ("! externals_options: " + externals_options + "%N")
				-- ***TBS*** add another copy of the eiffel library before shareables??
				if configuration.has ("xmotif_libs") then
					l_file.put_string ("! option %"== xmotif_libs%" used:%N" + configuration.item ("xmotif_libs") + "%N")
				else
					l_file.put_string ("! " + pretty_name + " default (== xmotif_libs option not defined):%N")
					--l_file.put_string("sys$share:decw$mrmlibshr12/share%N")
					--l_file.put_string("sys$share:decw$xlibshr/share%N")
					--l_file.put_string("sys$share:decw$xmlibshr12/share%N")
					--l_file.put_string("sys$share:decw$xtlibshrr5/share%N")
					l_file.put_string ("sys$share:decwindows.olb/libr%N")
--				else
--					l_file.put_string ("! option %"xmotif_libs%" used:%N" + configuration.item ("xmotif_libs") + "%N%N")
				end
			end -- not externals_options.is_empty
			l_file.put_string ("$ sts := '$status%N")
			l_file.put_string ("$ write sys$output %"link ended at ''f$time()' with status: ''sts'%"%N")
			l_file.put_string ("$! exit 'sts'	***force success***%N")
			l_file.close
		end; -- produce_link_dot_com

	append_dependent_objects_to_link_dot_com (l_file: ES5SH_TEXT_FILE) is
			-- append `a_deps' to `l_file'
		do

		end


--	produce_make_dot_com (a_subdir : STRING) is
--			-- generate make.com (DCL command procedure) in subdirectory 'a_subdir'
--		require
--			subdirectory_nonblank: a_subdir /= Void and then not a_subdir.is_empty
--		local
--			l_filnam : FILE_NAME
--			l_fil: PLAIN_TEXT_FILE
--			l_subdir: STRING
--		do
--			l_subdir := as_vms_filespec (a_subdir + "/")
--			create l_filnam.make_from_string (base_directory)
--			if a_subdir /= Void and then not a_subdir.is_empty then
--				l_filnam.extend (a_subdir)
--			end
--			l_filnam.set_file_name ("make.com")
--			create l_fil.make_open_write (l_filnam)
--			l_fil.put_string ("$! " + l_filnam + "%N")
--			l_fil.put_string ("$ set verify%N")
--			l_fil.put_string ("$ current = %"''f$envir(%"default%")'%"%N")
--			l_fil.put_string ("$ set default " + l_subdir + "%N")
--			if configuration.has ("make") then
--				l_fil.put_string ("$ " + configuration.item ("make"))
--			else
--				l_fil.put_string ("$ make")
--			end
--			l_fil.put_string ("%N$ set default 'current'%N")
--			l_fil.close
--		end; -- produce_make_dot_com


	will_produce_concatenated_source_file_in (a_subdir: STRING) : BOOLEAN is
			-- will we creating concatenated source file for subdirectory `a_subdir'?
			-- True if we're doing it at all, unless the subdirectory is "E1"
		require
			subdirectory_exists: a_subdir /= Void
		do
			Result := will_concatenate_source_files and then not a_subdir.is_equal ("E1") and then not a_subdir.is_empty
		end

	produce_concatenated_source_file (a_subdir : STRING) is
			-- produce concatenated source file for subdirectory `a_subdir'
		require
			will_produce_concatenated_source_file_in (a_subdir)
			--in_subdirectory: not dependent_subdirectories.off
			subdirectory_nonblank: a_subdir /= Void and then not a_subdir.is_empty
		local
			l_path : DIRECTORY_NAME
			l_subdir_name : STRING
			l_big_file_name: FILE_NAME
			l_big_file: ES5SH_TEXT_FILE  --PLAIN_TEXT_FILE
			l_extension : STRING
			l_objects : ROSE_DELIMITED_TEXT

		do
--			debug
--				create l_objects.make ("foo", space_character)
--				create l_objects.make ("foo  bar", space_character)
--				create l_objects.make_ignoring_repeats ("foo  bar", space_character)
--			end
			if finalized then
				l_extension := "x"
			else
				l_extension := "c"
			end
			create l_path.make_from_string (base_directory)
			l_path.extend (a_subdir)
			-- extract the subdirectory name
			l_subdir_name := a_subdir.twin
			l_subdir_name.prune_all_leading ('[');
			l_subdir_name.prune_all_trailing (']')
			if l_subdir_name.count >= 1 and then (l_subdir_name @ 1) = '.' then
				l_subdir_name.remove (1)
			end
			create l_big_file_name.make_from_string (l_path)
			--l_big_file_name.set_file_name ("big_file_" + l_subdir_name)
			l_big_file_name.set_file_name (concatenated_source_file_name (a_subdir))
			l_big_file_name.add_extension (l_extension)
			create l_big_file.make_open_write (l_big_file_name)
			l_big_file.put_string ("/***  " + l_big_file_name + " -- generated by " + pretty_version + " at " + start_time + " ***/%N%N")
			if value_macro_OLDOBJECTS /= Void then
				create l_objects.make_ignoring_repeats (value_macro_OLDOBJECTS, space_character)
			else
				create l_objects.make_ignoring_repeats (value_macro_OBJECTS, space_character)
			end
			-- for each file in list, append to big_file, skipping #line directives
			l_objects.do_all (agent append_source_to_big_file_agent (?, l_big_file, l_path, l_extension))
			l_big_file.close
		end; -- produce_concatenated_source_file

	concatenated_source_file_name (a_subdir: STRING) : STRING is
			-- name of concatenated source file for subdirectory `a_subdir'
		require
			subdirectory_nonblank: a_subdir /= Void and then not a_subdir.is_empty
		do
			if True or else generate_object_libraries then
				Result := "big_file_" +  subdirectory_name (a_subdir)
			else
				Result := subdirectory_object_filename (a_subdir)
			end
		end

	append_source_to_big_file_agent (a_source: STRING; a_big_file: ES5SH_TEXT_FILE; a_path: DIRECTORY_NAME; a_extension: STRING) is
			-- append file `a_source'.`a_extension' in `a_path' to big source file `a_big_file'
		require
			source_exists: a_source /= Void
			big_file_exists: a_big_file /= Void
			big_file_is_open_write: a_big_file.is_open_write
		local
			l_name: STRING
			l_source_file_name: FILE_NAME
			l_source_file: ES5SH_TEXT_FILE
			l_file_name_vms: STRING
		do
			l_name := a_source.twin
			if ends_with (l_name, ".obj") then
				l_name.remove_tail (4)
			end
			create l_source_file_name.make_from_string (a_path)
			l_source_file_name.set_file_name (l_name)
			l_source_file_name.add_extension (a_extension)
			create l_source_file.make (l_source_file_name)
			-- if no .x file exists, try .c
			if not l_source_file.exists and then ends_with (l_source_file.name, ".x") then
				create l_source_file_name.make_from_string (a_path)
				l_source_file_name.set_file_name (l_name)
				l_source_file_name.add_extension ("c")
				create l_source_file.make (l_source_file_name)
			end
			if not l_source_file.exists then
				print_error_message ("source file: " + l_source_file_name + " does not exist!%N")
			else
				l_source_file.open_read ()
				if command_option_verbose then
					--print ("   appending " + l_source_file.name + " to " + a_big_file.name + "%N")
					print ("   appending " + basename (l_source_file.name) + " to " + basename (a_big_file.name)
							+ " in " + dirname (l_source_file.name) + "%N")
				end
				l_file_name_vms := as_vms_filespec (make_absolute_filespec (l_source_file_name))
				if value_platform.substring_index ("VMS", 1) > 0 then
					a_big_file.put_string ("#line 1  %"" + l_file_name_vms + "%"  /* " + l_source_file_name + " */%N")
				else
					a_big_file.put_string ("#line 1  %"" + l_source_file_name + "%"  /* " + l_file_name_vms + " */%N")
				end
				from
					l_source_file.read_line
				until
					l_source_file.end_of_file
				loop
					--if l_source_file.last_string.count > ("#line").count and then
					if l_source_file.last_string.count > 5 and then l_source_file.last_string @ 1 = '#'
							and then l_source_file.last_string.substring_index ("line", 2) >= 2 then
						a_big_file.put_string ("/*** " + l_source_file.last_string + " ***/%N")
					else
						a_big_file.put_string (l_source_file.last_string + "%N")
					end
					l_source_file.read_line
				end -- loop until l_source_file.end_of_file
				l_source_file.close
				a_big_file.put_string ("/*** end " + l_source_file_name + " ***/%N")
				--if not objects.after then
				a_big_file.put_string ("%F%N")
				--end
				a_big_file.flush
			end
		end

----------------------------------------------------------------------------
feature -- Process macro definitions
--------------------------------------------------------------------------

	is_macro_definition (line : STRING) : BOOLEAN is
			-- is this line a macro definition (of the form <name> = <value>) ?
		local
			l_token1, l_token2 : STRING
			unfinished: BOOLEAN
		do
			-- Check for macro definitions: line begins with tokens: <name> <=>
			if line /= Void and then not line.is_empty then
				l_token1 := first_token (line)
				if not l_token1.is_empty and then is_symbol_constituent (l_token1 @ 1) then
					l_token2 := next_token (line, line.substring_index(l_token1, 1) + l_token1.count)  -- debug
					l_token2 := next_token (line, l_token1.count +1);
					l_token2 := second_token (line, l_token1);
					Result := l_token2.is_equal ("=")
				end -- l_token1 not Void and not is_empty and starts with symbol constituent
			end -- line not empty
		end -- is_macro_definition


	is_macro_definition_of (a_line : STRING; a_macro_name : STRING) : BOOLEAN is
			-- is `a_line' a macro definition of the specified macro `a_name' (NAME = <value>)
			-- with optional whitespace around the =?
		require
			--line_not_void: a_line /= Void
			macro_name_not_blank: a_macro_name /= Void and then not a_macro_name.is_empty
		local
			l_token1 : STRING
			--eq_pos, end_pos : INTEGER
		do
			if a_line /= Void and then not a_line.is_empty then
				l_token1 := first_token (a_line)
				if l_token1.is_equal (a_macro_name) then
					Result := second_token (a_line, l_token1).is_equal ("=")
--					eq_pos := next_word_index (line, line.substring_index (l_token1, 1) + l_token1.count -1)
--					if eq_pos > 0 then
--						end_pos := end_word_index (line, eq_pos)
--					else
--						end_pos := -1
--					end
--					Result := end_pos = eq_pos and then line @ eq_pos = '='
				end -- l_token1 is_equal (name)
			end -- line not empty
		end -- is_macro_definition_of


	process_macro_definition () is
			-- process current line containing a macro definition
			-- EIFLIB, CFLAGS, CPPFLAGS et. al. are handled specially here.
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			is_macro_definition:	is_macro_definition (in_makefile.last_string)
		local
			l_macro, l_value: STRING
		do
			-- Check for various macro definitions: line begins with tokens: <name> <=>
			l_macro := first_token (in_makefile.last_string)
			if not l_macro.is_empty then
				if second_token (in_makefile.last_string, l_macro).is_equal ("=") then
						-- check for CFLAGS, CPPFLAGS, EIFLIB, etc.
					if l_macro.is_equal ("CFLAGS") or else l_macro.is_equal ("CPPFLAGS") then
						process_macro_CFLAGS (l_macro)
					elseif l_macro.is_equal ("EIFLIB") then
						process_macro_EIFLIB (l_macro)
					elseif l_macro.is_equal ("EXTERNALS") then
						process_macro_EXTERNALS (l_macro)
					elseif l_macro.is_equal ("INCLUDE_PATH") then
						process_macro_INCLUDE_PATH (l_macro)
					elseif l_macro.is_equal ("OBJECTS") then
						process_macro_OBJECTS (l_macro)
					elseif l_macro.is_equal ("OLDOBJECTS") then
						process_macro_OLDOBJECTS (l_macro)
--					elseif l_macro.is_equal ("EOBJ1") then
--						value_macro_EOBJ1 := read_processed_macro_value ("EOBJ1")
--						put_macro_definition ("EOBJ1", value_macro_EOBJ1)
					elseif l_macro.is_equal ("SUBDIRS") then
						--value_macro_SUBDIRS := read_processed_macro_value ("SUBDIRS")
						value_macro_SUBDIRS := read_macro_value_echoed ("SUBDIRS", Void)
						process_macro_value (value_macro_SUBDIRS)
						put_macro_definition ("SUBDIRS", value_macro_SUBDIRS)
					elseif l_macro.is_equal ("RCECIL") then
						l_value := read_processed_macro_value ("RCECIL")
						put_macro_definition ("RCECIL", l_value)
					elseif l_macro.is_equal ("X2C") then
						-- X2C must be defined externally as a foreign DCL command
						l_value := read_macro_value ("X2C")
						put_macro_definition ("X2C", "X2C")
--					elseif l_macro.is_equal ("SHELL") then
--						l_value := read_macro_value ("SHELL")
--						out_makefile.put_string (default_comment_prefix + "SHELL = " + l_value + "%N")
					else
						-- not a known or special handled macro;
						-- if it is not blank and not in suppressed_macro_definitions then output the processed definition
						l_value := read_macro_value (l_macro)
						process_macro_value (l_value)
						l_value := replace_macros (l_value)
						if not l_value.is_empty and then not suppressed_macro_definitions.has (l_macro) then
							--out_makefile.put_string (l_macro + " = " + l_value + "%N")
							put_macro_definition (l_macro, l_value)
						else
						end
					end -- else l_macro is whatever
				end -- second token is "="
			end -- l_macro not empty
		end; -- process_macro_definition


	process_macro_CFLAGS (a_macro_name : STRING) is
			-- process CFLAGS or CPPFLAGS macro definition
			-- a_macro_name is the macro name (CFLAGS or CPPFLAGS)
			-- eg. CFLAGS = ... -DWORKBENCH -I\$(ISE_EIFFEL)/studio/spec/\$(ISE_PLATFORM)/include \$(INCLUDE_PATH)
			-- or  CFLAGS = $optimize $ccflags $large -I\$(ISE_EIFFEL)/studio/spec/\$(ISE_PLATFORM)/include \$(INCLUDE_PATH)
			-- accumulate -I and -D values and replace them with DCL qualifiers for same.
			-- macro definitions must have already been replaced (how to express that in a precondition?)
			-- *FIXME* doesn't handle continuation lines
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			--macros_replaced:		in_makefile.last_string.index_of ('$', 1) = 0
			is_macro_definition:	is_macro_definition (in_makefile.last_string)
			is_CFLAGS_macro_definition:
				is_macro_definition_of (in_makefile.last_string, "CFLAGS") or else
				is_macro_definition_of (in_makefile.last_string, "CPPFLAGS")

		local
			l_cflags: STRING -- macro value
			l_prefix: STRING
			l_start, l_end : INTEGER
			l_word, l_orig, l_includes, l_defines : STRING
			l_size: INTEGER
			l_dbg : STRING
		do
			l_cflags := read_macro_value (a_macro_name)
			l_prefix := "VMS_" + a_macro_name.twin
			l_prefix.replace_substring_all ("FLAGS", "")

			-- The \$(INCLUDE_PATH) macro must be processed here, because all -I options must be collected.
			l_start := l_cflags.substring_index ("\$(INCLUDE_PATH)", 1)
			if l_start > 0 then
				if value_macro_INCLUDE_PATH /= Void then
					l_word := value_macro_INCLUDE_PATH
				else
					l_word := ""
				end
				--l_cflags.replace_substring (l_word, l_start, l_start + ("\$(INCLUDE_PATH)").count -1)
				l_cflags.replace_substring_all ("\$(INCLUDE_PATH)", l_word)
			end
			process_shell_commands (l_cflags, 1)
			l_cflags := replace_macros (l_cflags) -- ***defer***

			-- Replace -I and -D options with /INCLUDE and /DEFINE DCL qualifiers.
			-- Not quite as simple as it sounds, because DCL only uses the
			-- last qualifier value. So, all the -I and -D values must be
			-- accumulated and specified as a single /INCLUDE and /DEFINE
			-- with a parenthesized list of comma separated values.
			create l_defines.make (100)
			create l_includes.make (100)
			-- Insert the INCLUDE_PATH_PREFIX and _SUFFIX options, if present
			if configuration.has ("INCLUDE_PATH_PREFIX") then
				l_includes.append (configuration.item ("INCLUDE_PATH_PREFIX"))
			end
			-- First, find all the -I and -D options, and build a list of
			-- each of their respective values.
			from
				l_start := 1
			until
				l_start = 0 or else l_start >= l_cflags.count
			loop
				l_end := end_word_index (l_cflags, l_start)
				l_word := l_cflags.substring (l_start, l_end)
				l_orig := l_word.twin
				-- check for shell command
				--if (word.count > 1 and then (word @ 1) = '`') then -- starts_with (word, "`") then
				if (is_shell_command (l_cflags, l_start)) then
					-- handle shell command like `gtk-config` or $(gtk-config) ***FIXME***
					process_shell_command_at (l_cflags, l_start)
					-- debug
					if l_start <= l_cflags.count then
						l_end := end_word_index (l_cflags, l_start)
						l_word := l_cflags.substring (l_start, l_end)
					else
						l_end := l_cflags.count
						l_word := ""
					end
				end
				if starts_with (l_word, "-D") then
					l_word.remove_head (2) -- remove leading "-D"
					if not l_word.is_equal (l_word.as_upper) then
						l_word.prepend_character ('%"'); l_word.append_character ('%"')
					end
					append_DCL_value (l_defines, l_word)
					l_word := ""
				elseif starts_with (l_word, "-I") then
					l_word.remove_head (2) -- remove leading "-I"
--					if l_word.count >= 2 and then l_word @ 1 = '%"' and then l_word @ (l_word.count) = '%"' then
--						l_word.remove_tail (1) -- remove trailing quote
--						l_word.remove_head (1) -- remove leading quote
--					end
					remove_enclosing_quotes (l_word)
					if l_word.is_empty then
						print_makefile_warning ("blank include directive ignored: " + l_orig)
					elseif l_word.is_equal (".") then
						do_nothing
					else --not l_word.is_empty and then not l_word.is_equal (".") then
						--***FIXME*** check for VMS filespec, don't assume unix
						if not is_vms_filespec (l_word) then
							-- ensure it looks like a path (ends in '/')
							if l_word.item (l_word.count) /= '/' then
								l_word.append_character ('/')
							end
							l_word := as_vms_filespec (l_word)
						end
						l_word.replace_substring_all ("$ISE_PLATFORM", value_platform)
						append_DCL_value (l_includes, l_word)
					end
					l_word := ""
				elseif l_word.count >= 2 and then l_word @ 1 = '/' and then (l_word @ 2).is_alpha then
					-- process DCL qualifier
					l_size := DCL_qualifier_name_size (l_word, 1)
					if l_size >= 2 and then l_size < l_word.count - 2 and then l_word @ (l_size + 1) = '=' then
						-- DCL qualifier with value (/foo=bar or /foo=(a [,b]...)
						-- simplistic but usable: find end of value (quoted string or parenthesized list)
						inspect
							l_cflags @ (l_start + l_size + 1)
						when '(' then
							l_end := l_cflags.index_of (')', l_start + l_size + 2)
						when '%"' then
							l_end := l_cflags.index_of ('%"', l_start + l_size + 2)
						else
							-- no action
						end
						if l_end = 0 then
							l_end := l_cflags.count
							l_dbg := l_word
						else
							l_dbg := l_cflags.substring (l_start, l_end)
						end
						if DCL_qualifier_matches ("/include_directory", 3, l_word, 1) then
							-- allow quoted strings, leave quotes (may be UNIX filespecs)
							--if l_size < l_word.count - 1 and then l_word @ (l_size + 1) = '=' then
							append_DCL_value (l_includes, l_cflags.substring (l_start + l_size + 1, l_end))
							--l_cflags.replace_substring ("", l_start, l_end)
							--l_end := l_start
							l_word := ""
						elseif DCL_qualifier_matches ("/define", 3, l_word, 1) then
							--if l_size < l_word.count - 1 and then l_word @ (l_size + 1) = '=' then
							-- special handling for /DEFINE values, which may be quoted strings
							-- or a parenthesized list of comma separated values ***TBS***
							--append_DCL_value (defines, l_word.substring (l_size + 2, l_word.count))
							append_DCL_value (l_defines, l_cflags.substring (l_start + l_size + 1, l_end))
							--l_cflags.replace_substring ("", l_start, l_end)
							--l_end := l_start
							l_word := ""
						end
					end
				elseif l_word @ 1 = '$' then
					--l_word := replace_macros (l_word)
				end
				-- remove word if processed
				if l_word.is_empty and then l_start <= l_end then
					-- ***TBS*** remove trailing whitespace after word as well as word
					l_cflags.replace_substring ("", l_start, l_end)
					l_end := l_start
				end

				-- setup next loop iteration
				if l_end < l_cflags.count then
					l_start := next_word_index (l_cflags, l_end)
				else
					l_start := l_end + 1
				end
			end -- loop

			if configuration.has ("INCLUDE_PATH_SUFFIX") then
				l_word := configuration.item ("INCLUDE_PATH_SUFFIX")
				if not l_word.is_empty then
					append_DCL_VALUE (l_includes, l_word)
				end
			end

			reduce_whitespace (l_cflags, 1)
			-- replace any remaining unprocessed macros
			--l_cflags := replace_macros (l_cflags)
			out_makefile.put_string (a_macro_name + " = " + l_cflags + " $(" + l_prefix + "DEFINES) $(" + l_prefix + "INCLUDE)%N")
			-- Emit the /INCLUDE and /DEFINE qualifiers
			out_makefile.put_string (l_prefix + "DEFINES = ")
			if not l_defines.is_empty then
				--l_cflags.append ("/DEFINE=")
				--l_cflags.append (l_defines)
				out_makefile.put_string ("/DEFINE=" + l_defines)
			end
			out_makefile.put_string ("%N" + l_prefix + "INCLUDE = ")
			if not l_includes.is_empty then
				replace_eiffel_symbols (l_includes)
				--remove_redundant_DCL_filespecs (l_includes)  -- removed: CC/INCL does not do a default input parse any more (did it ever?)
				--if not l_defines.is_empty then l_cflags.append_character (space_character) end
				--l_cflags.append ("/INCLUDE=")
				--l_cflags.append (l_includes)
				out_makefile.put_string ("/INCLUDE=" + l_includes)
			end
			--out_makefile.put_string (a_macro_name + " = " + l_cflags + "%N")
			out_makefile.new_line
		end; -- process_macro_CFLAGS


	process_macro_EIFLIB (a_macro_name_unused: STRING) is
				-- process EIFLIB macro definition
		--indexing "FIXME"
		require
			input_file_readable: in_makefile /= Void and then in_makefile.is_open_read
			is_macro_definition:
				is_macro_definition (in_makefile.last_string)
			is_EIFLIB_macro_definition:
				is_macro_definition_of (in_makefile.last_string, "EIFLIB")
		local
			l_eiflib: STRING
		do
			-- handle EIFLIB macro definition
			-- eg: EIFLIB = \$(ISE_EIFFEL)/studio/spec/\$(ISE_PLATFORM)/lib/$prefix$wkeiflib$suffix
			-- or  EIFLIB = \$(ISE_EIFFEL)/studio/spec/\$(ISE_PLATFORM)/lib/$prefix$mt_prefix$eiflib$suffix
			l_eiflib := read_macro_value ("EIFLIB")
			remove_enclosing_quotes (l_eiflib)
			l_eiflib := replace_macros (l_eiflib)
			--out_makefile.put_string ("EIFLIB = " + l_eiflib + "%N")
			eiffel_library := as_vms_filespec (l_eiflib)
			put_macro_definition ("EIFLIB", eiffel_library)
			--eiffel_library.replace_substring_all ("$(ISE_PLATFORM)", value_platform)
	end; -- process_macro_EIFLIB


	process_macro_EXTERNALS (a_macro_name_unused: STRING) is
			-- process EXTERNALS macro definition: for each word (filespec) make it VMS syntax, add to externals_list
		require
			input_file_readable: in_makefile /= Void and then in_makefile.is_open_read
			is_EXTERNALS_macro_definition: is_macro_definition_of (in_makefile.last_string, "EXTERNALS")
		local
			l_externals, word : STRING
			l_start, l_end : INTEGER
			l_dbg: STRING
		do
			l_externals := read_processed_macro_value ("EXTERNALS")
			from
				l_start := 1
			until
				l_start = 0 or else l_start > l_externals.count
			loop
				l_end := end_word_index (l_externals, l_start)
				l_dbg := l_externals.substring (l_start, l_end)
				if l_end <= l_externals.count then
					if (is_shell_command (l_externals, l_start)) then
						process_shell_command_at (l_externals, l_start)
						l_end := end_word_index (l_externals, l_start)
					end
					if l_start <= l_end then  -- if replacement is not empty string
						word := l_externals.substring (l_start, l_end)
						if not word.is_empty and then word @ 1 = '-' then
							-- word is an option (-l or -L)
							externals_options.append (word)
							externals_options.append_character (space_character)
						else
							l_dbg := replace_macros (word)
							if ends_with (word, ".lib") then
								replace_end (word, ".lib", ".olb")
							end
							externals_list.extend (word)
						end
					end
				end
				-- continue loop: find start of next word
				l_start := next_word_index (l_externals, l_end)
			end -- loop for each word

			-- output externals list and externals options as comments
			out_makefile.put_string (default_comment_prefix + " EXTERNALS list:%N")
			from
				externals_list.start
			until
				externals_list.after
			loop
				out_makefile.put_string (default_comment_prefix + "  " + externals_list.item + "%N")
				externals_list.forth
			end -- externals_list loop
			out_makefile.put_string (default_comment_prefix + " EXTERNALS options: ")
			if externals_options = Void then
				out_makefile.put_string ("(Void)")
			elseif externals_options.is_empty then
				out_makefile.put_string ("(none)")
			else
				out_makefile.put_string (externals_options)
			end
		out_makefile.put_string ("%N%N")

		ensure
		end; -- process_macro_EXTERNALS


	process_macro_INCLUDE_PATH (a_macro_name_unused: STRING) is
			-- Process INCLUDE_PATH macro definition.
			-- Most processing is deferred until the CFLAGS macro is processed
			-- because all of the -I options have to be collected into a single DCL qualifier.
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			is_INCLUDE_PATH_macro_definition: is_macro_definition_of (in_makefile.last_string, "INCLUDE_PATH")
		local
			l_start, l_end, l_pos : INTEGER
			l_word, l_symbol: STRING
			l_initial_value: STRING
		do
			value_macro_INCLUDE_PATH := read_macro_value ("INCLUDE_PATH")
			l_initial_value := value_macro_INCLUDE_PATH.twin
			from
				l_start := next_word_index (value_macro_INCLUDE_PATH, 0)
			until
				l_start = 0 or else l_start >= value_macro_INCLUDE_PATH.count
			loop
				l_end := end_word_index (value_macro_INCLUDE_PATH, l_start)
				l_word := value_macro_INCLUDE_PATH.substring (l_start, l_end) -- debug
				--if word.count > 3 and then word @ 1 = '-' and then word @ 2 = 'I' and then word @ 3 = '$'then
				if l_end > l_start + 3
						and then value_macro_INCLUDE_PATH @ l_start = '-'
						and then value_macro_INCLUDE_PATH @ (l_start + 1) = 'I'
						and then value_macro_INCLUDE_PATH @ (l_start + 2) = '$' then
						-- what we have here is a failure to communicate (properly quote a macro value)!
						-- find end of $-prefixed symbol starting at index l_start + 3
					from
						l_pos := l_start + 3
					until
						l_pos > l_end or else not is_symbol_constituent(value_macro_INCLUDE_PATH @ l_pos)
					loop
						l_pos := l_pos + 1
					end -- l_pos loop
					l_symbol := value_macro_INCLUDE_PATH.substring (l_start + 3, l_pos -1) -- debug
					if True then
						value_macro_INCLUDE_PATH.insert_character ('\', l_start + 2)
						l_end := l_end + 1
						l_pos := l_pos + 1
					else
						value_macro_INCLUDE_PATH.insert_string (")", l_pos)
						value_macro_INCLUDE_PATH.replace_substring ("\$(", l_start + 2, l_start + 2)
						l_end := l_end + 3
						l_pos := l_pos + 3
					end
					l_symbol := value_macro_INCLUDE_PATH.substring (l_start + 2, l_pos - 1) -- debug
					l_word := value_macro_INCLUDE_PATH.substring (l_start, l_end) -- debug
				end
				l_start := next_word_index (value_macro_INCLUDE_PATH, l_end)
			end -- loop
			if not l_initial_value.is_equal (value_macro_INCLUDE_PATH) then
				out_makefile.put_string (default_comment_prefix + "INCLUDE_PATH = " + value_macro_INCLUDE_PATH + "%N")
			end
		end; -- process_macro_INCLUDE_PATH


	process_macro_OBJECTS (a_macro_name_unused: STRING) is
			-- process line containing OBJECTS macro definition
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			is_OBJECTS_macro_definition: is_macro_definition_of (in_makefile.last_string, "OBJECTS")
		local
			l_count: INTEGER
			l_objects: STRING
		do
			l_count := in_makefile.line_count
			l_objects := read_processed_macro_value ("OBJECTS")
			if value_macro_OBJECTS /= Void then
				print ("   line " + l_count.out + ": OBJECTS redefined:%N     old: %""
						+ value_macro_OBJECTS + "%"%N     new: %"" + l_objects + "%"%N")
			end
			value_macro_OBJECTS := l_objects
			-- emit OBJECTS macro definition
			if dependent_subdirectories.off then
				put_macro_definition ("OBJECTS", value_macro_OBJECTS)
			else
				if will_produce_concatenated_source_file_in (dependent_subdirectories.item) then
					if value_macro_OLDOBJECTS /= Void then
							-- already processed by quick_finalize (upwards compatibility)
						put_macro_definition ("OLDOBJECTS", value_macro_OLDOBJECTS)
						put_macro_definition ("OBJECTS", value_macro_OBJECTS)
					else
						put_macro_definition ("OLDOBJECTS", value_macro_OBJECTS)
						--put_macro_definition ("OBJECTS", "big_file_" + subdirectory_name(dependent_subdirectories.item) + ".obj")
						put_macro_definition ("OBJECTS", concatenated_source_file_name (dependent_subdirectories.item) + ".obj")
					end
				else
					if value_macro_OLDOBJECTS /= Void then
						put_macro_definition ("OLDOBJECTS", value_macro_OLDOBJECTS)
					end
					put_macro_definition ("OBJECTS", value_macro_OBJECTS)
				end
			end
			out_makefile.put_new_line
		end; -- process_macro_OBJECTS


	process_macro_OLDOBJECTS (a_macro_name_unused: STRING) is
			-- process line containing OLDOBJECTS macro definition
			-- (only encountered when quick_finalize is run before ES5SH, which no longer happens on VMS)
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			is_OLDOBJECTS_macro_definition: is_macro_definition_of (in_makefile.last_string, "OLDOBJECTS")
		local
			l_count: INTEGER
			l_old_objects : STRING
		do
			l_count := in_makefile.line_count
			l_old_objects := read_processed_macro_value ("OLDOBJECTS")
			if value_macro_OLDOBJECTS /= Void then
				print ("   line " + l_count.out + ": OLDOBJECTS redefined:%N     old: %""
						+ value_macro_OLDOBJECTS + "%"%N     new: %"" + l_old_objects + "%"%N")
			end
			value_macro_OLDOBJECTS := l_old_objects
			--put_macro_definition ("OLDOBJECTS", value_macro_OLDOBJECTS)
			-- macro definition is not ouptut until OBJECTS macro is read
		end; -- process_macro_OLDOBJECTS



	read_processed_macro_value (a_macro_name : STRING) : STRING is
			-- The processed value of the macro defined on the current input line (plus any continuation lines).
			-- Position in input file is advanced if necessary, to consume continued lines.
			-- Only continued input lines are consumed.
			-- UNIX filespecs are translated to VMS syntax, shell commands are processed,
			-- Processed lines are NOT written to output makefile.
			-- Use for macro definitions that require special processing
			-- before writing to the output makefile.
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			macro_name_nonblank:	a_macro_name /= Void and then not a_macro_name.is_empty
			is_macro_definition:	is_macro_definition_of (in_makefile.last_string, a_macro_name)
		do
			Result := read_macro_value (a_macro_name)
			process_macro_value (Result)
		ensure
			Result_exists: Result /= Void
		end; -- read_processed_macro_value


	read_macro_value (a_macro_name: STRING) : STRING is
			-- The value of the macro defined on the current line of in_makefile (plus any continuation lines).
			-- Position in input file is advanced if necessary, to consume continued lines.
			-- The current input line, and all continued lines, are consumed. Commands and queries are a fool's mixture.
			-- The unpreprocessed lines read are echoed as comments to output_makefile if the comment_prefix configuration option is defined.
			-- If the macro name appears in echoed_unprocessed_macro_definitions then "##" is used as the comment prefix.
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			output_file_ready:		out_makefile /= Void and then out_makefile.extendible
			macro_name_nonblank:	a_macro_name /= Void and then not a_macro_name.is_empty
			is_macro_definition:	is_macro_definition_of (in_makefile.last_string, a_macro_name)
		do
			Result := read_macro_value_echoed (a_macro_name, effective_comment_prefix (a_macro_name))
		ensure
			Result_exists: Result /= Void
		end

	effective_comment_prefix (a_macro_name: STRING) : STRING is
			-- comment prefix to be used for original value of `a_macro_name' definition.
			-- if `a_macro_name' is in `echoed_unprocessed_macro_definitions' then `default_comment_prefix'
			-- otherwise the configuration comment prefix is used if defined (may be Void)
		do
			if a_macro_name /= Void and then echoed_unprocessed_macro_definitions.has (a_macro_name) then
				Result := default_comment_prefix
			else
				Result := configuration.comment_prefix
			end
		end


	read_macro_value_echoed (a_macro_name: STRING; a_comment_prefix: STRING) : STRING is
			-- The value of the macro defined on the current line of in_makefile, plus any continuation lines.
			-- Position in input file is advanced if necessary, to consume continued lines.
			-- The current input line, and all continued lines, are consumed. Commands and queries are a fool's mixture.
			-- The unpreprocessed lines read are echoed as comments to output_makefile if comment_prefix is defined.
		require
			input_file_readable:	in_makefile /= Void and then in_makefile.is_open_read
			output_file_ready:		out_makefile /= Void and then out_makefile.extendible
			macro_name_nonblank:	a_macro_name /= Void and then not a_macro_name.is_empty
			is_macro_definition:	is_macro_definition_of (in_makefile.last_string, a_macro_name)
			comment_prefix_void_or_not_empty: a_comment_prefix = Void or else not a_comment_prefix.is_empty
		local
			l_start, hash_pos, l_end : INTEGER
			l_done : BOOLEAN
			dbg : INTEGER
			l_echoed: STRING
		do
			create Result.make (200)
			-- loop: append successive input lines, beginning with current line, until input line not continued
			from
				l_start := in_makefile.last_string.index_of ('=', a_macro_name.count +1) + 1
				l_done := False
			until
				l_done
			loop
				-- loop: skip leading whitespace
				from
				until
					l_start > in_makefile.last_string.count or else not is_whitespace (in_makefile.last_string @ l_start)
				loop
					l_start := l_start + 1
				end -- loop: skip leading whitespace
				-- back up over end of line comment or continuation char and trailing whitespace
				from
					hash_pos := in_makefile.last_string.index_of ('#', l_start)
					if hash_pos = 0 then hash_pos := in_makefile.last_string.count + 1 end
					l_end := in_makefile.last_string.last_index_of ('\', in_makefile.last_string.count)
					dbg := next_word_index (in_makefile.last_string, l_end)
					if l_end = 0 or else l_end > hash_pos or else next_word_index (in_makefile.last_string, l_end) > 0 then
						l_end := hash_pos - 1
					else
						l_end := l_end - 1
					end
				until
					l_end <= l_start or else not is_whitespace (in_makefile.last_string @ l_end)
				loop
					l_end := l_end - 1
				end -- backup loop

				if l_end >= l_start then
					if not Result.is_empty then Result.append (" ") end
					Result.append (in_makefile.last_string.substring (l_start, l_end))
				end

				--if echoed then
				if a_comment_prefix /= Void then
					create l_echoed.make (in_makefile.last_string.count + a_comment_prefix.count)
					l_echoed.append (a_comment_prefix)
					l_echoed.append (in_makefile.last_string);
					out_makefile.put_string (l_echoed + "%N")
				end
				-- bottom of loop: read next input line (if continued)
				-- out_makefile.put_string (in_makefile.last_string); out_makefile.put_new_line
				--done := not is_continued_line (in_makefile.last_string)
				if is_continued_line (in_makefile.last_string) then
					in_makefile.read_line
				else
					l_done := True
					in_makefile.read_line
				end
			l_start := 1
			end -- loop: read input until not continued
			Result.right_adjust
		ensure
			Result_exists: Result /= Void
		end; -- read_macro_value_echoed


----------------------------------------
feature -- Macro replacement
----------------------------------------

	process_macro_value (a_value : STRING) is
			-- UNIX filespecs are translated to VMS syntax, shell commands are processed.
		require
			value_exists: a_value /= Void
		do
			if not a_value.is_empty then
				replace_eiffel_symbols (a_value)
				to_vms_filespecs (a_value, 1);
				process_shell_commands (a_value, 1)
				a_value.right_adjust
			end
		end; -- process_macro_value

--	as_replaced_eiffel_symbols (a_str: STRING): STRING is
--			-- `a_str' with EIFFEL and PLATFORM macros replaced by their values
--		require
--			string_exists:	a_str /= Void
--		do
--			Result := a_str.twin
--			replace_eiffel_symbols (Result)
--		end

	replace_eiffel_symbols (a_str : STRING) is
			-- replace EIFFEL and PLATFORM macros
		require
			string_exists:	a_str /= Void
		do
			 a_str.replace_substring_all (macro_platform, value_platform)
		end; -- replace_eiffel_symbols


	macro_open_delimiters: STRING is "({["
	macro_close_delimiters: STRING is ")}]"

	replace_macros (a_str : STRING): STRING is
			-- string with each macro ($-prefixed element) in `a_str' replaced with its value
			-- escaped-$-prefixed words are passed without the escape
			-- leading and trailing are removed, multiple spaces are replaced with a single space
			-- note: if all macros are removed as undefined, the spaces between them will remain
		require
			string_exists:	a_str /= Void
		local
			l_symb, l_val : STRING
			l_pos, l_end : INTEGER
		do
			Result := a_str.twin
			-- loop: for each $-prefixed symbol, replace with value
			-- invariant: l_pos = index of next symbol starting char ('$') or 0
			from
				if Result.is_empty then l_pos := 0 else l_pos := Result.index_of ('$', 1) end
			invariant
				l_pos = 0 or else Result @ l_pos = '$'
			until
				l_pos = 0 or else l_pos >= Result.count
			loop
				--l_last_symb := l_symb; l_last_val := l_val
				--l_symb := Void; l_val := Void
				-- find end of [\]$-prefixed symbol starting at l_pos
				from
					if macro_open_delimiters.has (Result @ (l_pos + 1)) then
						l_end := l_pos + 2
					else
						l_end := l_pos + 1
					end
				until
					l_end > Result.count or else not is_symbol_constituent(Result.item(l_end))
				loop
					l_end := l_end + 1
				end -- l_end loop
				-- l_end is the index of the character after the last character of the symbol name (terminator character or end of string).
				-- If the symbol began with a delimiter, eg. $(symbol) then the l_end-th character is part of the name.
				if macro_open_delimiters.has (Result @ (l_pos +1)) then
					l_end := l_end + 1
				end
				check
					symbol_end_after_start: l_end > l_pos
					symbol_end_within_string: l_end <= Result.count + 1
				end
				l_symb := Result.substring (l_pos +1, l_end -1)
				-- if symbol is a make macro (escaped -- prefixed with "\") then it should be copied to the makefile
				-- with the escape removed, as Unix shell would do.
				if l_pos > 1 and then Result @ (l_pos - 1) = '\' then
					Result.remove (l_pos - 1)
					l_end := l_end - 1
				else
					--l_val := configuration_item_once (l_symb, "")
					if configuration.has (l_symb) then
						l_val := configuration.item (l_symb)
					else
						l_val := ""
					end
					Result.replace_substring (l_val, l_pos, l_end - 1)
					-- set l_end to index of end of replacement text (no rescan)
					l_end := l_pos + l_val.count
				end
				-- find next '$'
				if l_end < Result.count then
					l_pos := Result.index_of ('$', l_end)
				else
					l_pos := 0
				end
			end -- loop on l_pos
			reduce_whitespace (Result, 1)
--			-- cheat: replace Eiffel symbols ***cant do it here***
--			--Result.replace_substring_all ("$ISE_PLATFORM", value_platform)
--			replace_eiffel_symbols (Result)
		end -- replace_macros

--	get_configuration_item_once (a_key : STRING; a_default : STRING) : STRING is
--			-- Return the value of configuration option `a_key'. If not defined, print warning message
--			-- and define it as `a_default' so the warning is issued only once.
--		require
--			key_exists_nonblank: a_key /= Void and then not a_key.is_empty
--		local
--			--l_msg: STRING
--		do
--			if configuration.has (a_key) then
--				Result := configuration.item (a_key)
--			else
--				--print_file_message (in_makefile, in_makefile.line_count, "Warning", a_key + " not specified")
--				print_makefile_message ("Warning", "%N%T value for $" + a_key + " not specified")
--				if a_default /= Void and then not a_default.is_empty then
--					Result := a_default
--					print ("%N%T$" + a_key + " = " + Result + " will be assumed.%N")
--				else
--					Result := ""
--					print ("%N%T$" + a_key + " will be ignored.%N")
--				end
--				configuration.force (Result, a_key)	-- suppress further warnings for this name
--			end
--		end; -- get_configuration_option_once



--	is_known_symbol (a_symbol: STRING): BOOLEAN is
--				-- is `a_symbol' a known (special) symbol?
--		do
--			Result := a_symbol.is_equal (symbol_eiffel) or else a_symbol.is_equal (symbol_platform)
--						or else a_symbol.is_equal ("EIFFEL_SRC")
--		end


----------------------------------------------------------------------------
feature -- special purpose output
--------------------------------------------------------------------------

	put_comment_prefixed_line (a_line : STRING) is
			-- if comment_prefix is defined, ouput line to out_makefile as a comment with terminating newline,
		require
			line_exists:	a_line /= Void
			output_file_ready:	out_makefile /= Void and then out_makefile.extendible
		do
			if configuration.comment_prefix /= Void then
				put_comment_prefixed_text (a_line + "%N")
			end
		end; -- put_comment_prefixed_line

--	put_comment_prefixed_strings (the_strings: ARRAY[STRING] ; prefix_suffix : STRING) is
--			-- if comment_prefix is defined, ouput the_strings to out_makefile as a single comment line
--			-- with terminating newline, with prefix_suffix appended to comment_prefix
--		require
--			the_strings_exist:	the_strings /= Void
--			the_strings_not_empty: the_strings.count > 0
--			output_file_ready:	out_makefile /= Void and then out_makefile.extendible
--		local
--			ii : INTEGER
--		do
--			if configuration.comment_prefix /= Void and then the_strings.count > 0 then
--				ii := the_strings.lower
--				put_comment_prefixed_text (the_strings @ ii, prefix_suffix)
--				from
--					ii := ii + 1
--				until
--					ii > the_strings.upper
--				loop
--					out_makefile.put_string (the_strings @ ii)
--					ii := ii + 1
--				end -- loop
--				out_makefile.put_new_line
--			end
--		end; -- put_comment_prefixed_strings


	put_comment_prefixed_text (a_text : STRING) is
			-- if comment_prefix is defined, ouput text as a comment,
		require
			text_exists:	a_text /= Void
			output_file_ready:	out_makefile /= Void and then out_makefile.extendible
		local
			l_text: STRING
		do
			if configuration.comment_prefix /= Void then
				create l_text.make (configuration.comment_prefix.count + a_text.count + 2)
				l_text.append (configuration.comment_prefix)
				--if prefix_suffix /= Void and then not prefix_suffix.is_empty then
				--	l_text.append (prefix_suffix)
				--end
				-- MMS chokes on comments that end with continuation character, so remove any continuation
				l_text.append (a_text)
--				if is_continued_line (l_text) then
--					strip_continuation (l_text)
--				end
				out_makefile.put_string (l_text)
			end
		end; -- put_comment_prefixed_text


	put_macro_definition (a_macro_name : STRING; a_macro_value : STRING) is
			-- output macro definition to current output makefile
		require
			macro_name_nonblank:	a_macro_name /= Void and then not a_macro_name.is_empty
			macro_value_exists:		a_macro_value /= Void
			output_file_ready:		out_makefile /= Void and then out_makefile.extendible
		local
			l_line: STRING
		do
			l_line := a_macro_name + " = " + a_macro_value
			put_continued_line (l_line, "%T", default_wrap_margin)
	end ; -- put_macro_definition


	put_continued_line (line : STRING; continuation_prefix : STRING; wrap_margin : INTEGER) is
			-- Output continued line with (optional) continuation prefix
			-- using primitive (whitespace) tokenization.
			-- If line exceeds wrap margin it is continued by using continuation string.
			-- Continued lines are terminated with continuation string.
			-- Continuation lines are prefixed with tab if continuation prefix is Void.
			-- A wrap margin of zero is treated as "largest possible value."
		require
			line_exists:	line /= Void
			output_file_ready:	out_makefile /= Void and then out_makefile.extendible
		local
			start_pos, end_pos, next_pos, last_pos : INTEGER
		do
			-- loop: while start_pos <= line.count
			-- start_pos: starting position to output from
			from
				start_pos := 1
			until
				start_pos > line.count
			loop
			-- loop: from start_pos, find the end of the last word within the wrap margin.
			-- find pos of last word to output (last word that ends before wrap margin)
			-- last_pos: position after last word that fits within wrap margin
			-- next_pos: starting position of next word after word at last_pos
			-- end_pos: temporary, end position of word at last_pos, used to find next_pos
			-- keep advancing last_pos to next_pos while next_pos is within wrap margin
			from
				-- last_pos := start_pos
				end_pos := end_word_index (line, start_pos)
				last_pos := next_word_index (line, end_pos)
				next_pos := last_pos
			until
				next_pos = 0 or else (wrap_margin > 0 and then next_pos - start_pos > wrap_margin)
			loop
				last_pos := next_pos
				end_pos := end_word_index (line, last_pos)
				next_pos := next_word_index (line, end_pos)
			end
			-- output line fragment
			if next_pos = 0 then
				last_pos := line.count +1
			end
			out_makefile.put_string (line.substring (start_pos, last_pos -1))
			-- if more (next_pos > 0) output continuation, prefix
			if last_pos <= line.count then
				out_makefile.put_string (configuration.continuation_string + "%N")
				if continuation_prefix /= Void then
					out_makefile.put_string (continuation_prefix)
				else
					out_makefile.put_character ('%T')
				end
			else
				out_makefile.put_new_line
			end
			start_pos := last_pos
			end -- until (start_pos > line.count)
		end; -- put_continued_line



----------------------------------------
feature -- platform specific file names
----------------------------------------

	subdirectory_make_command (a_subdir, a_target: STRING): STRING is
			-- command string to perform make in subdirectory of (optional) target `a_target'
			-- eg. <tab>-@ISE_EIFEL:[studio.spec.$(ISE_PLATFORM).bin]make.vms subidr target
		require
			subdirectory_exists: a_subdir /= Void
		local
			l_subdir: STRING
		do
			--"ISE_EIFFEL:[studio.spec." + value_platform + ".bin]make.vms " + l_target_dir_vms + "%N")
			if is_blank (a_subdir) then
				l_subdir := "[]"
			elseif is_vms_filespec (a_subdir) then
				l_subdir := a_subdir
			else
				l_subdir := as_vms_filespec (a_subdir + "/")
			end
			Result := "%T" + configuration.ignore_prefix + configuration.commandfile
					+ "ISE_EIFFEL:[studio.spec.$(" + symbol_platform + ").bin]make.vms " + l_subdir
			if is_nonblank (a_target) then
				Result.append (" " + a_target)
			end
		end

	platform_specific_path_name (base, subdir: ARRAY[STRING]) : FILE_NAME is
			-- build a VMS-syntax platform specific path name: ISE_EIFFEL:[<base>.$(ISE_platform).<subdir>]
			-- typically <base> is studio.spec (i.e. <<"studio","spec">> or studio.config,
			-- subdir
		local
			l_chk : BOOLEAN
			l_hack : STRING
		do
			--!!Result.make_from_string (symbol_eiffel)
			--if not Result.has(':') then Result.append_character (':') end
			create {FILE_NAME}Result.make_from_string (symbol_eiffel + ":")	--brute force device name
			--Result.extend_from_array (<< base, "spec", value_platform, subdir >>)
			if base /= Void and then not base.is_empty then
				Result.extend_from_array (base)
			end
			Result.extend (value_platform)
			if subdir /= Void and then not subdir.is_empty then
				Result.extend_from_array (subdir)
			end
			debug ("vms_hack_nugatory")
					-- TEMPORARY VMS SPECIFIC HACK UNTIL RUNTIME FIXED: IF NO DEV/DIR DELIMITERS, APPEND :
				l_chk := Result.is_valid
				l_hack ?= Result
				if not l_chk or else not (l_hack.has (':') or l_hack.has ('[')) then
					--hack := symbol_eiffel.twin; hack.append_character (':')
					--Result.extend_from_array (<< base, "spec", value_platform, subdir >>)
					create Result.make_from_string (symbol_eiffel + ":")
					if base /= Void then Result.extend_from_array (base) end
					Result.extend (value_platform)
					if subdir /= Void then Result.extend_from_array (subdir) end
				end
			end -- debug
			l_hack := as_vms_filespec (Result)
		end -- platform_specific_path_name

	platform_specific_file_name (base, subdir: ARRAY[STRING]; filename: STRING) : FILE_NAME is
			-- build a VMS-syntax platform-specific file name: ISE_EIFFEL:[<base>.$ISE_PLATFORM.<subdir>]<filename>
			-- typically <base> is studio.spec (i.e. <<"studio","spec">> or studio.config
		local
			l_hack: STRING
		do
			Result := platform_specific_path_name (base, subdir)
			if filename /= Void then
				Result.set_file_name (filename)
			end
			l_hack := as_vms_filespec (Result)
		end; -- platform_specific_file_name

	eiffel_library_filespec: STRING is
			-- VMS file specification of the Eiffel runtime/workbench object library (with platform macro replaced)
			--   ISE_EIFFEL:[studio.spec.<ISE_platform>.lib]<prefix><eiffel_library><suffix>
		require
			eiffel_library_exists_nonblank:   eiffel_library /= Void and then not eiffel_library.is_empty
		local
			--l_libfile: STRING
		do
			--create l_libfile.make_from_string (eiffel_library)
			--Result := platform_specific_file_name (<<"studio","spec">>, <<"lib">>, l_libfile)
			create Result.make_from_string (eiffel_library)
			Result.replace_substring_all ("$(ISE_PLATFORM)", value_platform)
		end -- eiffel_library_filespec

	to_vms_filespecs (str : STRING; initial_pos : INTEGER) is
			-- for each "word" in `str', translate filespec to VMS syntax
			-- also handle semantics for .a and .o extensions
		require
			start_small_enough: initial_pos <= str.count
			start_large_enough: initial_pos > 0
		local
			start_pos, end_pos : INTEGER
			word, vmsword : STRING
			file_pos : INTEGER
			l_vmsdir, l_vmsfil : STRING
		do
			from
				start_pos := next_word_index (str, initial_pos -1)
			until
				start_pos = 0 or else start_pos > str.count
			loop
				end_pos := end_word_index (str, start_pos)
				word := str.substring (start_pos, end_pos)
				vmsword := word
				--if word.is_equal ("#") then
				if str @ start_pos = '#' then
					end_pos := str.count
				elseif is_shell_command (str, start_pos) then
					do_nothing
				elseif not word.is_empty and word @ 1 = '-' then
					-- skip leading - probably an option
					do_nothing
				elseif word.is_equal ("\") or else word.is_equal (configuration.continuation_string) then
					-- skip continuation character
					do_nothing
				elseif word.is_equal ("\") then
					-- skip continuation character
					do_nothing
				elseif word.is_equal ("Makefile") then
					-- skip Makefile
					do_nothing
				elseif word.is_equal ("EMAIN_SPECIAL") then
					-- special processing for Emain
					do_nothing
				else
					-- translate to vms
					vmsword := as_vms_filespec (word)
					file_pos := basename_index (vmsword, 1)
					if file_pos > 1 then
						l_vmsdir := vmsword.substring (1, file_pos -1)
					else
						l_vmsdir := ""
					end
					l_vmsfil := vmsword.substring (file_pos, vmsword.count)
					if ends_with (vmsword, ".o") then
						vmsword.remove_tail (2)
						-- this is a terrible hack, that can be removed once generate_object_libraries is finished:
						-- if the filename is a subdirectory object file, change it to a library file type
						--if vmsword @ 1 /= '[' or else vmsword.is_equal ("[.E1]emain.o") then
						if vmsword @ 1 /= '[' then
							vmsword.append (".obj")
						elseif l_vmsdir.is_equal ("[.E1]") then
							vmsword.append (".obj")
						elseif vmsword.is_equal ("[.E1]emain") then
							vmsword.append (".obj")
						else
							vmsword.append (generated_object_file_type)
						end
					elseif ends_with (vmsword, ".a") then
						vmsword.remove_tail (2)
						vmsword.append (".olb")
						-- ***FIXME*** check filespec part only (this checks entire filespec)  ".olb"   "lib"
						if starts_with (vmsword, "lib") then
							do_nothing
						end
						l_vmsfil := vmsword.substring (file_pos, vmsword.count)
						if vmsword.count > file_pos + 3 and then
								--vmsword.substring (file_pos, file_pos +2).is_equal ("lib") then
								vmsword @ file_pos = 'l' and then vmsword @ (file_pos + 1) = 'i' and then vmsword @ (file_pos + 2) = 'b' then
							vmsword.remove (file_pos); vmsword.remove (file_pos); vmsword.remove (file_pos);
						end
					end
					if not word.is_equal (vmsword) then
						str.replace_substring (vmsword, start_pos, end_pos)
						end_pos := end_pos + vmsword.count - word.count
					end
				end -- special word handling
				start_pos := next_word_index (str, end_pos)
			end -- loop: for each word in str
		end; -- to_vms_filespecs


	as_vms_filespec (a_filespec : STRING) : STRING is
			-- a new string transformed from a unix filespec to vms syntax
			-- enclosing quotes are removed
			-- Rules:
			--   a ==> a	     $(a) ==> a:        a/b ==> [.a]b	      $(a)/b ==> a:b	   a/b/c ==> [.a.b]c	
			--   a/ ==> [.a]     $(a)/ ==> a:[]     a/b/ ==> [.a.b]       $(a)/b/ ==> a:[b]    a/b/c/ ==> [.a.b.c]
			--   /a ==> a:       /$(a) ==> a:       /a/b ==> a:b (a:[]b)  /$(a)/b ==> a:[b]    /a/b/c ==> a:[b]c	
			--   /a/ ==> a:[]    /$(a)/ ==> a:[]    /a/b/ ==> a:[b]       /$(a)/b/ ==> a:[b]   /a/b/c/ ==> a:[b.c]
			--
			--  $(a)/b/c ==> a:[b]c	 $(a)/b/c/ ==> a:[b.c]  /$(a)/b/c ==> a:[b]c  $(a)/b/c/ ==> a:[b.c]
		require
			filespec_exists:	a_filespec /= Void
		local
			start_pos : INTEGER -- should be a parameter
			l_filespec: STRING
			last_pos, next_pos : INTEGER
		do
			start_pos := 1		-- note: this should be a parameter ***TBS***
			l_filespec := a_filespec.twin
			remove_enclosing_quotes (l_filespec)
			if starts_with (l_filespec, "\$") then
				start_pos := start_pos + 1
			end
			-- hack: change Windows path delimiters to Unix
			if starts_with (l_filespec, "\\") then
				l_filespec.remove_head (1)
				l_filespec.replace_substring_all ("\", "/")
			elseif l_filespec.substring_index (":\", start_pos) > 1 then
				next_pos := l_filespec.substring_index (":\", start_pos)
				l_filespec.remove (next_pos)
				l_filespec.replace_substring_all ("\", "/")
				l_filespec.insert_character ('/', start_pos)
--			elseif l_filespec.count > 3 and then l_filespec @ 2 = ':' and then l_filespec @ 3 = '\' then
--				l_filespec := "/" + l_filespec
--			end
--			if l_filespec.index_of ('\', start_pos) > 0 then --and then l_filespec.index_of ('/', start_pos) = 0 then
--				--l_filespec.replace_substring_all ("\", "/")
			end


			if l_filespec.index_of ('/', start_pos) = 0 and then l_filespec.substring_index ("$(", start_pos) /= start_pos then
				Result := l_filespec
			else
				-- if filespec starts with escaped $, remove the escape
				--if l_filespec @ 1 = '$' then l_filespec.remove(1) end

--				-- if it has no unix filespec delimiters and doesnt begin with a symbol $(x),
--				-- then assume it is a VMS filespec
--				if not l_filespec.has ('/') and then l_filespec.substring_index ("$(", 1) /= 1
--				then -- assume it is already a vms filespec
--					Result := l_filespec -- already .twin'ed
--				else

				-- if there are any VMS path delimiters, return the result after removing $() ***TBS***

				-- first determine the path delimiter???

				-- handle the first element specially (make a device: if / prefixed or $() delimited or $ prefixed,
				-- [.dir] if / suffixed, else file)
				if l_filespec.count > start_pos then
					next_pos := l_filespec.index_of ('/', start_pos + 1)
					if next_pos = 0 then
						next_pos := l_filespec.count + 1
					end
				else
					next_pos := l_filespec.count + 1
				end
				if l_filespec  @ 1 = '/' then
					last_pos := 1
				else
					last_pos := 0
				end

				if l_filespec.count > last_pos + 1 and then l_filespec  @ (last_pos + 1) = '$' then
					if l_filespec  @ (last_pos + 2) = '(' and then l_filespec  @ (next_pos - 1) = ')' then
						Result := l_filespec.substring (last_pos + 3, next_pos - 2)
					else
						Result := l_filespec.substring (2, next_pos -1)
					end
					Result.append (":")
				elseif l_filespec  @ 1 = '/' then
					Result := l_filespec.substring (2, next_pos -1)
					Result.append (":")
				else
					Result := l_filespec.substring (1, next_pos -1)
					if next_pos <= l_filespec.count then
						Result.prepend ("[.")
					end
				end

				-- handle terminating slash
				if next_pos = l_filespec.count and then Result @ Result.count = ':' then
					-- if next_pos = l_filespec.count and then last_pos > 0 then
					Result.append_character ('[')
				end

				-- handle the rest of the filespec
				from
					last_pos := next_pos + 1
					if last_pos <= l_filespec.count then
						next_pos := l_filespec.index_of ('/', last_pos)
					else next_pos := 0
					end
				until
					next_pos = 0
				loop
					if Result @ Result.count = ':' then
					Result.append_character ('[')
					else
					Result.append_character ('.')
					end
					Result.append (l_filespec.substring (last_pos, next_pos -1))
					last_pos := next_pos +1
					if last_pos <= l_filespec.count then
					next_pos := l_filespec.index_of ('/', last_pos)
					else next_pos := 0
					end
				end -- loop

				-- terminate directory
				if Result.index_of ('[', 1) > 0 then
					Result.append_character (']')
				end
				if last_pos <= l_filespec.count then
					Result.append (l_filespec.substring (last_pos, l_filespec.count))
				end
			end -- filespec not empty
		end; -- as_vms_filespec



	is_vms_filespec (filespec : STRING) : BOOLEAN is
			-- does string look like a VMS filespec?
			-- if it has no unix filespec delimiters and doesnt begin with a symbol $(x),
			-- then assume it is a VMS filespec
		require
			filespec_exists:	filespec /= Void
		do
			if filespec.is_empty
				--or else filespec.has (operating_environment_.directory_separator)
				or else filespec.has ('/') or else filespec.has ('\')
				or else filespec.substring_index ("$(", 1) = 1
			then
				Result := False
			else
				Result := True
			end
		end; -- is_vms_filespec


	is_relative_filespec (a_filespec: STRING) : BOOLEAN is
		require
			filespec_exists: a_filespec /= Void
		local
			--l_dir: STRING
			l_pos1, l_pos2: INTEGER
		do
			--l_dir := basename (a_filespec)
			if a_filespec.is_empty then
				Result := True
			elseif is_vms_filespec (a_filespec) then
				l_pos1 := a_filespec.index_of ('[', 1)
				l_pos2 := a_filespec.index_of ('<', 1)
				if l_pos2 > 0 and then (l_pos1 = 0 or else l_pos2 < l_pos1) then
					l_pos1 := l_pos2
				end
				Result := l_pos1 = 0 or else l_pos1 >= a_filespec.count or else (a_filespec @ (l_pos1 + 1) = '.' or else a_filespec @ (l_pos1 + 1) = ']')
			--else Result := a_filespec @ 1 /= '/'
			elseif a_filespec @ 1 = '.' then
				Result := True
			else
				if a_filespec @ 1 = '/' or else starts_with (a_filespec, "\\") then
					Result := False
				else
					l_pos1 := a_filespec.index_of (':', 1)
					if l_pos1 < 1 or else l_pos1 >= a_filespec.count or else a_filespec @ (l_pos1 + 1) /= '\' then
						Result := True
					end
				end
			end
		end

	make_absolute_filespec (a_filespec: STRING) : STRING is
		require
			filespec_exists: a_filespec /= Void
		local
			l_cwd: STRING
		do
			if is_relative_filespec (a_filespec) then
				Result := a_filespec.twin
				l_cwd := execution_environment_.current_working_directory
				if is_vms_filespec (l_cwd) then
				else
					if Result.count >= 2 and then Result @ 1 = '.' and then Result.index_of (operating_environment_.directory_separator, 2) = 2 then
						Result.remove_head (2)
					end
					Result.prepend_character (operating_environment_.directory_separator)
					Result.prepend (execution_environment_.current_working_directory)
				end
			else
				Result := a_filespec.twin
			end
		end

	dirname (a_filespec: STRING): STRING is
			-- the directory name (path, excluding the filename) part of 'a_filespec'
			-- including terminating path delimiter; empty if no path delimiter found
		local
			l_pos : INTEGER
			unfinished: INTEGER
		do
			l_pos := basename_index (a_filespec, 1)
			if l_pos > 1 then
				Result := a_filespec.substring (1, l_pos -1)
			else
				create Result.make_empty
			end
		ensure
			dirname_exists: Result /= Void
		end

	basename (a_filespec: STRING) : STRING is
			-- the filename (filespec less path); empty if filespec ends with path delimiter
		require
			filespec_exists: a_filespec /= Void
		local
			l_pos : INTEGER
			unfinished: INTEGER
		do
			l_pos := basename_index (a_filespec, 1)
			if l_pos = 0 then
				Result := a_filespec.twin
			elseif l_pos > a_filespec.count then
				create Result.make_empty
			else
				Result := a_filespec.substring (l_pos, a_filespec.count)
			end
		ensure
			basename_exists: Result /= Void
		end

	basename_index (a_filespec : STRING; start_pos: INTEGER) : INTEGER is
			-- the position (index) of the basename (filename part) in the (any platform syntax) file path.
			-- may be start_pos if no directory delimiters found,
			-- may be > a_filespec.count (a_filespec.count + 1) if no filename is present (ie. the last character is a path delimiter)
	 	require
			filespec_exists: a_filespec /= Void
			start_large_enough:	start_pos >= 1
		local
			l_delim, l_pos : INTEGER
		do
			if a_filespec.is_empty then
				Result := start_pos
			else
				-- find the last directory delimiter at or after start_pos
				-- if none, then simply return start_pos
				from
					Result := start_pos
					l_delim := 1
				until
					l_delim > path_delimiters.count
				loop
					l_pos := a_filespec.last_index_of (path_delimiters @ l_delim, a_filespec.count)
					if l_pos >= start_pos and then l_pos >= Result then
						Result := l_pos + 1
					end
					l_delim := l_delim + 1
				end -- loop
			end
		ensure
			correct_place:	Result >= start_pos and Result <= a_filespec.count + 1
		end; -- basename_index



-------------------------------------------------------------
feature -- shell commands
-------------------------------------------------------------

	is_shell_command (a_str : STRING; a_start : INTEGER) : BOOLEAN is
			-- is a shell command in `a_str' beginning at `a_start?'
			-- examples: `foo' or $(foo)
			--  where foo is a command followed by optional arguments, eg.
			--		gtk-config --cflags  or
			--		$EIFFEL_SRC/library/vision2/implementation/gtk/Clib/vision2-gtk-config --devel --include_path
		require
			string_exists:	a_str /= Void
			start_large_enough: a_start >= 1
			start_small_enough: a_start <= a_str.count
		local
			l_end: INTEGER
			l_cmd: STRING
		do
			if (a_str.count - a_start + 1 > 2 and then a_str @ a_start = '`')
						or else (a_str.count - a_start + 1 > 3 and then a_str @ a_start = '$' and then a_str @ (a_start + 1) = '(') then
				-- Problem: a $() delimited shell command is indistinguishable from a Make macro.
				-- Solution: not a shell command if $(name)/file where name is ISE_EIFFEL or ISE_LIBRARY or EIFFEL_SRC
				-- and file is anything
				l_end := shell_command_end_index (a_str, a_start)
				if l_end = 0 then
					print_warning_message ("is_shell_command: Quoted string has no closing quote, starting position: "
							+ a_start.out + ", %N string: %"" + a_str + "%"%N")
				else
					if a_str @ a_start = '$' then
						l_cmd := a_str.substring (a_start + 2, l_end - 1)
					else
						l_cmd := a_str.substring (a_start + 1, l_end - 1)
					end
					if l_end < a_str.count and then a_str @ l_end = ')' and then a_str @ (l_end + 1) = '/' then
						--Result := False
					else
						Result := True
					end
				end
			end
		end; -- is_shell_command

	shell_command_end_index (a_str: STRING; a_start: INTEGER): INTEGER is
			-- the position in 'a_str' of the ending delimiter of the shell command that starts at 'a_start'.
			-- zero if not found
		require
			string_exists:	a_str /= Void
			start_large_enough:	a_start > 0
		local
			l_start: INTEGER
			l_delim: CHARACTER
		do
			if (a_str.count - a_start + 1 > 2 and then a_str @ a_start = '`') then
				l_delim := '`'
				l_start := a_start + 1
			elseif (a_str.count - a_start + 1 > 3 and then a_str @ a_start = '$' and then a_str @ (a_start + 1) = '(') then
				l_delim := ')'
				l_start := a_start + 2
			else
				l_start := 0
			end
			if l_start > 0 then
				Result := end_word_index (a_str, a_start)	-- debug
				from
					Result := l_start
				until
					Result = 0 or else Result >= a_str.count or else a_str @ Result = l_delim
				loop
					Result := a_str.index_of (l_delim, Result)
					if Result = 0 then
					print_warning_message ("shell_command_end_index: Quoted string has no closing quote, starting position: " + a_start.out
								+ ", %N string: %"" + a_str + "%"%N")
					elseif a_str @ (Result - 1) = '\' then
					Result := Result + 1
					end
				end
			end
		end; -- shell_command_end_index

	process_shell_commands (a_str : STRING; a_start_pos : INTEGER ) is
			-- process all shell commands in `a_str' beginning at `a_start_pos'
		require
			string_exists : a_str /= Void
			start_small_enough: a_start_pos <= a_str.count
			start_large_enough: a_start_pos > 0
		local
			l_next, l_end: INTEGER
			l_cmd: STRING   -- ***debug***
		do
			from
				l_next := next_word_index (a_str, a_start_pos - 1)
			until
				l_next = 0 or else l_next > a_str.count
			-- ***fixme*** need loop variant
			loop
				l_end := end_word_index (a_str, l_next)		-- ***debug***
				l_cmd := a_str.substring (l_next, l_end)	-- ***debug***
				if (is_shell_command (a_str, l_next)) then
					l_end := shell_command_end_index (a_str, l_next)	-- ***debug***
					l_cmd := a_str.substring (l_next, l_end)		-- ***debug***
					process_shell_command_at (a_str, l_next)
					l_end := l_next - 1
					-- n.b. this requires that the shell command be removed, or this will be an infinite loop
				else --if (l_next <= a_str.count) then
					l_end := end_word_index (a_str, l_next)
				end
				l_next := next_word_index (a_str, l_end)
			end -- loop
		end; -- process_shell_commands


	process_shell_command_at (a_str : STRING ; a_start_pos : INTEGER) is
			-- replace the shell command in `a_str' starting at `a_start_pos'
		require
--			string_exists : a_str /= Void
--			position_large_enough: a_start_pos >= 1
--			string_long_enough: a_str.count > a_start_pos + 1
			is_shell_command: is_shell_command (a_str, a_start_pos)
		local
			l_end_pos: INTEGER		-- position of shell command end delimiter
			l_cmd_start_pos: INTEGER	-- start of shell command (after delimiter)
			l_cmd, l_val: STRING
		do
			l_end_pos := shell_command_end_index (a_str, a_start_pos)
			l_cmd_start_pos := a_start_pos
			if a_str @ a_start_pos = '`' then
				l_cmd_start_pos := a_start_pos + 1
			elseif a_str @ a_start_pos = '$' and then a_str @ (a_start_pos + 1) = '(' then
				l_cmd_start_pos := a_start_pos + 2
			end
			l_cmd := a_str.substring (l_cmd_start_pos, l_end_pos - 1)
			l_val := shell_command_result (l_cmd)
			a_str.replace_substring (l_val, a_start_pos, l_end_pos)
		end


	vision2_gtk_shell_script_name: STRING is "vision2-gtk-config"
	--vision2_gtk_shell_script_path: STRING is "$EIFFEL_SRC/library/vision2/implementation/gtk/Clib/"
	vision2_gtk_shell_script_path: STRING is "/library/vision2/implementation/gtk/Clib/"
	shell_command_result (a_str : STRING) : STRING is
			-- options resulting from shell command `a_str'
		require
			string_exists : a_str /= Void
		local
			--l_cmd_start_pos: INTEGER	-- start of shell command (after delimiter)
			--l_end_pos: INTEGER		-- position of shell command end delimiter
			--l_sh_cmd: STRING		-- the entire shell command, including delimiters
			l_base, l_dir: STRING
			l_shword: ROSE_DELIMITED_TEXT
			l_cmd, l_opt, l_top: STRING
			l_key, l_default: STRING
			ii: INTEGER
		do
			--l_end_pos := shell_command_end_index (a_str, a_start_pos)
			--l_sh_cmd := a_str.substring (a_start_pos, l_end_pos)
			--l_cmd_start_pos := a_start_pos
			--if a_str @ a_start_pos = '`' then
			--	l_cmd_start_pos := a_start_pos + 1
			--elseif a_str @ a_start_pos = '$' and then a_str @ (a_start_pos + 1) = '(' then
			--	l_cmd_start_pos := a_start_pos + 2
			--end
			--l_cmd := a_str.substring (l_cmd_start_pos, l_end_pos - 1)	-- ***debug***
			create l_shword.make (a_str, ' ')
			l_cmd := l_shword.first
			l_dir := dirname (l_cmd)
			l_base := basename (l_cmd)
			if l_dir.substring_index ("$(EIFFEL_SRC)", 1) = 1 then
					-- replace $(EIFFEL_SRC) with $EIFFEL_SRC
				l_dir.remove (13); l_dir.remove (2);
			end
			--if (l_dir.is_equal (vision2_gtk_shell_script_path) and then l_base.is_equal (vision2_gtk_shell_script_name)) then
			if l_dir.has_substring (vision2_gtk_shell_script_path) and then l_base.is_equal (vision2_gtk_shell_script_name) then
					-- Hack time: fake the results of vision2 gtk shell script:
					--	`$EIFFEL_SRC/library/vision2/implementation/gtk/Clib/vision2-gtk-config --devel --include_path`
					-- or `$(EIFFEL_SRC)/library/vision2/implementation/gtk/Clib/vision2-gtk-config --devel --object`
					-- or (5.7.65176)
					--  `\$ISE_LIBRARY/library/vision2/implementation/gtk/Clib/vision2-gtk-config --include_path`
				from
					l_top := "$ISE_EIFFEL"
					ii := 2
				until
					ii > l_shword.count
				loop
					--l_opt := l_shword.i_th (ii)
					l_opt := l_shword.item (ii)
					if l_opt.is_equal ("--devel") then
						l_top := "$EIFFEL_SRC"
					elseif l_opt.is_equal ("--include_path") then
						l_key := vision2_gtk_shell_script_name + l_opt
						--l_val := get_configuration_item_once (l_key, "/incl=vision2_gtk_include_path:")
						--a_str.replace_substring (l_val, a_start_pos, l_end_pos)
						Result := configuration_item_once (l_key, "/incl=vision2_gtk_include_path:")
					elseif l_opt.is_equal ("--object") then
						l_key := vision2_gtk_shell_script_name + l_opt
						--l_val := get_configuration_item_once (l_key, "vision2_gtk_object:")
						--a_str.replace_substring (l_val, a_start_pos, l_end_pos)
						Result := configuration_item_once (l_key, "vision2_gtk_object:")
					else
						print_warning_message ("Unknown option: '" + l_opt + "' in shell command:%N " + a_str + "%N")
						Result := ""
					end
					ii := ii + 1
				end
			elseif l_cmd.is_equal ("gtk-config") then
					-- Hack time: replace `gtk-config --cflags` and `gtk-config --libs`
					-- with corredsponding configuration options (gtk_config_cflags, gtk_config_whatsit)
				l_opt := l_shword.item (2)
				if l_opt.is_equal ("--cflags") or else l_opt.is_equal ("--libs") then
					l_key := "gtk_config_" + l_opt.substring (3, l_opt.count)
					l_default := "$(GTK_" + l_opt.substring (3, l_opt.count) + ")"
					l_default.to_upper
					--l_val := get_configuration_item_once (l_key, l_default)
					--a_str.replace_substring (l_val, a_start_pos, l_end_pos)
					Result := configuration_item_once (l_key, l_default)
				else
					print_warning_message ("shell_command_result: unknown gtk-config shell command option: " + l_opt + " ignored.%N")
					--a_str.replace_substring (l_cmd + "_" + l_opt, a_start_pos, l_end_pos)
					Result := l_cmd + "_" + l_opt
				end
			else
				print_warning_message ("shell_command_result: unknown shell command: " + a_str + " ignored.%N")
				--a_str.replace_substring ("", a_start_pos, l_end_pos)
				Result := ""
			end
		ensure
			result_not_void: Result /= Void
		end; -- shell_command_result



--------------------------------------------------------------------------
feature -- DCL operations -- another missed opportunity to create a class
--------------------------------------------------------------------------

	append_DCL_value (a_str : STRING; a_value : STRING ) is
			-- append `a_value' to `a_str' using DCL rules for parentheses, commas, and quoting
		require
			this_exists:	a_str  /= Void
			value_exists:   a_value /= Void
			value_valid:	( (a_value @ 1) = '(' ) = ( (a_value @ a_value.count) = ')' )
			this_valid:	a_str.is_empty or else ( a_str @ 1 = '(' ) = ( a_str @ a_str.count = ')' )
		local
			quoted_value : STRING
		do
			-- ***TBS*** check for quoting required	
			quoted_value := a_value
			if a_str.is_empty then
				a_str.append (quoted_value)
			else
				if quoted_value @ 1 = '(' then
					quoted_value.remove (quoted_value.count); quoted_value.remove (1)
				end
				if a_str @ 1 = '(' then
					-- this is a comma delimited parenthesized list; append ,value before )
					-- assume a_str @ a_str.count = ')' -- change it to a ,
					a_str.put (',', a_str.count)
					a_str.append (quoted_value)
					a_str.append_character (')')
				else
					-- a_str is a single value, make it a comma delimited parenthesized list
					a_str.prepend_character ('(')
					a_str.append_character (',')
					a_str.append (quoted_value)
					a_str.append_character (')')
				end
			end
		end; -- append_DCL_value


	DCL_qualifier_name_size ( a_str : STRING ; start_pos : INTEGER ) : INTEGER is
			-- size of DCL qualifier at start of a_str, zero if not a DCL qualifier
			-- size must be zero or >= 2, and always includes leading '/'
		require
			str_exists: a_str /= Void
			str_large_enough: a_str.count >= 2
			start_large_enough:  start_pos > 0
			start_small_enough : start_pos <= a_str.count

		local
			l_comp : STRING
			l_pos : INTEGER
		do
			if start_pos < a_str.count and then a_str @ start_pos = '/' and then a_str.item (start_pos + 1).is_alpha then
				from
					l_comp := a_str.substring (start_pos, a_str.count); l_comp.to_upper; l_comp.append_character ('/')
					l_pos := 3
				until
					l_pos = 0 or else l_pos > a_str.count
				loop
					if not is_symbol_constituent (l_comp @ l_pos) then
						Result := l_pos - 1
						l_pos := 0
					else
						l_pos := l_pos + 1
					end
				end -- loop		
			end

	ensure
		size_large_enough:  Result = 0 or else Result >= 2
	end ; -- DCL_qualifier_name_size


	DCL_qualifier_name ( a_str : STRING ; start_pos : INTEGER ) : STRING is
			-- name of DCL qualifier at start_pos in a_str, Void if not a DCL qualifier
		require
		local
			size : INTEGER
		do
			size := DCL_qualifier_name_size (a_str, start_pos);
			if size > 0 then
				Result := a_str.substring (start_pos, size)
			end
		end; -- DCL_qualifier_name

	DCL_qualifier_matches ( DCL_qualifier: STRING ; minimum : INTEGER ; str : STRING ; start_pos : INTEGER ) : BOOLEAN is
				-- does DCL_qualifier match that at start_pos in str?
		require
			str_exists: str /= Void
			str_large_enough: str.count >= 2
			start_large_enough:  start_pos > 0
			start_small_enough : start_pos <= str.count
			str_is_DCL_qualifier: str.item (start_pos) = '/' and then str.item (start_pos + 1).is_alpha
			DCL_qualifier_exists: DCL_qualifier /= Void
			DCL_qualifier_valid:
				DCL_qualifier.count >= 2 and then DCL_qualifier.item(1) = '/' and then DCL_qualifier.item(2).is_alpha
		local
			l_qual, l_comp : STRING
			l_pos, l_len : INTEGER
		do
			if start_pos < str.count and then str @ start_pos = '/' then
				from
					l_qual := DCL_qualifier.as_upper
					l_comp := str.substring (start_pos, str.count); l_comp.to_upper
					Result := True
					l_pos := 2
				until
					not Result or else l_pos = 0 or else l_pos > str.count
				loop
					if not is_symbol_constituent (l_comp @ l_pos) then
						l_len := l_pos - 1
						l_pos := 0
					elseif l_pos <= l_qual.count and then (l_qual @ l_pos) /= (l_comp @ l_pos) then
						Result := False
					else
						l_pos := l_pos + 1
					end
				end -- loop
				if l_len < minimum then
					Result := False
				end
			end
		end; -- DCL_qualifier_matches


	DCL_quoted_word (word : STRING) : STRING is
				-- generate a DCL word with quoted '$' if required
		require
			word_exists:  word /= Void
			word_not_empty: not word.is_empty
		local
			l_pos : INTEGER
		do
			Result := word.twin
			if configuration.target_gnu_make then  -- configuration.DCL_dollar_quote /= Void
				from
					l_pos := Result.index_of ('$', 1)
				until
					l_pos = 0
				loop
					--Result.insert_string (configuration.DCL_dollar_quote, l_pos)
					--l_pos := Result.index_of ('$', l_pos + 1 + configuration.DCL_dollar_quote.count)
					Result.insert_character ('$', l_pos)
					l_pos := Result.index_of ('$', l_pos + 1)
				end
			end
		end; -- DCL_quoted_word


	remove_redundant_DCL_filespecs (a_value : STRING) is
			-- Remove redundant DCL file specifications from DCL value string `a_value'.
			-- This is done solely to shorten the DCL command.
			-- The device (and directory?) portions of a DCL value are redundant in
			-- a multiple valued (parenthesized, comma separated) DCL value item
			-- if the device of item[n] matches that of item[n-1].
		local
			start_pos, end_pos, colon_pos, slash_pos : INTEGER
			device, previous_device : STRING
			dbg : STRING
		do
			if a_value @ 1 = '(' and then a_value @ (a_value.count) = ')' then
				-- loop invariant: start_pos is the first position of the value item,
				-- end_pos is the position after the end of the value item
				from
					start_pos := 2
					previous_device := ""
				until
					start_pos >= a_value.count
				loop
					end_pos := a_value.index_of (',' , start_pos + 1)
					if end_pos = 0 then
						end_pos := a_value.count
					end
					dbg := a_value.substring (start_pos, end_pos - 1)
					-- get device, compare to previous
					slash_pos := a_value.index_of ('/', start_pos)
					colon_pos := a_value.index_of (':', start_pos)
					if slash_pos = 0 then
						slash_pos := end_pos
					end
					if colon_pos > 0 and then colon_pos < slash_pos then
						device := a_value.substring (start_pos, colon_pos)
						if device.is_equal (previous_device) then
							-- end_pos := end_pos - device.count
							a_value.replace_substring ("", start_pos, colon_pos)
							end_pos := end_pos - (colon_pos - start_pos) - 1
						else
							previous_device := device
						end
						elseif slash_pos < end_pos then
							previous_device := ""
						else
						end
					-- next element
					start_pos := end_pos + 1
				end -- loop
			end -- if parenthesized value
		end; -- remove_redundant_DCL_filespecs

---------------------------------------------------------------
feature -- continuation lines
-------------------------------------------------------------

	is_continued_line (a_line : STRING) : BOOLEAN is
			-- returns True if input ends with continuation character, otherwise False
		require
			line_exists:		a_line /= Void
		do
			Result := continuation_character_index (a_line) > 0
		end; -- is_continued_line

	strip_continuation (a_line : STRING)  is
			-- strip continuation indicator from input string
		require
			line_exists:		a_line /= Void
			line_is_continued:   	is_continued_line (a_line)
		local
			last_pos : INTEGER
		do
			last_pos := continuation_character_index (a_line)
			if last_pos > 0 then
				-- Result := True
				a_line.keep_head (last_pos -1)
				-- else Result := False
			end
	end; -- strip_continuation

	continuation_character_index (a_line : STRING) : INTEGER is
			-- returns index of continuation character in line, 0 if none
		require
			line_exists:	a_line /= Void
		local
			last_pos : INTEGER
		do
			-- find the last non-whitespace character
			from
				last_pos := a_line.count
			until
				last_pos < 1 or else not is_whitespace (a_line @ last_pos)
			loop
				last_pos := last_pos - 1
			end -- loop
			if last_pos > 0 and then a_line @ last_pos = '\' then
				Result := last_pos
			else Result := 0
			end
		end; -- continuation_character_index



feature -- Test

	test is
		local
			l_test: ES5SH_TEST
		do
			print ("{" + generating_type + "}.test called:%N")
			create l_test
			l_test.test (command_option_verbose)
		end

invariant
--	precompilation_used: use_precompiled implies (precompiled_library /= Void)

end -- class ES5SH

--|--------------------------------------------------------------------------
--
--
-- 16-Apr-2008	6.2-xxx
--	restore force /include=EIF_PROJECT
--
-- date tbs	5.7-002
--	refactor: create ES5SH_COMMON, ES5SH_CONFIGURATION
--	internal changes:
--		process_macro_EIFLIB uses replace_macros instead of special case checks for $prefix, $suffix
--		eiffel_library is full VMS path with embedded $ISE_PLATFORM
--
-- 26-Sep-2006  5.7-001
--  do not concatenate source files in E1 directory
--
-- 16-Nov-2005	X5.6-002
--	check for .OLB, .OPT, .EXE external files case insensitively
--
-- 15-Aug-2005	x5.6-001
--	remove force /include=EIF_PROJECT (not necessary in 5.6.1113)
--
-- 03-Feb-2005	x5.5-022d
--	move shareable insertion to end of link.com file
--	remove check for and use of (INCLUDE_PATH) configuration option in process_macro_CFLAGS
--	add to warnings of obsolete options at end of get_options
--
-- 29-Nov-2004	x5.5-022c
--	add processing for new gtk-config macros now in Eiffel 5.5.1126
--
-- 19-Nov-2004	x5.5-022b
--		add INCLUDE_FILE_PREFIX, INCLUDE_FILE_SUFFIX configuration options (to provide for VMS_JACKETS_INCLUDE to CONFIG.EIF)
--
-- 8-Oct-2004	x5.5-022a	
--	add test facility for as_vms_filespec
--
-- 6-Oct-2004	x5.5-021a	
--	ensure #line directives in concatenated source file have VMS syntax
--
-- 29-Sep-2004	V5.5-021	david_s
--	fix error in creating preobj library in link.com (subdirectory names must be VMS paths)
--	minor readability enhancements in make.com
--
-- 23-Sep-2004	V5.5-020	david_s
--	major rewrite; improve parsing;
--	add eiflib after preobj library in link.com
--
--  1-Sep-2004	X5.5-019
--	handle E1/estructure target
--
-- ***tbs***
--  eliminate need for qf (edit OBJECTS macro to OLDOBJECTS if required)
--
-- 15-Mar-2003		X5.4-018c
--	remove put_library_filespec, replace with eiffel_library_filespec;
--	move config.eif to ISE_EIFFEL:[studio.config.$ISE_PLATFORM]config.eif
--
-- 3-Feb-2004		X5.4-018b
--	add eiffel_shareable option, append to link.com if defined
-- 30-Jan-2004		X5.4-018b
--	copy emain.template from ISE_EIFFEL:[studio.config.$(ISE_PLATFORM).templates]emain.template
--
-- 28-Jan-2004		X5.4-018
--	force copy emain template to emain.C (upcase .C) to workaround MMS case sensitivity bug:
--	MMS does not execute .c.obj: (or .C.obj): suffix rule for .c file on
--	ODS5 volume; name must be upcase .C
--	Allow any of -? /? -h -help /h /help as -help argument
--
-- 18-Aug-2003		X5.3-017
--	comment out garbage (unhandled rules for cecil and dynamic libraries) at
--	end of Makefile. that was causing MMK to barf
--
-- 21-Jul-2003 x5.1.016
--	use ES5SH_TEXT_FILE for input files to eliminate spurious <cr>
--	this may be an artifact of DEC C RTL and may be eliminated by use of VMS porting library in the future.
--
-- 2-nov-2002	version x5.1.015
--	fix need \$() in external include_path but not in objects (it's logical, but not friendly)
--	allow .lib type in external objects,
--	allow windows path separators in external include_paths, objects
--
-- 29-Aug-2002	version x5.1.014
--	command line option processing, print_usage
--	fix EXTERNALS processing:
--		correct file name mangling (-Idev:[dir] to [.dev:[dir]])
--		allow LINK .OPT option files
--
-- 16-Jul-2002 verison x5.1.013
--	use DATE_TIME to generate date in generated files.
--
-- 19-June-2002	remove optimization to remove redundant device names in /INCLUDE specifier
--	(remove call to remove_redundant_DCL_filespecs); new DECC compiler does not do
--	input parse defaulting
--
-- ??? version x5.1.012
--
-- 5-Jan-2002	big_file (like quick_finalize),
--		controlled by configuration option ***tbs***
--
--
-- 30-Nov-2001	es4sh --> es5sh
--
-- 14-May-2001  handle X2C macro definition
--
-- 02-May-2001  gather all misc. replacements into one place (perform_inchoate_replacements)
--			  which will be used until we install some sensible parsing
--
-- 29-Apr-2001  create files in proper subdirectory (we removed the calls to set_working_directory)
--
-- 23-Apr-2001  use ISE_PLATFORM and ISE_EIFFEL in preference to PLATFORM and EIFFEL
--
--|---------------------------------------------------------------------------
