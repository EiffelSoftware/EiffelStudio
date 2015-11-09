note
	description: "Command-line Eiffel Inspector (code analysis)"
	author: "Stefan Zurfluh"
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
	make_with_arguments

feature {NONE} -- Initialization

	make_with_arguments (a_arguments: ITERABLE [STRING_32])
			-- Initialization for `Current'. `a_arguments' are the command-line
			-- arguments that are relevant for the Code Analyzer.
		local
			l_string: STRING_32
			l_list_strings: LIST [STRING_32]
		do
			create unknown_arguments.make (8)

			across a_arguments as l_args loop
				if l_args.item.same_string ("-cadefaults") then
					restore_preferences := True
				elseif l_args.item.same_string ("-caloadprefs") then
					l_args.forth
					preference_file := l_args.item
				elseif l_args.item.same_string ("-caforcerules") then
					l_args.forth

					parse_forced_rules (l_args.item)
					if forced_rules_parse_error then
						unknown_arguments.extend (l_args.item)
					end
				elseif l_args.item.same_string ("-caclass") or l_args.item.same_string ("-caclasses") then
						-- Syntax: -caclass "MY_CLASS; MY_CLASS_2; MY_CLASS_3"
						-- where semicolons are optional.
					l_args.forth

					if l_args.item.is_empty then
							-- Corner case: split would return one empty string, I want zero strings.
							-- We still want to instantiate the list, as we want to analyze exactly zero classes.
						create {ARRAYED_LIST [STRING_32]} class_name_list.make (0)
					else
						l_string := l_args.item.to_string_32

							-- We can't just prune all semicolons, otherwise "FOO;BAR" would become "FOOBAR"
						l_string.replace_substring_all (";", " ")
						l_list_strings := l_string.to_string_32.split (' ')

							-- Remove empty entries
						create {ARRAYED_LIST [STRING_32]} class_name_list.make (l_list_strings.count)
						across l_list_strings as ic loop
							if not ic.item.is_empty then
								class_name_list.extend (ic.item)
							end
						end

					end
				else
					unknown_arguments.extend (l_args.item)
				end
			end
		end


		forced_rules_parse_error: BOOLEAN
				-- Did the last call to `parse_forced_rules' result in an error?

		parse_forced_rules (a_line: STRING)
				-- Parse an argument representing the forced rules list (possibly with forced preferences).
			local
				l_line: STRING
				l_preferences_to_add: like parse_preference_block
				l_parse_error: BOOLEAN
				l_rule_name: STRING
				l_block_end_pos: INTEGER
			do
				l_line := a_line.twin
				create forced_preferences.make (16)

					-- We can't just prune all semicolons, otherwise "FOO;BAR" would become "FOOBAR"
				l_line.replace_substring_all (";", " ")

				from
					-- l_line
				until
					l_line.is_empty or l_parse_error
				loop
						-- Read the rule name
					l_rule_name := first_word (l_line, 1)

						-- Get angry if it's not recognized
					if l_rule_name.is_empty then
						l_parse_error := true
					else
							-- Enable the rule.
						forced_preferences.extend ([l_rule_name, {CA_RULE}.Option_name_enable, "True"])

							-- Trim the head
						l_line.remove_head (l_rule_name.count)
						l_line.left_adjust

							-- Do we have a preference block?
						if l_line.starts_with ("(") then
							l_block_end_pos := l_line.index_of (')', 1)
							if l_block_end_pos = 0 then
								l_parse_error := true
							else
								l_preferences_to_add := parse_preference_block (l_line.substring (2, l_block_end_pos - 1), l_rule_name)

								if attached l_preferences_to_add then
									forced_preferences.finish
									forced_preferences.merge_right (l_preferences_to_add)
								else
									l_parse_error := True
								end

									-- Trim again
								l_line.remove_head (l_block_end_pos)
								l_line.left_adjust
							end
						end
					end
				end

				forced_rules_parse_error := l_parse_error
			end

	parse_preference_block (a_block, a_rule_id: STRING): like forced_preferences
			-- Parse a preference block for a single forced rule. Return the list of preferences to force.
			-- Return Void in case of error.
		local
			l_preferences: LIST [STRING]
			l_preference: STRING
			l_equal_pos: INTEGER
			l_name, l_value: STRING
			l_this_forced_preference: like forced_preference_type
		do
			if a_block.is_empty then
					-- Border case: split would return one string, I want zero.
				create {ARRAYED_LIST [STRING]} l_preferences.make (0)
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
					l_name := l_preference.head (l_equal_pos - 1)
					l_value := l_preference.substring (l_equal_pos + 1, l_preference.count)

					create l_this_forced_preference
					l_this_forced_preference.rule_id := a_rule_id
					l_this_forced_preference.preference_name := l_name
					l_this_forced_preference.preference_value := l_value
					Result.extend (l_this_forced_preference)
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

	preference_file: STRING

	unknown_arguments: ARRAYED_LIST [STRING]

feature -- Execution (declared in EWB_CMD)

	execute
			-- Execute the Code Analysis command-line tool
		local
			l_code_analyzer: CA_CODE_ANALYZER
			l_rule_name, l_rule_id, l_line, l_col: STRING
			l_has_violations: BOOLEAN
		do
			create l_code_analyzer.make
				-- Delegate any output to the command line window.
			l_code_analyzer.add_output_action (agent print_line)

			if not attached class_name_list then
				l_code_analyzer.add_whole_system
			else
				across class_name_list as ic loop
					try_add_class_with_name (l_code_analyzer, ic.item)
				end
			end

			output_window.add ("%NEiffel Inspector%N")
			output_window.add ("----------------%N")

			if attached unknown_arguments then
				across unknown_arguments as ic loop
					print_line (ca_messages.unknown_argument (ic.item))
				end
			end

			if restore_preferences then
				l_code_analyzer.preferences.restore_defaults
			elseif preference_file /= Void then -- The user wants to load preferences.
				import_preferences (l_code_analyzer.preferences, preference_file)
			end
			if attached forced_preferences as l_forced_preferences then
				l_code_analyzer.force_preferences (l_forced_preferences)
			end
			l_code_analyzer.analyze

			across l_code_analyzer.rule_violations as l_vlist loop

				if not l_vlist.item.is_empty then
					l_has_violations := True
						-- Always sort the rule violations by the class they are referring to.
					output_window.add (ca_messages.cmd_class + l_vlist.key.name + "':%N")

						-- See `{CA_RULE_VIOLATION}.is_less' for information on the sorting.
					across l_vlist.item as ic loop
						l_rule_name := ic.item.rule.title
						l_rule_id := ic.item.rule.id
						if attached ic.item.location as l_loc then
							l_line := ic.item.location.line.out
							l_col := ic.item.location.column.out

							output_window.add (" [" + l_line + ":" + l_col + "] " + ic.item.rule.severity.short_form + ": "
								+ l_rule_id + " - " + l_rule_name + ": ")
						else -- No location attached. Print without location.
							output_window.add ("  "	+ l_rule_name + " (" + l_rule_id + "): ")
						end
						ic.item.format_violation_description (output_window)
						output_window.add ("%N")
					end
				end
			end

			if not l_has_violations then output_window.add (ca_messages.no_issues + "%N") end
		end

	import_preferences (a_pref: PREFERENCES; a_xml_file: STRING)
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
			output_window.add (a_string + "%N")
		end

	try_add_class_with_name (a_analyzer: CA_CODE_ANALYZER; a_class_name: STRING)
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

	name: STRING = "Eiffel Inspector"
			-- Name of this command-line tool.

	help_message: STRING_GENERAL
			-- Help message for this command-line tool.
		do
			Result := ca_messages.cmd_help_message
		end

	abbreviation: CHARACTER = 'a'
			-- One-character abbreviation for this command-line tool.

