note
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_CLASS

inherit
	EIFFEL_LAYOUT

	CONF_CONSTANTS
		export
			{NONE} all
		end

	KL_SHARED_EXECUTION_ENVIRONMENT
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
			arguments.execute (agent start)
		end

feature {NONE} -- Implementation: results

	failed_compilations: LINKED_LIST [TUPLE [log: detachable READABLE_STRING_8; ecf: READABLE_STRING_8; system: READABLE_STRING_8; target: READABLE_STRING_8; uuid: READABLE_STRING_8]]

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

	report_passed (a_action_mode: READABLE_STRING_8; a_target: CONF_TARGET)
			-- Report passed compilation
		do
			passed_compilations_count := passed_compilations_count + 1
		end

	report_failed (a_action_mode: READABLE_STRING_8; a_target: CONF_TARGET)
			-- Report failed compilation
		local
			l_logfn: detachable READABLE_STRING_8
		do
			if arguments.is_log_verbose then
				l_logfn := logs_filename (a_action_mode, a_target)
			end
			failed_compilations.extend ([l_logfn, a_target.system.file_name, a_target.system.name, a_target.name, a_target.system.uuid.out])
		end

	report_ignored (a_ecf: READABLE_STRING_8; a_target: detachable CONF_TARGET)
			-- Report skipped or ignored compilation
		do
			ignored_compilations_count := ignored_compilations_count + 1
		end

