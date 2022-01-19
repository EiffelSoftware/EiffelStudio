note
	description: "[
			Tool to build+execute an Eiffel project (via ecf file).
			Then the executable is stored in a cache.
			The executable is recompiled if changes occurred (for now, just looking at ecf modification time).
						
			In addition, it provides operation to just "build" the project.
		]"

class
	EIFFEL_SCRIPT

inherit
	SHARED_EXECUTION_ENVIRONMENT
		rename
			print as ascii_print
		end

	EIFFEL_LAYOUT
		rename
			print as ascii_print
		end

	LOCALIZED_PRINTER
		rename
			print as ascii_print,
			localized_print as print,
			localized_print_error as print_error
		end

create
	make

feature {NONE} -- Creation

	make
			-- Instantiate Current object.
		local
			arr:  ARRAY [READABLE_STRING_32]
			target: detachable PATH
			v: READABLE_STRING_32
			i,n: INTEGER
			l_display_help: BOOLEAN
			op: NATURAL_8
			l_build_output: detachable PATH
			params: detachable EIFFEL_SCRIPT_PARAMETERS
			build_params: EIFFEL_SCRIPT_BUILD_PARAMETERS
			launch_params: EIFFEL_SCRIPT_LAUNCH_PARAMETERS
		do
			arr := execution_environment.arguments.argument_array
			n := arr.upper
			i := arr.lower + 1 -- Skip executable name.
			if i > n then
				op := op_help
			else
				v := arr [i] -- First
				if v.same_string_general ("build") then
					op := op_build
					create {EIFFEL_SCRIPT_BUILD_PARAMETERS} params.make (arr.subarray (i + 1, n))
				else
					op := op_launch
					create {EIFFEL_SCRIPT_LAUNCH_PARAMETERS} params.make (arr.subarray (i, n))
				end
			end

			initialize_environment

			if params = Void then
				display_usage
			elseif params.has_error then
				if attached params.error_message as err then
					print ("ERROR: ")
					print (err)
					print ("%N")
				end
				display_usage
			else
				is_verbose := params.is_verbose
				inspect
					op
				when op_launch then
					if
						attached {EIFFEL_SCRIPT_LAUNCH_PARAMETERS} params as l_launch_params and then
						attached l_launch_params.ecf_location as l_ecf
					then
						is_build_forced := l_launch_params.is_build_forced
						check_level := l_launch_params.check_level
						launch (l_ecf, l_launch_params.ecf_target, l_launch_params.args)
					else
						display_usage
					end
				when op_build then
					if
						attached {EIFFEL_SCRIPT_BUILD_PARAMETERS} params as l_build_params and then
						attached l_build_params.ecf_location as l_ecf
					then
						build (l_ecf, l_build_params.ecf_target, l_build_params.resources, l_build_params.executable_path)
					else
						display_usage
					end
				else
					display_usage
				end
			end
			if has_error then
				{EXCEPTIONS}.die (-1)
			end
		end

feature {NONE} -- Constants	

	op_undefined: NATURAL_8 = 0
	op_launch: NATURAL_8 = 1
	op_build: NATURAL_8 = 2
	op_help: NATURAL_8 = 3

feature {NONE} -- Initialization

	initialize_environment
		local
			ut: FILE_UTILITIES
			dir: PATH
		do
			if not is_eiffel_layout_defined then
				set_eiffel_layout (create {EC_EIFFEL_LAYOUT})
			end
			if attached execution_environment.item ("EIFFEL_SCRIPT_DIR") as d then
				create dir.make_from_string (d)
			elseif
				attached eiffel_layout.user_files_path as p and then
				ut.directory_path_exists (p)
			then
				dir := p.extended (".apps")
			elseif attached execution_environment.home_directory_path as p then
				dir := p.extended (".es").extended (".apps")
			else
				create dir.make_current
			end

			if attached execution_environment.item ("EIFFEL_SCRIPT_CACHE_DIR") as d then
				create appcache_location.make_from_string (d)
			else
				appcache_location := dir.extended ("cache")
			end

			if attached execution_environment.item ("EIFFEL_SCRIPT_COMP_DIR") as d then
				create appcomp_location.make_from_string (d)
			else
				appcomp_location := dir.extended ("comp")
			end

			ut.create_directory_path (appcache_location)
			ut.create_directory_path (appcomp_location)
		end

