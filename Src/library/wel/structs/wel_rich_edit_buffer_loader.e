note
	description: "[
		This class allows to set a buffer into a rich edit
		control. Used internally by WEL.
		
		Note: Do not use more than one instance of this class at the same
			time. Nested streams are not supported.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT_BUFFER_LOADER

inherit
	WEL_RICH_EDIT_STREAM_IN
		rename
			make as rich_edit_stream_in_make
		export
			{ANY} set_is_unicode_data
		end

create
	make

feature {NONE} -- Initialization

	make (a_string: STRING_GENERAL)
			-- Set `a_string' to the rich edit control.
		require
			a_string_not_void: a_string /= Void
		do
			rich_edit_stream_in_make
			string := a_string
			last_position := 1
		ensure
			string_set: string = a_string
		end

feature {NONE} -- Implementation

	last_position: INTEGER
			-- Last position of `string'

	string: STRING_GENERAL
			-- String to set in the rich edit control

	read_buffer
			-- Set to buffer a substring of `string'.
		local
			l_uni_str: WEL_STRING
			l_c_str: C_STRING
			l_upper: INTEGER
			l_buffer: like buffer
		do
			l_buffer := buffer
				-- Per precondition
			check l_buffer_attached: l_buffer /= Void end
			if last_position > string.count then
				l_buffer.set_from_pointer (l_buffer.item, 0)
			else
					-- Because `shared_from_pointer_and_count' assumes an additional character
					-- for the nyll character, and that the call to `set_substring' always adds
					-- a null character at the end of the string, it caused a memory corruption.
					-- Removing one character from the given `l_buffer' seems to do the trick
					-- until both `shared_from_pointer_and_count' and `set_substring' don't assume
					-- anything about a null-terminated string.
				if is_unicode_data then
					create l_uni_str.share_from_pointer_and_count (l_buffer.item, l_buffer.count - {WEL_STRING}.character_size)
					l_upper := (last_position + l_uni_str.count - 1).min (string.count)
					l_uni_str.set_substring (string, last_position, l_upper)
					l_buffer.set_from_pointer (l_buffer.item, (l_upper - last_position + 1) * l_uni_str.character_size)
					last_position := last_position + l_uni_str.count
				else
					create l_c_str.make_shared_from_pointer_and_count (l_buffer.item, l_buffer.count - {C_STRING}.character_size)
					l_upper := (last_position + l_c_str.count - 1).min (string.count)
					l_c_str.set_substring (string, last_position, l_upper)
					l_buffer.set_from_pointer (l_buffer.item, (l_upper - last_position + 1) * l_c_str.character_size)
					last_position := last_position + l_c_str.count
				end
			end
		end

invariant
	string_not_void: string /= Void
	positive_last_position: last_position > 0

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
