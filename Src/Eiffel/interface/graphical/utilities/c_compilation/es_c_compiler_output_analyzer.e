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
	ES_RECYCLABLE

--	COMPILER_EXPORTER
--		export
--			{NONE} all
--		end

feature {NONE} -- Initialization

	make (a_formatter: like notifier_formatter)
			-- Initializes the C output analyzer.
			--
			-- `a_formatter': A notifier formatter to extract the C compilation output from.
		require
			a_formatter_attached: attached a_formatter
		do
			notifier_formatter := a_formatter
			register_action (a_formatter.text_changed_actions, agent on_output_text_changes)
			register_action (a_formatter.new_line_actions, agent on_output_new_line)
		ensure
			notifier_formatter_set: notifier_formatter = a_formatter
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
		end

feature {NONE} -- Access

	notifier_formatter: ES_NOTIFIER_FORMATTER
			-- Notifier formatter, which the output string can be extracted from.

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

feature {NONE} -- Basic operations

	process_last_error
			-- Process the last error information.
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

	c_compiler_context: UUID
			-- Event list service context id
		once
			create Result.make_from_string ("E1FFE1CC-D45B-4A56-87C5-B64535BAFE1B")
		end

feature {NONE} -- Measurement

	last_position: INTEGER
			-- Last position in the text

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

	process_line (a_line: READABLE_STRING_8)
			-- Processes a line.
			--
			-- `a_line': A line to process/parse.
		require
			is_interface_usable: is_interface_usable
			a_line_attached: attached a_line
			not_a_line_is_empty: not a_line.is_empty
		deferred
		end
--		local
--			l_error: C_COMPILER_ERROR
--			l_file_name: STRING
--			l_position: STRING
--			l_message_type: STRING
--			l_message: STRING
--			l_line: INTEGER
--			i, j, k: INTEGER
--		do
--				-- Parse GCC.
--			i := a_line.index_of (':', 1)
--			if i > 1 then
--					-- File name
--				l_file_name := a_line.substring (1, i - 1)
--				l_file_name.right_adjust
--				l_file_name.left_adjust
--				if l_file_name /~ file_name then
--					process_last_error
--					file_name := l_file_name
--				end
--				j := i + 1

--				i := a_line.index_of (':', j)
--				if i > j then
--						-- Line number/warning
--					l_position := a_line.substring (j, i - 1)
--					l_position.right_adjust
--					l_position.left_adjust
--					if l_position.is_integer_32 then
--						l_line := l_position.to_integer_32
--						if l_line /= line_number then
--							if line_number > 0 then
--								process_last_error
--							end

--							file_name := l_file_name
--							line_number := l_line
--						end

--						j := i + 1
--						i := a_line.index_of (':', j)
--						if i > j then
--								-- Message type
--							l_message_type := a_line.substring (j, i - 1)
--							l_message_type.right_adjust
--							l_message_type.left_adjust

--							if l_message_type.as_lower.substring_index ("error", 1) > 0 then
--								is_error := True
--							end
--						end
--					else
--						line_number := 0

--							-- Not a line number.
--						k := l_position.substring_index ("inline_F", 1)
--						if k > 1 then
--								-- Indicates the last function
--							l_position := l_position.substring (k, l_position.count - 1)
--							function_name := l_position
--							from k := 9 until k > l_position.count loop
--								if not (l_position[k].is_digit or l_position[k] = '_') then
--									l_position.keep_head (k - 1)
--								end
--								k := k + 1
--							end
--						else
--							l_message_type := l_position
--						end

--						l_line := 0
--					end

--					if attached l_message_type and not l_message_type.is_empty then
--							-- Message
--						j := i + 1
--						l_message := a_line.substring (j , a_line.count)
--						l_message.right_adjust
--						l_message.left_adjust

--						if not l_message.is_empty then
--							if not attached message then
--								create message.make (100)
--							else
--								message.append_character (' ')
--							end
--							message.append (l_message)
--							message := message
--						end
--					end
--				else
--					process_last_error
--				end
--			else
--				process_last_error
--			end
--		end

feature {NONE} -- Action handlers

	on_output_text_changes
			-- Called when the output changes.
		require
			is_interface_usable: is_interface_usable
		do

		end

	on_output_new_line
			-- Called when a new line was added to the output string.
		require
			is_interface_usable: is_interface_usable
		local
			l_next_position: INTEGER
			l_position: INTEGER
			l_string: STRING
			l_line: STRING
		do
			l_string := notifier_formatter.string
			l_position := last_position + 1
			l_next_position := l_string.count
			if l_next_position - 1 > l_position then
				l_line := l_string.substring (l_position, l_next_position)
				if not l_line.is_empty then
					process_line (l_line)
				end
			else
					-- Content was reset.
			end
			last_position := l_next_position
		ensure
			last_position_set: last_position = notifier_formatter.string.count
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
