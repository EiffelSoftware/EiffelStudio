indexing
	description:
		" A silly container that doesn't do anything. Used%
		% to store a spin_button. Do not flash."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_SILLY_CONTAINER_IMP

inherit
	WEL_CONTROL_WINDOW
		redefine
			default_style,
			on_wm_erase_background,
			on_wm_vscroll
		end

	WEL_SB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- We redefine the default style.
		do
			Result := Ws_child + Ws_visible
		end

	on_wm_erase_background (wparam: INTEGER) is
			-- Wm_erasebkgnd message.
			-- Ne need to erase the background because this
			-- containers has always the same size than the
			-- tool-bar.
		do
			disable_default_processing
		end

	on_wm_vscroll (wparam, lparam: INTEGER) is
			-- Wm_vscroll message.
			-- Here, we know it's a spin button.
		local
			gauge: EV_GAUGE_IMP
			up_down: WEL_UP_DOWN_CONTROL
			p: POINTER
		do
			-- To avoid the commands to be call two times, we check that
			-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= Sb_endscroll then
				p := cwin_get_wm_vscroll_hwnd (wparam, lparam)
				if p /= default_pointer then
					-- The message comes from a spin button
					up_down ?= windows.item (p)
					gauge ?= up_down.buddy_window
					if gauge /= Void then
						check
							gauge_exists: gauge.exists
						end
						gauge.execute_command (gauge.Cmd_gauge, Void)
					end
				end
			end
		end

end -- class EV_INTERNAL_SILLY_CONTAINER_IMP

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
