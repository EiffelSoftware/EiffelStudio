indexing
	description: "Eiffel Vision check button. Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		redefine
			interface
		end
		
	EV_TOGGLE_BUTTON_IMP
		undefine
			default_alignment
		redefine
			enable_select,
			disable_select,
			default_style,
			interface,
			make,
			internal_default_height,
			set_default_minimum_size
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the check button with no label.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
			extra_width := 20
			text_alignment := default_alignment
		end

feature -- Status setting

	set_default_minimum_size is
			-- Reset `Current' to its default minimum size.
		do
				-- This extra width only needs to be added if
				-- we are using a large font, hence we do nothing
				-- with the system font.
			if not has_system_font and not text.is_empty then
				extra_width := 20 + wel_font.height // 2
			end
			Precursor {EV_TOGGLE_BUTTON_IMP}
		end

	enable_select is
			-- Make `is_selected' True.
		do
			cwin_send_message (wel_item, bm_setcheck, 1, 0)
			Precursor {EV_TOGGLE_BUTTON_IMP}
		end

	disable_select is
			-- Make `is_selected' False.
		do
			cwin_send_message (wel_item, bm_setcheck, 0, 0)
			Precursor {EV_TOGGLE_BUTTON_IMP}
		end

feature {NONE} -- Implementation

	internal_default_height: INTEGER is
			-- The default minimum height of `Current' with no text.
			-- This is used in set_default_size.
		do
				--|FIXME As soon as we find a nice way to
				--| know how large the check part of `Current'
				--| will be drawn by Windows, we can query this directly.
			Result := 13
		end

	default_style: INTEGER is
			-- Not visible or child at creation
		do
			Result := Ws_child + Ws_visible + Ws_group
					+ Ws_tabstop + Bs_autocheckbox + Ws_clipchildren + Ws_clipsiblings
		end

	interface: EV_CHECK_BUTTON

end -- class EV_CHECK_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

