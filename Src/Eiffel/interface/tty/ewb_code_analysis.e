note
	description: "Command-line Eiffel Inspector (code analysis)"
	author: "Stefan Zurfluh and others"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_CODE_ANALYSIS

inherit
	EWB_CMD

	SHARED_SERVER
		export {NONE} all end

	CA_SHARED_NAMES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize with empty set of classes and rules.
		do
		end

feature -- Status report

	argument_error: detachable STRING_32
			-- Error in an argument(s) (if any).

	is_all_classes: BOOLEAN
			-- Should all classes be processed?

feature -- Initialization

	parse_arguments (a_arguments: ITERABLE [READABLE_STRING_32])
			-- Initialize using command-line arguments `a_arguments'
			-- that are relevant for the Code Analyzer.
		do
			across a_arguments as l_args loop
				if l_args.item.same_string_general ("-cadefaults") then
					set_defaults
				elseif l_args.item.same_string_general ("-caloadprefs") then
					l_args.forth
					if l_args.after then
						argument_error := ca_messages.missing_file_name ("-caloadprefs")
					else
						set_preference_file (l_args.item)
					end
				elseif l_args.item.same_string_general ("-caforcerules") then
					l_args.forth
					if l_args.after then
						argument_error := ca_messages.missing_rule ("-caforcerules")
					elseif not attached argument_error then
						add_rule (l_args.item)
						if attached argument_error as e then
								-- Add option name to the error message.
							argument_error := ca_messages.rule_argument_error ("-caforcerules", e)
						end
					end
				elseif l_args.item.same_string_general ("-caclass") or l_args.item.same_string_general ("-caclasses") then
						-- Syntax: -caclass "MY_CLASS; MY_CLASS_2; MY_CLASS_3"
						-- where semicolons are optional.
					l_args.forth
					if l_args.after then
						argument_error := ca_messages.missing_class ("-caclasses")
					else
						add_class (l_args.item)
					end
				else
					argument_error := ca_messages.unknown_argument (l_args.item)
				end
			end
				-- By default if code analysis is requested with an old command-line option,
				-- it should be performed in any case.
				-- Therefore if a class list is not set, all classes need to be processed.
			if not attached class_name_list then
				is_all_classes := True
			end
		end

	set_defaults
			-- Tell code analyzer to use default preferences.
		do
			restore_preferences := True
		end

	set_preference_file (f: READABLE_STRING_32)
			-- Tell code analyzer to load preferences from a file of name `f'.
		do
			preference_file := f
		end

	add_rule (r: READABLE_STRING_32)
			-- Tell code analyzer to apply a specified rule or rules (with optional preference settings).
		do
			parse_forced_rules (r)
		end

	set_all_classes
			-- Tell code analyzer to process all classes.
		do
			is_all_classes := True
		end

	add_class (c: READABLE_STRING_32)
			-- Tell code analyzer to process a given class or classes.
		local
			s: STRING_32
			ss: like {STRING_32}.split
		do
			if c.is_empty then
					-- Request to analyze exactly zero classes.
				create {ARRAYED_LIST [STRING_32]} class_name_list.make (0)
			else
				s := c.to_string_32

					-- We can't just prune all semicolons, otherwise "FOO;BAR" would become "FOOBAR".
				s.replace_substring_all ({STRING_32} ";", {STRING_32} " ")
				ss := s.split (' ')

					-- Remove empty entries
				create {ARRAYED_LIST [STRING_32]} class_name_list.make (ss.count)
				across ss as ic loop
					if not ic.item.is_empty then
						class_name_list.extend (ic.item)
					end
				end
			end
		end

