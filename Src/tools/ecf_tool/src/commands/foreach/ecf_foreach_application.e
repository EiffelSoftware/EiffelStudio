note
	description: "[
				Root class for ecf foreach task
			]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_FOREACH_APPLICATION

inherit
	ECF_CONF_HELPERS

	LOCALIZED_PRINTER
		undefine
			default_create
		end

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make (args: ECF_FOREACH_ARGUMENTS)
		local
			dv: ECF_DIRECTORY_CUSTOM_ITERATOR
			has_processed_node: BOOLEAN
			confirmed: BOOLEAN
			s: READABLE_STRING_GENERAL
			dirs: ARRAYED_LIST [READABLE_STRING_GENERAL]
			lst: ARRAYED_LIST [PATH]
			fut: FILE_UTILITIES
			utf: UTF_CONVERTER
			l_regexp: REGULAR_EXPRESSION
		do
			default_create
			create errors.make (0)
			create warnings.make (0)
			has_processed_node := False

			if attached args.expression as exp then
				expression := exp
			else
				expression := ""
			end
			root_directory := execution_environment.current_working_path

			if attached args.excluded_directories as l_excluded_dirs then
				create dirs.make (l_excluded_dirs.count)
				excluded_directories := dirs

				across
					l_excluded_dirs as ic
				loop
					s := ic.item.absolute_path.canonical_path.name
					if {PLATFORM}.is_windows then
						s := s.as_lower -- Case insensitive!
					end
					if not dirs.has (s) then
						dirs.force (s)
					end
				end
			end

			is_simulation := args.simulation_enabled
			if attached args.regexp_pattern as l_pattern then
				create l_regexp
				l_regexp.compile (utf.utf_32_string_to_utf_8_string_8 (l_pattern))
				if l_regexp.is_compiled then
					ecf_regexp := l_regexp
				end
			end
			verbose := args.verbose

			if attached args.included_paths as l_included_paths and then not l_included_paths.is_empty then
				create lst.make (l_included_paths.count)
				across
					l_included_paths as ic
				loop
					if not lst.has (ic.item) then
						lst.force (ic.item)
					end
				end
			else
				create lst.make (1)

				io.output.put_string ("No file or directory were provided.%N")
				if args.execution_forced then
					lst.force (root_directory)
				else
					io.output.put_string ("Do you want to process recursively current directory %N%T%"")
					localized_print (execution_environment.current_working_path.name)
					io.output.put_string ("%" %N Continue (y|N)?")
					io.read_line
					io.last_string.left_adjust
					io.last_string.right_adjust
					io.last_string.to_lower
					if io.last_string.same_string ("y") then
						lst.force (root_directory)
					end
				end
					-- Defaulted to `root_directory'.
				create lst.make (1)
				lst.force (root_directory)
			end

			io.output.put_string ("Scan for ecf in:%N")
			across
				lst as ic
			loop
				io.output.put_string ("  - ")
				localized_print (ic.item.name)
				io.output.put_string ("%N")
			end

			io.output.put_string ("Simulation=" + is_simulation.out + "%N")
			if verbose then
				io.output.put_string ("Verbose=" + verbose.out + "%N")
			end


			confirmed := True
			if confirmed then
				create dv.make (agent process_ecf)
				if excluded_directories /= Void then
					dv.set_process_directory_action (agent record_last_visited_directory)
					dv.set_directory_excluded_function (agent is_excluded_path)
				end

				across
					lst as ic --| Later, maybe allow multiple root dirs.
				loop
					if verbose then
						report_progress ({STRING_32} "Scanning %"" + ic.item.name + {STRING_32} "%" for .ecf files ...")
					end
					if fut.file_path_exists (ic.item) then
						if fut.file_path_exists (ic.item) then
							dv.process_file (ic.item)
						else
							localized_print ("File not found: ")
							localized_print (ic.item.name)
							localized_print ("%N")
						end
					else
						if fut.directory_path_exists (ic.item) then
							dv.process_directory (ic.item)
						else
							localized_print ("Directory not found: ")
							localized_print (ic.item.name)
							localized_print ("%N")
						end
					end
				end

				if not warnings.is_empty then
					io.error.put_string ("[WARNING] " + warnings.count.out + " warnings occurred.")
					io.error.put_new_line
					across
						warnings as warn
					loop
						localized_print_error (warn.item)
						io.error.put_new_line
					end
				end

				if not errors.is_empty then
					io.error.put_string ("[ERROR] " + errors.count.out + " errors occurred.")
					io.error.put_new_line
					across
						errors as err
					loop
						localized_print_error (err.item)
						io.error.put_new_line
					end
				end
			else
				io.output.put_string ("Operation cancelled by user.%N")
			end
		end

feature -- Access

	expression: detachable READABLE_STRING_32

	process_expression (ecf: READABLE_STRING_GENERAL; a_uuid: detachable READABLE_STRING_GENERAL; a_system_name, a_target_name: READABLE_STRING_GENERAL; )
		local
			cmd: STRING_32
		do
			if attached expression as exp and then not exp.is_whitespace then
				create cmd.make_from_string (exp)
				cmd.replace_substring_all ("{{ecf}}", ecf.as_string_32)
				cmd.replace_substring_all ("{{system}}", a_system_name.as_string_32)
				cmd.replace_substring_all ("{{target}}", a_target_name.as_string_32)
				if a_uuid /= Void then
					cmd.replace_substring_all ("{{uuid}}", a_uuid.as_string_32)
				else
					cmd.replace_substring_all ("{{uuid}}", "_")
				end
				if is_simulation then
					localized_print ("Execute:%N")
					localized_print (cmd)
					localized_print ("%N%N")
				else
					execution_environment.system (cmd)
				end
			else
				localized_print (ecf)
				localized_print (": call ")
				localized_print (expression)
				localized_print (" (")
				localized_print (a_target_name)
				localized_print (")%N")
			end
		end

	root_directory: PATH
			-- Root directory of the collection of lib
			-- or as reference for an environment variable

	excluded_directories: detachable LIST [READABLE_STRING_GENERAL]
			-- Directory paths to exclude from scanning.

	is_simulation: BOOLEAN

	ecf_regexp: detachable REGULAR_EXPRESSION

	verbose: BOOLEAN

	errors: ARRAYED_LIST [READABLE_STRING_GENERAL]
	warnings: ARRAYED_LIST [READABLE_STRING_GENERAL]

feature -- Basic operation	

	process_ecf (a_fn: PATH)
		local
			tgt: CONF_TARGET
			l_regexp: detachable REGULAR_EXPRESSION
		do
			l_regexp := ecf_regexp
			if
				l_regexp = Void or else
				(attached a_fn.entry as e and then l_regexp.matches (e.utf_8_name))
			then
				if attached config_system_from (a_fn.name) as l_system then
					across
						l_system.targets as ic
					loop
						tgt := ic.item
						if not tgt.is_abstract then
							if verbose then
								localized_print (a_fn.name)
								localized_print ("[")
								localized_print (l_system.uuid.out)
								localized_print ("].")
								localized_print (l_system.name)
								localized_print (".")
								localized_print (tgt.name)
								localized_print ("%N")
							end
							process_expression (a_fn.name, l_system.uuid.out, l_system.name, tgt.name)
						end
					end
				else
					report_warning ({STRING_32} "Could not load ecf from %"" + a_fn.name + "%".")
				end
			end
		end

	is_excluded_path (p: PATH): BOOLEAN
		local
			loc: STRING_32
		do
			if attached excluded_directories as dirs then
				if attached last_visited_directory as dp then
					loc := dp.extended_path (p).absolute_path.canonical_path.name
				else
					loc := p.absolute_path.canonical_path.name
				end
				if {PLATFORM}.is_windows then
					loc.to_lower
				end
				across
					dirs as ic
				until
					Result
				loop
					Result := loc.starts_with_general (ic.item)
				end
			end
		end

	record_last_visited_directory (dn: PATH)
		do
			last_visited_directory := dn
		end

	last_visited_directory: detachable PATH


feature {NONE} -- Implementation

	report_warning (m: READABLE_STRING_GENERAL)
		do
			warnings.extend (m)
			localized_print ({STRING_32} "[Warning] " + m.to_string_32)
			io.error.put_new_line
		end

	report_progress (m: READABLE_STRING_GENERAL)
		do
			localized_print (m)
			io.output.put_new_line
		end

	report_error (m: READABLE_STRING_GENERAL)
		do
			errors.extend (m)
			localized_print_error ({STRING_32} "[Error] " + m.to_string_32)
			io.error.put_new_line
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