feature -- Access

	is_verbose: BOOLEAN

	has_error: BOOLEAN
			-- Error occurred.

	is_build_forced: BOOLEAN

	check_level: NATURAL_8

	is_deep_check: BOOLEAN
		do
			Result := check_level > 0
		end

	appcache_location: PATH

	appcomp_location: PATH

feature -- Execution

	launch (a_ecf: READABLE_STRING_GENERAL; a_target_name: detachable READABLE_STRING_GENERAL; args: LIST [READABLE_STRING_GENERAL])
		require
			is_ecf: a_ecf.ends_with (".ecf")
		local
			p_ecf: PATH
			err: STRING_32
		do
			if a_ecf.starts_with ("iron:") then
				report_error ("iron locations are not yet supported!%N")
			else
				p_ecf := (create {PATH}.make_from_string (a_ecf)).absolute_path.canonical_path
				if attached ecf_system (p_ecf) as sys then
					if attached ecf_targets (sys, a_target_name) as tgts then
						if tgts.count > 1 then
							create err.make_empty
							across
								tgts as ic
							loop
								if not err.is_empty then
									err.append_string_general (", ")
								end
								err.append (ic.item.name)
							end
							report_error ({STRING_32} "Multiple targets, select one: " + err + " ...%N")
						elseif attached tgts.first as tgt then
							launch_system (sys, tgt, args)
						else
							report_error ("Missing ecf target!%N")
						end
					else
						report_error ("Missing ecf target!%N")
					end
				else
					report_error ("Invalid ecf file!%N")
				end
			end
		end

	build (a_ecf: READABLE_STRING_GENERAL; a_target_name: detachable READABLE_STRING_GENERAL; a_resources: detachable ITERABLE [PATH]; a_exec_output_path: detachable PATH)
		require
			is_ecf: a_ecf.ends_with (".ecf")
		local
			p_ecf, p: PATH
			p_output_dir_location, p_output_file_location: PATH
			s: STRING_32
			err: STRING_32
			ut: FILE_UTILITIES
		do
			if a_ecf.starts_with ("iron:") then
				report_error ("iron locations are not yet supported!%N")
			else
				p_ecf := (create {PATH}.make_from_string (a_ecf)).absolute_path.canonical_path

				create s.make_from_string_general ("Build project ")
				s.append (p_ecf.name)
				if a_target_name /= Void then
					s.append_string_general (" (target:")
					s.append_string_general (a_target_name)
					s.append_string_general (")")
				end
				s.append_string_general (" and save generated executable")
				if a_exec_output_path /= Void then
						-- TODO: check if path is folder or executable name.
					if ut.directory_path_exists (a_exec_output_path) then
						p_output_dir_location := a_exec_output_path
						s.append_string_general (" in ")
						s.append (p_output_dir_location.name)
					else
						p_output_file_location := a_exec_output_path
						s.append_string_general (" as ")
						s.append (p_output_file_location.name)
					end
				else
					s.append_string_general (" in current folder")
				end
				s.append_string_general (" .%N")
				print (s)
				if attached ecf_system (p_ecf) as sys then
					if attached ecf_targets (sys, a_target_name) as tgts then
						if tgts.count > 1 then
							create err.make_empty
							across
								tgts as ic
							loop
								if not err.is_empty then
									err.append_string_general (", ")
								end
								err.append (ic.item.name)
							end
							report_error ({STRING_32} "Multiple targets, select one: " + err + " ...%N")
						elseif attached tgts.first as tgt then
							if p_output_file_location /= Void then
								p := p_output_file_location
							else
								p := executable_name (sys, tgt)
								if p_output_dir_location /= Void then
									p := p_output_dir_location.extended_path (p)
								end
							end
							build_executable (sys, tgt, a_resources, p)
							if not has_error then
								print ({STRING_32} "Executable generated as " + p.name + " .%N")
							end
						else
							report_error ("Missing target!%N")
						end
					else
						report_error ("Missing target!%N")
					end
				else
					report_error ("Invalid ecf file!%N")
				end
			end
		end

