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
		end

create
	make

feature {NONE} -- Initialization

	make (a_string: STRING) is
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

	string: STRING
			-- String to set in the rich edit control

	read_buffer (length: INTEGER) is
			-- Set to buffer a substring of `string'.
		do
			if last_position > string.count then
				create buffer.make_empty (0)
			else
				create buffer.make (string.substring (last_position,
					(last_position + length - 1).min (string.count)))
				last_position := last_position + length
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

