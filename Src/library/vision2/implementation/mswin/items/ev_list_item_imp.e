indexing
	description: "EiffelVision list item. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I

	EV_SIMPLE_ITEM_IMP
		redefine
			set_text
		end

	EV_SYSTEM_PEN_IMP
		export
			{NONE} all
		end

creation
	make,
	make_with_text,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make is
			-- Create the widget with `par' as parent.
		do
			set_text ("")
		end

	make_with_index (par: EV_LIST; value: INTEGER) is
			-- Create an item with `par' as parent and `value'
			-- as index.
		do
			set_text ("")
			parent_imp ?= par.implementation
			parent_imp.insert_item (Current, value)
		end

	make_with_all (par: EV_LIST; txt: STRING; value: INTEGER) is
			-- Create an item with `par' as parent, `txt' as text
			-- and `value' as index.
		do
			set_text (txt)
			parent_imp ?= par.implementation
			parent_imp.insert_item (Current, value)
		end

feature -- Access

	parent_imp: EV_LIST_ITEM_HOLDER_IMP
			-- Parent of the current item

	index: INTEGER is
			-- Index of the current item.
			-- `id' is a zero-based index
		do
			Result := parent_imp.internal_get_index (Current)
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current object destroyed ?
			-- Yes if the item doesn't exist in the parent.
		do
			Result := False
		end

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := parent_imp.internal_is_selected (Current)
		end

	is_first: BOOLEAN is
			-- Is the item first in the list ?
		do
			Result := (index = 1)
		end

	is_last: BOOLEAN is
			-- Is the item last in the list ?
		do
			Result := (index = parent_imp.count)
		end
	
feature -- Status setting

	destroy is
			-- Destroy the actual item.
		do
			if parent_imp /= Void then
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			interface := Void
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if flag then
				parent_imp.internal_select_item (Current)
			else
				parent_imp.internal_deselect_item (Current)
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposit status.
		do
			set_selected (not is_selected)
		end

feature -- Element change

	set_parent (par: EV_LIST) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			if parent_imp /= Void then
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				parent_imp.add_item (Current)
			end
		end

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		do
			{EV_SIMPLE_ITEM_IMP} Precursor (txt)
			if parent_imp /= Void then
				parent_imp.internal_set_text (Current, txt)
			end
		end

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item in the
			-- list.
		do
			parent_imp.move_item (Current, value)
		end

feature -- Event : command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is activated.
		do
			add_command (Cmd_item_activate, cmd, arg)			
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unactivated.
		do
			add_command (Cmd_item_deactivate, cmd, arg)		
		end

	add_double_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed
			-- when the item is double clicked.
		do
			add_command (Cmd_item_dblclk, cmd, arg)
		end	

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		do
			remove_command (Cmd_item_activate)			
		end	

	remove_deactivate_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		do
			remove_command (Cmd_item_deactivate)		
		end

	remove_double_click_commands is
			-- Empty the list of commands to be executed when
			-- the item is double-clicked.
		do
			remove_command (Cmd_item_dblclk)
		end	

feature {EV_LIST_ITEM_HOLDER_IMP} -- Implementation for drawing

	on_draw (struct: WEL_DRAW_ITEM_STRUCT) is
			-- Draw the current item according to the given
			-- struct.
		local
			dc: WEL_DC
			rect: WEL_RECT
		do
			dc := struct.dc
			rect := struct.rect_item

			if struct.item_action = Oda_focus then
				draw_focus (dc, rect)
			elseif struct.item_action = Oda_select then
				if struct.item_state = Ods_selected then
					draw_selected_body (dc, rect)
				else
					draw_unselected_body (dc, rect)
				end
				if struct.item_state = Ods_focus then
					draw_focus (dc, rect)
				end
			elseif struct.item_action = Oda_drawentire then
				if struct.item_state = Ods_selected then
					draw_selected_body (dc, rect)
				else
					draw_unselected_body (dc, rect)
				end
				if struct.item_state = Ods_focus then
					draw_focus (dc, rect)
				end
			end
		end

feature {NONE} -- Implementation for drawing

	draw_focus (dc: WEL_DC; rect: WEL_RECT) is
			-- Draw the focus line around the button.
		do
			draw_focus_rect (dc, rect)
		end

	draw_selected_body (dc: WEL_DC; rect: WEL_RECT) is
			-- Invert the color of the item to show the
			-- selection.
		do
			dc.set_background_color (selection_color)
			dc.set_text_color (white)
			if pixmap_imp /= Void and text /= "" then
				dc.bit_blt (rect.left, rect.top, rect.width, rect.height, pixmap_imp.dc, 0, 0, Srccopy)
				rect.set_left (pixmap_imp.width)
				dc.fill_rect (rect, selection_brush)
				rect.set_left (rect.left + 5)
				dc.draw_text (text, rect, Dt_left)
				rect.set_left (0)
			elseif pixmap_imp /= Void then
				dc.bit_blt (rect.left, rect.top, rect.width, rect.height, pixmap_imp.dc, 0, 0, Srccopy)
				rect.set_left (pixmap_imp.width)
				dc.fill_rect (rect, selection_brush)
				rect.set_left (0)
			elseif text /= "" then
				dc.fill_rect (rect, selection_brush)
				dc.draw_text (text, rect, Dt_left)
			end
		end

	draw_unselected_body (dc: WEL_DC; rect: WEL_RECT) is
			-- Draw the body of the button : bitmap + text
		do
			dc.set_background_color (parent_imp.background_color_imp)
			dc.fill_rect (rect, parent_imp.background_brush)
			if pixmap_imp /= Void and text /= "" then
				dc.bit_blt (rect.left, rect.top, rect.width, rect.height, pixmap_imp.dc, 0, 0, Srccopy)
			rect.set_left (pixmap_imp.width + 5)
				dc.set_text_color (parent_imp.foreground_color_imp)
				dc.draw_text (text, rect, Dt_left)
				rect.set_left (0)
			elseif pixmap_imp /= Void then
				dc.bit_blt (rect.left, rect.top, rect.width, rect.height, pixmap_imp.dc, 0, 0, Srccopy)
			elseif text /= "" then
				dc.set_text_color (parent_imp.foreground_color_imp)
				dc.draw_text (text, rect, Dt_left)
			end
		end	

	selection_color: WEL_COLOR_REF is
			-- Color used to draw a selection
		once
			!! Result.make_system (Color_highlight)
		end

	selection_brush: WEL_BRUSH is
			-- Color used to draw a selection
		once
			!! Result.make_by_sys_color (Color_highlight + 1)
		end

end -- class EV_LIST_ITEM_IMP

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
