indexing

	description: 
		"EiffelVision combo box, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_COMBO_BOX_IMP
	
inherit
	EV_COMBO_BOX_I

	EV_TEXT_FIELD_IMP
		undefine
			make_with_text,
			destroy,
			cut_selection,
			copy_selection,
			selection_start,
			selection_end,
			has_selection,
			delete_selection,
			select_all,
			deselect_all
		redefine
			make,
			text,
			set_editable,
			set_text,
			append_text,
			prepend_text,
			set_position,
			set_maximum_text_length,
			select_region,
			add_activate_command,
			add_change_command,
			remove_activate_commands,
			remove_change_commands
		end

	EV_LIST_IMP
		undefine
			set_default_colors,
			set_default_options,
			is_multiple_selection,
			set_single_selection,
			set_multiple_selection
		redefine
			make,
			select_item,
			selected_item,
			rows,
			selected,
			clear_items,
			add_selection_command,
			add_double_click_selection_command,
			remove_selection_commands,
			remove_double_click_selection_commands,
			add_item,
			remove_item
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create a combo-box with `par' as parent.
		do
			!!ev_children.make
			widget := gtk_combo_new
			gtk_object_ref (widget)
			entry_widget := c_gtk_combo_entry (widget)
			list_widget := c_gtk_combo_list (widget)
		end

feature -- Access

	text: STRING is
		local
			p: POINTER
		do
			p := gtk_entry_get_text (entry_widget)
			!!Result.make (0)
			Result.from_c (p)
		end

	select_item (index: INTEGER) is
			-- Give the item of the list at the one-base
			-- index. (Gtk uses 0 based indexs, I think)
		do
			gtk_list_select_item (list_widget, index-1)
		end

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected, for a multiple
			-- selection, it gives the item which has the focus.
			-- XX Currently just give head of the gtk selection list
		local
			index: INTEGER
		do
			index := c_gtk_list_selected_item(list_widget)
			if index = -1 then
				Result := Void
			else
				-- Gtk has 0 based indicies
				Result ?= (ev_children @ (index+1)).interface
			end
		end

feature -- Measurement

	extended_height: INTEGER is
			-- height of the combo-box when the children are
			-- visible.
		do
		end

feature -- Status report

	rows: INTEGER is
		 	-- Number of lines
		do
			Result := c_gtk_list_rows (list_widget)
		end

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			Result := c_gtk_list_selected (list_widget)
		end

feature -- Status setting

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			gtk_entry_set_editable (entry_widget, flag)
		end

	set_text (txt: STRING) is
		local
			a: ANY
		do
			a ?= txt.to_c
			gtk_entry_set_text (entry_widget, $a)
		end
	
	append_text (txt: STRING) is
		local
			a: ANY
		do
			a ?= txt.to_c
			gtk_entry_append_text (entry_widget, $a)
		end
	
	prepend_text (txt: STRING) is
		local
			a: ANY
		do
			a ?= txt.to_c
			gtk_entry_prepend_text (entry_widget, $a)
		end
	
	set_position (pos: INTEGER) is
		do
			gtk_entry_set_position (entry_widget, pos)
		end
	
	set_maximum_text_length (len: INTEGER) is
		do
			gtk_entry_set_max_length (entry_widget, len)
		end
	
	select_region (start_pos, end_pos: INTEGER) is
		do
			gtk_entry_select_region (entry_widget, start_pos-1, end_pos-1)
		end	

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		do
			clear_ev_children
			gtk_list_clear_items (list_widget, 0, rows)
		end

feature -- Event : command association

	add_selection_command (a_command: EV_COMMAND; arguments: EV_ARGUMENT) is	
			-- Make `command' executed when an item is
			-- selected.
		local
			p: POINTER
		do
			p := widget
			widget := list_widget
			add_command ("selection_changed", a_command, arguments)
			widget := p
		end

	add_double_click_selection_command (a_command: EV_COMMAND; arguments: EV_ARGUMENT) is
			-- Make `command' executed when an item is
			-- selected.
		do
			check
				not_yet_implemented: False
			end
		end

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be
			-- executed when the button is pressed
		local
			p: POINTER
		do
			p := widget
			widget := entry_widget
			add_command ("activate", cmd,  arg)
			widget := p
		end

	add_change_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the text of the widget have changed.
		local
			p: POINTER
		do
			p := widget
			widget := entry_widget
			add_command ("changed", cmd,  arg)
			widget := p
		end

feature -- Event -- removing command association

	remove_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		do
			check False end
		end

	remove_double_click_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		do
			check False end
		end

	remove_activate_commands is
			-- Empty the list of commands to be executed
			-- when the text field is activated, ie when the user
			-- press the enter key.
		do
			check False end
		end

	remove_change_commands is
			-- Empty the list of commands to be executed
			-- when the text of the widget have changed.
		do
			check False end
		end

feature {EV_LIST_ITEM} -- Implementation

	add_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Add `item' to the list
		local
			s: ANY
		do
			ev_children.extend (item_imp)
			s ?= item_imp.text.to_c
			gtk_combo_set_item_string (widget, item_imp.widget, $s)
			gtk_container_add (list_widget, item_imp.widget)
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Remove `item' from the list
		do
			ev_children.prune_all (item_imp)
			gtk_container_remove (list_widget, item_imp.widget)
		end

feature {NONE} -- Implementation

	entry_widget: POINTER
		-- A pointer on the text field

	list_widget: POINTER
		-- A pointer on the list

end -- class EV_COMBO_BOX_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable  components for ISE Eiffel.
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
