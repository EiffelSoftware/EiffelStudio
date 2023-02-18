note
	description: "System's root class."

class
	SYNTAX_UPDATER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as argument_make,
			execute as argument_execute
		end

	CONF_ACCESS
	LOCALIZED_PRINTER
	SHARED_ERROR_HANDLER
	STRING_HANDLER

create
	make

feature {NONE} -- Initialization

	make
		do
			create factory
			create parser.make_with_factory (factory)
			create fast_factory
			create fast_parser.make_with_factory (fast_factory)
				-- Enabling `il_parsing' only means accepting more, not accepting less
				-- which is important to allow for such a syntax converter
			parser.set_il_parser
			fast_parser.set_il_parser
			create visitor.make

			create string_buffer.make (102400)

			argument_make (False, True)
			is_using_builtin_switches := False
			argument_execute (agent execute)
		end

feature {NONE} -- File discovering and processing

	execute
			-- Process all files under directories specified on the command line arguments.
		local
			dir: DIRECTORY
			l_dir: STRING_32
			l_has_error: BOOLEAN
			l_processed_values: like values
		do
				-- Set settings from command line
			visitor.set_is_updating_agents (is_updating_agents)
			visitor.set_is_updating_iteration (is_updating_iteration)
			fast_factory.set_is_updating_agents (is_updating_agents)
			fast_factory.set_is_updating_iteration (is_updating_iteration)

				-- Reset `is_eiffel_class_updated' to its default value, False.
			is_eiffel_class_updated := False

				-- Ensure directories exist.
			create l_processed_values.make (values.count)
			across
				values as v
			loop
				l_dir := environment.interpreted_string_32 (v.item)
				create dir.make (l_dir)
				if not dir.exists then
					if not l_dir.is_empty and then (l_dir.item (l_dir.count) = '/' or l_dir.item (l_dir.count) = '\') then
						l_dir.remove_tail (1)
						l_processed_values.extend (l_dir)
						create dir.make (l_dir)
						if not dir.exists then
							l_has_error := True
							localized_print_error ({STRING_32} "directory: " + l_dir + {STRING_32} " is not accessible%N")
						end
					else
						l_has_error := True
						localized_print_error ({STRING_32} "directory: " + l_dir + {STRING_32} " is not accessible%N")
					end
				else
					l_processed_values.extend (l_dir)
				end
			end

				-- All directories seem to exist, let's process them.
			if not l_has_error then
				across
					l_processed_values as v
				loop
					create dir.make (v.item)
					if dir.exists then
						test_recursive (dir)
					else
						localized_print_error ("Error trying to access directory: ")
						localized_print_error (v.item)
						io.error.put_new_line
					end
				end
			end
		end

	test_recursive (a_dir: DIRECTORY)
			-- Process files and directories under `a_dir'.
		require
			a_dir_not_void: a_dir /= Void
			a_dir_exists: a_dir.exists
		local
			dir_names: ARRAYED_LIST [PATH]
			l_file: RAW_FILE
			l_dir: DIRECTORY
			l_previous_modified: like is_eiffel_class_updated
			l_ecf_lists: ARRAYED_LIST [PATH]
		do
			dir_names := a_dir.entries
			if dir_names /= Void then
				l_previous_modified := is_eiffel_class_updated
				is_eiffel_class_updated := False
				create l_ecf_lists.make (10)
				across
					dir_names as dir
				loop
					if not dir.item.is_current_symbol and then not dir.item.is_parent_symbol then
						create l_file.make_with_path (a_dir.path.extended_path (dir.item))
						if l_file.exists then
							if l_file.is_directory then
								create l_dir.make_with_path (l_file.path)
								if l_dir.is_readable then
									test_recursive (l_dir)
								end
							elseif l_file.is_readable and l_file.is_plain then
								update_eiffel_class (l_file.path)
									-- We do not process ECFs if no Eiffel classes have been modified in `a_dir',
									-- so we have to store all the ECFs we encounter before converting them.
								if is_updating_ecfs and then l_file.path.has_extension ("ecf") then
									l_ecf_lists.extend (l_file.path)
								end
							end
						end
					end
				end
				if is_eiffel_class_updated then
						-- Only update ECFs if some Eiffel classes have been modified.
					⟳ e: l_ecf_lists ¦ process_configuration (e) ⟲
				end
				is_eiffel_class_updated := l_previous_modified or else is_eiffel_class_updated
			end
		end

feature {NONE} -- Implementation

	process_configuration (a_file: PATH)
			-- Process configuration file `a_file`.
		require
			is_updating_ecfs: is_updating_ecfs
			a_file_is_ecf: a_file.has_extension ("ecf")
		local
			l_loader: CONF_LOAD
			l_saver: CONF_PRINT_VISITOR
			l_file: PLAIN_TEXT_FILE
			has_error: BOOLEAN
		do
			create l_loader.make (create {CONF_PARSE_FACTORY})
			l_loader.retrieve_configuration (a_file.name)
			if l_loader.is_error then
				display_error ({STRING_32} "Could not retrieve configuration " + a_file.name + "!")
				if attached l_loader.last_error as e then
					display_error (e.text)
				end
			elseif l_loader.last_redirection = Void then
					-- Process only an ECF file that is not a redirection, otherwise
					-- the redirection would be replaced with the content of the redirected ECF.
				if attached l_loader.last_system as s then
					if is_updating_agents then
							-- Remove the `is_obsolete_routine_type' option if present on all targets.
							-- Report only one agent-related error per configuration.
						has_error := False
						across s.targets as t loop
							if attached t.item.internal_options as o then
								if not o.is_obsolete_routine_type and not has_error then
									display_error ({STRING_32} "Configuration %"" + a_file.name + "%" uses up-to-date agent types.")
									has_error := True
								end
									-- The configuration still relies on the original version.
									-- Therefore, `o.unset_is_obsolete_routine_type` would affect that version, not the latest one.
									-- To avoid that, the option is set even if it has the same default value in the latest configuration.
								o.set_is_obsolete_routine_type (False)
							end
						end
					end
					if is_updating_iteration then
							-- Remove `is_obsolete_iteration` on all targets and their own clusters.
							-- Report only one iteration-related error per configuration.
						has_error := False
						across s.targets as t loop
							if attached t.item.internal_options as o then
								if not o.is_obsolete_iteration and not has_error then
									display_error ({STRING_32} "Configuration %"" + a_file.name + "%" uses up-to-date iteration syntax.")
									has_error := True
								end
									-- The configuration still relies on the original version.
									-- Therefore, `o.unset_is_obsolete_iteration` would affect that version, not the latest one.
									-- To avoid that, the option is set even if it has the same default value in the latest configuration.
								o.set_is_obsolete_iteration (False)
							end
							if attached t.item.internal_clusters as cs then
								across cs as c loop
									if attached c.item.changeable_internal_options as o then
										if not o.is_obsolete_iteration and not has_error then
											display_error ({STRING_32} "Configuration %"" + a_file.name + "%" uses up-to-date iteration syntax.")
											has_error := True
										end
											-- The configuration still relies on the original version.
											-- Therefore, `o.unset_is_obsolete_iteration` would affect that version, not the latest one.
											-- To avoid that, the option is set even if it has the same default value in the latest configuration.
										o.set_is_obsolete_iteration (False)
									end
								end
							end
						end
					end
						-- Resave the file in the right format
					create l_saver.make
					l_saver.process_system (s)
					create l_file.make_with_path (a_file)
					safe_open_write (l_file)
					l_file.put_string (l_saver.text)
					l_file.close
				end
			end
		end

	update_eiffel_class (file_name: PATH)
		require
			file_name_not_void: file_name /= Void
		local
			file: RAW_FILE
			outfile: RAW_FILE
			count: INTEGER
			l_text: STRING
			l_generate_output: BOOLEAN
			l_converted: BOOLEAN
		do
			if file_name.has_extension ("e") then
				create file.make_with_path (file_name)
				count := file.count
				safe_open_read (file)
				if file.is_open_read then
					if string_buffer.count < count then
						string_buffer.resize (count)
					end
					string_buffer.set_count (count)
					string_buffer.set_count (file.read_to_string (string_buffer, 1, count))
					file.close
						-- Fast parsing using our `fast_factory' to detect old constructs.
					fast_factory.reset
					parse_eiffel_class (fast_parser, string_buffer, False)
					if error_handler.has_error then
							-- We ignore syntax errors since we want to test roundtrip parsing
							-- on valid Eiffel classes.

						if attached {SYNTAX_ERROR} error_handler.error_list.last as l_syntax1 then
							display_error ({STRING_32} "Syntax error at (" + l_syntax1.line.out + ", " + l_syntax1.column.out + ") in file: " + file_name.name)
							if not l_syntax1.error_message.is_empty then
								display_error ({STRING_32} "    " + l_syntax1.error_message)
							end
						else
							display_error ({STRING_32} "Syntax error in file: " + file_name.name)
						end
						error_handler.wipe_out
					elseif fast_factory.has_obsolete_constructs then
							-- Slow parsing to rewrite the class using the new constructs.
						parse_eiffel_class (parser, string_buffer, False)
						check no_error: not error_handler.has_error end
						check
							attached parser.root_node as r
							attached parser.match_list as m
						then
							visitor.setup (r, m, True, True)
								-- Free some memory from the parser that we don't need.
							parser.reset
							parser.reset_nodes
								-- Perform the visiting
							visitor.process_ast_node (r)
							if visitor.is_updated then
								is_eiffel_class_updated := True
								l_text := visitor.text
								parse_eiffel_class (fast_parser, l_text, True)
								if error_handler.has_error then
										-- We ignore syntax errors since we want to test roundtrip parsing
										-- on valid Eiffel classes.
									display_error ({STRING_32} "After conversion syntax error in file: " + file_name.name)
									if attached {SYNTAX_ERROR} error_handler.error_list.last as l_syntax2 then
										display_error ({STRING_32} " (" + l_syntax2.line.out + ", " + l_syntax2.column.out + ")" + l_syntax2.error_message)
									end
									if has_option (force_switch) then
										l_generate_output := True
										display_error (" (converted)")
									else
										l_generate_output := False
									end
									error_handler.wipe_out
								else
									l_generate_output := True
								end
								if l_generate_output then
									if attached original_encoding as l_encoding then
										utf8.convert_to (l_encoding, l_text)
										if utf8.last_conversion_successful then
											l_text := utf8.last_converted_stream
											l_converted := True
										else
											display_error ("Encoding conversion failed: UTF-8 to " + l_encoding.code_page)
										end
									end
									create outfile.make_with_path (file_name)
									safe_open_write (outfile)
									if last_open_successful then
										if l_converted and then attached original_bom as l_bom then
											outfile.put_string (l_bom)
										end
										outfile.put_string (l_text)
										outfile.close
										if has_option (verbose_switch) then
											display_message ({STRING_32} "Converted: " + file_name.name)
										end
									else
										display_error ({STRING_32} "Could not write to: " + file_name.name)
									end
								end
							end
								-- Free our memory.
							visitor.reset
						end
					end
				else
					display_error ({STRING_32} "Couldn't open: " + file_name.name)
				end
			end
		end

	parse_eiffel_class (a_parser: EIFFEL_PARSER; a_buffer: STRING; a_verification: BOOLEAN)
			-- Using a parser, parse our code using different parser mode, to ensure that we can
			-- indeed convert any kind of Eiffel classes.
			-- `a_verification' indicates that `a_buffer' was read in UTF-8 from the roundtrip parser.
			-- Otherwise `a_buffer' is in unknown encoding.
		require
			a_parser_not_void: a_parser /= Void
			a_buffer_not_void: a_buffer /= Void
		local
			is_parsed: BOOLEAN
		do
				-- Perform parsing using different syntax conventions in the order:
				-- obsolete, transitional, standard.
			across
				<<{EIFFEL_PARSER}.obsolete_syntax,
				{EIFFEL_PARSER}.transitional_syntax,
				{EIFFEL_PARSER}.ecma_syntax>> as s
			until
				is_parsed
			loop
				error_handler.wipe_out
				a_parser.set_syntax_version (s.item)
				a_parser.set_is_explicit_iteration_cursor (is_updating_iteration)
				if not a_verification then
					a_parser.parse_class_from_string (a_buffer, Void, Void)
					original_encoding := a_parser.detected_encoding
					original_bom := a_parser.detected_bom
				else
					a_parser.parse_from_utf8_string (a_buffer, Void)
				end
				is_parsed := not error_handler.has_error
			end
		end

	safe_open_read (a_file: FILE)
		local
			retried: BOOLEAN
		do
			if not retried then
				a_file.open_read
				last_open_successful := True
			else
				last_open_successful := False
			end
		rescue
			retried := True
			retry
		end

	safe_open_write (a_file: FILE)
		local
			retried: BOOLEAN
		do
			if not retried then
				a_file.open_write
				last_open_successful := True
			else
				last_open_successful := False
			end
		rescue
			retried := True
			retry
		end

	last_open_successful: BOOLEAN
			-- Was last call to `safe_open_read|write' successful?

	is_eiffel_class_updated: BOOLEAN
			-- Was a class updated?

feature {NONE} -- Encoding

	original_encoding: detachable ENCODING
			-- Encoding detected by last parsing

	original_bom: detachable STRING
			-- Bom of the encoding detected by last parsing

feature {NONE} -- Parser

	parser: EIFFEL_PARSER
	fast_parser: EIFFEL_PARSER
	factory: AST_ROUNDTRIP_FACTORY
	fast_factory: SYNTAX_UPDATER_FACTORY
	visitor: SYNTAX_UPDATER_VISITOR
			-- Factories and visitors being used for parsing.

	string_buffer: STRING
			-- Buffer for reading Eiffel classes.

feature {NONE} -- Error handling

	display_error (a_message: READABLE_STRING_GENERAL)
			-- Process `a_message'.
		require
			a_message_ok: a_message /= Void and then not a_message.is_empty
		do
			localized_print_error (a_message)
			io.error.new_line
		end

	display_message (a_message: READABLE_STRING_GENERAL)
			-- Process `a_message'.
		require
			a_message_ok: a_message /= Void and then not a_message.is_empty
		do
			localized_print (a_message)
			io.new_line
		end

feature {NONE} -- Arguments processing

	is_updating_agents: BOOLEAN
			-- Will agent types be updated?
		do
			Result := has_option (agents_switch)
		end

	is_updating_iteration: BOOLEAN
			-- Will iteration syntax be updated?
		do
			Result := has_option (iteration_switch)
		end

	is_updating_ecfs: BOOLEAN
			-- Will ECFs be updated?
		do
			Result := has_option (ecf_switch) or else is_updating_agents or else is_updating_iteration
		end

	name: STRING = "Eiffel Syntax Updater"
	version: STRING = "21.05.01"
	copyright: STRING = "Copyright Eiffel Software 2007-2023. All Rights Reserved."

	non_switched_argument_name: STRING = "Directory"
	non_switched_argument_description: STRING = "Directory to process"
	non_switched_argument_type: STRING = "Directory"

	agents_switch: STRING = "a|agents"
	agents_switch_description: STRING = "Update type of agents to new 15.11 definition. Implies -e."
	ecf_switch: STRING = "e|ecf"
	ecf_switch_description: STRING = "Update ECF if Eiffel classes have been updated"
	force_switch: STRING = "f|force"
	force_switch_description: STRING = "Force generation of syntactically incorrect classes"
	iteration_switch: STRING = "i|iteration"
	iteration_switch_description: STRING = "Update iteration loops to the syntax supported by 21.05 and above. Implies -e."
	verbose_switch: STRING = "v|verbose"
	verbose_switch_description: STRING = "Verbose output of processing"
			-- Our arguments

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
		once
			create Result.make (2)
			Result.extend (create {ARGUMENT_SWITCH}.make (verbose_switch, verbose_switch_description, True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (force_switch, force_switch_description, True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (ecf_switch, ecf_switch_description, True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (agents_switch, agents_switch_description, True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (iteration_switch, iteration_switch_description, True, False))
		end

feature {NONE} -- Environment

	environment: ENV_INTERP
		once
			create Result
		end

invariant
	parser_not_void: parser /= Void
	fast_parser_not_void: fast_parser /= Void
	factory_not_void: factory /= Void
	fast_factory_not_void: fast_factory /= Void
	visitor_not_void: visitor /= Void
	string_buffer_not_void: string_buffer /= Void

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
