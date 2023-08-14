note
	description: "System's root class."
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_CLASS

inherit
	LOCALIZED_PRINTER

	CONF_CONSTANTS
		export
			{NONE} all
		end

	EIFFEL_LAYOUT

	OUTPUT_HANDLER

	INPUT_HANDLER

	HELPER

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Creation procedure.
		do
				-- setup env
			set_eiffel_layout (create {PAT_EIFFEL_ENV})
			eiffel_layout.check_environment_variable

			initialize_interface_texts
				-- get arguments
			create arguments.make
			create failed_targets.make
			create waiting_tasks.make (10)
			arguments.execute (agent start)
		end

feature {NONE} -- Implementation

	arguments: ARGUMENT_PARSER
			-- Command line arguments.

	base_location: detachable PATH
			-- Base location where to look for .ecf files.

	ignores: STRING_TABLE [STRING_TABLE [BOOLEAN]]
			-- Ignored files/targets.

	directory_ignores: STRING_TABLE [READABLE_STRING_GENERAL]
			-- Ignored directories

	regexp_ignores: ARRAYED_LIST [REGULAR_EXPRESSION]
			-- Ignored regexp

	max_processes: INTEGER
			-- Max processes to run.

	waiting_tasks: ARRAYED_LIST [PROCEDURE]
			-- Waiting tasks

	path_regexp_ignored (p: READABLE_STRING_32): BOOLEAN
			-- Is path ignored in relation with `regexp_ignores'?
		local
			utf8_pattern: STRING_8
		do
			if attached regexp_ignores as l_regexp_ignores then
				utf8_pattern := {UTF_CONVERTER}.string_32_to_utf_8_string_8 (p)
				across
					l_regexp_ignores as r
				until
					Result
				loop
					if attached r.item as rexp then
						rexp.match (utf8_pattern)
						Result := rexp.has_matched
						rexp.wipe_out
					end
				end
			end
		end

	start
			-- Starts application
		require
			arguments_attached: arguments /= Void
		local
			loc: PATH
		do
			if attached arguments.ignore as l_ignore then
				load_ignores (l_ignore)
			end
			if arguments.is_ecb then
				(create {EXECUTION_ENVIRONMENT}).put ("ecb", "EC_NAME")
			end
			set_interface_texts_from_argument (arguments)
			loc := arguments.location

			if arguments.has_max_processors then
				max_processes := arguments.max_processors.to_integer_16
			else
				max_processes := available_cpus.to_integer_16
			end

			set_base_location (loc)
			localized_print ({STRING_32} "Base location: %"" + loc.name + "%"")
			io.put_new_line
			io.put_new_line

			process_directory (loc)

			if arguments.is_parse_only then
					-- We report summary for parse only process.
					-- Otherwise we report when parallel processes are done.
				report_summary
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

	load_ignores (a_file: READABLE_STRING_GENERAL)
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
		do
			create l_file.make_with_name (a_file)
			if not l_file.exists or else not l_file.is_readable then
				display_error ({STRING_32} "Could not open ignore file " + a_file.to_string_32)
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
					l_ignored_files := l_ini_loader.read_document.sections
					create ignores.make (l_ignored_files.count)
					create directory_ignores.make (l_ignored_files.count)
					create regexp_ignores.make (l_ignored_files.count)
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
								regexp_ignores.extend (rexp)
							end
						else
							l_label := translated_platform_path (l_label)
							l_actual_path := (create {ENV_INTERP}).interpreted_string_32 (l_label)
							create l_file.make_with_name (l_actual_path)
							if not l_file.exists then
								display_error ("Could not read file/path "+l_label+"!")
							elseif l_file.is_directory then
								directory_ignores.force (l_actual_path, l_actual_path)
							else
									-- no literals implies the whole configuration file is ignored, else each literal represents an ignored target
								l_ignored_targets := l_ini_section.literals
								create l_ig_target.make_caseless (l_ignored_targets.count)
								across
									l_ignored_targets as t
								loop
									l_ig_target.force (True, t.item.name)
								end
								ignores.force (l_ig_target, l_actual_path)
							end
						end
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
		do
			if not path_regexp_ignored (a_directory.name) then
				create l_dir.make_with_path (a_directory)
				if not l_dir.is_readable then
					display_error ({STRING_32} "Could not read "+a_directory.name+"!")
				elseif directory_ignores = Void or else not directory_ignores.has (a_directory.name) then
						-- Process only if the directory is not excluded.
						-- 1 - process config files with an ecf extension
					across l_dir.entries as l_entry loop
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
		do
			if attached ignores as l_ignores then
				l_ignored_targets := l_ignores.item (a_file.name)
			end
				--| if the file is not listed in the excludes or explicitely lists excluded targets
			if l_ignored_targets = Void or else not l_ignored_targets.is_empty then
				create l_loader.make (create {CONF_PARSE_FACTORY})
				l_loader.retrieve_configuration (a_file.name)
				if l_loader.is_error then
					display_error ({STRING_32} "Could not retrieve configuration "+a_file.name+"!")
				else
					across l_loader.last_system.compilable_targets as l_cursor loop
						process_target (l_cursor.item, a_dir)
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
		do
			if arguments.is_parse_only then
				parse (a_target)
			else
				l_is_clean := arguments.is_clean
				if not is_test or else target_has_tests (a_target) then
					if attached non_reported_workers as l_workers implies l_workers.count < max_processes then
						schedule_process (l_is_clean, a_target, a_dir)
					else
						waiting_tasks.extend (agent schedule_process (l_is_clean, a_target, a_dir))
					end
				end
			end
		end

	schedule_process (a_clean: BOOLEAN; a_target: CONF_TARGET; a_dir: PATH)
			-- Schedule process
		do
			run_process (create {separate PROCESS_WORKER}.make (Current, Current), a_clean, a_target, a_dir)
		end

	finish_report (a_worker_id: INTEGER_32)
			-- Finish report
		local
			l_item: PROCEDURE
		do
			if attached non_reported_workers as l_workers then
				l_workers.prune_all (a_worker_id)
				if l_workers.is_empty and then waiting_tasks.is_empty then
					report_summary
				end
			end
			if
				(attached non_reported_workers as l_workers implies l_workers.count < max_processes) and then
				not waiting_tasks.is_empty
			then
				l_item := waiting_tasks.first
				waiting_tasks.start
				waiting_tasks.remove
				l_item.apply
			end
		end

	run_process (a_worker: separate PROCESS_WORKER; a_clean: BOOLEAN; a_target: CONF_TARGET; a_dir: PATH)
			-- Run process
		require
			a_worker_set: a_worker /= Void
			a_target_not_void: a_target /= Void
			a_dir_set: a_dir /= Void and then not a_dir.is_empty
		do
			increase_worker_count
			a_worker.set_worker_id (worker_count)
			a_worker.set_target (a_target)
			a_worker.set_ecf_location_dir (a_dir)
			a_worker.set_ec_command_name (eiffel_layout.ec_command_name.name)
			a_worker.run (True)
		end

	target_has_tests (a_target: CONF_TARGET): BOOLEAN
			-- Does `a_target' have test to run?
		require
			a_target_not_void: a_target /= Void
		local
			l_test_searcher: TEST_SEARCHER
		do
			create l_test_searcher
			a_target.process (l_test_searcher)
			Result := l_test_searcher.has_test
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
		do
				-- create state for conditioning
			create l_version.make (1)
			l_version.force (create {CONF_VERSION}.make_version ({EIFFEL_CONSTANTS}.major_version, {EIFFEL_CONSTANTS}.minor_version, 0, 0), v_compiler)
			create l_state.make (pf_windows, build_workbench, a_target.concurrency_mode, a_target.void_safety_mode, a_target.setting_msil_generation, a_target.setting_dynamic_runtime, a_target.variables, l_version)

				-- setup ISE_PRECOMP
			eiffel_layout.set_precompile (a_target.setting_msil_generation, a_target.setting_msil_clr_version)

			output_action (interface_text_parsing, a_target, 0)

			create l_vis.make_build (l_state, a_target, create {CONF_PARSE_FACTORY})
			a_target.process (l_vis)

			if l_vis.is_error then
				if arguments.is_log_verbose then
					create l_file.make_with_path (logs_filename (arguments.logs_dir, "parse", a_target))
					l_file.open_write
					l_vis.last_errors.do_all (agent (a_error: CONF_ERROR; a_file: PLAIN_TEXT_FILE)
						do
							a_file.put_string (a_error.out)
						end (?, l_file))
					l_file.close
				end
				report_failed ({STRING_32} "parse", a_target, 0)
				output_status_failed (0)
			else
				report_passed (0)
				output_status_passed (0)
			end
			io.new_line
		end

	frozen available_cpus: NATURAL_32
			--| FIXME: Copied from ISE_SCOOP_MANAGER. Remove it when available in base.
		do
			Result := execution_environment.available_cpu_count
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

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
