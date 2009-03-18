note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAKEFILE_TRANSLATOR

inherit
	ANY

	PATH_CONVERTER
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	PROCESS_FACTORY
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_options: like options; mapped_path: BOOLEAN; a_force_32bit: BOOLEAN; a_processor_count: NATURAL_8; a_output: like output)
			-- Initialize
		require
			a_options_not_void: a_options /= Void
		local
			l_c_setup: COMPILER_SETUP
		do
			options := a_options
			output := a_output

			create system_dependent_directories.make (5)
			create object_dependent_directories.make (50)
			create dependent_directories.make (55)
			force_32bit := a_force_32bit

			eiffel_dir := eiffel_layout.shared_path
			processor_count := a_processor_count

			uses_precompiled := False

			directory_separator := options.get_string_or_default ("directory_separator", "\")
			object_extension := options.get_string_or_default ("obj_file_ext", "obj").twin
			object_extension.prepend_character ('.')

			lib_extension := options.get_string_or_default ("intermediate_file_ext", "lib").twin
			lib_extension.prepend_character ('.')

			check_for_il
			quick_compilation := options.get_boolean ("quick_compilation", True)
			if quick_compilation and not is_il_code then
				output.put_string ("Prepring C compilation...%N")
				output.flush
				launch_quick_compilation
			end

				-- Initialize the C compiler environment.
			create l_c_setup.initialize (options, a_force_32bit)
		ensure
			processor_count_set: processor_count = a_processor_count
			force_32bit_set: force_32bit = a_force_32bit
		end

feature -- Quick compile

	launch_quick_compilation
			-- Launch the `quick_finalize' program with the correct options.
		local
			quick_prg: STRING
		do
			create quick_prg.make (35)
			quick_prg.append_character ('%"')
			quick_prg.append (eiffel_layout.Quick_finalize_command_name)
			quick_prg.append ("%" . ")
			quick_prg.append (options.get_string_or_default ("obj_file_ext", "obj"))

				-- On Windows, we need to surround the command with " since it is executed
				-- by COMSPEC.
			env.system ("%"" + quick_prg + "%"")
		end

feature -- Status report

	has_makefile_sh: BOOLEAN
			-- Did we find any Makefile.SH?

feature -- Access

	makefile_sh: detachable PLAIN_TEXT_FILE
			-- Makefile.SH to read from

	makefile: detachable PLAIN_TEXT_FILE
			-- Makefile to create

	options: RESOURCE_TABLE
			-- Options read from config.eif

	dependent_directories, system_dependent_directories,
	object_dependent_directories: ARRAYED_LIST [TUPLE [directory, file:STRING]]
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

	appl: detachable STRING
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

feature {NONE} -- Access

	output: FILE
			-- Access to the default output

feature -- Execution

	translate
			-- create Makefile from Makefile.SH and options
		do
			translate_makefile (True)
			translate_sub_makefiles
		end

	run_make
			-- run the make utility on the generated Makefile
		local
			command: STRING
			l_make_flags: STRING
			eiffel_make: STRING
			l_process: PROCESS
			l_success: BOOLEAN
			l_flags: LIST [STRING]
			l_file: RAW_FILE
		do
				-- the command to execute the make utility on this platform
			command := options.get_string_or_default ("make_utility", "")
			subst_eiffel (command)
			subst_platform (command)
			subst_compiler (command)
			l_make_flags := options.get_string_or_default ("make_flags", "")
			l_make_flags.left_adjust
			l_make_flags.right_adjust

				-- Launch building of `E1\estructure.h' and `E1\eoffsets.h' in case it is not built and we are not
				-- in .NET mode
			if not is_il_code then
				create l_file.make ("E1" + directory_separator + "estructure.x")
				if l_file.exists then
					l_flags := l_make_flags.split (' ')
					l_flags.extend ("E1" + directory_separator + "estructure.h")
					l_process := process_launcher (command, l_flags, Void)
					l_process.launch
					l_success := l_process.launched
					if l_success then
						l_process.wait_for_exit
					end
				end

				create l_file.make ("E1" + directory_separator + "eoffsets.x")
				if l_file.exists then
					l_flags := l_make_flags.split (' ')
					l_flags.extend ("E1" + directory_separator + "eoffsets.h")
					l_process := process_launcher (command, l_flags, Void)
					l_process.launch
					l_success := l_process.launched
					if l_success then
						l_process.wait_for_exit
					end
				end
			end

				-- Launch emake.
			create {ARRAYED_LIST [STRING]} l_flags.make (8)
			if processor_count > 0 then
				l_flags.extend ("-cpu")
				l_flags.extend (processor_count.out)
			end
			l_flags.extend ("-target")
			l_flags.extend (env.current_working_directory)
			l_flags.extend ("-make")
			l_flags.extend (command)
			if not l_make_flags.is_empty then
				l_flags.extend ("-make_flags")
				l_flags.extend (l_make_flags)
			end

			l_process := process_launcher (eiffel_layout.Emake_command_name, l_flags, Void)
			l_process.launch
			l_success := l_process.launched
			if l_success then
				l_process.wait_for_exit
			end
		end

feature {NONE} -- Translation

	check_for_il
			-- Read content of first Ace file
		local
			l_last_string: detachable STRING
		do
			open_files
			if has_makefile_sh and attached makefile_sh as l_file_sh then
				l_file_sh.read_stream (l_file_sh.count)
				l_last_string := l_file_sh.last_string
				check l_last_string_attached: l_last_string /= Void end
				is_il_code := l_last_string.substring_index ("$(IL_SYSTEM)", 1) > 0
				close_files
			else
				is_il_code := True
			end
		end

	translate_makefile  (master: BOOLEAN)
			-- translate the Makefile.SH in the current directory
			-- 	master: is this the master makefile (i.e. the one in the F/W_code directory)?
		require
			makefile_sh_attached: makefile_sh /= Void
			makefile_attached: makefile /= Void
		do
			debug ("progress")
				io.put_string ("Translate makefile")
				if master then
					io.put_string (" (master)")
				end
				io.put_new_line
			end

			open_files

			if has_makefile_sh and then attached makefile_sh as l_file_sh then
				if not l_file_sh.end_of_file then
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

			from
				dependent_directories.start
				old_dir := ""
			until
				dependent_directories.after
			loop
				dir := dependent_directories.item.directory

				if dir /~ old_dir then
					debug ("progress")
						io.put_string ("%TTranslating Makefile.SH in directory ")
						io.put_string (dir)
						io.put_string (".%N")
					end

					env.change_working_directory (dir)

					translate_makefile (False)

					env.change_working_directory (options.get_string_or_default ("updir", ".."))

					old_dir := dir.twin
				end

				dependent_directories.forth
			end
		end

	translate_case
			-- translate case section by ignoring it.
		require
			makefile_sh_attached: makefile_sh /= Void
			makefile_attached: makefile /= Void
			has_makefile_sh: has_makefile_sh
		local
			lastline: detachable STRING
		do
			debug ("progress")
				io.put_string ("Translate case%N")
			end

			if attached makefile_sh as l_file_sh and attached makefile as l_file then
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				lastline := lastline.twin

				debug ("translate_case")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				check
					lastline.substring (1,4) ~ once "case"
				end

				from
				until
					l_file_sh.end_of_file or else lastline.count > 3 and then lastline.substring (1,4) ~ once "esac"
				loop
					read_next
					lastline := l_file_sh.last_string
					check lastline_attached: lastline /= Void end
					lastline := lastline.twin

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
		end

	translate_echo
			-- Translate echo section by ignoring it.
		require
			makefile_sh_attached: makefile_sh /= Void
			has_makefile_sh: has_makefile_sh
		local
			lastline: detachable STRING
		do
			debug ("progress")
				io.put_string ("Translate echo%N")
			end

			if attached makefile_sh as l_file_sh then
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				lastline := lastline.twin

				debug ("translate_echo")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				check
					lastline.substring (1,4) ~ once "echo"
				end

				read_next
			end
		end

	translate_spit  (do_subst: BOOLEAN; endtag: detachable STRING)
			-- Translate spitshell section
			-- 	do_subst: should substitutions be carried out?
			--	endtag: up to where we should read.
		require
			makefile_sh_attached: makefile_sh /= Void
			makefile_attached: makefile /= Void
			has_makefile_sh: has_makefile_sh
		local
			lastline: detachable STRING
			strpos: INTEGER -- where we are in the string
			tag: STRING -- read until we encounter this tag
		do
			debug ("progress")
				io.put_string ("Translate spit%N")
			end

			if attached makefile_sh as l_file_sh and attached makefile as l_file then
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				lastline := lastline.twin

				check
					endtag = Void implies lastline.substring (1,10) ~ once "$spitshell"
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
					lastline = Void or else
					(l_file_sh.end_of_file or else lastline ~ tag)
				loop
					if do_subst then
						translate_line_subst
					else
						if not lastline.is_empty then
							translate_line_change
						else
							l_file.put_new_line
						end
					end

					read_next
					lastline := l_file_sh.last_string
				end

				read_next
			end
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
		require
			makefile_sh_attached: makefile_sh /= Void
			makefile_attached: makefile /= Void
			has_makefile_sh: has_makefile_sh
		local
			lastline: detachable STRING
		do
			debug ("progress")
				io.put_string ("%Ttranslate%N")
			end

			if attached makefile_sh as l_file_sh and attached makefile as l_file then
				from
					read_next
					lastline := l_file_sh.last_string
				until
					lastline = Void or else
					((lastline ~ options.get_string (once "externals_continuation_text")) or else
					lastline.count>4 and then (lastline.substring (1,4) ~ options.get_string_or_default (once "all", "").substring (1,4)))
				loop
					lastline := lastline.twin

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

						lastline.replace_substring_all ("$ (CC) $ (CFLAGS) -c", options.get_string_or_default ("cc_text", "Void"))
						lastline.replace_substring_all (".c.o:", options.get_string_or_default ("cobj_text", ""))
						lastline.replace_substring_all (".cpp.o:", options.get_string_or_default ("cppobj_text", ""))
						if lastline.count>4 and then lastline.substring (1,5) ~ ".x.o:" then
							lastline.replace_substring_all (".x.o:", options.get_string_or_default ("xobj_text", ""))
						end
						if lastline.count>6 and then lastline.substring (1,7) ~ ".xpp.o:" then
							lastline.replace_substring_all (".xpp.o:", options.get_string_or_default ("xppobj_text", ""))
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

					l_file.put_string (lastline)
					l_file.put_new_line

					read_next
					lastline := l_file_sh.last_string
				end
			end
		end

	translate_externals
			-- Translate externals section.
		require
			makefile_sh_attached: makefile_sh /= Void
			makefile_attached: makefile /= Void
			has_makefile_sh: has_makefile_sh
		local
			lastline: detachable STRING
		do
			debug ("progress")
				io.put_string ("%Texternals%N")
			end

			if attached makefile_sh as l_file_sh and attached makefile as l_file then
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end

				if lastline.count>8 and then lastline.substring (1, 9) ~ options.get_string ("externals_text") then
					externals := True
				end

				from
				until
					lastline = Void or else
					(lastline.is_empty or l_file_sh.end_of_file or not externals)
				loop
					lastline := lastline.twin

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

					l_file.put_string (lastline.out)
					l_file.put_new_line

					read_next
					lastline := l_file_sh.last_string
				end

				if not l_file_sh.end_of_file and externals then
					l_file.put_new_line
					read_next
				end
			end
		end

	translate_application
			-- Translate application section.
		require
			makefile_sh_attached: makefile_sh /= Void
		local
			lastline: detachable STRING
			extension: detachable STRING -- the extension of the filename (e.g. '.exe')
			appl_exe: detachable STRING -- the executable for the application
			appl_ext: detachable STRING
			shared_library_pos: INTEGER
		do
			debug ("translate_application")
				io.put_string ("%Tapplication%N")
			end
			if attached makefile_sh as l_file_sh then
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				lastline := lastline.twin

				debug ("translate_application")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				if
					lastline.count > 3 and then
					lastline.substring (1, 4) ~ options.get_string_or_default ("all", "").substring (1,4)
				then
					shared_library_pos := lastline.substring_index ("$(SYSTEM", 6)
					if shared_library_pos = 0 then
						appl_ext := lastline.substring (6, lastline.count)
					else
						appl_ext := lastline.substring (6, shared_library_pos - 1)
					end
					appl_ext.right_adjust

					if appl_ext.count>4 then
						extension := appl_ext.twin
						extension.to_lower
						extension.keep_tail (4)
						if extension ~ options.get_string ("executable_file_ext") then
							appl_ext := appl_ext.substring (1, appl_ext.count -4)
						end
					end

					if appl_ext.substring_index (options.get_string_or_default ("driver_text", ""), 1) > 0 then
						precompile := True
						appl_exe := options.get_string_or_default ("driver_filename", "")
					else
						appl_exe := appl_ext.twin
						appl_exe.append (options.get_string_or_default ("executable_file_ext", ""))
					end
					appl := appl_ext
				end

				if not is_il_code then
					read_next
					read_next

					if attached makefile as l_file then
						l_file.put_string (options.get_string_or_default ("all", ""))
						if appl_exe /= Void then
							l_file.put_string (appl_exe)
						end

						if shared_library_pos /= 0 then
							l_file.put_string (" $(SYSTEM_IN_DYNAMIC_LIB)")
						end

						l_file.put_new_line
						l_file.put_string (options.get_string_or_default ("completed", ""))
						l_file.put_string ("%N%N")
					else
						check False end
					end
				end
			end
		end

	translate_dependencies
			-- Translate dependencies section.
		require
			makefile_sh_attached: makefile_sh /= Void
			makefile_attached: makefile /= Void
			has_makefile_sh: has_makefile_sh
		local
			lastline: detachable STRING
			dir_sep_pos: INTEGER -- the position of the directory separator
			dir: STRING -- the directory
			filename: STRING -- the filename of the sub makefile
			is_E1_makefile, is_E1_structure, is_E1_offsets: BOOLEAN
			min: INTEGER
			dependency: STRING
			l_target_file: STRING
			l_precomps: STRING
			l_opt_string: detachable STRING
		do
			debug ("progress")
				io.put_string ("%Tdependencies%N")
			end

			if attached makefile_sh as l_file_sh and then attached makefile as l_file then
				from
					lastline := l_file_sh.last_string
				until
					lastline = Void or else (
					lastline.count > (once "OBJECTS=").count and then lastline.substring (1, (once "OBJECTS=").count) ~ once "OBJECTS=")
					--lastline.count > appl.count and then lastline.substring (1, appl.count) ~ appl
				loop
					check lastline_attached: lastline /= Void end
					lastline := lastline.twin

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
						l_file.put_string (dir)
						l_file.put_string (directory_separator)
						subst_dir_sep (dependency)
						l_file.put_string (options.get_string_or_default ("emain_obj_text", ""))
						l_file.put_string (": ")
						l_file.put_string (dependency)
						l_file.put_new_line
						read_next
						lastline := l_file_sh.last_string
						check lastline_attached: lastline /= Void end
						lastline := lastline.twin
						subst_dir_sep (lastline)
						l_file.put_string (lastline)
						l_file.put_new_line
					elseif filename ~ once "Makefile" and then dir ~ once "E1" then
						is_E1_makefile := True
					elseif filename ~ once "estructure" and then dir ~ once "E1" then
						is_E1_structure := True
					elseif filename ~ once "eoffsets" and then dir ~ once "E1" then
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
							l_opt_string := options.get_string ("intermediate_file_ext")
							if l_opt_string /= Void then
								filename.append (l_opt_string)
							end
						end
						l_target_file.append (filename)
						if dir.item (1) = 'E' then
							system_dependent_directories.put_front ([dir, l_target_file])
						else
							object_dependent_directories.put_front ([dir, l_target_file])
						end
						dependent_directories.put_right ([dir, l_target_file])

						l_file.put_string (l_target_file)
						l_file.put_string (":")
						l_file.put_string (dependency)
						l_file.put_new_line
					end

					if is_E1_makefile then
						read_next
					elseif is_E1_structure or is_E1_offsets then
						subst_dir_sep (lastline)
						l_file.put_string (lastline)
						l_file.put_new_line
						read_next
						lastline := l_file_sh.last_string
						check lastline_attached: lastline /= Void end
						lastline := lastline.twin
						subst_dir_sep (lastline)
						l_file.put_string (lastline)
						l_file.put_new_line
						l_file.put_new_line
					else
						l_file.put_string ("%T")
						l_file.put_string (options.get_string_or_default ("cd", ""))
						l_file.put_string (" ")
						l_file.put_string (dir)
						l_file.put_string (options.get_string_or_default ("subcommand_separator", " && "))
						l_file.put_string ("$(START_TEST) $(MAKE) ")
						l_file.put_string (filename)
						l_file.put_string (" $(END_TEST)")
						l_file.put_string (options.get_string_or_default ("subcommand_separator", " && "))
						l_file.put_string (options.get_string_or_default ("cd", ""))
						l_file.put_string (" ")
						l_file.put_string (options.get_string_or_default ("updir", ""))

						read_next

						l_file.put_string ("%N%N")
					end

					read_next
					read_next
					lastline := l_file_sh.last_string
				end

				read_next -- On windows, we skip the OBJECTS=..., it is done after
				--read_next

					-- Generate the `OBJECTS = ' line
				from
					dependent_directories.start
					l_file.put_string (options.get_string_or_default ("objects_text", ""))
				until
					dependent_directories.after
				loop
					dir := dependent_directories.item.file
					l_file.put_string (dir)
					l_file.put_character (' ')
					dependent_directories.forth
				end

					-- Generate the `x_OBJECTS = ' lines
				from
					object_dependent_directories.start
					l_file.put_string ("%N%N");
					l_file.put_string (options.get_string_or_default ("c_objects_text", ""))
				until
					object_dependent_directories.after
				loop
					dir := object_dependent_directories.item.file
					l_file.put_string (dir)
					l_file.put_character (' ')
					object_dependent_directories.forth
				end
				if object_dependent_directories.is_empty then
					l_file.put_string (" %"%" %N")
				end

				from
					l_file.put_string ("%N%N")
					l_file.put_string (options.get_string_or_default ("eobjects_text", ""))
					system_dependent_directories.start
				until
					system_dependent_directories.after
				loop
					dir := system_dependent_directories.item.file
					l_file.put_string (dir)
					l_file.put_character (' ')
					system_dependent_directories.forth
				end

				l_file.put_string ("%N%N")

				from
					lastline := l_file_sh.last_string
				until
					lastline = Void or else (
					lastline.count > (once "PRECOMP_OBJECTS=").count and then
					lastline.substring (1, (once "PRECOMP_OBJECTS=").count) ~ once "PRECOMP_OBJECTS=")
				loop
					read_next
					lastline := l_file_sh.last_string
				end
				check lastline_attached: lastline /= Void end
				l_precomps := get_precompile_libs (lastline.twin)
				l_file.put_string (l_precomps)
				l_file.put_new_line
			end
		end

	translate_line_subst
			-- Translate a line requiring substitution.
		require
			makefile_sh_attached: makefile_sh /= Void
			makefile_attached: makefile /= Void
			has_makefile_sh: has_makefile_sh
		local
			lastline: detachable STRING
			runtime: STRING
			i, j: INTEGER
		do
			debug ("progress")
				io.put_string ("%Tsubst%N")
			end
			if attached makefile_sh as l_file_sh and then attached makefile as l_file then
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				lastline := lastline.twin

				debug ("translate_line_subst")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				-- adapt RM and MAKE lines for further usage
				if lastline.count>3 then
					if lastline.substring (1,4) ~ (options.get_string (once "rm_text")) then
						lastline := "RM = $rm"
					end

					if lastline.substring (1,4) ~ (options.get_string (once "make_text")) then
						lastline := "MAKE = $make"
					end

					if lastline.substring (1, 11) ~ (once "EIFLIB = -L") then
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

				l_file.put_string (lastline)
				l_file.put_new_line
			end
		end

	translate_line_change
			-- Translate a line requiring changes.
		require
			makefile_sh_attached: makefile_sh /= Void
			makefile_attached: makefile /= Void
			has_makefile_sh: has_makefile_sh
		local
			lastline: detachable STRING
			replacement: detachable STRING -- what to replace with
			dir: STRING -- what directory it should be in (e.g. E1, F1)
		do
			debug ("progress")
				io.put_string ("%Tchange%N")
			end

			if attached makefile_sh as l_file_sh and attached makefile as l_file then
				lastline := l_file_sh.last_string
				if lastline = Void then
					create lastline.make_empty
				end

				debug ("translate_line_change")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				if lastline.count > 4 and then lastline.substring_index (options.get_string_or_default ("all", "").substring (1, 4), 1) > 0 then
					subst_intermediate (lastline)
				end

				subst_continuation (lastline)

				-- replace all occurrences of certain strings
				lastline.replace_substring_all ("$ (CC) $ (CFLAGS) -c", options.get_string_or_default ("cc_text", ""))
				lastline.replace_substring_all (".c.o:", options.get_string_or_default ("cobj_text", ""))
				lastline.replace_substring_all (".cpp.o:", options.get_string_or_default ("cppobj_text", ""))
				lastline.replace_substring_all (".o ", options.get_string_or_default ("obj_text", ""))
				if lastline.substring_index (".SUFFIXES", 1) /= 0 then
					lastline.replace_substring_all (".o", options.get_string_or_default ("obj_text", ".obj"))
				end

				-- replace .o:
				replacement := options.get_string_or_default ("intermediate_file_ext", "").twin
				replacement.prepend (".")
				replacement.append (": $")
				lastline.replace_substring_all (".o: $", replacement)

				subst_eiffel (lastline)
				subst_platform (lastline)
				subst_compiler (lastline)
				subst_dir_sep (lastline)

				-- intermediate files
				if lastline.count > 8 and then lastline.substring_index ("$(CREATE_TEST)", 1) >0 then
					lastline := ""
				end
				if lastline.count > 8 and then lastline.substring_index ("$(LD) $(LDFLAGS) -r -o", 1) >0 then
					lastline := options.get_string_or_default ("make_intermediate", "")
					subst_eiffel (lastline)
					subst_platform (lastline)

					debug ("translate_line_change")
						debug ("input")
							io.put_string ("CHANGE: ")
							io.put_string (lastline)
							io.put_new_line
						end
					end

					dir := dependent_directories.item.directory
				end


				-- externals
				if lastline.count>8 and then lastline.substring (1,9) ~ options.get_string ("externals_text") then
					externals := True
				end
				-- .x.o
				if lastline.count>4 and then lastline.substring (1,5) ~ ".x.o:" then
					lastline.replace_substring_all (".x.o:", options.get_string_or_default ("xobj_text", ""))
				end

				-- .xpp.o
				if lastline.count>6 and then lastline.substring (1,7) ~ ".xpp.o:" then
					lastline.replace_substring_all (".xpp.o:", options.get_string_or_default ("xppobj_text", ""))
				end

				-- application name, cecil
				if
					not is_il_code and then attached appl as l_app and then
					lastline.count >= l_app.count and then
					lastline.substring (1, l_app.count) ~ l_app
				then
					translate_appl
				elseif
					lastline.count>14 and then lastline.substring (1,14) ~ once "STATIC_CECIL ="
				then
					translate_cecil_and_dll
				elseif
					is_il_code and then
					lastline.count = 27 and then
					lastline.substring (1, 27) ~ "$il_system_compilation_line"
				then
						-- Add resource file dependency for IL system
					replacement := options.get_string_or_default ("il_system_compilation_line", "")
					subst_eiffel (replacement)
					subst_platform (replacement)
					subst_compiler (replacement)
					l_file.put_string (replacement)
				else
					debug ("translate_line_change")
						debug ("output")
							io.put_string ("OUT: ")
							io.put_string (lastline)
							io.put_new_line
						end
					end

					l_file.put_string (lastline)
				end

				l_file.put_new_line
			end
		end

	translate_appl
			-- Translate application generation code.
		require
			makefile_sh_attached: makefile_sh /= Void
			makefile_attached: makefile /= Void
			appl_attached: appl /= Void
		local
			lastline: detachable STRING
		do
			debug ("progress")
				io.put_string ("%Tappl%N")
			end

			if attached makefile_sh as l_file_sh and then attached makefile as l_file then
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end

				debug ("translate_appl")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				-- precompile or make application?
				if precompile then
					lastline := options.get_string_or_default ("precompile", "")
				else
					lastline := options.get_string_or_default ("appl_make", "")
				end

				debug ("translate_appl")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				if attached appl as l_appl then
					lastline.replace_substring_all ("$appl", l_appl)
				else
					lastline.replace_substring_all ("$appl", "")
					check False end
				end
				subst_objects_redirection (lastline)

				if options.has ("sharedlibs") then
					lastline.replace_substring_all ("$sharedlibs", options.get_string_or_default ("sharedlibs", ""))
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

				l_file.put_string (lastline)

					-- Get rid of what comes after the application rule.
				from
				until
					lastline.is_empty
				loop
					read_next
					lastline := l_file_sh.last_string
				end
			end

		end

	translate_cecil_and_dll
			-- Translate cecil.
		require
			makefile_sh_attached: makefile_sh /= Void
			makefile_attached: makefile /= Void
			has_makefile_sh: has_makefile_sh
		local
			lastline: detachable STRING
			previous_line: STRING
			l_appl: like appl
		do
			debug ("progress")
				io.put_string ("%Tcecil%N")
			end

			if attached makefile_sh as l_file_sh and then attached makefile as l_file then
				l_file.put_string ("%N#STATIC_CECIL PART%N")

				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				lastline := lastline.twin
				lastline.replace_substring_all (".a", lib_extension)
				l_file.put_string (lastline)
				l_file.put_new_line

				read_next
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				l_file.put_string (lastline)
				l_file.put_new_line

				if options.has ("cecil_make") then
					lastline := options.get_string_or_default ("cecil_make", "").twin
				else
					lastline := options.get_string_or_default ("cecil_text", "").twin
				end

				debug ("translate_cecil_and_dll")
					debug ("input")
						io.put_string ("IN: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				l_appl := appl
				check l_appl_attached: l_appl /= Void end
				lastline.replace_substring_all ("$appl", l_appl)
				subst_eiffel (lastline)

				debug ("translate_cecil_and_dll")
					debug ("output")
						io.put_string ("OUT: ")
						io.put_string (lastline)
						io.put_new_line
					end
				end

				l_file.put_string (lastline)
				l_file.put_new_line

				read_next
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				from
				until
					lastline.count > 14 and then lastline.substring (1,14) ~ once "SHARED_CECIL ="
				loop
					read_next
					lastline := l_file_sh.last_string
					check lastline_attached: lastline /= Void end
				end

				l_file.put_new_line
				l_file.put_new_line

				l_file.put_string ("%N#SHARED_CECIL PART%N")
				l_file.put_string (lastline)
				l_file.put_new_line
				read_next

				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				l_file.put_string (lastline)
				l_file.put_new_line

-- DEF_FILE= appl.def
				if options.has ("cecil_def") then
					lastline := options.get_string_or_default ("cecil_def", "").twin
					lastline.replace_substring_all ("$appl", l_appl)
					subst_eiffel (lastline)
					subst_platform (lastline)
					l_file.put_string (lastline)
				end
				l_file.put_new_line

					-- dynamic_cecil: $(SHARED_CECIL)
				l_file.put_new_line
				read_next
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				l_file.put_string (lastline)
				l_file.put_new_line

				from
				until
					lastline = Void or else (
					lastline.count = 12 and then
					lastline.substring (3,12) ~ once "E1/emain.o")
				loop
					read_next
					lastline := l_file_sh.last_string
				end

					-- SHARED_CECIL_OBJECT
				check lastline_attached: lastline /= Void end
				lastline.replace_substring_all (".o", object_extension)
				l_file.put_string (lastline)
				l_file.put_new_line
				read_next
				l_file.put_string ("SHARED_FLAGS = $(LDSHAREDFLAGS)")

					-- SHAREDFLAGS
				if options.has ("cecil_dynlib") then
					l_file.put_string (" \%N")
					lastline := options.get_string_or_default ("cecil_dynlib", "").twin
					lastline.replace_substring_all ("$appl", l_appl)
					subst_eiffel (lastline)
					subst_platform (lastline)
					subst_compiler (lastline)
					l_file.put_string (lastline)
					l_file.put_new_line
				else
					l_file.put_new_line
				end

					-- SHARED_CECIL
				read_next
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				l_file.put_string (lastline)
				l_file.put_string (" $(DEF_FILE)")
				l_file.put_new_line

					-- $(RM) "$(SHARD_CECIL)"
				read_next
				lastline := options.get_string_or_default ("safe_rm", "").twin
				lastline.replace_substring_all ("@", "$(SHARED_CECIL)")
				lastline.precede ('%T')
				l_file.put_string (lastline)
				l_file.put_new_line

					-- $(SHAREDLINK) $(SHAREDFLAGS) $(SHARED_CECIL_OBJECT) $(SHAREDLIBS)
				read_next
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				l_file.put_string (lastline)
				l_file.put_new_line

					-------------------------------------------------
					-- Search the beginning of the SYSTEM_IN_DYNAMIC_LIB part
				read_next
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				from
				until
					lastline.count > 7 and then lastline.substring (1,7) ~ once "dynlib:"
				loop
					read_next
					lastline := l_file_sh.last_string
					check lastline_attached: lastline /= Void end
				end

				l_file.put_string ("%N#SYSTEM_IN_DYNAMIC_LIB PART%N%N")

					-- DEF_FILE= appl.def
				l_file.put_string ("DEF_FILE= ")
				l_file.put_string (l_appl)
				l_file.put_string (".def")
				l_file.put_new_line

					-- dynlib: $(SYSTEM_IN_DYNAMIC_LIB)
				l_file.put_string (lastline)
				l_file.put_new_line

					-- egc_dynlib.obj
				read_next
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				lastline := lastline.twin
				lastline.replace_substring_all (".o", object_extension)
				subst_eiffel (lastline)
				subst_platform (lastline)
				subst_compiler (lastline)
				subst_dir_sep (lastline)
				l_file.put_string (lastline)
				l_file.put_new_line

				read_next -- $(MV) $(ISE_EIFFEL....
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				lastline := lastline.twin
				subst_eiffel (lastline)
				subst_platform (lastline)
				subst_compiler (lastline)
				subst_dir_sep (lastline)
				l_file.put_string (lastline)
				l_file.put_new_line

				read_next -- cd E1 ; $(MAKE) ....
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				lastline := lastline.twin
				lastline.replace_substring_all (".o", object_extension)
				lastline.replace_substring_all (" ; ", options.get_string_or_default ("subcommand_separator", " && "))
				l_file.put_string (lastline)
				l_file.put_new_line

					-- edynlib.obj
				read_next
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				lastline := lastline.twin
				lastline.replace_substring_all (".o", object_extension)
				subst_dir_sep (lastline)
				l_file.put_string (lastline)
				l_file.put_new_line

				read_next -- cd E1 ; $(MAKE) ...
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				lastline := lastline.twin
				lastline.replace_substring_all (".o", object_extension)
				lastline.replace_substring_all (" ; ", options.get_string_or_default ("subcommand_separator", " && "))
				l_file.put_string (lastline)
				l_file.put_new_line

					-- SYSTEM_IN_DYNAMIC_LIB_OBJ
				read_next
				l_file.put_new_line
				read_next
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				l_file.put_string (lastline)
				l_file.put_new_line

				from
					previous_line := lastline
				until
					lastline.count > 17 and then lastline.substring (1,17) ~ once "DYNLIBSHAREDFLAGS"
				loop
					read_next
					previous_line := lastline
					lastline := l_file_sh.last_string
					check lastline_attached: lastline /= Void end
				end

				previous_line.replace_substring_all (".o", object_extension)
				subst_dir_sep (previous_line)
				l_file.put_string (previous_line)
				l_file.put_new_line

					-- DYNLIBSHAREDFLAGS
				l_file.put_string ("DYNLIBSHAREDFLAGS = $(LDSHAREDFLAGS)")
				if options.has ("system_dynlib") then
					l_file.put_string (" \%N")
					lastline := options.get_string_or_default ("system_dynlib", "").twin
					lastline.replace_substring_all ("$appl", l_appl)
					subst_eiffel (lastline)
					subst_platform (lastline)
					subst_compiler (lastline)
					l_file.put_string (lastline)
					l_file.put_new_line
				else
					l_file.put_new_line
				end

-- SYSTEM_IN_DYNAMIC_LIB
				read_next
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				lastline := lastline.twin
				l_file.put_string (lastline)
				l_file.put_string (" $(DEF_FILE)")
				l_file.put_new_line

-- $(RM) "$(SYSTEM_IN_DYNAMIC_LIB)"
				read_next
				lastline := options.get_string_or_default ("safe_rm", "").twin
				lastline.replace_substring_all ("@", "$(SYSTEM_IN_DYNAMIC_LIB)")
				lastline.precede ('%T')
				l_file.put_string (lastline)
				l_file.put_new_line

-- $(SHAREDLINK) $(DYNLIBSHAREDFLAGS) $(SYSTEM_IN_DYNAMIC_LIB_OBJ) $(SHAREDLIBS)
				read_next
				lastline := l_file_sh.last_string
				check lastline_attached: lastline /= Void end
				l_file.put_string (lastline)
				l_file.put_new_line
			end

	end

feature {NONE}	-- substitutions

	subst_eiffel (line: STRING)
			-- Replace all occurrences of `Eiffel_dir' environment variable in `line'
		do
			debug ("subst")
				io.put_string("%Tsubst_eiffel%N")
			end

			if attached eiffel_dir as l_dir and then not l_dir.is_empty then
				line.replace_substring_all ("$(ISE_EIFFEL)", l_dir)
				line.replace_substring_all ("$(EIFFEL4)", l_dir)
			end
		end

	subst_objects_redirection (line: STRING)
			-- Replace all occurences of $objects_redirection with list of objects
		local
			l_string, l_dir: STRING
			i: INTEGER
			l_new_line_inserted: BOOLEAN
		do
			if line.substring_index ("$objects_redirection", 1) > 0 then
				from
					create l_string.make (dependent_directories.count * 10)
					dependent_directories.start
					i := 0
				until
					dependent_directories.after
				loop
					if i \\ 5 = 0 then
						l_string.append_string ("%Techo ")
						l_new_line_inserted := True
					end
					l_dir := dependent_directories.item.file
					l_string.append (l_dir)
					l_string.append_character (' ')
					if (i + 1) \\ 5 = 0 then
						l_string.append (" >> $@ %N")
						l_new_line_inserted := False
					end

					dependent_directories.forth
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
		local
			l_platform: like get_replacement
		do
			debug ("subst")
				io.put_string("%Tsubst_platform%N")
			end

			l_platform := get_replacement (once "ISE_PLATFORM")
			check l_platform_attached: l_platform /= Void end -- Checked during start-up
			line.replace_substring_all ("$(ISE_PLATFORM)", l_platform)
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
				line.append (options.get_string_or_default ("continuation", ""))
			end
		end

	subst_intermediate (line: STRING)
			-- replace all occurrences of ?obj#.obj with ?obj#.lib in `line' starting with "all"
		local
			start: INTEGER
			l_opt_string, l_replacement_opt_string: detachable STRING
		do
			debug ("subst")
				io.put_string("%Tsubst_intermediate%N")
			end

			check
				line.count > 4 and then line.substring_index(options.get_string_or_default ("all", "").substring (1, 4), 1) > 0
			end

			line.replace_substring_all (options.get_string_or_default ("all", "").substring (1, 4), options.get_string_or_default ("all", ""))
			line.replace_substring_all (".o", lib_extension)

			start := 1

			if line.substring_index (options.get_string_or_default ("emain_text", ""), start) > 0 then
				start := line.substring_index (options.get_string_or_default ("intermediate_file_ext", ""), start)
				check start > 0 end
				line.replace_substring (options.get_string_or_default ("obj_file_ext", ""), start, start+2)
			end
		end

feature {NONE} -- Implementation

	env: EXECUTION_ENVIRONMENT
			-- Execution environment
		once
			 create Result
		end

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
				replacement := Void

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
				elseif word.substring(1,18) ~ once "external_makefiles" then
					-- $EXTERNAL_MAKEFILES must not be replaced.
				else
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
			replacement: detachable STRING
		do
			debug ("implementation")
				io.put_string("%Tget_replacement%N")
			end

			if ({PLATFORM_CONSTANTS}.is_64_bits and force_32bit) and then word.is_case_insensitive_equal (once "ISE_PLATFORM") then
					-- Replace ISE_PLAFORM to 32bit builds on x64 platforms
				Result := once "windows"
			else
				if options.has (word) then
					replacement := options.get_string (word)
					if replacement /= Void and then replacement /~ "$(INCLUDE_PATH)" then
						search_and_replace (replacement)
					end
					Result := replacement
				else
						-- Note: Before we were taking the short path (rev#66961)
					Result := eiffel_layout.get_environment (word)
				end
			end
		end

	read_next
			-- read the next line from Makefile.SH if possible
		require
			makefile_sh_attached: makefile_sh /= Void
		do
			debug ("implementation")
				io.put_string("%Tread_next%N")
			end

			if attached makefile_sh as l_file and then not l_file.end_of_file then
				l_file.read_line
			end
		end

	get_precompile_libs (line_to_search: STRING): STRING
			-- look for precompiled libraries, also checks
			-- if application uses multithreading mechanism
		require
			makefile_sh_attached: makefile_sh /= Void
			makefile_attached: makefile /= Void
			has_makefile_sh: has_makefile_sh
		local
			line: detachable STRING
			next_precomp_lib: STRING
			precomp_lib_start: INTEGER
			preobj: STRING
		once
			Result := ""
			preobj := "precomp.lib"

			debug ("implementation")
				io.put_string ("%Tget_precompile_libs%N")
			end

			if attached makefile_sh as l_file_sh and attached makefile as l_file then
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
					l_file_sh.end_of_file or else line.is_empty
				loop
					read_next
					line := l_file_sh.last_string
					check line_attached: line /= Void end
					line := line.twin

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
		end

	open_files
			-- open the Makefile.SH and the Makefile to translate
		local
			out_file, retried: BOOLEAN
			l_file_sh: like makefile_sh
		do
			if not retried then
				out_file := False
				create l_file_sh.make ("Makefile.SH")
				makefile_sh := l_file_sh
				if l_file_sh.exists then
					l_file_sh.open_read
					has_makefile_sh := True
					out_file := True
					create makefile.make_open_write ("Makefile")
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
			-- close the Makefile.SH and the Makefile
		do
			debug ("implementation")
				io.put_string("%Tclose_files%N")
			end

			if attached makefile_sh as l_file and then not l_file.is_closed then
				l_file.close
			end

			if attached makefile as l_file and then not l_file.is_closed then
				l_file.close
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

invariant
	options_not_void: options /= Void

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class MAKEFILE_TRANSLATOR