feature {NONE} -- Execution

	launch_system (a_system: CONF_SYSTEM; a_target: CONF_TARGET; args: LIST [READABLE_STRING_GENERAL])
		local
			ut: FILE_UTILITIES
			p: PATH
		do
			p := executable_location (a_system, a_target)
			if
				not ut.file_path_exists (p)
				or else	is_build_forced
				or else is_file_more_recent_than (a_system.file_path, p)
				or else (check_level /= {EIFFEL_SCRIPT_LAUNCH_PARAMETERS}.check_level_project and then is_project_more_recent_than (a_system, a_target, p))
			then
					-- ecf file is more recent than cached executable
				build_executable (a_system, a_target, Void, p) -- TODO: check if launch may also want to pass resources...
			end
			if ut.file_path_exists (p) then
				launch_executable (p, args)
			end
		end

	build_executable (a_system: CONF_SYSTEM; a_target: CONF_TARGET; a_resources: detachable ITERABLE [PATH]; a_executable_target_location: PATH)
		require
			target_location_not_a_directory: not (create {FILE_UTILITIES}).directory_path_exists (a_executable_target_location)
		local
			l_comp_loc: PATH
			proc: BASE_PROCESS
			ut: FILE_UTILITIES
			params: ARRAYED_LIST [READABLE_STRING_GENERAL]
			ecb_cmd: PATH
			l_compiled_executable: PATH
			t: CONF_TARGET
			l_old_ise_ec_flags: detachable READABLE_STRING_GENERAL
		do
			l_comp_loc := compilation_location (a_system, a_target.name)
			ut.create_directory_path (l_comp_loc)
				-- Prepare compilation
			if a_resources /= Void then
				across
					a_resources as res
				loop
					if ut.file_path_exists (res.item) then
						if attached res.item.entry as l_entry then
							ut.copy_file_path (res.item, l_comp_loc.extended_path (l_entry))
						else
							check has_entry: False end
						end
					end
				end
			end
			create params.make (10)
			params.extend ("-config")
			params.extend (a_system.file_name)
			params.extend ("-target")
			params.extend (a_target.name)
			params.extend ("-finalize")
			params.extend ("-c_compile")
			params.extend ("-clean")
			params.extend ("-batch")
			params.extend ("-project_path")
			params.extend (l_comp_loc.name)
			ecb_cmd := eiffel_layout.bin_path.extended ("ecb" + eiffel_layout.executable_suffix)
				-- NOTE: do not use `eiffel_layout.ec_command_name`, as it may have issue.
			proc := (create {BASE_PROCESS_FACTORY}).process_launcher (ecb_cmd.name, params, l_comp_loc.name)
			if not is_verbose then
				proc.redirect_output_to_file (l_comp_loc.extended ("build.log").name)
				proc.redirect_error_to_same_as_output
			end
			l_old_ise_ec_flags := execution_environment.item ("ISE_EC_FLAGS")
			if l_old_ise_ec_flags /= Void then
					-- unset any ISE_EC_FLAGS as it may conflict with the current build process.
				execution_environment.put ("", "ISE_EC_FLAGS")
			end
			if attached execution_environment.item ("EIFFEL_EC_FLAGS") as l_eiffel_ec_flags then
				if is_verbose then
					log ("Set the ISE_EC_FLAGS variable using EIFFEL_EC_FLAGS variable value.%N")
					log ({STRING_32} " - ISE_EC_FLAGS=" + l_eiffel_ec_flags + "%N")
				end
				execution_environment.put (l_eiffel_ec_flags, "ISE_EC_FLAGS")
			elseif l_old_ise_ec_flags/= Void and is_verbose then
				log ("Unset existing ISE_EC_FLAGS to avoid conflict (use EIFFEL_EC_FLAGS if really needed).%N")
			end

			proc.launch
			if proc.launched then
				log ("Building executable...%N")
				proc.wait_for_exit
				l_compiled_executable := l_comp_loc.extended ("EIFGENs").extended (a_target.name).extended ("F_code").extended_path (executable_name (a_system, a_target))
				if
					proc.has_exited and then
					ut.file_path_exists (l_compiled_executable)
				then
					ut.create_directory_path (a_executable_target_location.parent)
					ut.copy_file_path (l_compiled_executable, a_executable_target_location)
					ensure_build_is_executable (a_executable_target_location)

					log ("Build succeed.%N")
					rmdir (l_comp_loc)

					build_compilation_index (a_system, a_target)
				else
					report_error ("Build failed! (user verbose option to get additional information)")
				end
			else
				report_error ("Unable to start building the executable!")
			end
			if l_old_ise_ec_flags /= Void then
				execution_environment.put (l_old_ise_ec_flags, "ISE_EC_FLAGS")
			end
		end

	build_compilation_index (a_system: CONF_SYSTEM; a_target: CONF_TARGET)
		local
			l_idx_location: PATH
			idx: EIFFEL_SCRIPT_COMPILATION_INDEX_BUILDER
		do
			log ("Building compilation index...%N")
			create idx.make
			idx.process (a_target)
			l_idx_location := index_location (a_system, a_target)
			idx.compilation_index.save_to (l_idx_location)
		end

	launch_executable (loc: PATH; args: LIST [READABLE_STRING_GENERAL])
		local
			proc: BASE_PROCESS
		do
			proc := (create {BASE_PROCESS_FACTORY}).process_launcher (loc.name, args, Void)
