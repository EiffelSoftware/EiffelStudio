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

				-- get arguments
			create arguments.make
			arguments.execute (agent start)
		end

feature {NONE} -- Implementation

	arguments: ARGUMENT_PARSER
			-- Command line arguments.

	ignores: HASH_TABLE [SEARCH_TABLE [STRING], STRING]
			-- Ignored files/targets.

	start
			-- Starts application
		require
			arguments_attached: arguments /= Void
		do
			if arguments.ignore /= Void then
				load_ignores (arguments.ignore)
			end
			if arguments.is_ecb then
				execution_environment.set_variable_value ("EC_NAME", "ecb")
			end
			process_directory (arguments.location)
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
		do
			create l_file.make (a_file)
			if not l_file.exists or else not l_file.is_readable then
				display_error ("Could not open ignore file "+a_file)
			else
				l_file.open_read
				create l_ini_loader.make
				l_ini_loader.read_from_file (l_file, False)
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
						l_ignored_files.start
					until
						l_ignored_files.after
					loop
							-- every section represents one configuration file
						l_ini_section := l_ignored_files.item
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
						ignores.force (l_ig_target, execution_environment.interpreted_string (l_ini_section.label).as_lower)
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
		do
			create l_dir.make (a_directory)
			if not l_dir.is_readable then
				display_error ("Could not read "+a_directory+"!")
			else
					-- process config files with an ecf extension
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
					-- process subdirs
				l_dir.directory_names.do_all (agent (a_dir, a_subdir: STRING)
					local
						l_dirname: DIRECTORY_NAME
					do
						create l_dirname.make_from_string (a_dir)
						l_dirname.extend (a_subdir)
						process_directory (l_dirname)
					end (a_directory, ?))
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
		do
			if ignores /= Void then
				l_ignored_targets := ignores.item (a_file.string.as_lower)
			end
				-- if the file is not listed in the excludes or explicitely lists exlucded targets
				-- after this, ignores.found_item is set
			if l_ignored_targets = Void or else not l_ignored_targets.is_empty  then
				create l_loader.make (create {CONF_PARSE_FACTORY})
				l_loader.retrieve_configuration (a_file)
				if l_loader.is_error then
					display_error ("Could not retrieve configuration "+a_file+"!")
				else
					l_loader.last_system.compilable_targets.linear_representation.do_if (agent process_target (?, a_dir), agent (a_target: CONF_TARGET; a_ignored_targets: SEARCH_TABLE [STRING]): BOOLEAN
						do
							Result := a_ignored_targets = Void or else not a_ignored_targets.has (a_target.name)
						end (?, l_ignored_targets))
				end
			end
	end

	process_target (a_target: CONF_TARGET; a_dir: STRING)
			-- Compile `a_target' located in `a_dir'.
		require
			a_target_ok: a_target /= Void
			a_dir_ok: a_dir /= Void and then not a_dir.is_empty
		do
			if arguments.is_parse_only then
				parse (a_target)
			else
				if arguments.is_melt then
					compile ("melt", arguments.is_clean, a_target, a_dir)
				end
				if arguments.is_freeze then
					compile ("freeze", False, a_target, a_dir)
				end
				if arguments.is_finalize then
					compile ("finalize", False, a_target, a_dir)
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
			l_version.force (create {CONF_VERSION}.make_version ({EIFFEL_ENVIRONMENT_CONSTANTS}.major_version, {EIFFEL_ENVIRONMENT_CONSTANTS}.minor_version, 0, 0), v_compiler)
			create l_state.make (pf_windows, build_workbench, a_target.setting_multithreaded, a_target.setting_msil_generation, a_target.setting_dynamic_runtime, a_target.variables, l_version)

				-- setup ISE_PRECOMP
			eiffel_layout.set_precompile (a_target.setting_msil_generation)

			l_system := a_target.system.name
			l_target := a_target.name
			print ("Parsing "+l_target+" from "+l_system+" ("+a_target.system.file_name+")...")

			create l_vis.make_build (l_state, a_target, create {CONF_PARSE_FACTORY})
			a_target.process (l_vis)

			if l_vis.is_error then
				if arguments.is_log_verbose then
					create l_file.make_open_write (l_system+"-"+a_target.system.uuid.out+"-"+l_target+"-parse.log")
					l_vis.last_errors.do_all (agent (a_error: CONF_ERROR; a_file: PLAIN_TEXT_FILE)
						do
							a_file.put_string (a_error.out)
						end (?, l_file))
					l_file.close
				end
				print ("Failed")
			else
				print ("Ok")
			end
			io.new_line
		end

	compile (a_action: STRING; a_clean: BOOLEAN;  a_target: CONF_TARGET; a_dir: STRING)
			-- Compile `a_target' located in `a_dir' according to `a_action' clean before compilation if `a_clean'.
		require
			a_action_ok: a_action /= Void and then (a_action.is_equal ("melt") or
						a_action.is_equal ("freeze") or a_action.is_equal ("finalize"))
			a_target_ok: a_target /= Void
			a_dir_ok: a_dir /= Void and then not a_dir.is_empty
		local
			l_args: ARRAYED_LIST [STRING]
			l_prc_factory: PROCESS_FACTORY
			l_prc_launcher: PROCESS
			l_system, l_target: STRING
			l_file: STRING
			l_dir_name: DIRECTORY_NAME
			l_dir: KL_DIRECTORY
			l_info_file: RAW_FILE
			l_info_filename: FILE_NAME
		do
			l_system := a_target.system.name
			l_target := a_target.name
			l_file := l_system+"-"+a_target.system.uuid.out+"-"+l_target+"-"+a_action

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
			end

			l_args.extend ("-project_path")
			if arguments.eifgen /= Void then
				create l_dir_name.make_from_string (arguments.eifgen)
				l_dir_name.extend (l_system)
				create l_dir.make (l_dir_name)
				l_dir.recursive_create_directory
				create l_info_filename.make_from_string (l_dir.name)
				l_info_filename.set_file_name ("ecf_location")
				create l_info_file.make_create_read_write (l_info_filename)
				l_info_file.put_string (a_target.system.file_name)
				l_info_file.close
				
				l_args.extend (l_dir_name)
			else
					-- We always use the directory of the ECF by default
				l_args.extend (a_dir)
			end

			if a_action.is_equal ("melt") then
				print ("Melting")
			elseif a_action.is_equal ("freeze") then
				print ("Freezing")
				l_args.extend ("-freeze")
			elseif a_action.is_equal ("finalize") then
				print ("Finalizing")
				l_args.extend ("-finalize")
			end
			print (" "+l_target+" from "+l_system+" ("+a_target.system.file_name+")...")

			create l_prc_factory
			l_prc_launcher := l_prc_factory.process_launcher (eiffel_layout.ec_command_name, l_args, Void)
			if arguments.is_log_verbose then
				add_data_to_file (l_file + ".log", a_target.system.file_name, a_target.name)
				l_prc_launcher.redirect_output_to_file (l_file+".log")
			else
				l_prc_launcher.redirect_output_to_agent (agent (a_string: STRING)
					do
					end)
			end
			l_prc_launcher.redirect_error_to_same_as_output
			l_prc_launcher.set_separate_console (False)
			l_prc_launcher.launch
			if l_prc_launcher.launched then
				l_prc_launcher.wait_for_exit
				if l_prc_launcher.exit_code = 0 then
					print ("Ok")
				else
					print ("Failed")
				end
				io.new_line
			end
		end

	add_data_to_file (a_file_name: STRING; a_config, a_target: STRING)
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

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
