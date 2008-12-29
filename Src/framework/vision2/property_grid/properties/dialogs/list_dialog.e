note
	description: "Dialog that allows to edit an ordered list of strings."
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_DIALOG

inherit
	PROPERTY_DIALOG [LIST [STRING_32]]
		redefine
			initialize,
			on_ok
		end

	PROPERTY_GRID_LAYOUT
		undefine
			default_create,
			copy
		end

create
	default_create,
	make_with_title

feature {NONE} -- Initialization

	initialize
			-- Initialize.
		local
			hb: EV_HORIZONTAL_BOX
			vb, vb1: EV_VERTICAL_BOX
			cl: EV_CELL
		do
			Precursor {PROPERTY_DIALOG}
			create hb
			element_container.extend (hb)
			create vb
			hb.extend (vb)
			if value /= Void then
				create list.make_with_strings (value)
			else
				create list
			end
			vb.extend (list)
			create vb1
			hb.extend (vb1)
			hb.disable_item_expand (vb1)
			create cl
			vb1.extend (cl)
			create up_button.make_with_text (up_button_text)
			vb1.extend (up_button)
			vb1.disable_item_expand (up_button)
			create down_button.make_with_text (down_button_text)
			vb1.extend (down_button)
			vb1.disable_item_expand (down_button)
			create cl
			vb1.extend (cl)

			append_small_margin (vb)
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create new_item_name
			hb.extend (new_item_name)
			create add_button.make_with_text (plus_button_text)
			add_button.set_minimum_width (small_button_width)
			hb.extend (add_button)
			hb.disable_item_expand (add_button)
			create remove_button.make_with_text (minus_button_text)
			remove_button.set_minimum_width (small_button_width)
			hb.extend (remove_button)
			hb.disable_item_expand (remove_button)
			create modify_button.make_with_text (change_button_text)
			hb.extend (modify_button)
			hb.disable_item_expand (modify_button)

			show_actions.extend (agent refresh_list)
			show_actions.extend (agent list.set_focus)
			data_change_actions.extend (agent update_list)
			up_button.select_actions.extend (agent on_up)
			down_button.select_actions.extend (agent on_down)
			add_button.select_actions.extend (agent on_add)
			remove_button.select_actions.extend (agent on_remove)
			modify_button.select_actions.extend (agent on_modify)
			list.select_actions.extend (agent on_select)
		end

feature {NONE} -- GUI elements

	list: EV_LIST
			-- List.

	new_item_name: EV_TEXT_FIELD
			-- Text field to enter name of an item.

	down_button: EV_BUTTON
			-- Button to move an item down.

	up_button: EV_BUTTON
			-- Button to move an item up.

	add_button: EV_BUTTON
			-- Button to add a new element.

	remove_button: EV_BUTTON
			-- Button to remove an element.

	modify_button: EV_BUTTON
			-- Button to modify an element.

feature {NONE} -- Agents

	on_ok
			-- Ok was pressed.
		do
			value := list.strings
			Precursor {PROPERTY_DIALOG}
		end

	refresh_list
			-- Refresh `list'.
		require
			list_created: list /= Void
		do
			update_list (value)
		end

	update_list (a_value: like value)
			-- Update `list' with new `a_value'.
		require
			list_created: list /= Void
		do
			list.wipe_out
			if a_value /= Void then
				list.set_strings (a_value)
			end
		end

	on_up
			-- Up was pressed
		local
			l_item: EV_LIST_ITEM
			i: INTEGER
		do
			l_item := list.selected_item
			if l_item /= Void then
				i := list.index_of (l_item, 1)
				if i > 1 then
					list.go_i_th (i)
					list.swap (i-1)
					list.i_th (i-1).enable_select
				end
			end
		end

	on_down
			-- Down was pressed.
		local
			l_item: EV_LIST_ITEM
			i: INTEGER
		do
			l_item := list.selected_item
			if l_item /= Void then
				i := list.index_of (l_item, 1)
				if i < list.count then
					list.go_i_th (i)
					list.swap (i+1)
					list.i_th (i+1).enable_select
				end
			end
		end

	on_add
			-- Add button was pressed.
		local
			l_found: BOOLEAN
		do
			from
				list.start
			until
				l_found or list.after
			loop
				l_found := list.item.text.is_equal (new_item_name.text)
				list.forth
			end
			if not l_found then
				list.extend (create {EV_LIST_ITEM}.make_with_text (new_item_name.text))
			end
		end

	on_remove
			-- Remove button was pressed.
		do
			if list.selected_item /= Void then
				list.go_i_th (list.index_of (list.selected_item, 1))
				list.remove
			end
		end

	on_modify
			-- Modify button was pressed.
		do
			if list.selected_item /= Void then
				on_remove
				on_add
			end
		end

	on_select
			-- Select an item in the list.
		do
			if list.selected_item /= Void then
				new_item_name.set_text (list.selected_item.text)
			end
		end

invariant
	value_set: is_ok implies value /= Void
	elements: is_initialized implies list /= Void and up_button /= Void and
			down_button /= Void and add_button /= Void and remove_button /= Void and
			modify_button /= Void

end
