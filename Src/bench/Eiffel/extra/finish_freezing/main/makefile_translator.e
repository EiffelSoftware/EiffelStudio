class MAKEFILE_TRANSLATOR

creation
	make

feature -- Initialization

	make is
		do
			!!options.make (25)
			!!dependent_directories.make
			eiffel4 := env.get ("EIFFEL4")

			if eiffel4 = Void or else eiffel4.empty then
				io.error.putstring ("EIFFEL4 environment variable not set.%N")
			end
		end

feature -- Access

	makefile_sh: PLAIN_TEXT_FILE	
			-- Makefile.SH to read from

	makefile: PLAIN_TEXT_FILE	
			-- Makefile to create

	options: RESOURCE_TABLE		
			-- Options read from config.eif

	dependent_directories: LINKED_LIST[STRING] 
			-- Subdirs for this compilation

	delete_next: BOOLEAN		
			-- Is the next line to be deleted?

	externals: BOOLEAN		
			-- Is the application using externals?

	finalized: BOOLEAN		
			-- Is this a finalized compilation?
	
	precompile: BOOLEAN		
			-- Is this a precompilation?

	appl: STRING			
			-- Application name

	eiffel4: STRING			
			-- EIFFEL4 environment variable

feature -- Execution

	read_options is
			-- read options from config.eif
		local
			reader: RESOURCE_PARSER
			filename: FILE_NAME -- the filename for the config.eif file
		do
			filename := config_eif_fn
			!!reader
			reader.parse_file (filename, options)
		end

	translate is
			-- create Makefile from Makefile.SH and options
		do
			translate_makefile (true)
			translate_sub_makefiles
		end

	run_make is
			-- run the make utility on the generated Makefile
		local
			command: STRING -- the command to execute the make utility on this platform
		do
			command := options.get_string ("make", Void)

			env.system (command)

			if env.return_code /= 0 then
				io.error.putstring ("Error executing ")
				io.error.putstring (options.get_string ("make", Void))
				io.error.putstring (".%N%TReturn code: ")
				io.error.putint (env.return_code)
				io.error.new_line
			end
		end

