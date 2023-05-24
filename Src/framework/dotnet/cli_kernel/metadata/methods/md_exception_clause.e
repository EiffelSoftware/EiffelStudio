note
	description: "Description of an exception clause"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_EXCEPTION_CLAUSE

inherit
	REFACTORING_HELPER

feature {NONE} -- Creation

	frozen make
			-- Set all fields to "undefined" state.
		do
			reset
		ensure then
			trye_offste_set: try_offset = -1
			try_length_set: try_length = -1
			handler_offset_set: handler_offset = -1
			handler_length_set: handler_length = -1
			not_is_defined: not is_defined
		end

feature -- Reset

	reset
			-- Restore default values.
		do
			try_offset := -1
			try_length := -1
			handler_offset := -1
			handler_length := -1
		ensure
			trye_offste_set: try_offset = -1
			try_length_set: try_length = -1
			handler_offset_set: handler_offset = -1
			handler_length_set: handler_length = -1
			not_is_defined: not is_defined
		end

feature -- Status report

	is_defined: BOOLEAN
			-- Is current a fully described exception clause?
		do
			Result :=
				try_offset >= 0 and then try_length >= 0 and then
				handler_offset >= 0 and then handler_length >= 0
		ensure
			valid_try_offset: Result implies try_offset >= 0
			valid_try_length: Result implies try_length >= 0
			valid_handler_offset: Result implies handler_offset >= 0
			valid_handler_length: Result implies handler_length >= 0
		end

	is_fat: BOOLEAN
			-- Has this exception clause to be stored using fat form?
		require
			is_defined: is_defined
		do
			Result :=
				try_offset > 65535 or else try_length >= 256 or else
				handler_offset > 65535 or else handler_length >= 256
		end

	flags: INTEGER_16
			-- Flags of exception clause
		deferred
		end

feature -- Access

	try_offset: INTEGER
			-- Offset in bytes of "try" block from start of associated MD_METHOD_BODY

	try_length: INTEGER
			-- Length in bytes of "try" block

	handler_offset: INTEGER
			-- Location of handler for "try" block

	handler_length: INTEGER
			-- Length of handler code in bytes

feature {NONE} -- Implementation

	class_token_or_filter_offset: INTEGER
			-- Value of `class_token' or `filter_offset' fields depending on type of exception clause
			-- (0 by default)
		do
		end

feature -- Modification

	set_try_offset (offset: like try_offset)
			-- Set `try_offset' to `offset'.
		require
			valid_offset: offset >= 0
		do
			try_offset := offset
		ensure
			try_offset_set: try_offset = offset
		end

	set_try_length (length: like try_length)
			-- Set `try_length' to `length'.
		require
			valid_length: length >= 0
		do
			try_length := length
		ensure
			try_length_set: try_length = length
		end

	set_try_end (offset: like try_offset)
			-- Set `try_length' to `offset - try_offset'.
			-- Convenience routine that can be used instead of `set_try_length'.
		require
			try_offset_set: try_offset >= 0
			valid_offset: offset >= try_offset
		do
			try_length := offset - try_offset
		ensure
			try_length_set: try_length = offset - try_offset
		end

	set_handler_offset (offset: like handler_offset)
			-- Set `handler_offset' to `offset'.
		require
			valid_offset: offset >= 0
		do
			handler_offset := offset
		ensure
			handler_offset_set: handler_offset = offset
		end

	set_handler_length (length: like handler_length)
			-- Set `handler_length' to `length'.
		require
			valid_length: length >= 0
		do
			handler_length := length
		ensure
			handler_length_set: handler_length = length
		end

	set_handler_end (offset: like handler_offset)
			-- Set `handler_length' to `offset - handler_offset'.
			-- Convenience routine that can be used instead of `set_handler_length'.
		require
			handler_offset_set: handler_offset >= 0
			valid_offset: offset >= handler_offset
		do
			handler_length := offset - handler_offset
		ensure
			handler_length_set: handler_length = offset - handler_offset
		end

feature -- Measurement

	count (is_fat_form: BOOLEAN): INTEGER
			-- Number of bytes when stored in PE file in fat form or small form depending on `is_fat_form'
		require
			is_defined: is_defined
			is_fat_form_enforced: is_fat implies is_fat_form
		do
			if is_fat_form then
				Result := 24
			else
				Result := 12
			end
		ensure
			definition: is_fat_form and then Result = 24 or else not is_fat_form and then Result = 12
		end

feature -- Saving

	write_to_stream (is_fat_form: BOOLEAN; m: MANAGED_POINTER; pos: INTEGER)
			-- Write to stream `m' at position `pos' using fat form or small form depending on `is_fat_form'.
		require
			is_defined: is_defined
			is_fat_form_enforced: is_fat implies is_fat_form
			m_not_void: m /= Void
			positive_pos: pos > 0
			valid_pos: pos + count (is_fat_form) <= m.count
		do
			fixme ("To be on the safe side (e.g., to avoid sign extension in fat form), `flags' should be declared as NATURAL_16.")
			if is_fat_form then
				m.put_integer_32_le (flags, pos)
				m.put_integer_32_le (try_offset, pos + 4)
				m.put_integer_32_le (try_length, pos + 8)
				m.put_integer_32_le (handler_offset, pos + 12)
				m.put_integer_32_le (handler_length, pos + 16)
				m.put_integer_32_le (class_token_or_filter_offset, pos + 20)
			else
				m.put_integer_16_le (flags, pos)
				m.put_integer_16_le (try_offset.to_integer_16, pos + 2)
				m.put_integer_8_le (try_length.to_integer_8, pos + 4)
				m.put_integer_16_le (handler_offset.to_integer_16, pos + 5)
				m.put_integer_8_le (handler_length.to_integer_8, pos + 7)
				m.put_integer_32_le (class_token_or_filter_offset, pos + 8)
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
