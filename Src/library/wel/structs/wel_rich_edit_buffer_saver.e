indexing
	description: "[
		This class allows to get the contents of a rich edit
		control. Used internally by WEL.
		
		Note: Do not use more than one instance of this class at the same
			time. Nested streams are not supported.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT_BUFFER_SAVER

inherit
	WEL_RICH_EDIT_STREAM_OUT
		rename
			make as rich_edit_stream_out_make
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create `text'.
		do
			rich_edit_stream_out_make
			create text.make (0)
		end

feature -- Access

	text: STRING
			-- Contents of the rich edit control

feature {NONE} -- Implementation

	write_buffer (buffer: STRING) is
			-- Append `buffer' in `text'.
		do
			text.append (buffer)
		ensure then
			valid_count: text.count = old text.count + buffer.count
		end

invariant
	text_not_void: text /= Void

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




end -- class WEL_RICH_EDIT_BUFFER_SAVER

