indexing
	description: "Information about message Wm_char, Wm_syschar, %
		%Wm_keydown, Wm_keyup, Wm_syskeydown, Wm_syskeyup. These %
		%messages are sent when a key is pressed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_KEY_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

create
	make

feature -- Access

	code: INTEGER is
			-- Character code of the key
			-- See class WEL_VK_CONSTANTS for different values.
		do
			Result := w_param.to_integer_32
		end

	data: INTEGER is
			-- Key data
		do
			Result := l_param.to_integer_32
		end

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




end -- class WEL_KEY_MESSAGE

