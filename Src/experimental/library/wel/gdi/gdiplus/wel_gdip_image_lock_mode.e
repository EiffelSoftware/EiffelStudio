note
	description: "Enumeration of image lock mode."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_IMAGE_LOCK_MODE

feature -- Enumeration

	Read_only: NATURAL_32 = 1
			-- Read only

	Write_only: NATURAL_32 = 2
			-- Write only

	Read_write: NATURAL_32 = 3
			-- Read write

	User_input_buffer: NATURAL_32 = 4
			-- User input buffer

feature -- Query

	is_valid (a_mode: NATURAL_32): BOOLEAN
			-- If `a_mode' valid?
		do
			Result := a_mode = Read_only
				or a_mode = Write_only
				or a_mode = Read_write
				or a_mode = User_input_buffer
		end

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