feature {NONE} -- Implementation

	is_identifier_character (a_char: CHARACTER): BOOLEAN
			-- Is `a_char' a valid Eiffel identifier character?
		do
			Result := (a_char = '_' or (a_char >= 'a' and a_char <= 'z') or (a_char >= 'A' and a_char <= 'Z') or (a_char >= '0' and a_char <= '9'))
		end

	first_word (a_string: STRING; a_start_index: INTEGER): STRING
			-- The first word (formed with valid Eiffel identifier characters) in `a_string',
			-- starting from `a_start_index'.
			-- An empty string if `a_string' does not start with a valid identifier.
		require
			argument_exists: a_string /= Void
		local
			i: INTEGER
			l_stop: BOOLEAN
		do
			from
				i := 1
			until
				l_stop or i > a_string.count
			loop
				if not is_identifier_character (a_string.at (i)) then
					l_stop := True
				else
					i := i + 1
				end
			end
			Result := a_string.substring (a_start_index, i - 1)
		ensure
			is_prefix: a_string.starts_with (Result)
		end

		next_word_index (a_string: STRING; a_start_index: INTEGER): INTEGER
			-- At which position does the next word (formed with valid Eiffel identifier characters)
			-- start in `a_string', after `a_start_index'?
			-- Return `a_string'.count + 1 if not found.
		require
			argument_exists: a_string /= Void
		local
			i: INTEGER
			l_stop: BOOLEAN
		do
			from
				i := a_start_index
			until
				l_stop or i > a_string.count
			loop
				if is_identifier_character (a_string.at (i)) then
					l_stop := True
				else
					i := i + 1
				end
			end
			Result := i
		ensure
			positive_result: Result >= 1
			result_small_enough: Result <= a_string.count + 1
		end


note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
