indexing
	description: "EiffelVision split area. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_SPLIT_AREA_IMP
	
inherit
	EV_SPLIT_AREA_I

	EV_CONTAINER_IMP
		undefine
			on_left_button_down,
			on_left_button_up,
			on_mouse_move
		redefine
			set_insensitive,
			remove_child
		end

	EV_SYSTEM_PEN_IMP

	EV_WEL_CONTROL_CONTAINER_IMP
		redefine
			make,
			on_paint,
			on_wm_erase_background,
			default_style,
			top_level_window_imp
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

	WEL_RGN_CONSTANTS
		export
			{NONE} all
		end

feature -- Initialize

	make is
			-- Create the control window.
		do
			{EV_WEL_CONTROL_CONTAINER_IMP} Precursor
			!! dc.make (Current)
			set_text ("Split Area")
			set_first_area_shrinkable (True)
			set_second_area_shrinkable (True)
		end

feature -- Access

	child1: EV_WIDGET_IMP
				-- The first child of the split area

	child2: EV_WIDGET_IMP
				-- The second child of the split area

	is_first_area_shrinkable: BOOLEAN
			-- Is the first child allowed to be smaller than its minimum size.

	is_second_area_shrinkable: BOOLEAN
			-- Is the second child allowed to be smaller than its minimum size.

	position: INTEGER
			-- Actual position of the splitter

	dc: WEL_CLIENT_DC
			-- Client dc linked to the split window

	internal_cursor: WEL_CURSOR
			-- Current cursor

	is_splitting: BOOLEAN
			-- Is the user currently moving the split ?

	top_level_window_imp: EV_UNTITLED_WINDOW_IMP
			-- Top level window that contains the current widget.

	minimum_position: INTEGER is
			-- Minimum level that the splitter is allowed to go
			-- Depends of the first child minimum size
		deferred
		end	

	maximum_position: INTEGER is
			-- Maximum level that the splitter is allowed to go
			-- Depends of the second child minimum size
		deferred
		end

	size: INTEGER is
			-- width or height depending of the kind of split window
			-- of the splitter
		once
			Result := 6
		end

	splitter_region: WEL_REGION is
			-- A region that recover the splitter
		deferred
		end

feature -- Status settings

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		do
			if child2 /= Void then
				child2.set_insensitive (flag)
				{EV_CONTAINER_IMP} Precursor (flag)
			else
				{EV_CONTAINER_IMP} Precursor (flag)
			end
		end

	set_first_area_shrinkable (flag: BOOLEAN) is
			-- Allow the split area to shrink the first area if `flag', forbid
			-- it otherwise.
		do
			is_first_area_shrinkable := flag
		end

	set_second_area_shrinkable (flag: BOOLEAN) is
			-- Allow the split area to shrink the second area if `flag', forbid
			-- it otherwise.
		do
			is_second_area_shrinkable := flag
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into split area. Split area can 
			-- have two children.
		do
			if child1 = Void then
				child1 := child_imp
			else
				child2 := child_imp
			end
			notify_change (2 + 1)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove the given child from the children of
			-- the container.
		do
			if child_imp.is_equal (child1) then
				child1 := Void
				set_first_area_shrinkable (True)
			else
				child2 := Void
				set_second_area_shrinkable (True)
			end
			notify_change (2 + 1)
		end

	set_top_level_window_imp (a_window: EV_UNTITLED_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		do
			top_level_window_imp := a_window
			if child1 /= Void then
				child1.set_top_level_window_imp (a_window)
			end
			if child2 /= Void then
				child2.set_top_level_window_imp (a_window)
			end
		end

feature -- Basic operations

	propagate_background_color is
			-- Propagate the current background color of the container
			-- to the children.
		do
			if child1 /= Void then
				child1.set_background_color (background_color)
			end
			if child2 /= Void then
				child2.set_background_color (background_color)
			end
		end

	propagate_foreground_color is
			-- Propagate the current foreground color of the container
			-- to the children.
		do
			if child1 /= Void then
				child1.set_foreground_color (foreground_color)
			end
			if child2 /= Void then
				child2.set_foreground_color (foreground_color)
			end
		end

feature -- Assertions

	add_child_ok: BOOLEAN is
			-- True, if it is ok to add a child to
			-- container. Two children
			-- are allowed
		do
			Result := (child1 = Void) or (child2 = Void)
		end
	
	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		do
			Result := (a_child = child1) or
					(a_child = child2)
		end

feature {NONE} -- Implementation

	on_split (value: INTEGER): BOOLEAN is
			-- Is a point with `value' as the coordinate on the split?
		do
			Result := (value >= position) and then (value < position + size)
		end

	refresh is
			-- Erase the background around the children and
			-- draw the split.
		local
			region1: WEL_REGION
			region2: WEL_REGION
			c1, c2: EV_WIDGET_IMP
		do
			-- Some local variable for the speed
			c1 := child1
			c2 := child2
			
			-- First, we draw the split
			draw_split

			-- Then, we erase the background around the children
			dc.get
			!! region1.make_rect (0, 0, width, height)
			region1 := region1.combine (splitter_region, Rgn_diff)
			if c1 /= Void and then c1.shown then
				!! region2.make_rect (c1.x, c1.y, c1.width + c1.x, c1.height + c1.y)
				region1 := region1.combine (region2, Rgn_diff)
				c1.invalidate
			end
			if c2 /= Void and then c2.shown then
				!! region2.make_rect (c2.x, c2.y, c2.width + c2.x, c2.height + c2.y)
				region1 := region1.combine (region2, Rgn_diff)
				c2.invalidate
			end
			dc.fill_region (region1, background_brush)
			dc.release
		end

feature {NONE} -- WEL Implementation

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

	on_wm_erase_background (wparam: INTEGER) is
			-- Wm_erasebkgnd message.
		do
			disable_default_processing
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_paint message
		do
			refresh
		end

	default_style: INTEGER is
		do
			Result := Ws_child + Ws_visible
		end

feature {NONE} -- Deferred features

	draw_split is
			-- draw a vertical split at 'position'.
		deferred
		end

	invert_split is
			-- Invert the vertical split from `first' position to `last' position
			-- Used when the user move the split
		deferred
		end

invariant
	positif_position: position >= 0
	dc_not_void: dc /= Void

end -- class EV_SPLIT_AREA_IMP

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