feature {NONE} -- Translation

	translate_makefile  (master: BOOLEAN) is
			-- translate the Makefile.SH in the current directory
			-- 	master: is this the master makefile (i.e. the one in the F/W_code directory)?
		do
			debug ("progress")
				io.putstring ("Translate makefile")
				if master then
					io.putstring (" (master)")
				end
				io.new_line
			end

			open_files

			check
				makefile_sh /= Void
				makefile /= Void
			end

			if not makefile_sh.end_of_file then
				read_next

				translate_case
				translate_case
				translate_echo
				translate_spit (true, Void)

				if master then
					translate_master
					translate_spit (false, options.get_string ("no_subs", Void))
				else
					translate_spit (false, Void)
				end
			else
				io.error.putstring ("Makefile.SH is empty.%N")
			end

			close_files
		end

	translate_sub_makefiles is
			-- Translate makefiles in subdirs from master makefile.
		local
			dir: STRING -- the directory we're working on
		do
			debug ("progress")
				io.putstring ("Translate sub makefiles%N")
			end

			from
				dependent_directories.start
			until
				dependent_directories.after
			loop
				dir := dependent_directories.item

				debug ("progress")
					io.putstring ("%TTranslating Makefile.SH in directory ")
					io.putstring (dir)
					io.putstring (".%N")
				end

				env.change_working_directory (dir)
				
				translate_makefile (false)

				env.change_working_directory (options.get_string ("updir", ".."))

				dependent_directories.forth
			end
		end

	translate_case is
			-- translate case section by ignoring it.
		local
			lastline: STRING
		do
			debug ("progress")
				io.putstring ("Translate case%N")
			end

			lastline := clone (makefile_sh.laststring)

			debug ("translate_case")
				debug ("input")
					io.putstring ("IN: ")
					io.putstring (lastline)
					io.new_line
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
				lastline := clone (makefile_sh.laststring)

				debug ("translate_case")
					debug ("input")
						io.putstring ("IN: ")
						io.putstring (lastline)
						io.new_line
					end
				end
			end

			read_next
		end

	translate_echo is
			-- Translate echo section by ignoring it.
		local
			lastline: STRING
		do
			debug ("progress")
				io.putstring ("Translate echo%N")
			end

			lastline := clone (makefile_sh.laststring)

			debug ("translate_echo")
				debug ("input")
					io.putstring ("IN: ")
					io.putstring (lastline)
					io.new_line
				end
			end

			check
				lastline.substring (1,4).is_equal ("echo")
			end

			read_next
		end

	translate_spit  (do_subst: BOOLEAN; endtag: STRING) is
			-- Translate spitshell section
			-- 	do_subst: should substitutions be carried out?
			--	endtag: up to where we should read.
		local
			lastline: STRING
			strpos: INTEGER -- where we are in the string
			tag: STRING -- read until we encounter this tag
		do
			debug ("progress")
				io.putstring ("Translate spit%N")
			end

			lastline := clone (makefile_sh.laststring)

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
					if not lastline.empty then
						translate_line_change
					else
						makefile.new_line
					end
				end

				read_next
				lastline := clone (makefile_sh.laststring)
			end

			read_next
		end

	translate_master is
			-- Translate master Makefile.SH.
		do
			debug ("progress")
				io.putstring ("Translate master%N")
			end

			translate_translate
			translate_externals
			translate_application
			translate_dependencies
		end

	translate_translate is
			-- Translate.
		local
			lastline: STRING
		do
			debug ("progress")
				io.putstring ("%Ttranslate%N")
			end

			from
				read_next
				lastline := clone (makefile_sh.laststring)
			until
				lastline.is_equal (options.get_string ("externals_continuation_text", Void)) or else
				lastline.count>4 and then lastline.substring (1,4).is_equal (options.get_string ("all", Void).substring (1,4))
			loop
				debug ("translate_translate")
					debug ("input")
						io.putstring ("IN: ")
						io.putstring (lastline)
						io.new_line
					end
				end

				if not lastline.empty then
					subst_continuation (lastline)
					subst_eiffel (lastline)
					subst_platform (lastline)
					subst_dir_sep (lastline)
					lastline.replace_substring_all ("$ (CC) $ (CFLAGS) -c", options.get_string ("cc_text", "Void"))
					lastline.replace_substring_all (".c.o:", options.get_string ("cobj_text", Void))
					if lastline.count>4 and then lastline.substring (1,5).is_equal (".x.o:") then
						finalized := true
						lastline.replace_substring_all (".x.o:", options.get_string ("xobj_text", Void))
					end
				end

				debug ("translate_translate")
					debug ("output")
						io.putstring ("OUT: ")
						io.putstring (lastline)
						io.new_line
					end
				end

				makefile.putstring (lastline)
				makefile.new_line

				read_next
				lastline := makefile_sh.laststring
			end
		end

	translate_externals is
			-- Translate externals section.
		local
			lastline: STRING
		do
			debug ("progress")
				io.putstring ("%Texternals%N")
			end

			lastline := clone (makefile_sh.laststring)

			if lastline.count>8 and then lastline.substring (1, 9).is_equal (options.get_string ("externals_text", Void)) then
				externals := true
			end

			from
               until
				lastline.empty or makefile_sh.end_of_file or not externals
			loop
				debug ("translate_externals")
					debug ("input")
						io.putstring ("IN: ")
						io.putstring (lastline)
						io.new_line
					end
				end
				
				subst_continuation (lastline)
				subst_eiffel (lastline)
				subst_platform (lastline)
				search_and_replace (lastline)
				subst_dir_sep (lastline)

				debug ("translate_externals")
					debug ("output")
						io.putstring ("OUT: ")
						io.putstring (lastline)
						io.new_line
					end
				end

				makefile.putstring (lastline.out)
				makefile.new_line

				read_next
				lastline := clone (makefile_sh.laststring)
			end

			if not makefile_sh.end_of_file and externals then
				makefile.new_line
				read_next
			end
		end

	translate_application is
			-- Translate application section.
		local
			lastline: STRING
			extension: STRING -- the extension of the filename (e.g. '.exe')
			appl_exe: STRING -- the executable for the application

		do
			debug ("translate_application")
				io.putstring ("%Tapplication%N")
			end

			lastline := clone (makefile_sh.laststring)

			debug ("translate_application")
				debug ("input")
					io.putstring ("IN: ")
					io.putstring (lastline)
					io.new_line
				end
			end

			if lastline.count>3 and then lastline.substring (1,4).is_equal (options.get_string ("all", Void).substring (1,4)) then
				appl := lastline.substring (6, lastline.count)
				appl.right_adjust

				if appl.count>4 then
					extension := clone (appl)
					extension.to_lower
					extension.tail (4)
					if extension.is_equal (options.get_string ("executable_file_ext", Void)) then
						appl := appl.substring (1, appl.count -4)
					end
				end

				if appl.is_equal (options.get_string ("driver_text", Void)) then
					precompile := true
					appl_exe := options.get_string ("driver_filename", Void)
				else
					appl_exe := clone (appl)
					appl_exe.append (options.get_string ("executable_file_ext", Void))
				end
			end

			read_next
			read_next

			makefile.putstring (options.get_string ("all", Void))
			makefile.putstring (appl_exe)
			makefile.new_line
			makefile.putstring (options.get_string ("completed", Void))
			makefile.putstring ("%N%N")
		end

	translate_dependencies is
			-- Translate dependencies section.
		local
			lastline: STRING
			dir_sep_pos: INTEGER -- the position of the directory separator
			dir: STRING -- the directory
			filename: STRING -- the filename of the sub makefile
			number: INTEGER -- the number of the Eobj file
		do
			debug ("progress")
				io.putstring ("%Tdependencies%N")
			end

			from
				lastline := clone (makefile_sh.laststring)
			until
				lastline.count > appl.count and then lastline.substring (1, appl.count).is_equal (appl)
			loop
				debug ("translate_dependencies")
					debug ("input")
						io.putstring ("IN: ")
						io.putstring (lastline)
						io.new_line
					end
				end

				-- get directory name and filetype
				dir_sep_pos := lastline.index_of (operating_environment.directory_separator, 1)
				if dir_sep_pos = 0 then
					dir_sep_pos := lastline.index_of ('/', 1)
				end

				debug ("translate_dependencies")
					io.error.putstring(lastline)
					io.error.putstring("%NIs this it: ")
					io.error.putint(dir_sep_pos)
					io.error.new_line
				end

				dir := lastline.substring (1, dir_sep_pos-1)
				filename := lastline.substring (dir_sep_pos+1, lastline.index_of ('.', 1)-1)

				makefile.putstring (dir)
				makefile.putchar (operating_environment.directory_separator)

				if filename.is_equal (options.get_string ("emain_text", Void)) then
					makefile.putstring (options.get_string ("emain_obj_text", Void))
					makefile.putstring (": Makefile%N")
				else
					dependent_directories.extend (dir)

					makefile.putstring (filename)
					makefile.putstring (".")
					makefile.putstring (options.get_string ("intermediate_file_ext", Void))
					makefile.putstring (": Makefile%N")
				end

				makefile.putstring ("%T ")
				makefile.putstring (options.get_string ("cd", Void))
				makefile.putstring (" ")
				makefile.putstring (dir)
				makefile.putstring ("%N%T ")
				makefile.putstring (options.get_string ("make", Void))
				makefile.putstring (" ")

				if filename.is_equal (options.get_string ("emain_text", Void)) then
					makefile.putstring (options.get_string ("emain_obj_text", Void))
					makefile.new_line
				else
					makefile.putstring (filename)
					makefile.putstring (".")
					makefile.putstring (options.get_string ("intermediate_file_ext", Void))
					makefile.new_line
				end

				makefile.putstring ("%T ")
				makefile.putstring (options.get_string ("cd", Void))
				makefile.putstring (" ")
				makefile.putstring (options.get_string ("updir", Void))
				makefile.putstring ("%N%N")

				read_next
				read_next
				read_next

				lastline := clone (makefile_sh.laststring)
			end

			from
				dependent_directories.start
				if not dependent_directories.after then
					dir := dependent_directories.item
				end

				makefile.putstring (options.get_string ("objects_text", Void))
				makefile.putstring (options.get_string ("continuation", Void))
				makefile.putstring ("%N%T")
			until
				dir.item (1) = 'E' or else dependent_directories.after
			loop
				makefile.putstring (dir)
				makefile.putchar (operating_environment.directory_separator)
				makefile.putchar (dir.item (1))
				makefile.putstring (options.get_string ("obj_file_ext", Void))
				makefile.putstring (dir.substring (2, dir.count))
				makefile.putchar ('.')
				makefile.putstring (options.get_string ("intermediate_file_ext", Void))
				makefile.putchar (' ')

				dependent_directories.forth
				if not dependent_directories.after then
					dir := dependent_directories.item
				end
			end

			makefile.putstring ("%N%N")

			from
				makefile.putstring (options.get_string ("eobjects_text", Void))
				makefile.putstring (options.get_string ("continuation", Void))
				makefile.putstring ("%N%T")
				number := 0
			until
				dependent_directories.after
			loop
				dir := dependent_directories.item
				number := number + 1

				makefile.putstring (dir)
				makefile.putchar (operating_environment.directory_separator)
				makefile.putchar (dir.item (1))
				makefile.putstring (options.get_string ("obj_file_ext", Void))
				makefile.putint (number)
				makefile.putchar ('.')
				makefile.putstring (options.get_string ("intermediate_file_ext", Void))
				makefile.putchar (' ')

				dependent_directories.forth
			end

			makefile.putstring ("%N%N")
		end

	translate_line_subst is
			-- Translate a line requiring substitution.
		local
			lastline: STRING
		do
			debug ("progress")
				io.putstring ("%Tsubst%N")
			end

			lastline := clone (makefile_sh.laststring)

			debug ("translate_line_subst")
				debug ("input")
					io.putstring ("IN: ")
					io.putstring (lastline)
					io.new_line
				end
			end

			-- adapt RM and MAKE lines for further usage
			if lastline.count>3 then
				if lastline.substring (1,4).is_equal (options.get_string ("rm_text", Void)) then
					lastline := "RM = $rm"
				end

				if lastline.substring (1,4).is_equal (options.get_string ("make_text", Void)) then
					lastline := "MAKE = $make"
				end
			end

			search_and_replace (lastline)
			subst_dir_sep (lastline)

			debug ("translate_line_subst")
				debug ("output")
					io.putstring ("OUT: ")
					io.putstring (lastline)
					io.new_line
				end
			end

			makefile.putstring (lastline)
			makefile.new_line
		end

	translate_line_change is
			-- Translate a line requiring changes.
		local
			lastline: STRING
			replacement: STRING -- what to replace with
			selected_object: STRING -- what object section we're working on (e.g. E, F)
			dir: STRING -- what directory it should be in (e.g. E1, F1)
		do
			debug ("progress")
				io.putstring ("%Tchange%N")
			end

			lastline := clone (makefile_sh.laststring)

			debug ("translate_line_change")
				debug ("input")
					io.putstring ("IN: ")
					io.putstring (lastline)
					io.new_line
				end
			end

			if lastline.count > 4 and then lastline.substring_index (options.get_string ("all", Void).substring (1, 4), 1) > 0 then
				subst_intermediate (lastline)
			end

			subst_continuation (lastline)

			-- replace all occurrences of certain strings
			lastline.replace_substring_all ("$ (CC) $ (CFLAGS) -c", options.get_string ("cc_text", Void))
			lastline.replace_substring_all (".c.o:", options.get_string ("cobj_text", Void))
			lastline.replace_substring_all (".o ", options.get_string ("obj_text", Void))
			
			-- replace .o:
			replacement := clone (options.get_string ("intermediate_file_ext", Void))
			replacement.prepend (".")
			replacement.append (": $")
			lastline.replace_substring_all (".o: $", replacement)

			subst_eiffel (lastline)
			subst_platform (lastline)
			subst_dir_sep (lastline)

			-- intermediate files
			if lastline.count>8 and then lastline.substring_index ("ld -r -o", 1) >0 then
				lastline := clone  (options.get_string ("make_intermediate", Void))

				debug ("translate_line_change")
					debug ("input")
						io.putstring ("CHANGE: ")
						io.putstring (lastline)
						io.new_line
					end
				end

				dir := dependent_directories.item

				if dir.item (1) = 'E' then
					selected_object := options.get_string ("eobj_text", Void)
					selected_object.extend (dir.item (dir.count))
					selected_object.extend (')')
				else
					selected_object := options.get_string ("objects__text", Void)
				end

				lastline.replace_substring_all ("$obj", selected_object)

				if precompile then
					lastline.replace_substring_all ("$dir_obj", env.current_working_directory)
					read_next
				else
					lastline.replace_substring_all ("$dir_obj", dir)
				end
			end

			-- externals
			if lastline.count>8 and then lastline.substring (1,9).is_equal (options.get_string("externals_text", Void)) then
				externals := True
			end

			-- .x.o
			if lastline.count>4 and then lastline.substring (1,5).is_equal (".x.o:") then
				lastline.replace_substring_all (".x.o:", options.get_string ("xobj_text", Void))
			end

			-- application name, cecil
			if appl /= Void and then lastline.count>=appl.count and then lastline.substring (1, appl.count).is_equal (appl) then
				translate_appl
			elseif lastline.count>6 and then lastline.substring (1,6).is_equal ("cecil:") then
				translate_cecil
			else
				debug ("translate_line_change")
					debug ("output")
						io.putstring ("OUT: ")
						io.putstring (lastline)
						io.new_line
					end
				end

				makefile.putstring (lastline)
			end

			makefile.new_line
		end

	translate_appl is
			-- Translate application generation code.
		local
			lastline: STRING
			strpos, plp: INTEGER
			uses_precompiled: BOOLEAN -- does the application use precompiled libraries?
			precompiled_lib: STRING -- the name of the precompiled library to use
			precomp_lib_replaced: BOOLEAN -- was the line with $precomplib encountered?
		do
			debug ("progress")
				io.putstring ("%Tappl%N")
			end

			lastline := clone (makefile_sh.laststring)

			debug ("translate_appl")
				debug ("input")
					io.putstring ("IN: ")
					io.putstring (lastline)
					io.new_line
				end
			end

			-- preobj
			from
				if not lastline.empty then
					plp := lastline.substring_index ("preobj", 1)
				end

				if plp > 0 and not precompile then
					uses_precompiled := true
					precompiled_lib := lastline.substring (1, lastline.substring_index ("preobj", 1)-2)
				end
			until
				makefile_sh.end_of_file or else lastline.empty
			loop
				read_next
				lastline := clone (makefile_sh.laststring)

				debug ("translate_appl")
					debug ("input")
						io.putstring ("IN: ")
						io.putstring (lastline)
						io.new_line
					end
				end

				if not lastline.empty then
					plp := lastline.substring_index ("preobj", 1)
				else
					plp := 0
				end

				if plp > 0 and not uses_precompiled and not precompile then
					uses_precompiled := true
					precompiled_lib := lastline.substring (1, lastline.substring_index ("preobj", 1)-2)
				end
			end

			if uses_precompiled then
				from
				until
					precompiled_lib.item (1) > ' '
				loop
					precompiled_lib.remove (1)
				end
			end

			-- precompile or make application?
			if precompile then
				if options.has ("precompile") then
					lastline := clone (options.get_string ("precompile", Void))
				else
					lastline := clone (options.get_string ("precompile_text", Void))
				end
			else
				if options.has ("appl_make") then
					lastline := clone (options.get_string ("appl_make", Void))
				else
					lastline := clone (options.get_string ("appl_text", Void))
				end
			end

			debug ("translate_appl")
				debug ("input")
					io.putstring ("IN: ")
					io.putstring (lastline)
					io.new_line
				end
			end

			lastline.replace_substring_all ("$appl", appl)

			subst_eiffel (lastline)

			-- precompiled library
			if uses_precompiled then
				if not precomp_lib_replaced then
					subst_dir_sep (precompiled_lib)
					lastline.replace_substring_all ("$precompilelib", precompiled_lib)
					precomp_lib_replaced := true
				end
			else
				if not precomp_lib_replaced and then lastline.substring_index("$precompilelib", 1) > 0 then
					lastline.replace_substring_all("@echo $precompilelib\precomp.lib >> $@", "")
					precomp_lib_replaced := true
				end
			end

			subst_library (lastline)

			if not externals then
				lastline.replace_substring_all ("$ (EXTERNALS)", "")
			end

			if not uses_precompiled then

				debug ("translate_appl")
					debug ("output")
						io.putstring ("OUT: ")
						io.putstring (lastline)
						io.new_line
					end
				end

				makefile.putstring (lastline)
				makefile.new_line
			end
		end

	translate_cecil is
			-- Translate cecil.
		local
			lastline: STRING
			library_name:STRING -- the name of the library file
		do
			debug ("progress")
				io.putstring ("%Tcecil%N")
			end

			if options.has ("cecil_make") then
				lastline := clone (options.get_string ("cecil_make", Void))
			else
				lastline := clone (options.get_string ("cecil_text", Void))
			end

			debug ("translate_cecil")
				debug ("input")
					io.putstring ("IN: ")
					io.putstring (lastline)
					io.new_line
				end
			end

			lastline.replace_substring_all ("$appl", appl)
			subst_library (lastline)

			debug ("translate_cecil")
				debug ("output")
					io.putstring ("OUT: ")
					io.putstring (lastline)
					io.new_line
				end
			end

			makefile.putstring (lastline)
			makefile.new_line

			from
			until
				makefile_sh.end_of_file or else makefile_sh.laststring.empty
			loop
				read_next
			end
		end