feature {NONE} -- Parsing

		parse_forced_rules (a_line: READABLE_STRING_32)
				-- Parse an argument representing the forced rules list (possibly with forced preferences).
			local
				l_line: STRING_32
				l_rule_name: READABLE_STRING_32
				l_block_end_pos: INTEGER
			do
				l_line := a_line
				create forced_preferences.make (16)

					-- We can't just prune all semicolons, otherwise "FOO;BAR" would become "FOOBAR"
				l_line.replace_substring_all ({STRING_32} ";", {STRING_32} " ")

				from
				until
					l_line.is_empty or attached argument_error
				loop
						-- Read the rule name
					l_rule_name := first_word (l_line, 1)

					if l_rule_name.is_empty then
							-- Report bad rule name.
						argument_error := ca_messages.invalid_rule_name
					else
							-- Enable the rule.
						forced_preferences.extend ([l_rule_name, {CA_RULE}.Option_name_enable, "True"])

							-- Trim the head
						l_line.remove_head (l_rule_name.count)
						l_line.left_adjust

							-- Do we have a preference block?
						if l_line.index_of ('(', 1) = 1 then
							l_block_end_pos := l_line.index_of (')', 1)
							if l_block_end_pos = 0 then
									-- Report missing closing parenthesis.
								argument_error := ca_messages.missing_closing_parenthesis (l_rule_name)
							else
								if attached parse_preference_block (l_line.substring (2, l_block_end_pos - 1), l_rule_name) as l_preferences_to_add then
									forced_preferences.finish
									forced_preferences.merge_right (l_preferences_to_add)
								else
										-- Report invalid rule settings.
									argument_error := ca_messages.invalid_rule_setting (l_rule_name)
								end
									-- Trim again
								l_line.remove_head (l_block_end_pos)
								l_line.left_adjust
							end
						end
					end
				end
			end

	parse_preference_block (a_block, a_rule_id: READABLE_STRING_32): like forced_preferences
			-- Parse a preference block for a single forced rule. Return the list of preferences to force.
			-- Return Void in case of error.
		local
			l_preferences: LIST [READABLE_STRING_32]
			l_preference: STRING_32
			l_equal_pos: INTEGER
		do
			if a_block.is_empty then
					-- Border case: split would return one string, I want zero.
				create {ARRAYED_LIST [READABLE_STRING_32]} l_preferences.make (0)
			else
				l_preferences := a_block.split (',')
			end
			create Result.make (l_preferences.count)

			from
				l_preferences.start
			until
				l_preferences.after or Result = Void
			loop
				l_preference := l_preferences.item
				l_preference.adjust
				l_equal_pos := l_preference.index_of ('=', 1)
				if l_equal_pos = 0 then
						-- Error
					Result := Void
				else
					if
						attached l_preference.head (l_equal_pos - 1) as n and then
						across n as nc all nc.item.natural_32_code <= 127 end
					then
						Result.extend ([a_rule_id, n.to_string_8, l_preference.substring (l_equal_pos + 1, l_preference.count)])
					else
							-- Invalid rule name.
						Result := Void
					end
				end
				l_preferences.forth
			end
		end

feature {NONE} -- Options

	class_name_list: detachable LIST [STRING_32]
			-- List of class names for analysis, which have been provided by the user.

	forced_preference_type: TUPLE [rule_id: READABLE_STRING_GENERAL; preference_name: STRING; preference_value: READABLE_STRING_GENERAL]
			-- Shortcut for the type.
		do
			check callable: False end
		end

	forced_preferences: detachable ARRAYED_LIST [like forced_preference_type]
			-- List of preferences specified through the command line.
			-- If specified, all rules will be disabled by default.
			-- Void if unspecified.

	restore_preferences: BOOLEAN
			-- Does the user want to restore the Code Analysis preferences to their
			-- default values?

	preference_file: READABLE_STRING_32
			-- Name of a preference file.

