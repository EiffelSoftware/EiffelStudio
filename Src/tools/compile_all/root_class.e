note
	description: "System's root class."
	date: "$Date$"
	revision: "$Revision$"
	ca_ignore: "CA033", "CA033: too large class"

class
	ROOT_CLASS

inherit
	LOCALIZED_PRINTER

	EIFFEL_LAYOUT

	CONF_VALIDITY
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation procedure.
		do
				-- setup env
			set_eiffel_layout (create {CAT_EIFFEL_ENV})
			eiffel_layout.check_environment_variable

			initialize_interface_texts
				-- get arguments
			create arguments.make
			create failed_compilations.make
			base_location := {EXECUTION_ENVIRONMENT}.current_working_path
			arguments.execute (agent start)
		end

feature {NONE} -- Implementation: results

	failed_compilations: LINKED_LIST [TUPLE [log: detachable PATH; ecf: PATH; system, target, uuid: READABLE_STRING_32]]

	failed_compilations_count: INTEGER
			-- Count of failed compilations
		do
			Result := failed_compilations.count
		end

	passed_compilations_count: INTEGER
			-- Count of passed compilations

	ignored_compilations_count: INTEGER
			-- Count of ignored compilations

	internal_error_compilations_count: INTEGER
			-- Count of internal error compilations

	total_count: INTEGER
			-- Total number of ECFs under processing. Only accurate at the end.
		do
			Result := passed_compilations_count + failed_compilations_count + ignored_compilations_count + internal_error_compilations_count
		end

	report_internal_error (a_action_mode: READABLE_STRING_8; a_target: CONF_TARGET)
			-- Report tool internal error
		do
			internal_error_compilations_count := internal_error_compilations_count + 1
		end

	report_passed (a_action_mode: READABLE_STRING_32; a_target: CONF_TARGET)
			-- Report passed compilation
		do
			passed_compilations_count := passed_compilations_count + 1
		end

	report_failed (a_action_mode: READABLE_STRING_8; a_target: CONF_TARGET)
			-- Report failed compilation
		local
			l_logfn: detachable PATH
		do
			if arguments.is_log_verbose then
				l_logfn := logs_filename (a_action_mode, a_target)
			end
			failed_compilations.extend ([l_logfn, a_target.system.file_path, a_target.system.name, a_target.name, a_target.system.uuid.string])
		end

	report_ignored (a_ecf: PATH; a_target: detachable CONF_TARGET)
			-- Report skipped or ignored compilation
		do
			ignored_compilations_count := ignored_compilations_count + 1
		end

