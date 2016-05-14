note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAKEFILE_TRANSLATOR

inherit
	ANY

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	PROCESS_FACTORY
		export
			{NONE} all
		end

	LOCALIZED_PRINTER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_options: like options; mapped_path: BOOLEAN; a_force_32bit: BOOLEAN; a_processor_count: NATURAL_8)
			-- Initialize
		require
			a_options_not_void: a_options /= Void
		local
			l_c_setup: COMPILER_SETUP
		do
			options := a_options
			create system_dependent_directories.make (5)
			create object_dependent_directories.make (50)
			create dependent_directories.make (55)
			create makefile.make_with_name ("Makefile")
			create makefile_sh.make_with_name ("Makefile.SH")
			create appl.make_empty
			create missing_options.make (2)
			missing_options.compare_objects
			makefile_content := ""

			force_32bit := a_force_32bit

			processor_count := a_processor_count

			uses_precompiled := False

			directory_separator := options.get_string_or_default ("directory_separator", "\")
			object_extension := options.get_string_or_default ("obj_file_ext", "obj").twin
			object_extension.prepend_character ('.')

			lib_extension := options.get_string_or_default ("intermediate_file_ext", "lib").twin
			lib_extension.prepend_character ('.')

				-- Initialize the C compiler environment.
			create l_c_setup.initialize (options.get_boolean ("smart_checking", True), a_force_32bit)
			if attached l_c_setup.found_c_config as l_config then
				io.put_string ("Preparing C compilation using " + l_config.description + "...%N")
			else
				io.put_string ("Preparing C compilation using already configured " + eiffel_layout.eiffel_c_compiler + " C compiler...%N")
			end
			io.standard_default.flush

			check_for_il
			quick_compilation := options.get_boolean ("quick_compilation", True)
			if quick_compilation and not is_il_code then
				launch_quick_compilation
			end
		ensure
			processor_count_set: processor_count = a_processor_count
			force_32bit_set: force_32bit = a_force_32bit
		end

feature -- Quick compile

	launch_quick_compilation
			-- Launch the `quick_finalize' program with the correct options.
		local
			quick_prg: STRING_32
		do
			quick_prg := {STRING_32} "%""
			quick_prg.append_string (eiffel_layout.quick_finalize_command_name.name)
			quick_prg.append_string ({STRING_32} "%" . ")
			quick_prg.append_string_general (options.get_string_or_default ("obj_file_ext", "obj"))
				-- On Windows, we need to surround the command with " since it is executed
				-- by COMSPEC.
			env.system ({STRING_32} "%"" + quick_prg + {STRING_32} "%"")
		end

feature -- Status report

	has_makefile_sh: BOOLEAN
			-- Did we find any Makefile.SH?

feature -- Access

	makefile_sh: PLAIN_TEXT_FILE
			-- Makefile.SH to read from

	makefile: PLAIN_TEXT_FILE
			-- Makefile to create

	options: RESOURCE_TABLE
			-- Options read from config.eif

	dependent_directories, system_dependent_directories,
	object_dependent_directories: ARRAYED_LIST [TUPLE [directory, file: STRING]]
			-- Subdirs for this compilation

	quick_compilation: BOOLEAN
			-- Is the current compilation a quick one?

	delete_next: BOOLEAN
			-- Is the next line to be deleted?

	externals: BOOLEAN
			-- Is the application using externals?

	precompile: BOOLEAN
			-- Is this a precompilation?

	multithreaded: BOOLEAN
			-- Is this a multithreaded application?

	appl: STRING
			-- Application name

	uses_precompiled: BOOLEAN

	directory_separator: STRING
			-- Directory separator which needs to be used for the Makefile translation.

	object_extension: STRING
			-- File extension name for C generated object files.

	lib_extension: STRING
			-- File extension name for C generated object files for
			-- each C*, D* and F* directory.

	is_il_code: BOOLEAN
			-- Is Makefile.SH generated for IL C code generation.

	processor_count: NATURAL_8
			-- Number of processors to utilize

	force_32bit: BOOLEAN
			-- Indiciates if 32bit compilation should be forced

	is_ascii: BOOLEAN
			-- Does makefile use only ASCII?

feature -- Execution

	translate
			-- create Makefile from Makefile.SH and options
		do
			translate_makefile (True, ".")
			translate_sub_makefiles
		end

	run_make (a_directory: PATH)
			-- Run the make utility on the generated Makefile in `a_directory'.
		local
			command: STRING
			l_make_flags: STRING_32
			l_process: PROCESS
			l_success: BOOLEAN
			l_flags: detachable LIST [STRING_32]
			l_file: RAW_FILE
			input_code_page: NATURAL_32
			output_code_page: NATURAL_32
			l_launched_command: READABLE_STRING_32
			l_cpu: INTEGER
		do
				-- Record current code page.
			input_code_page := {WEL_API}.console_input_code_page
			output_code_page := {WEL_API}.console_output_code_page

				-- The command to execute the make utility on this platform
			command := options.get_string_or_default ("make_utility", "")
			subst_eiffel (command)
			subst_platform (command)
			subst_compiler (command)
			l_make_flags := options.get_string_or_default ("make_flags", "")
			l_make_flags.left_adjust
			l_make_flags.right_adjust

				-- Some Make utility don't know how to execute multiple C compilation at once.
				-- For those, we have built a tool `emake' that will do the parallelization of the
				-- C compilation.
			if options.get_boolean ("use_emake", False) then
					-- Launch building of `E1\estructure.h' and `E1\eoffsets.h' in case it is not built and we are not
					-- in .NET mode
				if not is_il_code then
					create l_file.make_with_name ("E1" + directory_separator + "estructure.x")
					if l_file.exists then
						l_flags := l_make_flags.split (' ')
						l_flags.extend ({STRING_32} "E1" + directory_separator + {STRING_32} "estructure.h")
						l_process := process_launcher (command, l_flags, Void)
						l_process.launch
						l_success := l_process.launched
						if l_success then
							l_process.wait_for_exit
						else
							io.error.put_string ("ERROR: Cannot start %"" + command + "%".")
						end
					end

					create l_file.make_with_name ("E1" + directory_separator + "eoffsets.x")
					if l_file.exists then
						l_flags := l_make_flags.split (' ')
						l_flags.extend ({STRING_32} "E1" + directory_separator + {STRING_32} "eoffsets.h")
						l_process := process_launcher (command, l_flags, Void)
						l_process.launch
						l_success := l_process.launched
						if l_success then
							l_process.wait_for_exit
						else
							io.error.put_string ("ERROR: Cannot start %"" + command + "%".")
						end
					end
				end

					-- Setup arguments of `emake'.
				create {ARRAYED_LIST [STRING_32]} l_flags.make (8)
				if processor_count > 0 then
					l_flags.extend ({STRING_32} "-cpu")
					l_flags.extend (processor_count.out)
				end
				l_flags.extend ({STRING_32} "-make")
				l_flags.extend (command)
				if not l_make_flags.is_empty then
					l_flags.extend ({STRING_32} "-make_flags")
					l_flags.extend (l_make_flags)
				end

				l_launched_command := eiffel_layout.emake_command_name.name
			else
					-- If our Make utility support launching more jobs, use
					-- its command line to specify the number of jobs.
				if attached options.get_string ("make_cpu_flags") as l_cpu_flag and then not l_cpu_flag.is_empty then
					create {ARRAYED_LIST [STRING_32]} l_flags.make (8)
					if processor_count = 0 then
							-- Use all CPUs by default.
						compute_number_of_cpu ($l_cpu)
					elseif processor_count > 0 then
							-- Use only what was specified.
						l_cpu := processor_count
					else
							-- Use just one.
						l_cpu := 1
					end
					l_flags.extend (l_cpu_flag)
					l_flags.extend (l_cpu.out)
				end
				create {IMMUTABLE_STRING_32} l_launched_command.make_from_string_general (command)
			end
				-- Launch the C compilation process.
			l_process := process_launcher (l_launched_command, l_flags, a_directory.name)
			l_process.launch
			l_success := l_process.launched
			if l_success then
				l_process.wait_for_exit
			else
				localized_print_error ({STRING_32} "ERROR: Cannot start %"" + l_launched_command + "%".")
			end

				-- Restore original code page in case it has been changed.
			{WEL_API}.set_console_input_code_page (input_code_page).do_nothing
			{WEL_API}.set_console_output_code_page (output_code_page).do_nothing
		end

feature {NONE} -- Translation

	compute_number_of_cpu (a_result: TYPED_POINTER [INTEGER])
			-- Number of CPUs.
		external
			"C inline use <windows.h>"
		alias
			"[
				{
					SYSTEM_INFO SysInfo;
					ZeroMemory (&SysInfo, sizeof (SYSTEM_INFO));
					GetSystemInfo (&SysInfo);
					*(EIF_INTEGER *) $a_result = SysInfo.dwNumberOfProcessors;
				}
			]"
		end

	check_for_il
			-- Read content of first Ace file
		do
			open_files (".")
			if has_makefile_sh then
				makefile_sh.read_stream (makefile_sh.count)
				is_il_code := makefile_sh.last_string.substring_index ("$(IL_SYSTEM)", 1) > 0
				close_files
			else
				is_il_code := True
			end
		end

	translate_makefile  (master: BOOLEAN; directory: READABLE_STRING_GENERAL)
			-- Translate the Makefile.SH in the specified `directory'.
			-- Apply special rules to the top-level makefile flagged by `master'.
		do
			debug ("progress")
				io.put_string ("Translate makefile")
				if master then
					io.put_string (" (master)")
				end
				io.put_new_line
			end

			open_files (directory)

			if has_makefile_sh then
				check
					makefile_sh_exists: makefile_sh /= Void
					makefile /= Void
				end

				if not makefile_sh.end_of_file then
					read_next

					translate_case
					translate_case
					translate_echo
					translate_spit (True, Void)

					if master then
						translate_master
						translate_spit (False, options.get_string ("no_subs"))
					else
						translate_spit (False, Void)
					end
				else
					io.error.put_string ("WARNING: Makefile.SH is empty.%N")
				end

				close_files
			end
		end

	translate_sub_makefiles
			-- Translate makefiles in subdirs from master makefile.
		local
			dir: STRING -- the directory we're working on
			old_dir: STRING -- the previous directory
		do
			debug ("progress")
				io.put_string ("Translate sub makefiles%N")
			end

			old_dir := ""
			across
				dependent_directories as d
			loop
				dir := d.item.directory

				if not dir.is_equal(old_dir) then
					debug ("progress")
						io.put_string ("%TTranslating Makefile.SH in directory ")
						io.put_string (dir)
						io.put_string (".%N")
					end
					translate_makefile (False, dir)
					old_dir := dir.twin
				end
			end
		end

	translate_case
			-- translate case section by ignoring it.
		local
			lastline: STRING
		do
			debug ("progress")
				io.put_string ("Translate case%N")
			end

			lastline := makefile_sh.last_string.twin

			debug ("translate_case")
				debug ("input")
					io.put_string ("IN: ")
					io.put_string (lastline)
					io.put_new_line
				end
			end

			check
				lastline.substring (1,4).is_equal ("case")
			end

			from
			until
				makefile_sh.end_of_file or else lastline.count > 3 and then lastline.substring (1,4).is_equal ("esac")
			loop
				read_next
				lastline := makefile_sh.last_string.twin

				debug ("translate_case")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end
			end

			read_next
		end

	translate_echo
			-- Translate echo section by ignoring it.
		local
			lastline: STRING
		do
			debug ("progress")
				io.put_string ("Translate echo%N")
			end

			lastline := makefile_sh.last_string.twin

			debug ("translate_echo")
				debug ("input")
					io.put_string ("IN: ")
					io.put_string (lastline)
					io.put_new_line
				end
			end

			check
				lastline.substring (1,4).is_equal ("echo")
			end

			read_next
		end

	translate_spit  (do_subst: BOOLEAN; endtag: detachable STRING)
			-- Translate spitshell section
			-- 	do_subst: should substitutions be carried out?
			--	endtag: up to where we should read.
		local
			lastline: STRING
			strpos: INTEGER -- where we are in the string
			tag: STRING -- read until we encounter this tag
		do
			debug ("progress")
				io.put_string ("Translate spit%N")
			end

			if not makefile_sh.end_of_file then
				lastline := makefile_sh.last_string.twin

				check
					endtag = Void implies lastline.substring (1,10).is_equal ("$spitshell")
				end

					-- look for ending tag
				if endtag = Void then
					strpos := lastline.substring_index ("<<", 1)

					if lastline.item (strpos+2) = ''' then
						tag := lastline.substring (strpos+3, lastline.index_of (''', strpos+3)-1)
					else
						tag := lastline.substring (strpos+2, lastline.count)
					end

					read_next
				else
					tag := endtag
				end

				-- translate all lines in spit section
				from
				until
					makefile_sh.end_of_file or else lastline.is_equal (tag)
				loop
					if do_subst then
						translate_line_subst
					else
						if not lastline.is_empty then
							translate_line_change
						else
							put_new_line
						end
					end

					read_next
					lastline := makefile_sh.last_string.twin
				end
			end

			read_next
		end

	translate_master
			-- Translate master Makefile.SH.
		do
			debug ("progress")
				io.put_string ("Translate master%N")
			end

			translate_translate
			translate_externals
			translate_application
			if not is_il_code then
				translate_dependencies
			end
		end

	translate_translate
			-- Translate.
		local
			lastline: STRING
		do
			debug ("progress")
				io.put_string ("%Ttranslate%N")
			end

			from
				read_next
				lastline := makefile_sh.last_string.twin
			until
				lastline ~ options.get_string ("externals_continuation_text") or else
				lastline.count>4 and then lastline.substring (1,4).is_equal (options.get_string_or_default ("all", empty_string).substring (1,4)) or else
				makefile_sh.end_of_file
			loop
				debug ("translate_translate")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				if not lastline.is_empty then
					subst_continuation (lastline)
					subst_eiffel (lastline)
					subst_platform (lastline)
					subst_compiler (lastline)
					subst_dir_sep (lastline)

					lastline.replace_substring_all ("$ (CC) $ (CFLAGS) -c", options.get_string_or_default ("cc_text", empty_string))
					lastline.replace_substring_all (".c.o:", options.get_string_or_default ("cobj_text", empty_string))
					lastline.replace_substring_all (".cpp.o:", options.get_string_or_default ("cppobj_text", empty_string))
					if lastline.count>4 and then lastline.substring (1,5).is_equal (".x.o:") then
						lastline.replace_substring_all (".x.o:", options.get_string_or_default ("xobj_text", empty_string))
					end
					if lastline.count>6 and then lastline.substring (1,7).is_equal (".xpp.o:") then
						lastline.replace_substring_all (".xpp.o:", options.get_string_or_default ("xppobj_text", empty_string))
					end

					if lastline.substring_index (".SUFFIXES", 1) /= 0 then
						lastline.replace_substring_all (".o", options.get_string_or_default ("obj_text", ".obj"))
					end
				end

				debug ("translate_translate")
					debug ("output")
						io.put_string ("OUT: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				put_string (lastline)
				put_new_line

				read_next
				lastline := makefile_sh.last_string
			end
		end

	translate_externals
			-- Translate externals section.
		local
			lastline: STRING
		do
			debug ("progress")
				io.put_string ("%Texternals%N")
			end

			lastline := makefile_sh.last_string.twin

			if lastline.count>8 and then lastline.substring (1, 9) ~ options.get_string ("externals_text") then
				externals := True
			end

			from
               until
				lastline.is_empty or makefile_sh.end_of_file or not externals
			loop
				debug ("translate_externals")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				subst_continuation (lastline)
				subst_eiffel (lastline)
				subst_platform (lastline)
				subst_compiler (lastline)
				search_and_replace (lastline)
				subst_dir_sep (lastline)

				debug ("translate_externals")
					debug ("output")
						io.put_string ("OUT: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				put_string (lastline.out)
				put_new_line

				read_next
				lastline := makefile_sh.last_string.twin
			end

			if not makefile_sh.end_of_file and externals then
				put_new_line
				read_next
			end
		end

	translate_application
			-- Translate application section.
		local
			lastline: STRING
			appl_exe: STRING -- the executable for the application
			shared_library_pos: INTEGER
		do
			debug ("translate_application")
				io.put_string ("%Tapplication%N")
			end

			lastline := makefile_sh.last_string.twin

			debug ("translate_application")
				debug ("input")
					io.put_string ("IN: ")
					io.put_string (lastline)
					io.put_new_line
				end
			end

			if
				lastline.count>3 and then
				lastline.substring (1,4).is_equal (options.get_string_or_default ("all", empty_string).substring (1,4))
			then
				shared_library_pos := lastline.substring_index ("$(SYSTEM", 6)
				if shared_library_pos = 0 then
					appl := lastline.substring (6, lastline.count)
				else
					appl := lastline.substring (6, shared_library_pos - 1)
				end
				appl.right_adjust

				if appl.substring_index (options.get_string_or_default ("driver_text", empty_string),1) > 0 then
					precompile := True
					appl_exe := options.get_string_or_default ("driver_filename", empty_string)
				else
					appl_exe := appl.twin
					appl_exe.append_string (options.get_string ("executable_file_ext"))
				end
			else
				appl_exe := ""
			end

			if not is_il_code then
				read_next
				read_next

				put_string (options.get_string_or_default ("all", empty_string))
				put_string (appl_exe)

				if shared_library_pos /= 0 then
					put_string (" $(SYSTEM_IN_DYNAMIC_LIB)")
				end

				put_new_line
				put_string (options.get_string_or_default ("completed", empty_string))
				put_string ("%N%N")
			end
		end

	translate_dependencies
			-- Translate dependencies section.
		local
			lastline: STRING
			dir_sep_pos: INTEGER -- the position of the directory separator
			dir: STRING -- the directory
			filename: STRING -- the filename of the sub makefile
			is_E1_makefile, is_E1_structure, is_E1_offsets: BOOLEAN
			min: INTEGER
			dependency: STRING
			l_target_file: STRING
			l_precomps: STRING
		do
			debug ("progress")
				io.put_string ("%Tdependencies%N")
			end

			from
				lastline := makefile_sh.last_string.twin
			until
				lastline.count > ("OBJECTS=").count and then lastline.substring (1, ("OBJECTS=").count).is_equal ("OBJECTS=") or else
				makefile_sh.end_of_file
			loop
				debug ("translate_dependencies")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				is_E1_makefile := False
				is_E1_structure := False
				is_E1_offsets := False

				-- get directory name and filename
				dir_sep_pos := lastline.index_of (directory_separator.item (1), 1)
				if dir_sep_pos = 0 then
					dir_sep_pos := lastline.index_of ('/', 1)
				end

				dir := lastline.substring (1, dir_sep_pos-1)
				min := (lastline.index_of ('.', 1) - 1).min (lastline.index_of (':', 1) - 1)
				filename := lastline.substring (dir_sep_pos+1, min)
				dependency := lastline.substring (lastline.index_of (':', 1) + 1, lastline.count)
				subst_dir_sep (dependency)

				if filename ~ options.get_string ("emain_text") then
					filename.append (options.get_string_or_default ("obj_text", ".obj"))
					put_string (dir)
					put_string (directory_separator)
					subst_dir_sep (dependency)
					put_string (options.get_string_or_default ("emain_obj_text", empty_string))
					put_string (": ")
					put_string (dependency)
					put_new_line
					read_next
					lastline := makefile_sh.last_string.twin
					subst_dir_sep (lastline)
					put_string (lastline)
					put_new_line
				elseif filename.is_equal ("Makefile") and then dir.is_equal ("E1") then
					is_E1_makefile := True
				elseif filename.is_equal ("estructure") and then dir.is_equal ("E1") then
					is_E1_structure := True
				elseif filename.is_equal ("eoffsets") and then dir.is_equal ("E1") then
					is_E1_offsets := True
				else
					l_target_file := dir + directory_separator
						-- Last check on filename is to know if we are handling the old code
						-- generation where all objects file of E1 where in Eobj1 or if we do
						-- on a per object file.
					if dir.item (1) = 'E' and dir.item (2) = '1' and filename.item (1) /= 'E' then
						filename.append (options.get_string_or_default ("obj_text", ".obj"))
					else
						filename.append_character ('.')
						filename.append (options.get_string_or_default ("intermediate_file_ext", empty_string))
					end
					l_target_file.append (filename)
					if dir.item (1) = 'E' then
						system_dependent_directories.put_front ([dir, l_target_file])
					else
						object_dependent_directories.put_front ([dir, l_target_file])
					end
					dependent_directories.put_right ([dir, l_target_file])

					put_string (l_target_file)
					put_string (":")
					put_string (dependency)
					put_new_line
				end

				if is_E1_makefile then
					read_next
				elseif is_E1_structure or is_E1_offsets then
					subst_dir_sep (lastline)
					put_string (lastline)
					put_new_line
					read_next
					lastline := makefile_sh.last_string.twin
					subst_dir_sep (lastline)
					put_string (lastline)
					put_new_line
					put_new_line
				else
					put_string ("%T")
					put_string (options.get_string_or_default ("cd", empty_string))
					put_string (" ")
					put_string (dir)
					put_string (options.get_string_or_default ("subcommand_separator", " && "))
					put_string ("$(START_TEST) $(MAKE) ")
					put_string (filename)
					put_string (" $(END_TEST)")
					put_string (options.get_string_or_default ("subcommand_separator", " && "))
					put_string (options.get_string_or_default ("cd", empty_string))
					put_string (" ")
					put_string (options.get_string_or_default ("updir", empty_string))

					read_next

					put_string ("%N%N")
				end

				read_next
				read_next
				lastline := makefile_sh.last_string.twin
			end

			read_next -- On windows, we skip the OBJECTS=..., it is done after
			--read_next

				-- Generate the `OBJECTS = ' line
			put_string (options.get_string_or_default ("objects_text", empty_string))
			across
				dependent_directories as d
			loop
				put_string (d.item.file)
				put_character (' ')
			end

				-- Generate the `x_OBJECTS = ' lines
			put_string ("%N%N")
			put_string (options.get_string_or_default ("c_objects_text", empty_string))
			across
				object_dependent_directories as d
			loop
				put_string (d.item.file)
				put_character (' ')
			end
			if object_dependent_directories.is_empty then
				put_string (" %"%" %N")
			end

			put_string ("%N%N")
			put_string (options.get_string_or_default ("eobjects_text", empty_string))
			across
				system_dependent_directories as d
			loop
				put_string (d.item.file)
				put_character (' ')
			end

			put_string ("%N%N")

			from
				lastline := makefile_sh.last_string.twin
			until
				lastline.count > ("PRECOMP_OBJECTS=").count and then
				lastline.substring (1, ("PRECOMP_OBJECTS=").count).is_equal ("PRECOMP_OBJECTS=") or else
				makefile_sh.end_of_file
			loop
				read_next
				lastline := makefile_sh.last_string.twin
			end
			l_precomps := get_precompile_libs (lastline)
			put_string (l_precomps)
			put_new_line
		end

	translate_line_subst
			-- Translate a line requiring substitution.
		local
			lastline: STRING
			runtime: STRING
			i, j: INTEGER
		do
			debug ("progress")
				io.put_string ("%Tsubst%N")
			end
			lastline := makefile_sh.last_string.twin

			debug ("translate_line_subst")
				debug ("input")
					io.put_string ("IN: ")
					io.put_string (lastline)
					io.put_new_line
				end
			end

			-- adapt RM and MAKE lines for further usage
			if lastline.count>3 then
				if lastline.substring (1,4) ~ (options.get_string ("rm_text")) then
					lastline := "RM = $rm"
				end

				if lastline.substring (1,4) ~ (options.get_string ("make_text")) then
					lastline := "MAKE = $make"
				end

				if lastline.substring (1, 11).is_equal ("EIFLIB = -L") then
						-- Using a shared library, we have to replace `lastline' for proper translation
					create runtime.make (256)
					runtime.append (lastline.substring (1, 9))
					i := 13
					j := lastline.substring_index ("-l", i)
					runtime.append (lastline.substring (i, j - 3))
					runtime.append ("$shared_prefix")
					i := lastline.substring_index ("eiflib", j)
					runtime.append (lastline.substring (j + 2, i + 5))
					runtime.append ("$shared_rt_suffix")
					runtime.append (lastline.substring (i + 7, lastline.count))
					lastline := runtime
				end
			end

			search_and_replace (lastline)
			subst_dir_sep (lastline)

			debug ("translate_line_subst")
				debug ("output")
					io.put_string ("OUT: ")
					io.put_string (lastline)
					io.put_new_line
				end
			end

			put_string (lastline)
			put_new_line
		end

	translate_line_change
			-- Translate a line requiring changes.
		local
			lastline: STRING
			replacement: STRING -- what to replace with
		do
			debug ("progress")
				io.put_string ("%Tchange%N")
			end

			lastline := makefile_sh.last_string.twin

			debug ("translate_line_change")
				debug ("input")
					io.put_string ("IN: ")
					io.put_string (lastline)
					io.put_new_line
				end
			end

			if lastline.count > 4 and then lastline.substring_index (options.get_string_or_default ("all", empty_string).substring (1, 4), 1) > 0 then
				subst_intermediate (lastline)
			end

			subst_continuation (lastline)

			-- replace all occurrences of certain strings
			lastline.replace_substring_all ("$ (CC) $ (CFLAGS) -c", options.get_string_or_default ("cc_text", empty_string))
			lastline.replace_substring_all (".c.o:", options.get_string_or_default ("cobj_text", empty_string))
			lastline.replace_substring_all (".cpp.o:", options.get_string_or_default ("cppobj_text", empty_string))
			lastline.replace_substring_all (".o ", options.get_string_or_default ("obj_text", empty_string))
			if lastline.substring_index (".SUFFIXES", 1) /= 0 then
				lastline.replace_substring_all (".o", options.get_string_or_default ("obj_text", ".obj"))
			end

			-- replace .o:
			replacement := options.get_string_or_default ("intermediate_file_ext", empty_string).twin
			replacement.prepend (".")
			replacement.append (": $")
			lastline.replace_substring_all (".o: $", replacement)

			subst_eiffel (lastline)
			subst_platform (lastline)
			subst_compiler (lastline)
			subst_dir_sep (lastline)

			-- intermediate files
			if lastline.count>8 and then lastline.substring_index ("$(CREATE_TEST)", 1) >0 then
				lastline := ""
			end
			if lastline.count>8 and then lastline.substring_index ("$(LD) $(LDFLAGS) -r -o", 1) >0 then
				lastline := options.get_string_or_default ("make_intermediate", empty_string).twin
				subst_eiffel (lastline)
				subst_platform (lastline)

				debug ("translate_line_change")
					debug ("input")
						io.put_string ("CHANGE: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end
			end


			-- externals
			if lastline.count>8 and then lastline.substring (1,9) ~ options.get_string ("externals_text") then
				externals := True
			end
			-- .x.o
			if lastline.count>4 and then lastline.substring (1,5).is_equal (".x.o:") then
				lastline.replace_substring_all (".x.o:", options.get_string_or_default ("xobj_text", empty_string))
			end

			-- .xpp.o
			if lastline.count>6 and then lastline.substring (1,7).is_equal (".xpp.o:") then
				lastline.replace_substring_all (".xpp.o:", options.get_string_or_default ("xppobj_text", empty_string))
			end

			-- application name, cecil
			if
				not is_il_code and then appl /= Void and then
				lastline.count>=appl.count and then
				lastline.substring (1, appl.count).is_equal (appl)
			then
				translate_appl
			elseif
				lastline.count>14 and then lastline.substring (1,14).is_equal ("STATIC_CECIL =")
			then
				translate_cecil_and_dll
			elseif
				is_il_code and then
				lastline.count = 27 and then
				lastline.substring (1, 27).is_equal ("$il_system_compilation_line")
			then
					-- Add resource file dependency for IL system
				replacement := options.get_string_or_default ("il_system_compilation_line", "")
				subst_eiffel (replacement)
				subst_platform (replacement)
				subst_compiler (replacement)
				put_string (replacement)
			else
				debug ("translate_line_change")
					debug ("output")
						io.put_string ("OUT: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				put_string (lastline)
			end

			put_new_line
		end

	translate_appl
			-- Translate application generation code.
		local
			lastline: STRING
		do
			debug ("progress")
				io.put_string ("%Tappl%N")
			end

			lastline := makefile_sh.last_string.twin

			debug ("translate_appl")
				debug ("input")
					io.put_string ("IN: ")
					io.put_string (lastline)
					io.put_new_line
				end
			end

			-- precompile or make application?
			if precompile then
				lastline := options.get_string_or_default ("precompile", empty_string).twin
			else
				lastline := options.get_string_or_default ("appl_make", empty_string).twin
			end

			debug ("translate_appl")
				debug ("input")
					io.put_string ("IN: ")
					io.put_string (lastline)
					io.put_new_line
				end
			end

			lastline.replace_substring_all ("$appl", appl)
			subst_objects_redirection (lastline)

			if options.has ("sharedlibs") and then attached options.get_string ("sharedlibs") as l_sharedlibs then
				lastline.replace_substring_all ("$sharedlibs", l_sharedlibs)
			else
				lastline.replace_substring_all ("$sharedlibs", "$(SHAREDLIBS)")
			end

			subst_eiffel (lastline)
			subst_platform (lastline)
			subst_compiler (lastline)

			if not externals then
				lastline.replace_substring_all ("$(EXTERNALS)", "")
			end

			debug ("translate_appl")
				debug ("output")
					io.put_string ("OUT: ")
					io.put_string (lastline)
					io.put_new_line
				end
			end

			put_string (lastline)

				-- Get rid of what comes after the application rule.
			from
			until
				lastline.is_empty
			loop
				read_next
				lastline := makefile_sh.last_string
			end
		end

	translate_cecil_and_dll
			-- Translate cecil.
		local
			lastline, previous_line: detachable STRING
		do
			debug ("progress")
				io.put_string ("%Tcecil%N")
			end

			put_string ("%N#STATIC_CECIL PART%N")

			lastline := makefile_sh.last_string.twin
			lastline.replace_substring_all (".a", lib_extension)
			put_string (lastline)
			put_new_line

			read_next
			put_string (makefile_sh.last_string)
			put_new_line

			if options.has ("cecil_make") and then attached options.get_string ("cecil_make") as l_cecil_make then
				lastline := l_cecil_make.twin
			else
				lastline := options.get_string_or_default ("cecil_text", empty_string).twin
			end

			debug ("translate_cecil_and_dll")
				debug ("input")
					io.put_string ("IN: ")
					io.put_string (lastline)
					io.put_new_line
				end
			end

			lastline.replace_substring_all ("$appl", appl)
			subst_eiffel (lastline)

			debug ("translate_cecil_and_dll")
				debug ("output")
					io.put_string ("OUT: ")
					io.put_string (lastline)
					io.put_new_line
				end
			end

			put_string (lastline)
			put_new_line


			read_next
			lastline := makefile_sh.last_string.twin
			from
			until
				lastline.count>14 and then lastline.substring (1,14).is_equal ("SHARED_CECIL =")
			loop
				read_next
				lastline := makefile_sh.last_string.twin
			end

			put_new_line
			put_new_line

			put_string ("%N#SHARED_CECIL PART%N")
			put_string (lastline)
			put_new_line
			read_next
			put_string (makefile_sh.last_string)
			put_new_line

-- DEF_FILE= appl.def
			if options.has ("cecil_def") then
				lastline := options.get_string_or_default ("cecil_def", empty_string).twin
				lastline.replace_substring_all ("$appl", appl)
				subst_eiffel (lastline)
				subst_platform (lastline)
				put_string (lastline)
			end
			put_new_line

				-- dynamic_cecil: $(SHARED_CECIL)
			put_new_line
			read_next
			put_string (makefile_sh.last_string)
			put_new_line

			from
			until
				lastline.count = 12 and then lastline.substring (3,12).is_equal ("E1/emain.o")
			loop
				read_next
				lastline := makefile_sh.last_string.twin
			end

				-- SHARED_CECIL_OBJECT
			lastline.replace_substring_all (".o", object_extension)
			put_string (lastline)
			put_new_line
			read_next
			put_string ("SHAREDFLAGS = $(LDSHAREDFLAGS)")

				-- SHAREDFLAGS
			if options.has ("cecil_dynlib") then
				put_string (" \%N")
				lastline := options.get_string_or_default ("cecil_dynlib", empty_string).twin
				lastline.replace_substring_all ("$appl", appl)
				subst_eiffel (lastline)
				subst_platform (lastline)
				subst_compiler (lastline)
				put_string (lastline)
				put_new_line
			else
				put_new_line
			end

				-- SHARED_CECIL
			read_next
			put_string (makefile_sh.last_string)
			put_string (" $(DEF_FILE)")
			put_new_line

				-- $(RM) "$(SHARD_CECIL)"
			read_next
			lastline := options.get_string_or_default ("safe_rm", "").twin
			lastline.replace_substring_all ("@", "$(SHARED_CECIL)")
			lastline.precede ('%T')
			put_string (lastline)
			put_new_line

				-- $(SHAREDLINK) $(SHAREDFLAGS) $(SHARED_CECIL_OBJECT) $(SHAREDLIBS)
			read_next
			put_string (makefile_sh.last_string)
			put_new_line

				-------------------------------------------------
				-- Search the beginning of the SYSTEM_IN_DYNAMIC_LIB part
			read_next
			lastline := makefile_sh.last_string.twin
			from
			until
				lastline.count>7 and then lastline.substring (1,7).is_equal ("dynlib:")
			loop
				read_next
				lastline := makefile_sh.last_string.twin
			end

			put_string ("%N#SYSTEM_IN_DYNAMIC_LIB PART%N%N")

				-- DEF_FILE= appl.def
			put_string ("DEF_FILE= ")
			put_string (appl)
			put_string (".def")
			put_new_line

				-- dynlib: $(SYSTEM_IN_DYNAMIC_LIB)
			put_string (makefile_sh.last_string)
			put_new_line

				-- egc_dynlib.obj
			read_next
			lastline := makefile_sh.last_string.twin
			lastline.replace_substring_all (".o", object_extension)
			subst_eiffel (lastline)
			subst_platform (lastline)
			subst_compiler (lastline)
			subst_dir_sep (lastline)
			put_string (lastline)
			put_new_line

			read_next -- $(MV) $(ISE_EIFFEL....
			lastline := makefile_sh.last_string.twin
			subst_eiffel (lastline)
			subst_platform (lastline)
			subst_compiler (lastline)
			subst_dir_sep (lastline)
			put_string (lastline)
			put_new_line

			read_next -- cd E1 ; $(MAKE) ....
			lastline := makefile_sh.last_string.twin
			lastline.replace_substring_all (".o", object_extension)
			lastline.replace_substring_all (" ; ", options.get_string_or_default ("subcommand_separator", " && "))
			put_string (lastline)
			put_new_line

				-- edynlib.obj
			read_next
			lastline := makefile_sh.last_string.twin
			lastline.replace_substring_all (".o", object_extension)
			subst_dir_sep (lastline)
			put_string (lastline)
			put_new_line

			read_next -- cd E1 ; $(MAKE) ...
			lastline := makefile_sh.last_string.twin
			lastline.replace_substring_all (".o", object_extension)
			lastline.replace_substring_all (" ; ", options.get_string_or_default ("subcommand_separator", " && "))
			put_string (lastline)
			put_new_line

				-- SYSTEM_IN_DYNAMIC_LIB_OBJ
			read_next
			put_new_line
			read_next
			put_string (makefile_sh.last_string)
			put_new_line

			from
				previous_line := ""
			until
				lastline.count > 17 and then lastline.substring (1,17).is_equal ("DYNLIBSHAREDFLAGS")
			loop
				read_next
				previous_line := lastline
				lastline := makefile_sh.last_string.twin
			end

			previous_line.replace_substring_all (".o", object_extension)
			subst_dir_sep (previous_line)
			put_string (previous_line)
			put_new_line

				-- DYNLIBSHAREDFLAGS
			put_string ("DYNLIBSHAREDFLAGS = $(LDSHAREDFLAGS)")
			if options.has ("system_dynlib") then
				put_string (" \%N")
				lastline := options.get_string_or_default ("system_dynlib", empty_string).twin
				lastline.replace_substring_all ("$appl", appl)
				subst_eiffel (lastline)
				subst_platform (lastline)
				subst_compiler (lastline)
				put_string (lastline)
				put_new_line
			else
				put_new_line
			end

-- SYSTEM_IN_DYNAMIC_LIB
			read_next
			put_string (makefile_sh.last_string)
			put_string (" $(DEF_FILE)")
			put_new_line

-- $(RM) "$(SYSTEM_IN_DYNAMIC_LIB)"
			read_next
			lastline := options.get_string_or_default ("safe_rm", "").twin
			lastline.replace_substring_all ("@", "$(SYSTEM_IN_DYNAMIC_LIB)")
			lastline.precede ('%T')
			put_string (lastline)
			put_new_line

-- $(SHAREDLINK) $(DYNLIBSHAREDFLAGS) $(SYSTEM_IN_DYNAMIC_LIB_OBJ) $(SHAREDLIBS)
			read_next
			put_string (makefile_sh.last_string)
			put_new_line
	end

feature {NONE}	-- substitutions

	subst_eiffel (line: STRING)
			-- Replace all occurrences of `Eiffel_dir' environment variable in `line'
		local
			l_eiffel_dir: STRING
			u: UTF_CONVERTER
		do
			debug ("subst")
				io.put_string("%Tsubst_eiffel%N")
			end

			if eiffel_layout.is_valid_environment then
				l_eiffel_dir := u.string_32_to_utf_8_string_8 (eiffel_layout.shared_path.name)
			else
				l_eiffel_dir := empty_string
			end

			if not l_eiffel_dir.is_empty then
				line.replace_substring_all ("$(ISE_EIFFEL)", l_eiffel_dir)
				line.replace_substring_all ("$(EIFFEL4)", l_eiffel_dir)
			end
		end

	subst_objects_redirection (line: STRING)
			-- Replace all occurrences of $objects_redirection with list of objects
		local
			l_string: STRING
			i: INTEGER
			l_new_line_inserted: BOOLEAN
		do
			if line.substring_index ("$objects_redirection", 1) > 0 then
				across
					dependent_directories as d
				from
					create l_string.make (dependent_directories.count * 10)
					i := 0
				loop
					if i \\ 5 = 0 then
						l_string.append_string ("%Techo ")
						l_new_line_inserted := True
					end
					l_string.append (d.item.file)
					l_string.append_character (' ')
					if (i + 1) \\ 5 = 0 then
						l_string.append (" >> $@ %N")
						l_new_line_inserted := False
					end
					i := i + 1
				end
				if l_new_line_inserted then
					l_string.append (" >> $@ %N")
				end
				line.replace_substring_all ("$objects_redirection", l_string)
			end
		end

	subst_platform (line: STRING)
			-- Replace all occurrences of platform environment variable in `line'
		do
			debug ("subst")
				io.put_string("%Tsubst_platform%N")
			end

			line.replace_substring_all ("$(ISE_PLATFORM)", eiffel_layout.eiffel_platform)
		end

	subst_compiler (line: STRING)
			-- Replace all occurrences of compiler environment variable in `line'
		do
			debug ("subst")
				io.put_string("%Tsubst_compiler%N")
			end

			if {PLATFORM}.is_windows then
				line.replace_substring_all ("$(ISE_C_COMPILER)", eiffel_layout.eiffel_c_compiler)
			end
		end

	subst_dir_sep  (line: STRING)
			-- replace all occurrences of the directory separator in `line'
		local
			dir_sep: STRING
		do
			debug ("subst")
				io.put_string("%Tsubst_dir_sep%N")
			end

			dir_sep := ""
			dir_sep.append (directory_separator)

			if not line.is_empty then
				line.replace_substring_all ("/", dir_sep)
			end
		end

	subst_continuation  (line: STRING)
			-- replace all occurrences of the line continuation character in `line'
		do
			debug ("subst")
				io.put_string("%Tsubst_continuation%N")
			end

			if
				not line.is_empty and then line.item (line.count) = '\' and then
				options.has ("continuation")
			then
				line.remove (line.count)
				line.append_string (options.get_string ("continuation"))
			end
		end

	subst_intermediate (line: STRING)
			-- replace all occurrences of ?obj#.obj with ?obj#.lib in `line' starting with "all"
		local
			start: INTEGER
		do
			debug ("subst")
				io.put_string("%Tsubst_intermediate%N")
			end

			check
				line.count > 4 and then line.substring_index(options.get_string_or_default ("all", empty_string).substring (1, 4), 1) > 0
			end

			line.replace_substring_all (options.get_string_or_default ("all", empty_string).substring (1, 4), options.get_string_or_default ("all", empty_string))
			line.replace_substring_all (".o", lib_extension)

			start := 1

			if line.substring_index (options.get_string_or_default ("emain_text", empty_string), start) > 0 then
				start := line.substring_index (options.get_string_or_default ("intermediate_file_ext", empty_string), start)
				check
					start > 0
				end
				line.replace_substring (options.get_string_or_default ("obj_file_ext", empty_string), start, start+2)
			end
		end

feature {NONE} -- Implementation

	env: EXECUTION_ENVIRONMENT
			-- Execution environment
		once
			 create Result
		end

	missing_options: ARRAYED_LIST [STRING]
			-- Options that cannot be found anywhere

	search_and_replace (line: STRING)
			-- search words starting with $ and replace with option or env variable
		local
			wordstart: INTEGER
			wordlength: INTEGER
			word: STRING
			replacement: detachable STRING
		do
			debug ("implementation")
				io.put_string("%Tsearch_and_replace%N")
			end

			from
				if not line.is_empty then
					wordstart := line.index_of ('$', 1)
				else
					wordstart := 0
				end
			until
				wordstart = 0
			loop
				word := get_word_to_replace (line, wordstart)
				wordlength := word.count

				strip_parenthesis (word)
				word.to_lower
				replacement := get_replacement (word)

				if replacement /= Void then
					if
						wordstart > 2 and then line.item (wordstart-1) = '\' and then
						(line.item (wordstart-2) = '/' or
						line.item(wordstart-2) = '\' or
						line.item(wordstart-2) = ' ' or
						line.item(wordstart-2) = '"' or
						(line.item (wordstart-2) = 'I' and then line.item (wordstart-3) = '-'))
					then
						line.replace_substring (replacement, wordstart-1, wordstart+wordlength)
					else
						line.replace_substring (replacement, wordstart, wordstart+wordlength)
					end

					wordstart := wordstart + replacement.count - 2
				elseif word.substring(1,18).is_equal("external_makefiles") then
					-- $EXTERNAL_MAKEFILES must not be replaced.
				elseif not missing_options.has (word) then
					missing_options.extend (word)
					io.error.put_string ("WARNING: Option '")
					io.error.put_string (word)
					io.error.put_string ("' was found in neither CONFIG.EIF nor registry.")
					io.error.put_new_line
				end

				wordstart := wordstart + 1

				-- check for more words to replace
				if wordstart < line.count then
					wordstart := line.index_of ('$', wordstart)
				else
					wordstart := 0
				end
			end
		end

	get_word_to_replace (line: STRING; wordstart: INTEGER): STRING
			-- word on `line' starting with '$' after `wordstart'
		local
			wordend: INTEGER
		do
			debug ("implementation")
				io.put_string("%Tget_word_to_replace%N")
			end

			from
				wordend := wordstart + 1
				create Result.make (10)
			until
				wordend > line.count
				or else line.item (wordend) = ' '
				or line.item (wordend) = '/'
				or line.item (wordend) = '"'
				or line.item (wordend) = '\'
				or else line.item (wordend) = '%N'
				or else line.item (wordend) = '%T'
				or else line.item (wordend) = '$'
			loop
				Result.extend (line.item (wordend))
				wordend := wordend + 1
			end
		end

	get_replacement (word: STRING): detachable STRING
			-- find a replacement for `word' in options or environment
		local
			replacement: STRING
			u: UTF_CONVERTER
		do
			debug ("implementation")
				io.put_string("%Tget_replacement%N")
			end

			if ({PLATFORM_CONSTANTS}.is_64_bits and force_32bit) and then word.is_case_insensitive_equal (once "ISE_PLATFORM") then
					-- Replace ISE_PLAFORM to 32bit builds on x64 platforms
				Result := once "windows"
			else
				if options.has (word) and then attached options.get_string (word) as l_replacement then
					replacement := l_replacement.twin
					if not replacement.is_equal("$(INCLUDE_PATH)") then
						search_and_replace (replacement)
					end
					Result := replacement
				elseif attached eiffel_layout.get_environment_32 (word) as l_env then
						-- Note: Before we were taking the short path (rev#66961)
					Result := u.string_32_to_utf_8_string_8 (l_env)
				else
					Result := Void
				end
			end
		end

feature {NONE} -- Input/output

	makefile_content: STRING
			-- Content of a makefile.

	put_character (c: CHARACTER)
			-- Write `c' to `makefile'.
		do
			makefile_content.append_character (c)
			if c.natural_32_code > 127 then
				is_ascii := False
			end
		end

	put_string (s: STRING)
			-- Write `s' to `makefile'.
		local
			i: like {STRING}.count
		do
			makefile_content.append_string (s)
			if is_ascii then
				from
					i := s.count
				until
					i <= 0
				loop
					if s [i].natural_32_code > 127 then
						is_ascii := False
						i := 1
					end
					i := i - 1
				variant
					i + 1
				end
			end
		end

	put_new_line
			-- Write new line to `makefile'.
		do
			makefile_content.append_character ('%N')
		end

	read_next
			-- read the next line from Makefile.SH if possible
		do
			debug ("implementation")
				io.put_string("%Tread_next%N")
			end

			if not makefile_sh.end_of_file then
				makefile_sh.read_line
			end
		end

	get_precompile_libs (line_to_search: STRING): STRING
			-- look for precompiled libraries, also checks
			-- if application uses multithreading mechanism
		local
			line: STRING
			next_precomp_lib: STRING
			precomp_lib_start: INTEGER
			preobj: STRING
		once
			Result := ""
			preobj := "precomp.lib"

			debug ("implementation")
				io.put_string ("%Tget_precompile_libs%N")
			end

			line := line_to_search.twin

			from
				if not line.is_empty then
					precomp_lib_start :=  (line.substring_index (preobj, 1))
				end

				if precomp_lib_start > 0 then
					uses_precompiled := True
					Result.append (line.substring (1, precomp_lib_start - 2))
					Result.left_adjust
					Result.append (directory_separator)
					Result.append ("$(ISE_C_COMPILER)")
					Result.append (directory_separator)
						-- We always put a " since it is guaranteed that they have a " in the original
						-- Makefile.SH
					Result.append ("precomp.lib%"")
				else
					uses_precompiled := False
				end
			until
				makefile_sh.end_of_file or else line.is_empty
			loop
				read_next
				line := makefile_sh.last_string.twin

				debug ("implementation")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (line)
						io.put_new_line
					end
				end

				if not line.is_empty then
					precomp_lib_start := line.substring_index (preobj, 1)
				else
					precomp_lib_start := 0
				end

				if precomp_lib_start > 0 then
					uses_precompiled := True
					next_precomp_lib := line.substring (1, precomp_lib_start - 2)
					next_precomp_lib.left_adjust
					next_precomp_lib.append (directory_separator)
					next_precomp_lib.append ("$(ISE_C_COMPILER)")
					next_precomp_lib.append (directory_separator)
						-- We always put a " since it is guaranteed that they have a " in the original
						-- Makefile.SH
					next_precomp_lib.append ("precomp.lib%"")

					if not Result.is_empty then
						Result.append (" \%N%T")
					end
					Result.append (next_precomp_lib)
				end
			end

			search_and_replace (Result)
		end

	open_files (directory: READABLE_STRING_GENERAL)
			-- Open the Makefile.SH and the Makefile to translate in `directory'.
		local
			out_file, retried: BOOLEAN
			p: PATH
		do
			if not retried then
				out_file := False
				create p.make_from_string (directory)
				create makefile_sh.make_with_path (p.extended ("Makefile.SH"))
				if makefile_sh.exists then
					makefile_sh.open_read
					has_makefile_sh := True
					out_file := True
					create makefile.make_with_path (p.extended ("Makefile"))
					makefile.open_write
					is_ascii := True
					makefile_content := ""
				else
					has_makefile_sh := False
				end
			else
				has_makefile_sh := False
			end
		rescue
			if not out_file then
				io.error.put_string ("ERROR: Unable to open Makefile.SH for input%N")
			else
				io.error.put_string ("ERROR: Unable to open Makefile for output%N")
			end
			retried := True
			retry
		end

	close_files
			-- Close the Makefile.SH and the Makefile.
		do
			debug ("implementation")
				io.put_string("%Tclose_files%N")
			end

			if makefile_sh /= Void and then not makefile_sh.is_closed then
				makefile_sh.close
			end

			if makefile /= Void and then not Makefile.is_closed then
				if not is_ascii and then options.get_boolean ("makefile_bom", False) then
						-- Start makefile with a BOM.
					makefile.put_string ({UTF_CONVERTER}.utf_8_bom_to_string_8)
						-- Add code to generate BOM for linker.
					makefile_content.replace_substring_all ("$echo_link_bom", options.get_string_or_default ("echo_link_bom", ""))
				else
						-- Remove any BOM-specific code.
					makefile_content.replace_substring_all ("$echo_link_bom", "")
				end
				makefile.put_string (makefile_content)
				makefile.close
				makefile_content := ""
			end
		end

	strip_parenthesis  (word: STRING)
			-- remove enclosing parenthesis from word.
		do
			debug ("implementation")
				io.put_string("%Tstrip_parenthesis%N")
			end

			if word.item (1) = '(' then
				word.remove_head (1)
				if word.item (word.count) = ')' then
					word.remove_tail (1)
				end
			elseif word.item (1) = '{' then
				word.remove_head (1)
				if word.item (word.count) = '}' then
					word.remove_tail (1)
				end
			end
		end

	empty_string: STRING = ""
			-- Default value to use when option is not found.

invariant
	options_not_void: options /= Void
	empty_string_empty: empty_string.is_empty

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
