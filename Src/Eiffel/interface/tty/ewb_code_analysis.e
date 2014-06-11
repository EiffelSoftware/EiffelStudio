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

					if l_args.item.is_empty then
							-- Corner case: split would return one empty string, I want zero strings.
							-- We still want to instantiate the list, as we want to enable exactly zero rules.
						create {ARRAYED_LIST [STRING_32]} forced_rules_list.make (0)
					else
						forced_rules_list := l_args.item.to_string_32.split (' ')
					end
				elseif l_args.item.same_string ("-caclass") or l_args.item.same_string ("-caclasses") then
					l_args.forth

					if l_args.item.is_empty then
							-- Corner case: split would return one empty string, I want zero strings.
							-- We still want to instantiate the list, as we want to analyze exactly zero classes.
						create {ARRAYED_LIST [STRING_32]} class_name_list.make (0)
					else
						class_name_list := l_args.item.split (' ')
					end
				else
					unknown_arguments.extend (l_args.item)
				end
			end
		end

feature {NONE} -- Options

	class_name_list: detachable LIST [STRING_32]
			-- List of class names for analysis, which have been provided by the user.

	forced_rules_list: detachable LIST [STRING_32]
			-- List of the IDs of enabled rules which, if specified, overrides the preferences.
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
			if attached forced_rules_list as l_forced_rules_list then
				l_code_analyzer.force_enable_rules (l_forced_rules_list)
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