feature {NONE}	-- substitutions

	subst_eiffel  (line: STRING) is
			-- Replace all occurrences of EIFFEL4 environment variable in `line'
		do
			debug ("subst")
				io.putstring("%Tsubst_eiffel%N")
			end

			if eiffel4 /= Void and then not eiffel4.empty then
				line.replace_substring_all ("\$(EIFFEL4)", eiffel4)
				line.replace_substring_all ("$(EIFFEL4)", eiffel4)
			end
		end

	subst_platform  (line: STRING) is
			-- Replace all occurrences of platform environment variable in `line'
		local
			env_platform: STRING -- the environment's platform variable
		do
			debug ("subst")
				io.putstring("%Tsubst_platform%N")
			end

			if options.has ("platform") then
				line.replace_substring_all ("$(PLATFORM)", options.get_string ("platform", Void))
			else
				env_platform := env.get("platform")
				if env_platform /= Void and then not env_platform.empty then
					line.replace_substring_all ("$(PLATFORM)", env_platform)
				end
			end
		end

	subst_library  (line: STRING) is
			-- Replace all occurrences of library name in `line'
		local
			library_name: STRING
		do
			debug ("subst")
				io.putstring("%Tsubst_library%N")
			end

			library_name := clone (eiffel4)
			library_name.append_character (operating_environment.directory_separator)
			library_name.append ("bench")
			library_name.append_character (operating_environment.directory_separator)
			library_name.append ("spec")
			library_name.append_character (operating_environment.directory_separator)
			library_name.append (options.get_string ("platform", Void))
			library_name.append_character (operating_environment.directory_separator)
			library_name.append ("lib")
			library_name.append_character (operating_environment.directory_separator)
			if finalized then
				library_name.append ("runtime.lib")
			else
				library_name.append ("wkbench.lib")
			end

			line.replace_substring_all ("$library", library_name)
		end

	subst_dir_sep  (line: STRING) is
			-- replace all occurrences of the directory separator in `line'
		local
			dir_sep: STRING
		do
			debug ("subst")
				io.putstring("%Tsubst_dir_sep%N")
			end

			dir_sep := ""
			dir_sep.append_character (operating_environment.directory_separator)

			if not line.empty then
				line.replace_substring_all ("/", dir_sep)
			end
		end

	subst_continuation  (line: STRING) is
			-- replace all occurrences of the line continuation character in `line'
		do
			debug ("subst")
				io.putstring("%Tsubst_continuation%N")
			end

			if line.item (line.count) = '\' and then options.has ("continuation") then
				line.remove (line.count)
				line.append (options.get_string ("continuation", Void))
			end
		end
		
	subst_intermediate (line: STRING) is
			-- replace all occurrences of ?obj#.obj with ?obj#.lib in `line' starting with "all"
		local
			start: INTEGER
		do
			debug ("subst")
				io.putstring("%Tsubst_intermediate%N")
			end

			check
				line.count > 4 and then line.substring_index(options.get_string("all", Void).substring (1, 4), 1) > 0
			end

			line.replace_substring_all (options.get_string ("all", Void).substring (1, 4), options.get_string("all", Void))
			line.replace_substring_all (".o", ".lib")

			start := 1
			
			if line.substring_index (options.get_string ("emain_text", Void), start) > 0 then
				start := line.substring_index (options.get_string ("intermediate_file_ext", Void), start)
				check
					start > 0
				end
				line.replace_substring (options.get_string ("obj_file_ext", Void), start, start+2)
			end
		end
				

