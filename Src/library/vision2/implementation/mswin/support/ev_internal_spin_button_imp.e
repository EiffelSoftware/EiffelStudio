indexing
	description:
		"A spercific WEL_UP_DOWN_CONTROL for EiffelVision."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_SPIN_BUTTON_IMP

inherit
	WEL_UP_DOWN_CONTROL
		redefine
			buddy_window,
			on_delta_pos,
			default_style
		end

create
	make

feature -- Access

	buddy_window: EV_SPIN_BUTTON_IMP is
			-- Current buddy window
		do
			Result ?= {WEL_UP_DOWN_CONTROL} Precursor
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		do
			Result := Ws_visible + Ws_child + Ws_group
				+ Ws_tabstop + Uds_setbuddyint 
				+ Uds_alignright + Uds_arrowkeys
		end

	on_delta_pos (info: WEL_NM_UP_DOWN_CONTROL) is
			-- The position of the control is about to change.
		do
			buddy_window.set_text (info.position.out)
		end

end -- class EV_INTERNAL_SPIN_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