feature {NONE} -- Implementation

	arguments: ARGUMENT_PARSER
			-- Command line arguments.

	base_location: PATH
			-- Base location where to look for .ecf files.

	ignores: detachable STRING_TABLE [STRING_TABLE [BOOLEAN]]
			-- Ignored files/targets.

	directory_ignores: detachable STRING_TABLE [READABLE_STRING_GENERAL]
			-- Ignored directories

	regexp_ignores: detachable ARRAYED_LIST [REGULAR_EXPRESSION]
			-- Ignored regexp

	path_regexp_ignored (p: READABLE_STRING_32): BOOLEAN
			-- Is path ignored in relation with `regexp_ignores'?
		local
			u: UTF_CONVERTER
		do
			if
				attached regexp_ignores as l_regexp_ignores
			then
				from
					l_regexp_ignores.start
				until
					l_regexp_ignores.after or Result
				loop
					if attached l_regexp_ignores.item as rexp then
						rexp.match (u.string_32_to_utf_8_string_8 (p))
						Result := rexp.has_matched
						rexp.wipe_out
					end
					l_regexp_ignores.forth
				end
			end
		end

	start
			-- Starts application
		require
			arguments_attached: arguments /= Void
		do
			base_location := arguments.location
			if attached arguments.ignore as l_ignore then
				load_ignores (l_ignore)
			end
			if arguments.is_ecb then
				;(create {EXECUTION_ENVIRONMENT}).put ("ecb", "EC_NAME")
			end
			set_interface_texts_from_argument (arguments)

			localized_print ({STRING_32} "Base location: %"" + base_location.name + "%"")
			io.put_new_line
			io.put_new_line
			process_directory (base_location)

			io.put_new_line
			localized_print("Passed: ")
			io.put_integer (passed_compilations_count)
			localized_print (" / ")
			io.put_integer (total_count)
			localized_print("  (")
			if total_count = 0 then
				io.put_integer (100)
			else
				io.put_integer (((passed_compilations_count / total_count) * 100).truncated_to_integer)
			end
			localized_print ("%%)")
			io.put_new_line

			localized_print ("Failed: ")
			io.put_integer (failed_compilations_count)
			localized_print (" / ")
			io.put_integer (total_count)
			localized_print ("  (")
			if total_count = 0 then
				io.put_integer (100)
			else
				io.put_integer (((failed_compilations_count / total_count) * 100).truncated_to_integer)
			end
			localized_print ("%%)")
			io.put_new_line

			localized_print ("Ignored: ")
			io.put_integer (ignored_compilations_count)
			localized_print (" / ")
			io.put_integer (total_count)
			localized_print ("  (")
			if total_count = 0 then
				io.put_integer (100)
			else
				io.put_integer (((ignored_compilations_count / total_count) * 100).truncated_to_integer)
			end
			localized_print ("%%)")
			io.put_new_line

			io.put_new_line
			if arguments.list_failures then
				io.put_new_line
				if failed_compilations_count > 0 then
					localized_print (failed_compilations_count.out + " failure(s):")
					io.put_new_line
					across
						failed_compilations as c
					loop
						localized_print ({STRING_32} "" + c.item.system + "-" + c.item.uuid + "-" + c.item.target + " (" + c.item.ecf.name + ")")
						if attached c.item.log as l_logfn then
							localized_print ({STRING_32} ": " + l_logfn.name)
							show_log_content (l_logfn)
						end
						io.put_new_line
					end
				end
			end

			if failed_compilations_count > 0 then
				(create {EXCEPTIONS}).die (failed_compilations_count)
			end
		end

	set_base_location (loc: PATH)
			-- Set `base_location' to `loc'
		require
			loc_not_empty: not loc.is_empty
		do
			base_location := loc
		ensure
			base_location_set: base_location = loc
		end

	load_ignores (a_file: READABLE_STRING_32)
			-- Retrieve list of ignored files/targets from `a_file'.
		require
			a_file_ok: a_file /= Void
		local
			l_ini_loader: INI_DOCUMENT_READER
			l_file: PLAIN_TEXT_FILE
			l_ignored_files: ARRAYED_LIST [INI_SECTION]
			l_ini_section: INI_SECTION
			l_ignored_targets: ARRAYED_LIST [INI_LITERAL]
			l_ig_target: STRING_TABLE [BOOLEAN]
			l_actual_path: STRING_32
			l_label: STRING
			rexp: REGULAR_EXPRESSION
			ignored_directories: like directory_ignores
			ignored_expressions: like regexp_ignores
			ignored_targets: like ignores
		do
			create l_file.make_with_name (a_file)
			if not l_file.exists or else not l_file.is_readable then
				display_error ({STRING_32} "Could not open ignore file "+a_file)
			else
				l_file.open_read
				create l_ini_loader.make
				l_ini_loader.read_from_file (l_file, False)
				l_file.close
				if attached l_ini_loader.read_document as l_ini_file then
					l_ignored_files := l_ini_file.sections
					create ignored_targets.make (l_ignored_files.count)
					ignores := ignored_targets
					create ignored_directories.make (l_ignored_files.count)
					directory_ignores := ignored_directories
					create ignored_expressions.make (l_ignored_files.count)
					regexp_ignores := ignored_expressions
					across
						l_ignored_files as s
					loop
							-- every section represents one configuration file
						l_ini_section := s.item
						l_label := l_ini_section.label
						if l_label.starts_with ("regexp=") then
							create rexp
							l_label := l_label.substring (("regexp=").count + 1, l_label.count)
							l_label.left_adjust
							l_label.right_adjust
							rexp.compile (l_label)
							if rexp.error_message /= Void then
								ignored_expressions.extend (rexp)
							end
						else
							l_label := translated_platform_path (l_label)
							l_actual_path := (create {ENV_INTERP}).interpreted_string_32 (l_label)
							create l_file.make_with_name (l_actual_path)
							if not l_file.exists then
								display_error ("Could not read file/path "+l_label+"!")
							elseif l_file.is_directory then
								ignored_directories.force (l_actual_path, l_actual_path)
							else
									-- no literals implies the whole configuration file is ignored, else each literal represents an ignored target
								l_ignored_targets := l_ini_section.literals
								create l_ig_target.make_caseless (l_ignored_targets.count)
								across
									l_ignored_targets as t
								loop
									l_ig_target.force (True, t.item.name)
								end
								ignored_targets.force (l_ig_target, l_actual_path)
							end
						end
					end
				else
					across
						l_ini_loader.errors as e
					loop
						display_error (e.item.message)
					end
				end
			end
		end

	process_directory (a_directory: PATH)
			-- Process `a_directory'.
		require
			a_directory_ok: a_directory /= Void and then not a_directory.is_empty
		local
			l_dir: DIRECTORY
			l_file: RAW_FILE
			l_fn: PATH
			l_entries: ARRAYED_LIST [PATH]
		do
			if path_regexp_ignored (a_directory.name) then
				display_error ({STRING_32} "Directory ignored: " + a_directory.name + " .")
			else
				create l_dir.make_with_path (a_directory)
				if not l_dir.is_readable then
					display_error ({STRING_32} "Could not read "+a_directory.name+"!")
				elseif attached directory_ignores as i implies not i.has (a_directory.name) then
						-- Process only if the directory is not excluded.
						-- 1 - process config files with an ecf extension
					l_entries := l_dir.entries
					;(create {QUICK_SORTER [PATH]}.make (create {COMPARABLE_COMPARATOR [PATH]})).sort (l_entries)
					across l_entries as l_entry loop
						if not l_entry.item.is_current_symbol and not l_entry.item.is_parent_symbol then
							l_fn := a_directory.extended_path (l_entry.item)
							create l_file.make_with_path (l_fn)
							if l_file.exists then
								if l_file.is_directory then
									process_directory (l_fn)
								elseif l_fn.has_extension ("ecf") and l_file.is_plain then
									process_configuration (l_fn, a_directory)
								end
							end
						end
					end
				end
			end
		end

	process_configuration (a_file, a_dir: PATH)
			-- Process configuration file `a_file' located in `a_dir'
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
			a_dir_ok: a_dir /= Void and then not a_dir.is_empty
		local
			l_loader: CONF_LOAD
			l_ignored_targets: STRING_TABLE [BOOLEAN]
			l_skip_dotnet, l_is_ignored: BOOLEAN
			l_target: CONF_TARGET
			l_platform: IMMUTABLE_STRING_32
		do
			if attached ignores as l_ignores then
				l_ignored_targets := l_ignores.item (a_file.name)
			end
				--| if the file is not listed in the excludes or explicitely lists excluded targets
			if l_ignored_targets = Void or else not l_ignored_targets.is_empty then
				create l_loader.make (create {CONF_PARSE_FACTORY})
				l_loader.retrieve_configuration (a_file.name)
				if l_loader.is_error then
					display_error ({STRING_32} "Could not retrieve configuration " + a_file.name + "!")
				elseif l_loader.last_redirection /= Void then
					display_error ({STRING_32} "Ignore redirection configuration " + a_file.name + "!")
				else
					check
						from_condition: attached l_loader.last_system as system
					then
						l_skip_dotnet := arguments.skip_dotnet
						l_platform := arguments.platform_option
						across system.targets as l_cursor loop
							l_target := l_cursor.item
							if
								(l_target.root /= Void and then not l_target.is_abstract)  -- Compilable targets
								or attached {CONF_REMOTE_TARGET_REFERENCE} l_target.parent_reference -- Consider remote targets as compilable for now
							then
								l_is_ignored := l_ignored_targets /= Void and then l_ignored_targets.has (l_target.name)
								if not l_is_ignored then
										-- If we are asking for a .NET code generation and we are on a platform
										-- that does not support .NET or that we asked to ignore .NET, we ignore it.
									l_is_ignored := l_target.setting_msil_generation and l_skip_dotnet
								end
								if not l_is_ignored then
										-- If a platform is set in the ECF, we check that
										-- 1- if the platform option was set that it should be the same.
										-- 2- if the platform option is not set that it should be the same as the current platform.
										-- Otherwise we we ignore this target since it means it will most likely not compile.
									if not l_target.setting_platform.is_empty then
										if not l_platform.is_empty then
											l_is_ignored := not l_platform.is_case_insensitive_equal (l_target.setting_platform)
										else
											l_is_ignored := get_platform (l_target.setting_platform) /= current_platform
										end
									else
											-- If we have requested an exclusive platform, e.g. via `macosx!', and that the ECF
											-- is not specifying any platform, then we should ignore it since we requested
											-- to only process ECF which targets a specific platform.
										l_is_ignored := arguments.is_platform_exclusive
									end
								end

								if l_is_ignored then
									output_action (interface_text_target, l_target)
									report_ignored (a_file, l_target)
									output_status_ignored
									io.new_line
								else
									process_target (l_target, a_dir)
								end
							end
						end
					end
				end
			end
		end

	process_target (a_target: CONF_TARGET; a_dir: PATH)
			-- Compile `a_target' located in `a_dir'.
		require
			a_target_ok: a_target /= Void
			a_dir_ok: a_dir /= Void and then not a_dir.is_empty
		local
			l_is_clean: BOOLEAN
			b: BOOLEAN
		do
			if arguments.is_parse_only then
				parse (a_target)
			else
				l_is_clean := arguments.is_clean
				b := True
				if arguments.is_melt then
					b := compilation ("melt", l_is_clean, a_target, a_dir) and then b
					l_is_clean := False --| Clean only once
				end
				if arguments.is_freeze then
					b := compilation ("freeze", l_is_clean, a_target, a_dir) and then b
					l_is_clean := False --| Clean only once
				end
				if arguments.is_finalize then
					b := compilation ("finalize", l_is_clean, a_target, a_dir) and then b
				end
				if
						-- Keep failed.
					(b or not arguments.has_keep_failed) and
						-- Keep passed.
					not (b and arguments.has_keep_passed) and
						-- Keep all.
					not arguments.has_keep_all
				then
					clean_after (arguments.compilation_dir = Void, compilation_directory (a_target, arguments.compilation_dir, a_dir), a_target.name)
				end
			end
		end

	clean_after (a_using_ecf_dir: BOOLEAN; a_dir: PATH; a_target_name: READABLE_STRING_32)
			-- Clean compilation directory
		local
			dn: PATH
			d: DIRECTORY
		do
			dn := a_dir.extended ("EIFGENs").extended (a_target_name)
			create d.make_with_path (dn)
			rmdir (d) --| Safe to delete under EIFGENs

			dn := a_dir.extended ("EIFGENs")
			d.make_with_path (dn)
			if d.exists and then d.is_empty then
				if a_using_ecf_dir then
					rmdir (d) --| Safe to delete EIFGENs
				else
					d.make_with_path (a_dir)
					safe_rmdir (d) --| Try to delete parent of EIFGENs
				end
			end
		end

	parse (a_target: CONF_TARGET)
			-- Only parse configuration system (incl. used libraries) of `a_target'.
		require
			a_target_not_void: a_target /= Void
		local
			l_state: CONF_STATE
			l_vis: CONF_PARSE_VISITOR
			l_version: STRING_TABLE [CONF_VERSION]
			l_file: PLAIN_TEXT_FILE
			l_platform_id: INTEGER
		do
				-- create state for conditioning
			create l_version.make (1)
			l_version.force (create {CONF_VERSION}.make_version ({EIFFEL_CONSTANTS}.major_version, {EIFFEL_CONSTANTS}.minor_version, 0, 0), v_compiler)

				-- Compile target for the currently selected platform.
			if arguments.platform_option.is_empty then
				l_platform_id := current_platform
			else
				l_platform_id := get_platform (arguments.platform_option)
				if l_platform_id = 0 then
					l_platform_id := current_platform
				end
			end
			create l_state.make (l_platform_id, build_workbench, a_target.concurrency_mode, a_target.void_safety_mode, a_target.setting_msil_generation, a_target.setting_dynamic_runtime, a_target.variables, l_version)

				-- setup ISE_PRECOMP
			eiffel_layout.set_precompile (a_target.setting_msil_generation)

			output_action (interface_text_parsing, a_target)

			create l_vis.make_build (l_state, a_target, create {CONF_PARSE_FACTORY})
			a_target.process (l_vis)

			if attached l_vis.last_errors as e and then not e.is_empty then
				if arguments.is_log_verbose then
					create l_file.make_with_path (logs_filename ("parse", a_target))
					l_file.open_write
					e.do_all (agent (a_error: CONF_ERROR; a_file: PLAIN_TEXT_FILE)
						do
							a_file.put_string (a_error.out)
						end (?, l_file))
					l_file.close
				end
				report_failed ("parse", a_target)
				output_status_failed
			else
				report_passed (interface_text_parsing, a_target)
				output_status_passed
			end
			io.new_line
		end

	compilation (a_action_mode: STRING; a_clean: BOOLEAN;  a_target: CONF_TARGET; a_dir: PATH): BOOLEAN
			-- Compile `a_target' located in `a_dir' according to `a_action_mode' clean before compilation if `a_clean'.
			-- and return True if compilation was Ok, and False if it failed.
		require
			a_action_ok: a_action_mode /= Void and then (a_action_mode.same_string ("melt") or
						a_action_mode.same_string ("freeze") or a_action_mode.same_string ("finalize"))
			a_target_ok: a_target /= Void
			a_dir_ok: a_dir /= Void and then not a_dir.is_empty
		local
			l_args: ARRAYED_LIST [READABLE_STRING_GENERAL]
			l_prc_launcher: PROCESS
			l_file: PATH
			l_info_file: RAW_FILE
			l_info_filename: PATH
			l_action: READABLE_STRING_32
			rescued: BOOLEAN
			u: UTF_CONVERTER
		do
			if not rescued then
				create l_args.make (10)
				l_args.extend ("-config")
				l_args.extend (a_target.system.file_name)
				l_args.extend ("-target")
				l_args.extend (a_target.name)
				l_args.extend ("-batch")

				if arguments.is_c_compile then
					l_args.extend ("-c_compile")
				end

				if a_clean then
					l_args.extend ("-clean")
				end

				if arguments.is_experiment then
					l_args.extend ("-experiment")
				elseif arguments.is_compatible then
					l_args.extend ("-compat")
				end

				if not arguments.platform_option.is_empty then
					l_args.extend ("-platform")
					l_args.extend (arguments.platform_option)
				end

				l_args.extend ("-project_path")
				if attached arguments.compilation_dir as l_compile_dir then
					l_info_filename := compilation_directory (a_target, l_compile_dir, a_dir)
					mkdir (create {DIRECTORY}.make_with_path (l_info_filename))
					create l_info_file.make_with_path (l_info_filename.extended ("ecf_location"))
					l_info_file.create_read_write
					l_info_file.put_string (u.utf_8_bom_to_string_8)
					l_info_file.put_string (u.utf_32_string_to_utf_8_string_8 (a_target.system.file_name))
					l_info_file.close

					l_args.extend (l_info_filename.name)
				else
						-- We always use the directory of the ECF by default
					l_args.extend (compilation_directory (a_target, Void, a_dir).name)
				end

				if a_action_mode.is_equal ("melt") then
					l_action := interface_text_melting
					l_args.extend ("-melt")
					if not arguments.melt_ec_options.is_empty then
						l_args.extend (arguments.melt_ec_options)
					end
				elseif a_action_mode.is_equal ("freeze") then
					l_action := interface_text_freezing
					l_args.extend ("-freeze")
					if not arguments.freeze_ec_options.is_empty then
						l_args.extend (arguments.freeze_ec_options)
					end
				elseif a_action_mode.is_equal ("finalize") then
					l_action := interface_text_finalizing
					l_args.extend ("-finalize")
					if not arguments.finalize_ec_options.is_empty then
						l_args.extend (arguments.finalize_ec_options)
					end
				else
					l_action := {STRING_32} "Compiling"
				end

				if not arguments.ec_options.is_empty then
					l_args.extend (arguments.ec_options)
				end

				output_action (l_action, a_target)

				l_prc_launcher := {PROCESS_FACTORY}.process_launcher (eiffel_layout.ec_command_name.name, l_args, Void)
				if arguments.is_log_verbose then
					l_file := logs_filename (a_action_mode, a_target)
					add_data_to_file (l_file, a_target.system.file_name, a_target.name, l_args)
					l_prc_launcher.redirect_output_to_file (l_file.name)
				else
					l_prc_launcher.redirect_output_to_agent (agent (a_string: STRING)
						do
						end)
				end
				l_prc_launcher.redirect_error_to_same_as_output
				l_prc_launcher.set_separate_console (False)
				l_prc_launcher.launch

				check result_unset: not Result end
				if l_prc_launcher.launched then
					l_prc_launcher.wait_for_exit
					if l_prc_launcher.exit_code = 0 then
						report_passed (a_action_mode, a_target)
						output_status_passed
						Result := True
					else
						report_failed (a_action_mode, a_target)
						output_status_failed
					end
				else
					report_internal_error (a_action_mode, a_target)
					output_status_internal_error
				end
				io.new_line
			else
				report_internal_error (a_action_mode, a_target)
				output_status_internal_error
			end
		rescue
			rescued := True
			retry
		end

	compilation_directory (a_target: CONF_TARGET; a_compilation_dir: detachable PATH; a_ecf_dir: PATH): PATH
			-- Compilation directory
		do
			if a_compilation_dir /= Void then
				Result := a_compilation_dir
				Result := Result.extended (a_target.system.name + "-" + a_target.system.uuid.out)
			else
					-- We always use the directory of the ECF by default
				Result := a_ecf_dir
			end
		end

	logs_filename (a_action_mode: READABLE_STRING_GENERAL; a_target: CONF_TARGET): PATH
		require
			is_log_verbose: arguments.is_log_verbose
		local
			l_logs_file_name: STRING_32
		do
			l_logs_file_name := a_target.system.name + "-" + a_target.system.uuid.out + "-" + a_target.name + "-" + a_action_mode + ".log"
			if attached arguments.logs_dir as l_logs_dir then
				Result := l_logs_dir
			else
				create Result.make_current
			end
			Result := Result.extended (l_logs_file_name)
		end

	ISE_EC_FLAGS_environment_variable_value: detachable READABLE_STRING_32
		local
			e: EXECUTION_ENVIRONMENT
		once
			create e
			if attached e.item ("ISE_EC_FLAGS") as v then
				v.left_adjust
				if not v.is_empty then
					Result := v
				end
			end
		end

	add_data_to_file (a_file_name: PATH; a_config, a_target: READABLE_STRING_GENERAL; ec_args: ITERABLE [READABLE_STRING_GENERAL])
			-- Insert some data in `a_file_name' saying what we are compiling and when.
		require
			a_file_name_attached: a_file_name /= Void
			a_config_attached: a_config /= Void
			a_target_attached: a_target /= Void
		local
			retried: BOOLEAN
			l_file: PLAIN_TEXT_FILE
			l_date: DATE_TIME
			u: UTF_CONVERTER
		do
			if not retried then
				create l_date.make_now
				create l_file.make_with_path (a_file_name)
				l_file.open_append
				if l_file.is_empty then
					l_file.put_string ({UTF_CONVERTER}.utf_8_bom_to_string_8)
				end
				l_file.put_string ("**********************************************************************%N")
				l_file.put_string ("Date: ")
				l_file.put_string (l_date.out)
				l_file.put_string ("%NCompiling target %"")
				l_file.put_string (u.utf_32_string_to_utf_8_string_8 (a_target))
				l_file.put_string ("%" from config %"")
				l_file.put_string (u.utf_32_string_to_utf_8_string_8 (a_config))
				l_file.put_string ("%"%N%N")
				l_file.put_string ("Compiler's arguments in UTF-8 encoding: ")
				across
					ec_args as c
				loop
					l_file.put_string (u.utf_32_string_to_utf_8_string_8 (c.item) + " ")
				end
				l_file.put_string ("%N")
				if attached ISE_EC_FLAGS_environment_variable_value as v then
					l_file.put_string_32 ({STRING_32} "ISE_EC_FLAGS: "+ v + "%N")
				end

				l_file.close
			end
		rescue
			retried := True
			retry
		end

	show_log_content (a_log_file_name: PATH)
			-- Display the whole content of `a_log_filename` to the console.
		local
			l_raw_file: PLAIN_TEXT_FILE
		do
			create l_raw_file.make_with_path (a_log_file_name)
			if l_raw_file.exists and l_raw_file.is_readable then
				l_raw_file.open_read
				l_raw_file.read_stream (l_raw_file.count)
				l_raw_file.close
				io.put_new_line
					-- Output file data unmodified (without any localization)
					-- to avoid any unncessary conversion and preserve Unicode as is.
					-- Localized printing could be used only when data would be read as localized.
				io.put_string (l_raw_file.last_string)
				io.put_new_line
			end
		end

feature {NONE} -- Error handling

	display_error (a_message: READABLE_STRING_GENERAL)
			-- Process `a_message'.
		require
			a_message_ok: a_message /= Void and then not a_message.is_empty
		do
			localized_print_error (a_message)
			io.error.new_line
		end

