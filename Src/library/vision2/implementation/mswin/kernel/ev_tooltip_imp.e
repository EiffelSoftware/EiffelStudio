--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision Tooltip, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOLTIP_IMP

inherit
	EV_TOOLTIP_I

	WEL_TOOLTIP
		rename
			make as wel_make,
			text_color as wel_foreground_color,
			background_color as wel_background_color,
			set_text_color as wel_set_foreground_color,
			set_background_color as wel_set_background_color
		end

	WEL_TTF_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make is
			-- Create the tooltip with `par' as parent.
		do
			internal_window_make (Void, Void, default_style,
				Cw_usedefault, Cw_usedefault, Cw_usedefault,
				Cw_usedefault, id, default_pointer)
			id := 0
		end

feature -- Access

	delay: INTEGER is
			-- Delay im milliseconds the user has to hold the pointer over
			-- the widget before the tooltip pop up.
		do
			Result := initial_delay_time
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
			Result := not exists
		end

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		local
			ref: WEL_COLOR_REF
		do
			ref := wel_background_color
			create Result.make_rgb (ref.red, ref.green, ref.blue)
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget
			-- usually the text.
		local
			ref: WEL_COLOR_REF
		do
			ref := wel_foreground_color
			create Result.make_rgb (ref.red, ref.green, ref.blue)
		end

feature -- Status setting

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		local
			ref: WEL_COLOR_REF
		do
			ref ?= color.implementation
			wel_set_background_color (ref)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		local
			ref: WEL_COLOR_REF
		do
			ref ?= color.implementation
			wel_set_foreground_color (ref)
		end

feature -- Element change

	set_delay (value: INTEGER) is
			-- Make `value' the new delay.
		do
			set_initial_delay_time (value)
		end

	add_tip (wid: EV_WIDGET; txt: STRING) is
			-- Make `txt' the tip that is displayed when the
			-- user stays on `wid'.
		local
			ww: WEL_WINDOW
			info: WEL_TOOL_INFO
		do
			ww ?= wid.implementation
			check
				valid_cast: ww /= Void
			end
			create info.make
			info.set_flags (Ttf_subclass + Ttf_idishwnd)
			info.set_window (ww)
			info.set_id (ww.to_integer)
			info.set_text (txt)
			add_tool (info)
		end

end -- class EV_TOOLTIP_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.2  2000/01/27 19:30:11  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.1  1999/11/24 17:30:18  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
