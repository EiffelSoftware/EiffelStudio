indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DROP_DOWN_LIST_COMBO_BOX_EX

inherit
	WEL_COMBO_BOX_EX
		redefine
			text_length,
			text
		end

create
	make

feature -- Status report

	text_length: INTEGER is
			-- Text length
		do
			Result := selected_string.count
		end

	text: STRING_32 is
			-- Window text
		do
			Result := selected_string
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_border
				+ Cbs_dropdownlist + Cbs_autohscroll
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




end -- class WEL_DROP_DOWN_LIST_COMBO_BOX_EX

