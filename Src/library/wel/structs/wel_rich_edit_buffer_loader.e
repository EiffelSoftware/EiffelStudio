indexing
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

	make (a_string: STRING_GENERAL) is
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

	read_buffer is
			-- Set to buffer a substring of `string'.
		local
			l_uni_str: WEL_STRING
			l_c_str: C_STRING
			l_upper: INTEGER
		do
			if last_position > string.count then
				buffer.set_from_pointer (buffer.item, 0)
			else
				if is_unicode_data then
					create l_uni_str.share_from_pointer_and_count (buffer.item, buffer.count)
					l_upper := (last_position + l_uni_str.count - 1).min (string.count)
					l_uni_str.set_substring (string, last_position, l_upper)
					buffer.set_from_pointer (buffer.item, (l_upper - last_position + 1) * l_uni_str.character_size)
					last_position := last_position + l_uni_str.count
				else
					create l_c_str.share_from_pointer_and_count (buffer.item, buffer.count)
					l_upper := (last_position + l_c_str.count - 1).min (string.count)
					l_c_str.set_substring (string, last_position, l_upper)
					buffer.set_from_pointer (buffer.item, (l_upper - last_position + 1) * l_c_str.character_size)
					last_position := last_position + l_c_str.count
				end
			end
		end

invariant
	string_not_void: string /= Void
	positive_last_position: last_position > 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_RICH_EDIT_BUFFER_LOADER

