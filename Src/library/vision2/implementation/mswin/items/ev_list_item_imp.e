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

	EV_PIXMAPABLE_IMP

	EV_ITEM_IMP
		export {EV_LIST_ITEM_CONTAINER_IMP}
			id,
			set_id
		redefine
			parent_imp
		end

	EV_SYSTEM_PEN_IMP
		export
			{NONE} all
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_LIST) is
			-- Add and create an item with an empty label.
		do
			make_with_text (par, "")
		end

	make_with_text (par: EV_LIST; txt: STRING) is
			-- Add and create an item with `txt' as label.
		do
			parent_imp ?= par.implementation
			check
				parent_not_void: parent_imp /= Void
			end
			parent_imp.set_name (txt)
			initialize_list (item_command_count)
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := parent_imp.is_selected (id)
		end

	text: STRING is
			-- Current label of the item
		do
			Result := parent_imp.i_th_text (id)
		end

	destroyed: BOOLEAN is
			-- Is current object destroyed ?
			-- Yes if the item doesn't exist in the parent_imp.
		do
			Result := not parent_imp.ev_children.has (Current)
		end

feature -- Status setting

	destroy is
			-- Destroy the actual item.
		do
			parent_imp.remove_item (id)
			interface.remove_implementation
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			parent_imp.select_item (id + 1)
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposit status.
		do
			set_selected (not is_selected)
		end

feature -- Element change

	set_text (str: STRING) is
			-- Set `text' to `str'.
		do
			parent_imp.delete_string (id)
			parent_imp.insert_string_at (str, id)
		end

--	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void.
			-- We have to add the child to the new parent before
			-- to remove it from the old one.
--		local
--			par_imp: EV_CONTAINER_IMP
--		do
--			parent_imp.remove_item
--			if par /= Void then
--				par.set_name (text)
--				par.
--
--				parent_imp ?= par
--				check
--					parent_not_void: parent_imp /= Void
--				end
--			else
--				parent_imp := Void
--			end
--		end

feature -- Event : command association

	add_double_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be executed
			-- when the item is double clicked.
		do
			add_command (Cmd_item_dblclk, cmd, arg)
		end	

feature {EV_LIST_ITEM_CONTAINER_IMP} -- Implementation

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

feature {NONE} -- Implementation

	wel_window: WEL_WINDOW is
			-- Window used to create the pixmap. It has to be
			-- a wel_control.
		do
			Result ?= parent_imp
		end

	parent_imp: EV_LIST_ITEM_CONTAINER_IMP
			-- list that contains the current item.

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
				dc.bit_blt (rect.left, rect.top, rect.width, rect.height, pixmap_imp, 0, 0, Srccopy)
				rect.set_left (pixmap_imp.width)
				dc.fill_rect (rect, selection_brush)
				rect.set_left (rect.left + 5)
				dc.draw_text (text, rect, Dt_left)
				rect.set_left (0)
			elseif pixmap_imp /= Void then
				dc.bit_blt (rect.left, rect.top, rect.width, rect.height, pixmap_imp, 0, 0, Srccopy)
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
				dc.bit_blt (rect.left, rect.top, rect.width, rect.height, pixmap_imp, 0, 0, Srccopy)
			rect.set_left (pixmap_imp.width + 5)
				dc.set_text_color (parent_imp.foreground_color_imp)
				dc.draw_text (text, rect, Dt_left)
				rect.set_left (0)
			elseif pixmap_imp /= Void then
				dc.bit_blt (rect.left, rect.top, rect.width, rect.height, pixmap_imp, 0, 0, Srccopy)
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
