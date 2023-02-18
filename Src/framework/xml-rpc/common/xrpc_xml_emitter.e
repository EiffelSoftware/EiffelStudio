note
	description: "[
		Emits an XML-RPC XML from the core set of XML-RPC data types and values.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_XML_EMITTER

inherit
	XRPC_VISITOR
		redefine
			process_array,
			process_boolean,
			process_double,
			process_integer,
			process_member,
			process_string,
			process_struct
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes the emitter
		do
			is_pretty_printed := True
			reset
		end

feature -- Access

	xml: STRING
			-- XML string generated from processing Current

feature {NONE} -- Access

	indents: NATURAL
			-- Current indentations
		require
			not_buffer_stack_is_empty: not buffer_stack.is_empty
		local
			l_state: TUPLE [buffer: STRING; indents: NATURAL]
		do
			l_state := buffer_stack.item
			check l_state_attached: attached l_state end
			Result := l_state.indents
		end

	buffer: STRING
			-- Active buffer
		require
			not_buffer_stack_is_empty: not buffer_stack.is_empty
		local
			l_state: TUPLE [buffer: STRING; indents: NATURAL]
		do
			l_state := buffer_stack.item
			check l_state_attached: attached l_state end
			Result := l_state.buffer
		end

	buffer_stack: ARRAYED_STACK [TUPLE [buffer: STRING; indents: NATURAL]]
			-- Stack of buffers.