feature {NONE} -- Implementation

	env: EXECUTION_ENVIRONMENT is
		once
			!!Result
		end

	search_and_replace(line: STRING) is
			-- search words starting with $ and replace with option or env variable
		local
			wordstart: INTEGER
			wordlength: INTEGER
			word, replacement: STRING		
		do
			debug ("implementation")
				io.putstring("%Tsearch_and_replace%N")
			end

			from
				if not line.empty then
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
					if wordstart > 2 and then line.item (wordstart-1) = '\' and then (line.item (wordstart-2) = '/' or line.item(wordstart-2) = '\' or line.item(wordstart-2) = ' ' or (line.item (wordstart-2) = 'I' and then line.item (wordstart-3) = '-')) then
						line.replace_substring (replacement, wordstart-1, wordstart+wordlength)
					else
						line.replace_substring (replacement, wordstart, wordstart+wordlength)
					end

					wordstart := wordstart + replacement.count -1
				else
					io.error.putstring ("Missing option: ")
					io.error.putstring (word)
					io.error.new_line
					wordstart := wordstart + 1
				end

				-- check for more words to replace
				if wordstart < line.count then
					wordstart := line.index_of ('$', wordstart)
				else
					wordstart := 0
				end
			end
		end

	get_word_to_replace (line: STRING; wordstart: INTEGER): STRING is
			-- word on `line' starting with '$' after `wordstart'
		local
			wordend: INTEGER
		do
			debug ("implementation")
				io.putstring("%Tget_word_to_replace%N")
			end

			from
				wordend := wordstart + 1
				!!Result.make (10)
			until
				wordend > line.count or else line.item (wordend) = ' ' or line.item (wordend) = '/' or line.item (wordend) = '\'
			loop
				Result.extend (line.item (wordend))
				wordend := wordend + 1
			end
		end

	get_replacement (word: STRING): STRING is
			-- find a replacement for `word' in options or environment
		do
			debug ("implementation")
				io.putstring("%Tget_replacement%N")
			end

			if options.has (word) then			
				if word.is_equal ("eiffel4") then
					Result := clone (eiffel4)
				else
					Result := clone (options.get_string (word, Void))
				end
			else
				Result := clone (env.get (word))
			end
		end

	read_next is
			-- read the next line from Makefile.SH if possible
		do
			debug ("implementation")
				io.putstring("%Tread_next%N")
			end

			if not makefile_sh.end_of_file then
				makefile_sh.read_line
			end
		end

	open_files is
			-- open the Makefile.SH and the Makefile to translate
		local
			out_file, error: BOOLEAN
		do
			debug ("implementation")
				io.putstring("%Topen_files%N")
			end

			out_file := false

			if not error then
				!!makefile_sh.make_open_read ("Makefile.SH")
				out_file := true
				!!makefile.make_open_write ("Makefile")
			end

		rescue
			if not out_file then
				io.error.putstring ("Unable to open Makefile.SH for input%N")
			else
				io.error.putstring ("Unable to open Makefile for output%N")
			end

			error := true
			retry
		end

	close_files is
			-- close the Makefile.SH and the Makefile
		do
			debug ("implementation")
				io.putstring("%Tclose_files%N")
			end

			if makefile_sh /= Void and then not makefile_sh.is_closed then
				makefile_sh.close
			end

			if makefile /= Void and then not Makefile.is_closed then
				makefile.close
			end
		end

	strip_parenthesis  (word: STRING) is
			-- remove enclosing parenthesis from word.
		do
			debug ("implementation")
				io.putstring("%Tstrip_parenthesis%N")
			end

			if word.item (1) = '(' then
				word.tail (word.count-1)
			
				if word.item (word.count) = ')' then
					word.head (word.count-1)
				end
			end
		end

	config_eif_fn: FILE_NAME is
			-- the full filename for the CONFIG.EIF file
			-- currently: $EIFFEL4|bench|spec|$PLATFORM|es3sh|config.eif
		local
			platform: STRING
			temp_result: STRING
		do
			debug ("implementation")
				io.putstring("%Tconfig_eif_fn%N")
			end

			platform := env.get ("PLATFORM")
			if platform = Void or else platform.empty then
				io.error.putstring ("PLATFORM environment variable not set%N")
			end

			temp_result := clone (eiffel4)
			temp_result.append_character (operating_environment.directory_separator)
			temp_result.append ("bench")
			temp_result.append_character (operating_environment.directory_separator)
			temp_result.append ("spec")
			temp_result.append_character (operating_environment.directory_separator)
			temp_result.append (platform)
        		temp_result.append_character (operating_environment.directory_separator)
			temp_result.append ("es4sh")
			temp_result.append_character (operating_environment.directory_separator)
			temp_result.append ("config.eif")

			!!Result.make_from_string (temp_result)
		end
		
end -- class MAKEFILE_TRANSLATOR
