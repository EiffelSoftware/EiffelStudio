indexing
	description: 
		"EiffelVision notebook, Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_NOTEBOOK_IMP

inherit
	EV_NOTEBOOK_I

	EV_CONTAINER_IMP
		undefine
			add_child_ok
		redefine
			plateform_build,
			add_child,
			child_minheight_changed,
			child_minwidth_changed,
			set_insensitive,
			on_first_display
		end

	EV_FONTABLE_IMP
		redefine
			set_font
		end

	WEL_TAB_CONTROL
		rename
			make as wel_make,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy
		undefine
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_key_up,
			on_draw_item,
			on_menu_command
		redefine
			default_style,
			default_ex_style,
			adjust_items
		end

	WEL_TCIF_CONSTANTS
		export
			{NONE} all
		end

creation
	make
	
feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a fixed widget with, `par' as
			-- parent
		local
			wel_imp: WEL_WINDOW
		do
			wel_imp ?= par.implementation
			check
				parent_not_void: wel_imp /= Void
			end
			wel_make (wel_imp, 0, 0, 10, 10, 0)
			tab_pos := Pos_top
		end

	plateform_build (par: EV_CONTAINER_IMP) is
			-- Called after creation. Set the current size and
			-- notify the parent.
		do
			{EV_CONTAINER_IMP} Precursor (par)
			set_font (font)
			if tab_pos = Pos_top or tab_pos = Pos_bottom then
				set_minimum_height (tab_height)
			else
				set_minimum_width (tab_height)
			end
		end

feature {NONE} -- Access

	tab_pos: INTEGER
			-- Actual position of the tab.

feature -- Status setting
	
	set_tab_position (pos: INTEGER) is
			-- set position of tabs (left, right, top or bottom)
		do
 			tab_pos := pos
 			set_style (default_style)
			set_font (font)
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			if insensitive /= flag then
				from
					index := 0
				until
					index = count
				loop
					child_item := get_item (index)
					child_imp ?= child_item.window
					check
						child_imp_not_void: child_imp /= Void
					end
					child_imp.set_insensitive (flag)
					index := index + 1
				end
				{EV_CONTAINER_IMP} Precursor (flag)
			end
		end

feature -- Element change

	set_page_title (index: INTEGER; str: STRING) is
			-- Set the label of the `index' page of the notebook.
			-- The first page is the page number 1.
		local
			wel_item: WEL_TAB_CONTROL_ITEM
		do
			wel_item := get_item (index - 1)
			wel_item.set_text (str)
			delete_item (index - 1)
			insert_item (index - 1, wel_item)
		end
	
	append_page (child_imp: EV_WIDGET_I; label: STRING) is
		-- Add a new page for notebook containing 'child_imp' with tab 
		-- label `label'.
		local
			wel_item: WEL_TAB_CONTROL_ITEM
			widget_imp: WEL_WINDOW
		do
			widget_imp ?= child_imp
			!! wel_item.make
			wel_item.set_text (label)
			wel_item.set_window (widget_imp)
			insert_item (count, wel_item)
		end

	set_font (f: EV_FONT) is
			-- Set `font' to `f'.
			-- When the tabs are vertical, we set back the default font
			-- by using `cwin_send_message' (feature not implemented in WEL)
			-- because vertical fonts doesn't work with everything.
		local
			local_font_windows: EV_FONT_IMP
		do
			if (tab_pos = Pos_top) or (tab_pos = Pos_bottom) then
				private_font := f
				local_font_windows ?= private_font.implementation
				check
					valid_font: local_font_windows /= void
				end
				wel_set_font (local_font_windows.wel_font)
			else
				cwin_send_message (item, wm_setfont, 0, cwin_make_long (1, 0))
			end
		end

feature -- Implementation

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite. In this container, `child' is the
			-- child of the container whose page is currently selected.
		do
			{EV_CONTAINER_IMP} Precursor (child_imp)
			child_imp.hide
		end

feature {NONE} -- Implementation for automatic size compute

	child_minwidth_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his wn minimum value.
			-- We add 6 or 2 for the border size.
		do
			if tab_pos = Pos_top or tab_pos = Pos_top then
				if value + 6 > minimum_width then
					set_minimum_width (value + 6)
				end
			else
				if value + tab_height > minimum_width then
					set_minimum_width (value + tab_height + 2)
				end
			end
		end

	child_minheight_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum height of the container because
			-- the child changed his own minimum width.
			-- We add 6 or 2 for the border size.
		do
			if tab_pos = Pos_left or tab_pos = Pos_right then
				if value + 6 > minimum_height then
					set_minimum_height (value + 6)
				end
			else
				if value + tab_height > minimum_height then
					set_minimum_height (value + tab_height + 2)
				end
			end
		end

feature {NONE} -- WEL Implementation

	on_first_display is
			-- Called by the top_level window.
			-- Almost the same action than adjust_items.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			from
				index := 0
			until
				index = count
			loop
				child_item := get_item (index)
				child_imp ?= child_item.window
				check
					child_imp_not_void: child_imp /= Void
				end
				child_imp.on_first_display
				index := index + 1
			end
		end

	adjust_items is
			-- Adjust the size of the windows of the items
			-- to the current size.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
			child_imp: EV_WIDGET_IMP
		do
			from
				index := 0
			until
				index = count
			loop
				child_item := get_item (index)
				child_imp ?= child_item.window
				check
					child_imp_not_void: child_imp /= Void
				end
				child_imp.set_move_and_size (sheet_rect.left, sheet_rect.top, sheet_rect.width, sheet_rect.height)
				index := index + 1
			end
		end

 	default_style: INTEGER is
 			-- Default style used to create the control
 		do
 			Result := Ws_visible + Ws_child + Ws_group + Ws_tabstop
				+ Ws_clipchildren + Ws_clipsiblings
			if tab_pos = Pos_top then
				Result := Result + Tcs_singleline
			elseif tab_pos = Pos_bottom then
 				Result := Result + Tcs_bottom + Tcs_singleline
 			elseif tab_pos = Pos_left then
 				Result := Result + Tcs_vertical + Tcs_fixedwidth 
					+ Tcs_multiline
			elseif tab_pos = Pos_right then
 				Result := Result + Tcs_right + Tcs_vertical
					+ Tcs_fixedwidth + Tcs_multiline
 			end
 		end

	default_ex_style: INTEGER is
	  			-- Default extented style used to create the window
 		do
 			Result := Ws_ex_controlparent
 		end

	tab_height: INTEGER is
			-- The height of the tabs in `Pos_top' ot `Pos_bottom' status,
			-- the width of the tabs otherwise.
		do
			inspect tab_pos 
			when Pos_top then
				Result := sheet_rect.top - client_rect.top
			when Pos_left then
				Result := sheet_rect.left - client_rect.left
			when Pos_bottom then
				Result := client_rect.bottom - sheet_rect.bottom
			when Pos_right then
				Result := client_rect.right - sheet_rect.right
			else
				Result := 0
			end
		end

end -- EV_NOTEBOOK_IMP

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
