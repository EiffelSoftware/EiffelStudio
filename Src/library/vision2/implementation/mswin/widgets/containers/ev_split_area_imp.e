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
			add_child_ok,
			child_add_successful,
			add_child,
			on_left_button_down,
			on_left_button_up,
			on_mouse_move
		redefine
			set_insensitive,
			parent_ask_resize,
			set_width,
			set_height
		end

	EV_SYSTEM_PEN_IMP

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			destroy as wel_destroy
		undefine
			set_width,
			set_height,
			remove_command,
			on_wm_erase_background,
			on_set_cursor,
			on_left_button_down,
			on_mouse_move,
			on_left_button_up,
			on_right_button_down,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_char,
			on_key_up,
			on_draw_item
		redefine
			on_paint
		end

--	WEL_PS_CONSTANTS
--		export
--			{NONE} all
--		end

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

feature -- Initialize

	make (par: EV_CONTAINER) is
			-- Create the control window.
		local
			par_imp: WEL_COMPOSITE_WINDOW
		do
			par_imp ?= par.implementation
			check
				par_imp /= Void
			end
			wel_make (par_imp, "Split Area")
			!! dc.make (Current)
		end

feature -- Access

	level: INTEGER is
			-- Position of the splitter in the window
		deferred
		end

	dc: WEL_CLIENT_DC
			-- Client dc linked to the split window

	cursor: WEL_CURSOR
			-- Current cursor

	is_splitting: BOOLEAN
			-- Is the user currently moving the split ?

	temp_level: INTEGER
			-- Position of the splitter during the action of
			-- the user on the splitter.

	size: INTEGER is
			-- width or height depending of the kind of split window
			-- of the splitter
		once
			Result := 6
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

feature -- Resizing

	set_width (value: INTEGER) is
		do
			child_cell.set_width (value.max (minimum_width))
			set_local_width (child_cell.width)
		end

	set_height (value: INTEGER) is
		do
			child_cell.set_height (value.max (minimum_height))
			set_local_height (child_cell.height)
		end

feature {NONE} -- Basic operation

	set_local_width (new_width: INTEGER) is
		deferred
		end

	set_local_height (new_height: INTEGER) is
		deferred
		end

feature {NONE} -- Implementation

	parent_ask_resize (a_width, a_height: INTEGER) is
			-- Resize the box and all the children inside
   		do
			child_cell.resize (minimum_width.max (a_width), minimum_height.max (a_height))
			if resize_type = 3 then
	  			move_and_resize (child_cell.x, child_cell.y, child_cell.width, child_cell.height, True)
				resize_children (level)
			elseif resize_type = 2 then
				move_and_resize ((child_cell.width - width) // 2 + child_cell.x, child_cell.y, width, child_cell.height, True)
				resize_children (level)
			elseif resize_type = 1 then
				move_and_resize (child_cell.x, (child_cell.height - height) // 2 + child_cell.y, child_cell.width, height, True)
				resize_children (level)
			else
				move ((child_cell.width - width)//2 + child_cell.x, (child_cell.height - height)//2 + child_cell.y)
			end
		end

feature {EV_WEL_SPLIT_WINDOW} -- Implementation

	resize_children (a_level: INTEGER) is
			-- Resize both children according to the new level
			-- `level' of the splitter.
		deferred
		end

feature -- Implementation : Event handle

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

feature -- Implementation : Basic routines

	refresh is
			-- Refresh the window. Redraw the split and erase
			-- the rest if necessary.
		do
			on_wm_erase_background (0)
			draw_split
		end

	draw_split is
			-- draw a vertical split at 'level'.
		deferred
		end

	invert_split is
			-- Invert the vertical split from `first' position to `last' position
			-- Used when the user move the split
		deferred
		end

feature {NONE} -- Implementation : Brushes and pen

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

Invariant
	positif_level: level >= 0
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
