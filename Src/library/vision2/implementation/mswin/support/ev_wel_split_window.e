indexing
	description: "EiffelVision wel split window. Mswindows implementation.%
			% This class is used by EV_SPLIT_IMP."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_WEL_SPLIT_WINDOW
	
inherit

	WEL_CONTROL_WINDOW
		rename
			make as old_make
		redefine
			on_paint
		end

	WEL_PS_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_ROP2_CONSTANTS
		export
			{NONE} all
		end

	WEL_HT_CONSTANTS
		export
			{NONE} all
		end

	WEL_HS_CONSTANTS
		export
			{NONE} all
		end

feature -- Initialization

	make (par: WEL_COMPOSITE_WINDOW; imp: EV_SPLIT_IMP) is
			-- Create the control window.
		do
			make_with_coordinates (par, "", 0, 0, 0, 0)
			split_imp ?= imp
			!! dc.make (Current)
			level := 50
		ensure
			split_imp_not_void: split_imp /= Void
			dc_not_void: dc /= Void
		end

feature {NONE} -- Access

	split_imp: EV_SPLIT_IMP
			-- The parent container, an EV_SPLIT_IMP
	
	dc: WEL_CLIENT_DC
			-- Client dc linked to the split window

	cursor: WEL_CURSOR
			-- Current cursor

	is_splitting: BOOLEAN
			-- Is the user currently moving the split ?

	splitter_rect: WEL_RECT is
			-- The rect filled by the splitter
		deferred
		end

feature {EV_SPLIT_IMP} -- Access

	level: INTEGER
			-- width or height depending of the kind of split window
			-- of the splitter

	size: INTEGER is
			-- width or height depending of the kind of split window
			-- of the splitter
		once
			Result := 6
		end

feature -- Event handling

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_paint message.
		do
			draw_split
		end

	on_split (value: INTEGER): BOOLEAN is
			-- Is a point with `value' as the coordinate on the split?
		do
			Result := (value >= level)
					and then (value < level + size)
		end

feature -- Basic routines

	draw_split is
			-- draw a vertical split at 'level'.
		deferred
		end

	invert_split is
			-- Invert the vertical split. Used when the user move the split
		do
			dc.get
			dc.invert_rect (splitter_rect)	
			dc.release
		end

feature {NONE} -- Implementation

	window_frame_pen: WEL_PEN is
			-- Pen with the window frame color
		local
			color: WEL_COLOR_REF
		do
			!! color.make_system (Color_windowframe)
			!! Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
		end

	face_pen: WEL_PEN is
			-- Pen with the face color
		local
			color: WEL_COLOR_REF
		do
			!! color.make_system (Color_btnface)
			!! Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end
	
	shadow_pen: WEL_PEN is
			-- Pen with the shadow color
		local
			color: WEL_COLOR_REF
		do
			!! color.make_system (Color_btnshadow)
			!! Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	highlight_pen: WEL_PEN is
			-- Pen with the highlight color
		local
			color: WEL_COLOR_REF
		do
			!! color.make_system (Color_btnhighlight)
			!! Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

Invariant
	positif_level: level >= 0

end -- class EV_WEL_SPLIT_WINDOW

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