feature {NONE} -- Implementation

	arguments: ARGUMENT_PARSER
			-- Command line arguments.

	base_location: detachable READABLE_STRING_8
			-- Base location where to look for .ecf files.

	ignores: HASH_TABLE [SEARCH_TABLE [STRING], STRING]
			-- Ignored files/targets.

	directory_ignores: SEARCH_TABLE [STRING]
			-- Ignored directories

	regexp_ignores: ARRAYED_LIST [RX_REGULAR_EXPRESSION]
			-- Ignored regexp

	path_regexp_ignored (p: STRING): BOOLEAN
			-- Is path ignored in relation with `regexp_ignores'?
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
						rexp.match (p)
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
		local
			loc: READABLE_STRING_8
		do
			if arguments.ignore /= Void then
				load_ignores (arguments.ignore)
			end
			if arguments.is_ecb then
				execution_environment.set_variable_value ("EC_NAME", "ecb")
			end
			set_interface_texts_from_argument (arguments)
			loc := arguments.location

			set_base_location (loc)
			io.put_string ("Base location: %"" + loc + "%"")
			io.put_new_line
			io.put_new_line
			process_directory (loc)

			io.put_new_line
			io.put_string ("Passed: ")
			io.put_integer (passed_compilations_count)
			io.put_string (" / ")
			io.put_integer (total_count)
			io.put_string ("  (")
			io.put_integer (((passed_compilations_count / total_count) * 100).truncated_to_integer)
			io.put_string ("%%)")
			io.put_new_line

			io.put_string ("Failed: ")
			io.put_integer (failed_compilations_count)
			io.put_string (" / ")
			io.put_integer (total_count)
			io.put_string ("  (")
			io.put_integer (((failed_compilations_count / total_count) * 100).truncated_to_integer)
			io.put_string ("%%)")
			io.put_new_line

			io.put_string ("Ignored: ")
			io.put_integer (ignored_compilations_count)
			io.put_string (" / ")
			io.put_integer (total_count)
			io.put_string ("  (")
			io.put_integer (((ignored_compilations_count / total_count) * 100).truncated_to_integer)
			io.put_string ("%%)")
			io.put_new_line

			io.put_new_line
			if arguments.list_failures then
				io.put_new_line
				if failed_compilations_count > 0 then
					io.put_string (failed_compilations_count.out + " failure(s):")
					io.put_new_line
					across
						failed_compilations as c
					loop
						io.put_string (c.item.system + "-" + c.item.uuid + "-" + c.item.target + " (" + c.item.ecf + ")")
						if attached c.item.log as l_logfn then
							io.put_string (": " + l_logfn)
						end
						io.put_new_line
					end
				end
			end
		end

	set_base_location (loc: READABLE_STRING_8)
			-- Set `base_location' to `loc'
		require
			loc_not_empty: not loc.is_empty
		local
			sep: CHARACTER
		do
			sep := operating_environment.directory_separator
			if loc.item (loc.count) /= sep then
				base_location := loc + sep.out
			else
				base_location := loc
			end
		end

	load_ignores (a_file: STRING)
			-- Retrieve list of ignored files/targets from `a_file'.
		require
			a_file_ok: a_file /= Void
		local
			l_ini_loader: INI_DOCUMENT_READER
			l_file: PLAIN_TEXT_FILE
			l_ini_file: INI_DOCUMENT
			l_ignored_files: ARRAYED_LIST [INI_SECTION]
			l_ini_section: INI_SECTION
			l_ignored_targets: ARRAYED_LIST [INI_LITERAL]
			l_ig_target: SEARCH_TABLE [STRING]
			l_actual_path: STRING
			l_label: STRING
			rexp: RX_PCRE_REGULAR_EXPRESSION
		do
			create l_file.make (a_file)
			if not l_file.exists or else not l_file.is_readable then
				display_error ("Could not open ignore file "+a_file)
			else
				l_file.open_read
				create l_ini_loader.make
				l_ini_loader.read_from_file (l_file, False)
				l_file.close
				if not l_ini_loader.successful then
					l_ini_loader.errors.do_all (agent (a_error: INI_SYNTAX_ERROR)
						do
							display_error (a_error.message)
						end)
				else
					l_ini_file := l_ini_loader.read_document
					from
						l_ignored_files := l_ini_file.sections
						create ignores.make (l_ignored_files.count)
						create directory_ignores.make (l_ignored_files.count)
						create regexp_ignores.make (l_ignored_files.count)
						l_ignored_files.start
					until
						l_ignored_files.after
					loop
							-- every section represents one configuration file
						l_ini_section := l_ignored_files.item
						l_label := l_ini_section.label
						if l_label.starts_with ("regexp=") then
							create rexp.make
							l_label := l_label.substring (("regexp=").count + 1, l_label.count)
							l_label.left_adjust
							l_label.right_adjust
							rexp.compile (l_label)
							if rexp.error_message /= Void then
								regexp_ignores.extend (rexp)
							end
						else
							l_label := translated_platform_path (l_label)
							l_actual_path := execution_environment.interpreted_string (l_label)
							create l_file.make (l_actual_path)
							if not l_file.exists then
								display_error ("Could not read file/path "+l_label+"!")
							elseif l_file.is_directory then
								directory_ignores.force (l_actual_path.as_lower)
							else
									-- no literals implies the whole configuration file is ignored, else each literal represents an ignored target
								from
									l_ignored_targets := l_ini_section.literals
									create l_ig_target.make (l_ignored_targets.count)
									l_ignored_targets.start
								until
									l_ignored_targets.after
								loop
									l_ig_target.force (l_ignored_targets.item.name)
									l_ignored_targets.forth
								end
								ignores.force (l_ig_target, l_actual_path)
							end
						end
						l_ignored_files.forth
					end
				end
			end
		end

	process_directory (a_directory: STRING)
			-- Process `a_directory'.
		require
			a_directory_ok: a_directory /= Void and then not a_directory.is_empty
		local
			l_dir: KL_DIRECTORY
			dn: STRING
		do
			dn := a_directory.string
			if not path_regexp_ignored (dn) then
				create l_dir.make (dn)
				if not l_dir.is_readable then
					display_error ("Could not read "+a_directory+"!")
				elseif directory_ignores = Void or else not directory_ignores.has (dn.as_lower) then
						-- Process only if the directory is not excluded.
						-- 1 - process config files with an ecf extension
					l_dir.filenames.do_if (
						agent (a_dir, a_file: STRING)
							local
								l_fn: FILE_NAME
							do
								create l_fn.make_from_string (a_dir)
								l_fn.set_file_name (a_file)
								process_configuration (l_fn, a_dir)
							end (a_directory, ?),
						agent (a_file: STRING): BOOLEAN
							local
								l_cnt: INTEGER
							do
								l_cnt := a_file.count
								Result := l_cnt > 4 and then a_file.substring (l_cnt-3, l_cnt).is_equal (".ecf")
							end)
						-- 2 - process subdirs
					l_dir.directory_names.do_all (agent (a_dir, a_subdir: STRING)
						local
							l_dirname: DIRECTORY_NAME
						do
							create l_dirname.make_from_string (a_dir)
							l_dirname.extend (a_subdir)
							process_directory (l_dirname)
						end (dn, ?)
					)
				end
			end
		end

	process_configuration (a_file, a_dir: STRING)
			-- Process configuration file `a_file' located in `a_dir'
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
			a_dir_ok: a_dir /= Void and then not a_dir.is_empty
		local
			l_loader: CONF_LOAD
			l_ignored_targets: SEARCH_TABLE [STRING]
			l_skip_dotnet: BOOLEAN
			l_target: CONF_TARGET
		do
			if attached ignores as l_ignores then
				l_ignored_targets := l_ignores.item (a_file.string.as_lower)
			end
				--| if the file is not listed in the excludes or explicitely lists excluded targets
			if l_ignored_targets = Void or else not l_ignored_targets.is_empty then
				create l_loader.make (create {CONF_PARSE_FACTORY})
				l_loader.retrieve_configuration (a_file)
				if l_loader.is_error then
					display_error ("Could not retrieve configuration "+a_file+"!")
				else
					l_skip_dotnet := arguments.skip_dotnet
					across l_loader.last_system.compilable_targets as l_cursor loop
						l_target := l_cursor.item
						if l_target.setting_msil_generation and l_skip_dotnet then
							output_action (interface_text_target, l_target)
							report_ignored (a_file, l_target)
							output_status_ignored
							io.new_line
						elseif l_ignored_targets = Void or else not l_ignored_targets.has (l_target.name) then
							process_target (l_target, a_dir)
						else
							output_action (interface_text_target, l_target)
							report_ignored (a_file, Void)
							output_status_ignored
							io.new_line
						end
					end
				end
			end
		end

	process_target (a_target: CONF_TARGET; a_dir: STRING)
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
					l_is_clean := False --| Clean only once
				end
				if not b and arguments.has_keep_failed then
					--| Keep failed
				elseif b and arguments.has_keep_passed then
					--| Keep passed
				elseif arguments.has_keep_all then
					--| Keep all
				else
					clean_after (arguments.compilation_dir = Void, compilation_directory (a_target, arguments.compilation_dir, a_dir), a_target.name)
				end
			end
		end

	clean_after (a_using_ecf_dir: BOOLEAN; a_dir: READABLE_STRING_8; a_target_name: READABLE_STRING_8)
			-- Clean compilation directory
		local
			dn: DIRECTORY_NAME
			d: DIRECTORY
		do
			create dn.make_from_string (a_dir)
			dn.extend ("EIFGENs")
			dn.extend (a_target_name)
			create d.make (dn.string)
			rmdir (d) --| Safe to delete under EIFGENs

			dn.make_from_string (a_dir)
			dn.extend ("EIFGENs")
			d.make (dn.string)
			if d.exists and then d.is_empty then
				if a_using_ecf_dir then
					rmdir (d) --| Safe to delete EIFGENs
				else
					d.make (a_dir)
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
			l_version: HASH_TABLE [CONF_VERSION, STRING]
			l_system, l_target: STRING
			l_file: PLAIN_TEXT_FILE
		do
				-- create state for conditioning
			create l_version.make (1)
			l_version.force (create {CONF_VERSION}.make_version ({EIFFEL_CONSTANTS}.major_version, {EIFFEL_CONSTANTS}.minor_version, 0, 0), v_compiler)
			create l_state.make (pf_windows, build_workbench, a_target.concurrency_mode, a_target.setting_msil_generation, a_target.setting_dynamic_runtime, a_target.variables, l_version)

				-- setup ISE_PRECOMP
			eiffel_layout.set_precompile (a_target.setting_msil_generation)

			l_system := a_target.system.name
			l_target := a_target.name
			output_action (interface_text_parsing, a_target)

			create l_vis.make_build (l_state, a_target, create {CONF_PARSE_FACTORY})
			a_target.process (l_vis)

			if l_vis.is_error then
				if arguments.is_log_verbose then
					create l_file.make_open_write (logs_filename ("parse", a_target))
					l_vis.last_errors.do_all (agent (a_error: CONF_ERROR; a_file: PLAIN_TEXT_FILE)
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

	compilation (a_action_mode: STRING; a_clean: BOOLEAN;  a_target: CONF_TARGET; a_dir: STRING): BOOLEAN
			-- Compile `a_target' located in `a_dir' according to `a_action_mode' clean before compilation if `a_clean'.
			-- and return True if compilation was Ok, and False if it failed.
		require
			a_action_ok: a_action_mode /= Void and then (a_action_mode.same_string ("melt") or
						a_action_mode.same_string ("freeze") or a_action_mode.same_string ("finalize"))
			a_target_ok: a_target /= Void
			a_dir_ok: a_dir /= Void and then not a_dir.is_empty
		local
			l_args: ARRAYED_LIST [STRING]
			l_prc_factory: PROCESS_FACTORY
			l_prc_launcher: PROCESS
			l_system, l_target: STRING
			l_file: STRING
			l_dir: KL_DIRECTORY
			l_info_file: RAW_FILE
			l_info_filename: FILE_NAME
			l_action: READABLE_STRING_8
			rescued: BOOLEAN
		do
			if not rescued then
				l_system := a_target.system.name
				l_target := a_target.name

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

				l_args.extend ("-project_path")
				if attached arguments.compilation_dir as l_compile_dir then
					create l_dir.make (compilation_directory (a_target, l_compile_dir, a_dir))
					mkdir (l_dir)
					create l_info_filename.make_from_string (l_dir.name)
					l_info_filename.set_file_name ("ecf_location")
					create l_info_file.make_create_read_write (l_info_filename)
					l_info_file.put_string (a_target.system.file_name)
					l_info_file.close

					l_args.extend (l_dir.name)
				else
						-- We always use the directory of the ECF by default
					l_args.extend (compilation_directory (a_target, Void, a_dir))
				end

				if a_action_mode.is_equal ("melt") then
					l_action := interface_text_melting
					l_args.extend ("-melt")
					l_args.extend (arguments.melt_ec_options)
				elseif a_action_mode.is_equal ("freeze") then
					l_action := interface_text_freezing
					l_args.extend ("-freeze")
					l_args.extend (arguments.freeze_ec_options)
				elseif a_action_mode.is_equal ("finalize") then
					l_action := interface_text_finalizing
					l_args.extend ("-finalize")
					l_args.extend (arguments.finalize_ec_options)
				end

				l_args.extend (arguments.ec_options)
				debug
					across
						l_args as c
					loop
						print (c.item + " ")
					end
					print ("%N")
				end

				output_action (l_action, a_target)

				create l_prc_factory
				l_prc_launcher := l_prc_factory.process_launcher (eiffel_layout.ec_command_name, l_args, Void)
				if arguments.is_log_verbose then
					l_file := logs_filename (a_action_mode, a_target)
					add_data_to_file (l_file, a_target.system.file_name, a_target.name, l_args)
					l_prc_launcher.redirect_output_to_file (l_file)
				else
					l_prc_launcher.redirect_output_to_agent (agent (a_string: STRING)
						do
						end)
				end
				l_prc_launcher.redirect_error_to_same_as_output
				l_prc_launcher.set_separate_console (False)
				l_prc_launcher.launch

				check result_unset: Result = False end
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

	compilation_directory (a_target: CONF_TARGET; a_compilation_dir: detachable READABLE_STRING_8; a_ecf_dir: READABLE_STRING_8): READABLE_STRING_8
			-- Compilation directory
		local
			dn: DIRECTORY_NAME
		do
			if a_compilation_dir /= Void then
				create dn.make_from_string (a_compilation_dir)
				dn.extend (a_target.system.name + "-" + a_target.system.uuid.out)
				Result := dn.string
			else
					-- We always use the directory of the ECF by default
				Result := a_ecf_dir.string
			end
		end

	logs_filename (a_action_mode: READABLE_STRING_8; a_target: CONF_TARGET): READABLE_STRING_8
		require
			is_log_verbose: arguments.is_log_verbose
		local
			l_logs_file_name: FILE_NAME
		do
			Result := a_target.system.name + "-" + a_target.system.uuid.out + "-" + a_target.name + "-" + a_action_mode + ".log"
			if attached arguments.logs_dir as l_logs_dir then
				create l_logs_file_name.make_from_string (l_logs_dir)
				l_logs_file_name.set_file_name (Result)
				Result := l_logs_file_name.string
			end
		end

	ISE_EC_FLAGS_environment_variable_value: detachable READABLE_STRING_8
		local
			e: EXECUTION_ENVIRONMENT
		once
			create e
			if attached e.get ("ISE_EC_FLAGS") as v then
				v.left_adjust
				if not v.is_empty then
					Result := v
				end
			end
		end

	add_data_to_file (a_file_name: STRING; a_config, a_target: STRING; ec_args: ITERABLE [READABLE_STRING_8])
			-- Insert some data in `a_file_name' saying what we are compiling and when.
		require
			a_file_name_attached: a_file_name /= Void
			a_config_attached: a_config /= Void
			a_target_attached: a_target /= Void
		local
			retried: BOOLEAN
			l_file: PLAIN_TEXT_FILE
			l_date: DATE_TIME
		do
			if not retried then
				create l_date.make_now
				create l_file.make_open_append (a_file_name)
				l_file.put_string ("**********************************************************************%N")
				l_file.put_string ("Date: ")
				l_file.put_string (l_date.out)
				l_file.put_string ("%NCompiling target %"")
				l_file.put_string (a_target)
				l_file.put_string ("%" from config %"")
				l_file.put_string (a_config)
				l_file.put_string ("%"%N%N")
				l_file.put_string ("Compiler's arguments: ")
				across
					ec_args as c
				loop
					l_file.put_string (c.item + " ")
				end
				l_file.put_string ("%N")
				if attached ISE_EC_FLAGS_environment_variable_value as v then
					l_file.put_string ("ISE_EC_FLAGS: "+ v + "%N")
				end

				l_file.close
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Error handling

	display_error (a_message: STRING)
			-- Process `a_message'.
		require
			a_message_ok: a_message /= Void and then not a_message.is_empty
		do
			io.error.put_string (a_message)
			io.error.new_line
		end

feature {NONE} -- Interface text

	interface_output_action_template: READABLE_STRING_8

	interface_text_target: READABLE_STRING_8

	interface_text_error: READABLE_STRING_8
	interface_text_passed: READABLE_STRING_8
	interface_text_failed: READABLE_STRING_8
	interface_text_ignored: READABLE_STRING_8

	interface_text_parsing: READABLE_STRING_8
	interface_text_melting: READABLE_STRING_8
	interface_text_freezing: READABLE_STRING_8
	interface_text_finalizing: READABLE_STRING_8

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
			io.put_string (interface_text_error)
		end

	output_status_passed
		do
			io.put_string (interface_text_passed)
		end

	output_status_failed
		do
			io.put_string (interface_text_failed)
		end

	output_status_ignored
		do
			io.put_string (interface_text_ignored)
		end

	output_action (a_action: READABLE_STRING_8; a_target: CONF_TARGET)
			-- Display in the console the output progress report for compilations
		local
			l_system: CONF_SYSTEM
			l_target_name, l_system_name, l_uuid, l_ecf: READABLE_STRING_8
			t: STRING
		do
			l_system := a_target.system
			l_system_name := l_system.name
			l_ecf := l_system.file_name
			l_uuid := l_system.uuid.out
			l_target_name := a_target.name

			create t.make_from_string (interface_output_action_template)
			t.replace_substring_all ("#action", a_action)
			t.replace_substring_all ("#system", l_system_name)
			t.replace_substring_all ("#target", l_target_name)
			t.replace_substring_all ("#uuid", l_uuid)
			t.replace_substring_all ("#absolute_ecf", l_ecf)
			if arguments.is_log_verbose then
				t.replace_substring_all ("#log_filename", logs_filename (a_action, a_target))
			else
				t.replace_substring_all ("#log_filename", "")
			end

			if attached base_location as loc and then l_ecf.starts_with (loc) then
				t.replace_substring_all ("#ecf", l_ecf.substring (loc.count + 1, l_ecf.count))
			end

			io.put_string (t)
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
					directories_created_by_application.force (d.name)
				end
			else
				io.error.put_string ("ERROR: unable to create directory %"" + d.name + "%".%N")
			end
		rescue
			rescued := True
			retry
		end

	directories_created_by_application: ARRAYED_LIST [READABLE_STRING_8]
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
				if d.exists and then d.is_writable then
					d.recursive_delete
				else
					io.error.put_string ("ERROR: unable to remove directory %"" + d.name + "%".%N")
				end
			else
				io.error.put_string ("ERROR: unable to remove directory %"" + d.name + "%".%N")
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
				if directories_created_by_application.has (d.name) then
					rmdir (d)
				else
					check not_created_by_application: False end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
