indexing 
	description: "EiffelVision Combo-box. Implementation interface"
	status: "See notice at end of class"
	names: widget
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COMBO_BOX_IMP

inherit
	EV_COMBO_BOX_I
		undefine
			build
		end

	EV_ITEM_EVENTS_CONSTANTS_IMP

	EV_ITEM_CONTAINER_IMP
		redefine
			ev_children
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			parent_ask_resize
		end
		
	EV_BAR_ITEM_IMP

	WEL_DROP_DOWN_COMBO_BOX
		rename
			make as wel_make,
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			selected_item as wel_selected_item,
			height as wel_height
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- EV_PRIMITIVE_IMP and EV_TEXT_CONTAINER_IMP.
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

			-- XX Temporary
			wel_height,
			list_shown,
			show_list,
			hide_list
			
		redefine
			on_cbn_selchange,
			on_cbn_editupdate,
			default_style
		end

	WEL_DROP_DOWN_LIST_COMBO_BOX
		rename
			make as wel_make,
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			selected_item as wel_selected_item,
			height as wel_height
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- EV_PRIMITIVE_IMP and EV_TEXT_CONTAINER_IMP.
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
			on_key_up
		redefine
			on_cbn_selchange,
			on_cbn_editupdate,
			default_style
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a combo-box with `par' as parent.
		local
			par_imp: WEL_WINDOW
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			is_editable := True
			wel_make (par_imp, 0, 0, 0, 50, 0)
			set_minimum_height (height)
			initialize
		end

feature -- Access

	get_item (index: INTEGER): EV_COMBO_BOX_ITEM is
			-- Text at the zero-based `index'
		do
			Result ?= (ev_children.i_th (index)).interface
		end

	selected_item: EV_COMBO_BOX_ITEM is
			-- Give the item which is currently selected
			-- It start with a zero index in wel and with a
			-- one index for the array.
		do
			Result ?= (ev_children.i_th (wel_selected_item + 1)).interface
		end

	is_editable: BOOLEAN
			-- Is the combo-box editable

feature -- Measurement

	height: INTEGER is
			-- height of the combo-box when the list is hidden
			-- it is a constant
		do
			Result := window_rect.height
		end

	extended_height: INTEGER is
			-- height of the combo-box when the list is shown
		do
			Result := dropped_rect.height
		end

	set_extended_height (value: INTEGER) is
			-- Make `value' the new extended-height of the box.
		do
			move_and_resize (x, y, width, value, True)
		end

feature -- Element change

	remove_all_elements is
			-- Remove all the elements of the combo-box.
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Event : command association

	add_activate_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is	
		do
			add_command (Cmd_activate, a_command, arguments)
		end

	add_change_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		do
			add_command (Cmd_update, a_command, arguments)
		end
	
feature {EV_COMBO_BOX_ITEM_IMP} -- Implementation

	ev_children: LINKED_LIST [EV_COMBO_BOX_ITEM_IMP]

	item_height: INTEGER is
			-- height needed for an item
		do
			Result := wel_font.log_font.height
		end

	add_item (an_item: EV_COMBO_BOX_ITEM) is
			-- Add an item to the list of the combo-box
		local
			item_imp: EV_COMBO_BOX_ITEM_IMP
		do
			item_imp ?= an_item.implementation
			check
				valid_item: item_imp /= Void
			end
			ev_children.extend (item_imp)
			add_string (name_item)
			item_imp.set_id (ev_children.count - 1)
			if ev_children.count <= 5 then
				set_extended_height ((height + ev_children.count * item_height).max(extended_height))
			end
		end

	remove_item (an_id: INTEGER) is
			-- Remove the child whose id is `id'.
		do
			delete_string (an_id)
			ev_children.go_i_th (an_id + 1)
			ev_children.remove
			from
			until
				ev_children.after
			loop
				ev_children.item.set_id (ev_children.index - 1)
				ev_children.forth
			end
		end

   	parent_ask_resize (a_width, a_height: INTEGER) is
   			-- When we resize a combo-box, we resize the list,
			-- and not the appearance, it's why, we must not
			-- change the height of the combo_box.
		do
			child_cell.resize (minimum_width.max (a_width), minimum_height.max (a_height))
 			if resize_type = 3 then
 				move_and_resize (child_cell.x, child_cell.y, child_cell.width, height, True)
 			elseif resize_type = 2 then
 				move_and_resize ((child_cell.width - width) // 2 + child_cell.x, child_cell.y, width, height, True)
 			elseif resize_type = 1 then
 				move_and_resize (child_cell.x, (child_cell.height - height) // 2 + child_cell.y, child_cell.width, height, True)
			else
 				move ((child_cell.width - width) // 2 + child_cell.x, (child_cell.height - height) // 2 + child_cell.y)
 			end
 		end

feature {NONE} -- Implementation

	caret_position: INTEGER is
			-- Caret position
		do
			check
				not_yet_implemented: False
			end
		end

	set_caret_position (a_position: INTEGER) is
			-- Set the caret position with `position'.
		do
			check
				not_yet_implemented: False
			end
		end

	set_selection (start_position, end_position: INTEGER) is
			-- Set the selection between `start_position'
			-- and `end_position'.
		do
			check
				not_yet_implemented: False
			end
		end

	set_read_only is
			-- Set the read-only state.
		local
			par_imp: WEL_WINDOW
			temp_list: ARRAYED_LIST [STRING]
		do
			if is_editable then
				is_editable := False
				par_imp ?= parent_imp
				!! temp_list.make (0)
				save_list (temp_list)
				wel_destroy
				wel_make (par_imp, 0, 0, 0, 50, 0)
				copy_list (temp_list)
			end
		end

	set_read_write is
			-- Set the read-write state.
		local
			par_imp: WEL_WINDOW
			temp_list: ARRAYED_LIST [STRING]
		do
			if not is_editable then
				is_editable := True
				par_imp ?= parent_imp
				!! temp_list.make (0)
				save_list (temp_list)
				wel_destroy
				wel_make (par_imp, 0, 0, 0, 50, 0)
				copy_list (temp_list)
			end
		end

	save_list (temp_list: ARRAYED_LIST [STRING]) is
			-- Take an empty list and initialize all the children with
			-- the contents of `ev_children'.
		do
			if not ev_children.empty then
				from
					ev_children.start
				until
					ev_children.after
				loop
					temp_list.extend (ev_children.item.text)
					ev_children.forth
				end
			end
		end

	copy_list (temp_list: ARRAYED_LIST [STRING]) is
			-- Take an empty list and initialize all the children with
			-- the contents of `ev_children'.
		do
			if not ev_children.empty then
				from
					temp_list.start
				until
					temp_list.after
				loop
					add_string (temp_list.item)
					temp_list.forth
				end
			end
		end

feature {NONE} -- Wel implementation

	on_cbn_selchange is
			-- The selection is about to be changed.
		do
			execute_command (Cmd_activate, Void)
			(ev_children.i_th (wel_selected_item + 1)).execute_command (Cmd_item_activate, Void)
		end

	on_cbn_editupdate is
			-- The edit control portion is about to
			-- display altered text.
		do
			execute_command (Cmd_update, Void)
		end

	default_style: INTEGER is
		do
			if is_editable then
				Result := {WEL_DROP_DOWN_COMBO_BOX} Precursor
			else
				Result := {WEL_DROP_DOWN_LIST_COMBO_BOX} Precursor
			end
		end

end -- class EV_COMBO_BOX_IMP

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