--			proc.redirect_output_to_stream
--			proc.redirect_error_to_stream
--			proc.redirect_input_to_stream
			proc.launch
			if proc.launched then
				proc.wait_for_exit
			else
				report_error ("Could not launch execution!")
			end
		end

	ensure_build_is_executable (a_path: PATH)
		local
			f: RAW_FILE
		do
			create f.make_with_path (a_path)
			f.add_permission ("u", "rwx")
		end

feature -- Query

	ecf_system (a_ecf: PATH): detachable CONF_SYSTEM
		local
			loader: CONF_LOAD
		do
			create loader.make (create {CONF_PARSE_FACTORY})
			loader.retrieve_configuration (a_ecf.name)
			Result := loader.last_system
		end

	ecf_targets (sys: CONF_SYSTEM; a_target_name: detachable READABLE_STRING_GENERAL): detachable LIST [CONF_TARGET]
		local
			nb: INTEGER
			tgt: CONF_TARGET
		do
			if a_target_name /= Void then
				create {ARRAYED_LIST [CONF_TARGET]} Result.make (1)
				across
					sys.compilable_targets as ic
				until
					tgt /= Void
				loop
					tgt := ic.item
					if not a_target_name.is_case_insensitive_equal (tgt.name) then
						tgt := Void
					end
				end
				if tgt /= Void then
					Result.extend (tgt)
				end
			else
				tgt := sys.application_target
				if tgt = Void then
					tgt := sys.library_target
					if tgt /= Void and then not is_application_target (tgt) then
						tgt := Void
					end
					if
						tgt = Void and then
						attached sys.compilable_targets as l_comp_targets
					then
						create {ARRAYED_LIST [CONF_TARGET]} Result.make (l_comp_targets.count)
						across
							l_comp_targets as ic
						loop
							if is_application_target (ic.item) then
								Result.extend (ic.item)
							end
						end
					end
				end
				if tgt /= Void then
					if Result = Void then
						create {ARRAYED_LIST [CONF_TARGET]} Result.make (1)
					end
					Result.extend (tgt)
				end
			end
			if Result /= Void and then Result.is_empty then
				Result := Void
			end
		end

	is_application_target (tgt: CONF_TARGET): BOOLEAN
		do
			Result := not tgt.is_abstract and then
						attached tgt.root as l_root and then
						not l_root.is_all_root
		end

	ecf_target (sys: CONF_SYSTEM; a_target_name: detachable READABLE_STRING_GENERAL): detachable CONF_TARGET
		local
			nb: INTEGER
			err: STRING_32
		do
			if attached ecf_targets (sys, a_target_name) as lst and then not lst.is_empty then
				if lst.count = 1 then
					Result := lst.first
				else
					create err.make_empty
					across
						lst as ic
					loop
						if not err.is_empty then
							err.append (", ")
						end
						err.append (ic.item.name)
					end
					err.prepend ({STRING_32} "Multiple targets: ")
					err.extend ('%N')
					print_error (err)
				end
			end
		end

	executable_location (a_system: CONF_SYSTEM; a_target: detachable CONF_TARGET): PATH
		local
			l_app_id: STRING_32
			tgt: detachable CONF_TARGET
		do
			create l_app_id.make_from_string_general (a_system.name)
			if a_target /= Void then
				tgt := a_target
			else
				tgt := ecf_target (a_system, Void)
			end
			if tgt /= Void then
				l_app_id.append_character ('.')
				l_app_id.append (tgt.name)
			end
			if not a_system.is_generated_uuid then
				l_app_id.append_character ('.')
				l_app_id.append_string_general (a_system.uuid.out)
			end
			Result := appcache_location.extended (l_app_id).extended_path (executable_name (a_system, tgt))
		end

	index_location (a_system: CONF_SYSTEM; a_target: detachable CONF_TARGET): PATH
		local
			l_app_id: STRING_32
			l_index_name: PATH
		do
			create l_app_id.make_from_string_general (a_system.name)
			if not a_system.is_generated_uuid then
				l_app_id.append_character ('.')
				l_app_id.append_string_general (a_system.uuid.out)
			end
			l_index_name := executable_name (a_system, a_target).appended_with_extension ("idx")
			Result := appcache_location.extended (l_app_id).extended_path (l_index_name)
		end

	executable_name (a_system: CONF_SYSTEM; a_target: detachable CONF_TARGET): PATH
		local
			s: STRING_32
			tgt: detachable CONF_TARGET
		do
			s := a_system.name
			if a_target /= Void then
				tgt := a_target
			else
				tgt := ecf_target (a_system, Void)
			end
			if
				tgt /= Void and then
				attached tgt.setting_executable_name as l_exe_name and then
				not l_exe_name.is_whitespace
			then
				s := l_exe_name
			end
			create Result.make_from_string (s)
			Result := Result.appended (eiffel_layout.executable_suffix)
		end

	compilation_location (a_system: CONF_SYSTEM; a_target_name: detachable READABLE_STRING_GENERAL): PATH
		local
			l_app_id: STRING_32
			c,p: CHARACTER_32
			i,n: INTEGER
		do
			if
				attached ecf_target (a_system, a_target_name) as tgt
			then
				create l_app_id.make_from_string_general (a_system.name)
				if not a_system.is_generated_uuid then
					l_app_id.append_character ('.')
					l_app_id.append_string_general (a_system.uuid.out)
				end
				l_app_id.extend ('.')
				l_app_id.append (executable_name (a_system, tgt).name)
				Result := appcomp_location.extended (l_app_id)
			else
				create l_app_id.make (a_system.name.count)
				across
					a_system.name as ic
				loop
					c := ic.item
					if c.is_alpha_numeric then
						p := c
						l_app_id.extend (ic.item)
					elseif p /= '-' then
						p := '-'
						l_app_id.extend ('-')
					end
				end
				Result := appcomp_location.extended (l_app_id)
			end
		end

