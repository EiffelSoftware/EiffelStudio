note
	description: "[
		Analyzes the C compilation output to produce results.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_C_COMPILER_OUTPUT_ANALYZER

inherit
	ES_OUTPUT_ANALYZER
		redefine
			make,
			on_output_new_line
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_formatter: ES_NOTIFIER_FORMATTER)
			-- <Precursor>
		do
			Precursor (a_formatter)
			error_list_preferences := preferences.error_list_tool_data
		end

feature {NONE} -- Access

	file_name: detachable STRING
			-- Last processed file name.

	message: detachable STRING
			-- Last message string

	function_name: detachable STRING
			-- Last processed function name.

	line_number: INTEGER
			-- Last processed file line number.

	is_error: BOOLEAN
			-- Indicates if the last processed information was an error.

	error_list_preferences: ES_ERROR_LIST_DATA
			-- Error list preferences, used to

feature {NONE} -- Access: Help

	c_compiler_context: UUID
			-- Event list service context id
		once
			create Result.make_from_string ("E1FFE1CC-D45B-4A56-87C5-B64535BAFE1B")
		end

feature {NONE} -- Status report

	is_reporting_c_errors: BOOLEAN
			-- Indicates if C compiler errors are reported.
		do
			Result := error_list_preferences.report_c_compiler_errors
		end

	is_reporting_c_warnings: BOOLEAN
			-- Indicates if C compiler warnings (and errors) are reported.
		do
			Result := error_list_preferences.report_c_compiler_errors_and_warnings
		end

feature {NONE} -- Helpers

	event_list: SERVICE_CONSUMER [EVENT_LIST_S]
			-- Event list service
		once
			create Result
		ensure
			result_attached: attached Result
		end

	function_mapper: ES_C_TO_EIFFEL_FUNCTION_MAPPER
			-- Maps frozen C function names to Eiffel functions.
		once
			create Result
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Basic operations

	process_last_error
			-- Process the last error information.
		require
			is_interface_usable: is_interface_usable
			is_reporting_c_errors: is_reporting_c_errors
		local
			l_error: detachable C_COMPILER_ERROR
			l_item: detachable EVENT_LIST_ERROR_ITEM_I
		do
			if
				event_list.is_service_available and then
				attached file_name as l_file_name and then
				attached message as l_message and then
				not l_message.is_empty
			then
				l_message.put (l_message.item (1).as_upper, 1)

					-- Create the error/warning object
				if is_error then
					l_error := new_c_compiler_error (l_message, l_file_name, line_number)
					create {EVENT_LIST_ERROR_ITEM} l_item.make ({ENVIRONMENT_CATEGORIES}.compilation, l_message, l_error)
				else
					if is_reporting_c_warnings then
						l_error := new_c_compiler_warning (l_message, l_file_name, line_number)
						create {EVENT_LIST_WARNING_ITEM} l_item.make ({ENVIRONMENT_CATEGORIES}.compilation, l_message, l_error)
					end
				end

					-- Push to the event list service.
				if attached l_error and attached l_item then
					if
						attached function_name as l_fname and then
						attached function_mapper.feature_from_function_name (l_fname) as l_feature
					then
							-- Set an associated Eiffel feature.
						l_error.associated_feature := l_feature
					end

					event_list.service.put_event_item (c_compiler_context, l_item)
				end
			end

				-- Reset internals
			file_name := Void
			message := Void
			function_name := Void
			line_number := 0
			is_error := False
		ensure
			file_name_detached: not attached file_name
			message_detached: not attached message
			function_name_detached: not attached function_name
			line_number_reset: line_number = 0
			not_is_error: not is_error
		end

feature {NONE} -- Action handlers

	on_output_new_line (a_formatter: ES_NOTIFIER_FORMATTER; a_lines: NATURAL_32)
			-- <Precursor>
		do
			if is_reporting_c_errors then
				Precursor (a_formatter, a_lines)
			else
				position := a_formatter.string.count
			end
		end

feature {NONE} -- Factory

	new_c_compiler_error (a_message: READABLE_STRING_8; a_file_name: detachable READABLE_STRING_8; a_line: INTEGER): C_COMPILER_ERROR
			-- Creates a new C compiler error.
			--
			-- `a_message': A C compiler error message.
			-- `a_file_name': An optional file name for the message.
			-- `a_line': Line number in the external file
		require
			a_message_attached: attached a_message
			not_a_message_is_empty: not a_message.is_empty
			not_a_file_name_is_empty: attached a_file_name implies not a_file_name.is_empty
			a_line_non_negative: a_line >= 0
		do
			if attached a_file_name then
				create Result.make_with_file (a_message.as_string_8, a_file_name.as_string_8, a_line, 1)
			else
				create Result.make (a_message.as_string_8)
			end
		ensure
			result_attached: attached Result
		end

	new_c_compiler_warning (a_message: READABLE_STRING_8; a_file_name: detachable READABLE_STRING_8; a_line: INTEGER): C_COMPILER_WARNING
			-- Creates a new C compiler warning.
			--
			-- `a_message': A C compiler warning message.
			-- `a_file_name': An optional file name for the message.
		require
			a_message_attached: attached a_message
			not_a_message_is_empty: not a_message.is_empty
			not_a_file_name_is_empty: attached a_file_name implies not a_file_name.is_empty
			a_line_non_negative: a_line >= 0
		do
			if attached a_file_name then
				create Result.make_with_file (a_message.as_string_8, a_file_name.as_string_8, a_line, 1)
			else
				create Result.make (a_message.as_string_8)
			end
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Access: Regular expressions

	function_name_regexp: RX_PCRE_MATCHER
			-- Regular expression for Eiffel compiler C generated function names.
		once
			create Result.make
			Result.set_greedy (True)
			Result.compile ("F[0-9]+_[0-9]+")
		ensure
			result_attached: attached Result
			result_is_compiled: Result.is_compiled
		end

invariant
	error_list_preferences_attached: attached error_list_preferences

;note
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
