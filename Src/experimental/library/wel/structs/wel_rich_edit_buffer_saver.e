note
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
			make,
			release_stream
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create `text'.
		do
			create data.make (0)
			Precursor {WEL_RICH_EDIT_STREAM_OUT}
		end

feature -- Access

	text: STRING_32
			-- Contents of the rich edit control
		local
			l_uni_str: WEL_STRING
			l_c_str: C_STRING
		do
			if is_unicode_data then
				create l_uni_str.share_from_pointer_and_count (data.item, data.count)
				Result := l_uni_str.substring (1, l_uni_str.count)
			else
				create l_c_str.make_shared_from_pointer_and_count (data.item, data.count)
				Result := l_c_str.substring (1, l_c_str.count)
			end
		end

feature -- Basic operations

	release_stream
			-- <Precursor>
		do
			Precursor
			data.resize (0)
		end

feature {NONE} -- Implementation

	write_buffer
			-- Append `a_buffer' in `text'.
		do
			if attached buffer as l_buffer then
				data.append (l_buffer)
			end
		end

	data: MANAGED_POINTER
			-- Buffer where text will be stored.

invariant

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