feature {NONE} -- Implementation

	rmdir (p: PATH)
		local
			d: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create d.make_with_path (p)
				if d.exists then
					d.recursive_delete
				end
			end
		rescue
			retried := True
			retry
		end

	log (m: READABLE_STRING_GENERAL)
		do
			if is_verbose then
				print (m)
			end
		end

	report_error (err: READABLE_STRING_GENERAL)
		do
			has_error := True
			print_error (err)
			print_error ("%N")
		end

	is_file_more_recent_than (loc: PATH; ref: PATH): BOOLEAN
		do
			Result := (create {RAW_FILE}.make_with_path (loc)).date > (create {RAW_FILE}.make_with_path (ref)).date
		end

	is_project_more_recent_than (a_system: CONF_SYSTEM; a_target: CONF_TARGET; ref: PATH): BOOLEAN
		local
			idx: EIFFEL_SCRIPT_COMPILATION_INDEX
			loc: PATH
			fut: FILE_UTILITIES
		do
			Result := is_file_more_recent_than (a_system.file_path, ref)
			if not Result then
				loc := index_location (a_system, a_target)
				if fut.file_path_exists (loc) then
					log ("Checking if recompilation is needed...%N")
					create idx.make_from_path (index_location (a_system, a_target))
					Result := idx.is_project_more_recent_than (ref)
				else
					Result := True
				end
			end
		end

