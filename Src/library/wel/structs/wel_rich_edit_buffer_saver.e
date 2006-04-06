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
		export
			{ANY} set_is_unicode_data
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create `text'.
		do
			Precursor {WEL_RICH_EDIT_STREAM_OUT}
			create text.make (0)
		end

feature -- Access

	text: STRING_32
			-- Contents of the rich edit control

feature {NONE} -- Implementation

	write_buffer is
			-- Append `a_buffer' in `text'.
		local
			l_uni_str: WEL_STRING
			l_c_str: C_STRING
			l_text: STRING_32
		do
			if is_unicode_data then
				create l_uni_str.share_from_pointer_and_count (buffer.item, buffer.count)
				l_text := l_uni_str.substring (1, l_uni_str.count)
			else
				create l_c_str.share_from_pointer_and_count (buffer.item, buffer.count)
				l_text := l_c_str.substring (1, l_c_str.count)
			end
			text.append (l_text)
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