feature {NONE} -- Element change

	indent
			-- Increases the indentation level.
		require
			not_buffer_stack_is_empty: not buffer_stack.is_empty
		local
			l_state: TUPLE [buffer: STRING; indents: NATURAL]
		do
			l_state := buffer_stack.item
			check l_state_attached: attached l_state end
			l_state.indents := l_state.indents + 1
		ensure
			indents_increased: indents = old indents + 1
		end

	outdent
			-- Decreases the indentation level.
		require
			not_buffer_stack_is_empty: not buffer_stack.is_empty
			indents_positive: indents > 0
		local
			l_state: TUPLE [buffer: STRING; indents: NATURAL]
		do
			l_state := buffer_stack.item
			check l_state_attached: attached l_state end
			l_state.indents := l_state.indents - 1
		ensure
			indents_increased: indents = old indents - 1
		end

	replace_buffer (a_buffer: STRING)
			-- Replaces the current buffer with a new buffer.
			-- Note: Calls should pair with `restore_buffer'.
			--
			-- `a_buffer': The new buffer.
		do
			buffer_stack.put ([a_buffer, {NATURAL}0])
		ensure
			buffer_set: buffer = a_buffer
		end

	restore_buffer
			-- Resotres the current buffer with a previous buffer.
			-- Note: Calls should pair with `replace_buffer'.
		require
			buffer_stack_count_big_enough: buffer_stack.count >= 2
		do
			buffer_stack.remove
		ensure
			not_buffer_stack_is_empty: not buffer_stack.is_empty
			buffer_set: buffer /= old buffer
		end

feature -- Status report

	is_pretty_printed: BOOLEAN assign set_is_pretty_printed
			-- Indicates if the output should be formatted

feature -- Status setting

	set_is_pretty_printed (a_pretty: BOOLEAN)
			-- Sets if output XML should be formatted.
		do
			is_pretty_printed := a_pretty
		ensure
			is_pretty_printed_set: is_pretty_printed = a_pretty
		end

feature {NONE} -- Basic operations: Formatting

	append_indents (a_buffer: STRING)
			-- Appends the current indentations to a buffer.
			--
			-- `a_buffer': Buffer to append any indentations to.
		require
			a_buffer_attached: attached a_buffer
		local
			l_indents: like indents
		do
			if is_pretty_printed then
				l_indents := indents
				if l_indents > 0 then
					if a_buffer.is_empty or else a_buffer[a_buffer.count] = '%N' then
						a_buffer.append (create {STRING}.make_filled (' ', (2 * l_indents).as_integer_32))
					end
				end
			end
		end

	append_opening_tag (a_name: READABLE_STRING_8; a_buffer: STRING; a_new_line: BOOLEAN)
			-- Appends an open tag to a buffer.
			--
			-- `a_name': The name of the tag.
			-- `a_buffer': A buffer to append the opening tag contents to.
			-- `a_new_line': True to place the opening tag on a new line; False otherwise.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			a_buffer_attached: attached a_buffer
		do
			append_indents (a_buffer)
			a_buffer.append_character ('<')
			a_buffer.append (a_name)
			a_buffer.append_character ('>')
			if
				a_new_line and then
				is_pretty_printed --and then
				--(a_buffer.is_empty or else a_buffer[a_buffer.count] /= '%N')
			then
				a_buffer.append_character ('%N')
			end
			indent
		end

	append_closing_tag (a_name: READABLE_STRING_8; a_buffer: STRING; a_new_line: BOOLEAN)
			-- Appends an closing tag to a buffer.
			--
			-- `a_name': The name of the tag.
			-- `a_buffer': A buffer to append the closing tag contents to.
			-- `a_new_line': True to place the closing tag on a new line; False otherwise.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			a_buffer_attached: attached a_buffer
		do
			outdent
			append_indents (a_buffer)
			a_buffer.append_character ('<')
			a_buffer.append_character ('/')
			a_buffer.append (a_name)
			a_buffer.append_character ('>')
			if
				a_new_line and then
				is_pretty_printed
			then
				a_buffer.append_character ('%N')
			end
		end

	append_value (a_value_name: READABLE_STRING_8; a_value: READABLE_STRING_32; a_buffer: STRING)
			-- Appends a value declaration to the buffer.
			--
			-- `a_value_name': The name of the value type.
			-- `a_value': Actual value.
			-- `a_buffer': A buffer to append the value contents to.
		require
			a_value_name_attached: attached a_value_name
			not_a_value_name_is_empty: not a_value_name.is_empty
			a_value_attached: attached a_value
			a_buffer_attached: attached a_buffer
		local
			l_value: STRING_32
			l_trail_new_line: BOOLEAN
		do
			append_opening_tag ({XRPC_CONSTANTS}.value_name, a_buffer, True)
			append_opening_tag (a_value_name, a_buffer, False)

			if not a_value.is_empty then
				if
					is_pretty_printed and then
					indents > 0 and then
					a_value.occurrences ('%N') > 0
				then
						-- Indent the value, if necessary.
					create l_value.make (a_value.count + 1)
					l_value.append_character ('%N')
					l_value.append (a_value)
					if l_value[l_value.count] = '%N' then
						l_trail_new_line := True
						l_value.prune_all_trailing ('%N')
					end
					l_value.replace_substring_all ("%N", "%N" + create {STRING}.make_filled (' ', (indents * 2).as_integer_32))
					a_buffer.append ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_value))
					if l_trail_new_line then
						a_buffer.append_character ('%N')
					end
				else
					a_buffer.append ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_value))
				end
			end

			append_closing_tag (a_value_name, a_buffer, True)
			append_closing_tag ({XRPC_CONSTANTS}.value_name, a_buffer, True)
		ensure then
			indents_unchanged: indents = old indents
		end

feature -- Basic operations

	reset
			-- Resets any cached data.
		do
			create xml.make_from_string (xml_header)
			create buffer_stack.make (1)
			buffer_stack.put ([xml, {NATURAL}0])
		ensure
			xml_reset: xml ~ xml_header
		end

feature -- Processing operations

	process_array (a_array: XRPC_ARRAY)
			-- <Precursor>
		local
			l_buffer: STRING
			l_replaced: BOOLEAN
		do
				-- Replace the buffer to get the array content.
			create l_buffer.make (100)
			replace_buffer (l_buffer)
			l_replaced := True

			Precursor (a_array)

				-- Restore buffer and emit the contents as the array value.
			l_replaced := False
			restore_buffer

			append_value ({XRPC_CONSTANTS}.array_name, l_buffer, buffer)
		ensure then
			indents_unchanged: indents = old indents
		rescue
			if l_replaced then
				l_replaced := False
				restore_buffer
			end
		end

	process_boolean (a_boolean: XRPC_BOOLEAN)
			-- <Precursor>
		local
			l_value: STRING
		do
			if a_boolean.value then
				l_value := {XRPC_CONSTANTS}.boolean_true_value
			else
				l_value := {XRPC_CONSTANTS}.boolean_false_value
			end
			append_value ({XRPC_CONSTANTS}.boolean_name, l_value, buffer)
		ensure then
			indents_unchanged: indents = old indents
		end

	process_double (a_double: XRPC_DOUBLE)
			-- <Precursor>
		do
			append_value ({XRPC_CONSTANTS}.double_name, a_double.value.out, buffer)
		ensure then
			indents_unchanged: indents = old indents
		end

	process_integer (a_integer: XRPC_INTEGER)
			-- <Precursor>
		do
			append_value ({XRPC_CONSTANTS}.int_name, a_integer.value.out, buffer)
		ensure then
			indents_unchanged: indents = old indents
		end

	process_member (a_member: XRPC_MEMBER)
			-- <Precursor>
		local
			l_buffer: STRING
		do
			l_buffer := buffer
			append_opening_tag ({XRPC_CONSTANTS}.member_name, l_buffer, True)
				-- Name
			append_value ({XRPC_CONSTANTS}.string_name, a_member.name, l_buffer)
				-- Value
			a_member.value.visit (Current)
			append_closing_tag ({XRPC_CONSTANTS}.member_name, l_buffer, True)
		ensure then
			indents_unchanged: indents = old indents
		end

	process_string (a_string: XRPC_STRING)
			-- <Precursor>
		do
			append_value ({XRPC_CONSTANTS}.string_name, a_string.value, buffer)
		ensure then
			indents_unchanged: indents = old indents
		end

	process_struct (a_struct: XRPC_STRUCT)
			-- <Precursor>
		local
			l_buffer: STRING
			l_replaced: BOOLEAN
		do
				-- Replace the buffer to get the array content.
			create l_buffer.make (50)
			replace_buffer (l_buffer)
			l_replaced := True

			Precursor (a_struct)

				-- Restore buffer and emit the contents as the array value.
			l_replaced := False
			restore_buffer

			append_value ({XRPC_CONSTANTS}.struct_name, l_buffer, buffer)
		ensure then
			indents_unchanged: indents = old indents
		rescue
			if l_replaced then
				l_replaced := False
				restore_buffer
			end
		end

feature {NONE} -- Constants

	xml_header: STRING = "<?xml version=%"1.0%"?>"

invariant
	xml_attached: attached xml

;note
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