feature -- Execution (declared in EWB_CMD)

	execute
			-- Execute the Code Analysis command-line tool
		local
			l_code_analyzer: CA_CODE_ANALYZER
			l_rule_name, l_rule_id: STRING_32
			l_has_violations: BOOLEAN
		do
			create l_code_analyzer.make
				-- Delegate any output to the command line window.
			l_code_analyzer.add_output_action (agent print_line)

			if is_all_classes then
				l_code_analyzer.add_whole_system
			elseif attached class_name_list as cs then
				across cs as c loop
					try_add_class_with_name (l_code_analyzer, c.item)
				end
			end

			output_window.add ("[
				
				Code analysis
				-------------
				
			]")

			if restore_preferences then
				l_code_analyzer.preferences.restore_defaults
			end
			if preference_file /= Void then -- The user wants to load preferences.
				import_preferences (l_code_analyzer.preferences, preference_file)
			end
			if attached forced_preferences as l_forced_preferences then
				l_code_analyzer.force_preferences (l_forced_preferences)
			end
			l_code_analyzer.analyze

			across l_code_analyzer.rule_violations as l_vlist loop
				if not l_vlist.item.is_empty then
					l_has_violations := True
						-- Always sort rule violations by the class they are referring to.
					output_window.add (ca_messages.cmd_class + l_vlist.key.name + "':%N")
						-- See `{CA_RULE_VIOLATION}.is_less' for information on the sorting.
					across l_vlist.item as ic loop
						l_rule_name := ic.item.rule.title
						l_rule_id := ic.item.rule.id
						output_window.add
							(if attached ic.item.location as l_loc then
								{STRING_32} " [" + ic.item.location.line.out + ":" + ic.item.location.column.out + "] "
							else
								{STRING_32} " "
							end
							+ ic.item.severity.short_form + ": " + l_rule_id + " - " + l_rule_name + ": ")
						ic.item.format_violation_description (output_window)
						output_window.add_new_line
					end
				end
			end

			if not l_has_violations then output_window.add (ca_messages.no_issues + "%N") end
		end

	import_preferences (a_pref: PREFERENCES; a_xml_file: READABLE_STRING_32)
			-- Imports the preferences from the XML file `a_xml_file' to
			-- `a_pref'.
		local
			l_storage: PREFERENCES_STORAGE_XML
		do
			create l_storage.make_with_location_and_version (a_xml_file, a_pref.version)
			a_pref.import_from_storage (l_storage)
		end

	print_line (a_string: READABLE_STRING_GENERAL)
			-- Prints `a_string' and a new line to the output window.
		do
			output_window.add (a_string)
			output_window.add_new_line
		end

	try_add_class_with_name (a_analyzer: CA_CODE_ANALYZER; a_class_name: READABLE_STRING_GENERAL)
			-- Adds class with name `a_class_name' if it is found amongst the compiled
			-- classes to `a_analyzer'.
		do
			if attached universe.classes_with_name (a_class_name) as l_c and then not l_c.is_empty then
				across l_c as ic loop
					a_analyzer.add_class (ic.item.config_class)
				end
			else
				output_window.add (ca_messages.cmd_class_not_found_1 + a_class_name + ca_messages.cmd_class_not_found_2)
			end
		end

feature -- Info (declared in EWB_CMD)

	name: STRING = "Code analyzer"
			-- Name of this command-line tool.

	help_message: STRING_GENERAL
			-- Help message for this command-line tool.
		do
			Result := ca_messages.cmd_help_message
		end

	abbreviation: CHARACTER = 'a'
			-- One-character abbreviation for this command-line tool.

feature {NONE} -- Implementation

	is_identifier_character (a_char: CHARACTER_32): BOOLEAN
			-- Is `a_char' a valid Eiffel identifier character?
		do
			Result := a_char = '_' or (a_char >= 'a' and a_char <= 'z') or (a_char >= 'A' and a_char <= 'Z') or (a_char >= '0' and a_char <= '9')
		end

	first_word (a_string: READABLE_STRING_32; a_start_index: INTEGER): READABLE_STRING_32
			-- The first word (formed with valid Eiffel identifier characters) in `a_string',
			-- starting from `a_start_index'.
			-- An empty string if `a_string' does not start with a valid identifier.
		require
			argument_exists: a_string /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_string.count or else not is_identifier_character (a_string [i])
			loop
				i := i + 1
			end
			Result := a_string.substring (a_start_index, i - 1)
		ensure
			is_prefix: a_string.starts_with (Result)
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