feature -- Usage

	display_usage
		local
			cmd: READABLE_STRING_32
			p: PATH
		do
			cmd := execution_environment.arguments.command_name
			create p.make_from_string (cmd)
			if attached p.entry as e then
				cmd := e.name
				if attached e.extension as ext then
					cmd := cmd.head (cmd.count - 1 - ext.count)
				end
			end
			print ("USAGE:%N")
			print ("  ")
			print (cmd)
			print (" (-v|--verbose) (-h|--help) (-b|--build) (--check class,project) (--target ecf_target_name) (--resource file_name)* <project.ecf> ...%N")
			print ("  ")
			print (cmd)
			print (" build (-v|--verbose) (--target ecf_target_name) (--resource file_name)* <project.ecf> <output_executable_path> ...%N")
			print ("%N")
			print ("[
COMMANDS:
  <project.ecf> ...   : build once and launch <project.ecf> execution.
  build               : build project and save executable as <output_executable_path>
  						(no argument should be before the 'build' word!).


OPTIONS:
  --target <ecf-target-name>    : optional target name.
  --resource <file-name>        : optional resource file name to copy in the parent directory of the EIFGENs
                                : such as *.rc files (multiple occurrences allowed).
  --check <level>               : check level for recompilation, either class (default), or project.
                                : class   = check timestamp of system class files, 
                                :           and ecf files for included libraries 
                                :          (ignoring classes from libraries).
                                : project = only check the timestamp of main project ecf file.

  -b --build                    : force a fresh system build.
  -o --executable-output <path> : build and save executable as <path>.
                                : without any execution.!

  -v --verbose                  : verbose output.
  -h --help                     : display this help.
  ...                           : arguments for the <project.ecf> execution.

Note: you can overwrite default value, using
  EIFFEL_SCRIPT_DIR       : root directory for eiffel script app (default under Eiffel user files/.apps) 
  EIFFEL_SCRIPT_CACHE_DIR : directory caching the compiled executables ($EIFFEL_SCRIPT_DIR/cache) 
  EIFFEL_SCRIPT_COMP_DIR : directory caching the EIFGENs compilation ($EIFFEL_SCRIPT_DIR/comp)

]")

		end


end
