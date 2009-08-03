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

feature {NONE} -- Access: Help

	c_compiler_context: UUID
			-- Event list service context id
		once
			create Result.make_from_string ("E1FFE1CC-D45B-4A56-87C5-B64535BAFE1B")
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
		local
			l_error: C_COMPILER_ERROR
			l_item: EVENT_LIST_ERROR_ITEM_I
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
					l_error := new_c_compiler_warning (l_message, l_file_name, line_number)
					create {EVENT_LIST_WARNING_ITEM} l_item.make ({ENVIRONMENT_CATEGORIES}.compilation, l_message, l_error)
				end

					-- Push to the event list service.
				if
					attached function_name as l_fname and then
					attached function_mapper.feature_from_function_name (l_fname) as l_feature
				then
						-- Set an associated Eiffel feature.
					l_error.associated_feature := l_feature
				end

				event_list.service.put_event_item (c_compiler_context, l_item)
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

invariant
	notifier_formatter_attached: attached notifier_formatter

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
