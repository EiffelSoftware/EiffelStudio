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
			on_first_display,
			set_insensitive
		end

	EV_FONTABLE_IMP
		redefine
			set_font
		end

	WEL_TAB_CONTROL
		rename
			make as wel_make,
			parent as wel_parent,
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
			on_draw_item
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
			wel_make (wel_imp, 0, 0, 0, 0, 0)
		end

	plateform_build (par: EV_CONTAINER_IMP) is
			-- Called after creation. Set the current size and
			-- notify the parent.
		do
			{EV_CONTAINER_IMP} Precursor (par)
			set_font (font)
			set_minimum_height (tab_height)
		end

feature {NONE} -- Access

	tab_pos: INTEGER
			-- Actual position of the tab.

feature -- Status setting
	
	set_tab_position (pos: INTEGER) is
			-- set position of tabs (left, right, top or bottom)
		local
			temp_window: wel_window
			ev_children: LINKED_LIST [WEL_TAB_CONTROL_ITEM]
		do
			tab_pos := pos
			temp_window := wel_parent 
			if count > 0 then
				from
					!! ev_children.make
				until
					ev_children.count = count
				loop
					ev_children.extend (get_item (ev_children.count))
					ev_children.last.window.set_parent (temp_window)
					ev_children.last.window.hide
				end
				wel_destroy
				wel_make (temp_window, 0, 0, 0, 0, 0)
				from
					ev_children.start
				until
					ev_children.after
				loop
					ev_children.item.window.set_parent (Current)
					insert_item (count, ev_children.item)
					ev_children.forth
				end
			else
				wel_destroy
				wel_make (temp_window, 0, 0, 0, 0, 0)
			end
			set_font (font)
			set_minimum_height (tab_height)
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

feature -- Implementation

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite. In this container, `child' is the
			-- child of the container whose page is currently selected.
		do
			child := child_imp
			child_imp.hide
		end

feature {EV_WIDGET_IMP} -- Implementation

	child_minwidth_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his wn minimum value.
		do
			if value + 6 > minimum_width then
				set_minimum_width (value + 6)
			end
		end

	child_minheight_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum height of the container because
			-- the child changed his own minimum width.
		do
			if value + tab_height > minimum_height then
				set_minimum_height (value + tab_height)
			end
		end

feature {NONE} -- Implementation

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
			Result := {WEL_TAB_CONTROL} Precursor + Ws_clipchildren
				+ Ws_clipsiblings + Tcs_multiline + Tcs_hottrack
			if tab_pos = Pos_bottom then
				Result := Result + Tcs_bottom
			elseif tab_pos = Pos_left then
				Result := Result + Tcs_vertical + Tcs_fixedwidth
			elseif tab_pos = Pos_right then
				Result := Result + Tcs_vertical + Tcs_right + Tcs_fixedwidth
			end
		end

	default_ex_style: INTEGER is
	  			-- Default extented style used to create the window
 		do
 			Result := Ws_ex_controlparent
 		end

	tab_height: INTEGER is
			-- The height of the bar with the pages.
		do
			Result := 25 --client_rect.top - sheet_rect.top
		end

	set_font (f: EV_FONT) is
   			-- Set `font' to `f'.
   		local
   			local_font_windows: EV_FONT_IMP
   		do
 			private_font := f
 			local_font_windows ?= private_font.implementation
			check
   				valid_font: local_font_windows /= void
   			end
			if (tab_pos = Pos_top) or (tab_pos = Pos_bottom) then
				wel_set_font (local_font_windows.wel_font)
			else
				set_vertical_font (local_font_windows.wel_font)
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