feature {NONE} -- Interface text

	interface_output_action_template: READABLE_STRING_32

	interface_text_target: READABLE_STRING_32

	interface_text_error: READABLE_STRING_32
	interface_text_passed: READABLE_STRING_32
	interface_text_failed: READABLE_STRING_32
	interface_text_ignored: READABLE_STRING_32

	interface_text_parsing: READABLE_STRING_32
	interface_text_melting: READABLE_STRING_32
	interface_text_freezing: READABLE_STRING_32
	interface_text_finalizing: READABLE_STRING_32

	initialize_interface_texts
			-- Initialize interface_text_* with default values
		do
			interface_output_action_template := "#action #target from #system-#uuid (#ecf): "

			interface_text_target := "Target"
			interface_text_parsing := "Parsing"
			interface_text_melting := "Melting"
			interface_text_freezing := "Freezing"
			interface_text_finalizing := "Finalizing"

			interface_text_error := "error"
			interface_text_passed := "passed"
			interface_text_failed := "failed"
			interface_text_ignored := "ignored"
		end

	set_interface_texts_from_argument (args: like arguments)
			-- Initialize interface_text_* with eventual values specified via the arguments
		do
			if attached arguments.interface_output_action_template as tpl then
				interface_output_action_template := tpl
			end

			interface_text_target := args.interface_text ("Target")

			interface_text_parsing := args.interface_text ("Parsing")
			interface_text_melting := args.interface_text ("Melting")
			interface_text_freezing := args.interface_text ("Freezing")
			interface_text_finalizing := args.interface_text ("Finalizing")

			interface_text_error := args.interface_text ("error")
			interface_text_passed := args.interface_text ("passed")
			interface_text_failed := args.interface_text ("failed")
			interface_text_ignored := args.interface_text ("ignored")
		end

	output_status_internal_error
		do
			localized_print (interface_text_error)
		end

	output_status_passed
		do
			localized_print (interface_text_passed)
		end

	output_status_failed
		do
			localized_print (interface_text_failed)
		end

	output_status_ignored
		do
			localized_print (interface_text_ignored)
		end

	output_action (a_action: READABLE_STRING_32; a_target: CONF_TARGET)
			-- Display in the console the output progress report for compilations
		local
			l_system: CONF_SYSTEM
			l_target_name, l_system_name, l_uuid: READABLE_STRING_32
			l_ecf: PATH
			t: STRING_32
		do
			l_system := a_target.system
			l_system_name := l_system.name
			l_ecf := l_system.file_path
			l_uuid := l_system.uuid.out
			l_target_name := a_target.name

			create t.make_from_string (interface_output_action_template)
			t.replace_substring_all ("#action", a_action)
			t.replace_substring_all ("#system", l_system_name)
			t.replace_substring_all ("#target", l_target_name)
			t.replace_substring_all ("#uuid", l_uuid)
			t.replace_substring_all ("#absolute_ecf", l_ecf.name)
			if arguments.is_log_verbose then
				t.replace_substring_all ("#log_filename", logs_filename (a_action, a_target).name)
			else
				t.replace_substring_all ("#log_filename", "")
			end

				-- To avoid a lot of display, we try to only display the part after
				-- `base_location'.
			if l_ecf.name.substring_index (base_location.name, 1) = 1 then
				t.replace_substring_all ("#ecf", l_ecf.name.substring (base_location.name.count + 2, l_ecf.name.count))
			else
				t.replace_substring_all ("#ecf", l_ecf.name)
			end

			localized_print (t)
		end

feature {NONE} -- Directory manipulation

	translated_platform_path (s: READABLE_STRING_8): STRING_8
			-- Path translated for current platform
			--| i.e: replace \ or / by current platform directory separator
		local
			curr_dir_sep: CHARACTER
			i,n: INTEGER
		do
			curr_dir_sep := operating_environment.directory_separator
			from
				i := 1
				n := s.count
				create Result.make (n)
			until
				i > n
			loop
				inspect s[i]
				when '/' then
					Result.extend (curr_dir_sep)
				when '\' then
					Result.extend (curr_dir_sep)
				else
					Result.extend (s[i])
				end
				i := i + 1
			end
		end

	mkdir (d: DIRECTORY)
			-- Create directory `d' recursively
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if not d.exists then
					d.recursive_create_dir
					directories_created_by_application.force (d.path)
				end
			else
				localized_print_error ("ERROR: unable to create directory %"" + d.path.name + "%".%N")
			end
		rescue
			rescued := True
			retry
		end

	directories_created_by_application: ARRAYED_LIST [PATH]
			-- List of directories created by this application execution
		once
			create Result.make (25)
			Result.compare_objects
		end

	rmdir (d: DIRECTORY)
			-- remove directory `d' if exists
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if d.exists then
					d.recursive_delete
				end
			else
				localized_print_error ("ERROR: unable to remove directory %"" + d.path.name + "%".%N")
			end
		rescue
			rescued := True
			retry
		end

	safe_rmdir (d: DIRECTORY)
			-- remove directory only if created by this session
			-- mainly to avoid removing user folders ...
		do
			if d.exists then
				if directories_created_by_application.has (d.path) then
					rmdir (d)
				else
					check not_created_by_application: False end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
