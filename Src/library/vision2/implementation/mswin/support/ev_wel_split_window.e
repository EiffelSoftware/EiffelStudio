indexing
	description: "EiffelVision wel split window. Mswindows implementation.%
			% This class is used by EV_SPLIT_AREA_IMP."
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

	WEL_DIB_COLORS_CONSTANTS
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

	make (par: WEL_COMPOSITE_WINDOW; imp: EV_SPLIT_AREA_IMP) is
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

	split_imp: EV_SPLIT_AREA_IMP
			-- The parent container, an EV_SPLIT_AREA_IMP
	
	dc: WEL_CLIENT_DC
			-- Client dc linked to the split window

	cursor: WEL_CURSOR
			-- Current cursor

	is_splitting: BOOLEAN
			-- Is the user currently moving the split ?

feature {EV_SPLIT_AREA_IMP} -- Access

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
			-- Invert the vertical split from `first' position to `last' position
			-- Used when the user move the split
		deferred
		end

feature {NONE} -- Implementation

	splitter_brush: WEL_BRUSH is
			-- Create the brush used to draw the invert splitter.
			-- For this, it creates a bitmap :	black / white
			--                                  white / black
			-- In the following code, `hexa_number' and `string_bitmap'
			-- are hexadecimal representations of the bitmap. 
			-- Here follows the representation of the picture:
 			-- binary: 0 / 1     hexa : 40 / 00     decimal : 128 / 0
			--         1 / 0            80 / 00                64 / 0
		local
			bitmap: WEL_BITMAP
			log: WEL_LOG_BITMAP
			string_bitmap: STRING
			hexa_number: INTEGER
			c: ANY
		once
			string_bitmap := ""
				-- First line of the bitmap
			hexa_number := 128
			string_bitmap.append_character (hexa_number.ascii_char)
			hexa_number := 0
			string_bitmap.append_character (hexa_number.ascii_char)
				-- Second line of the bitmap
			hexa_number := 64
			string_bitmap.append_character (hexa_number.ascii_char)
			hexa_number := 0
			string_bitmap.append_character (hexa_number.ascii_char)
			c := string_bitmap.to_c
				-- Then, we create the brush
			!! log.make (2, 2, 2, 1, 1, $c)
			!! bitmap.make_indirect (log)
			!! Result.make_by_pattern (bitmap)
		end

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
