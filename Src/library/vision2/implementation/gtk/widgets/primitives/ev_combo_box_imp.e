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

	EV_PRIMITIVE_IMP
		undefine
			build
		redefine
			destroy
		end
	
creation

	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a combo-box with `par' as parent.
		do
			widget := gtk_combo_new
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

feature -- Basic operation

	search (str: STRING): INTEGER is
			-- Search the string `str' in the text.
			-- If `str' is find, it returns its start
			-- index in the text, otherwise, it returns
			-- `Void'
		do
			check
				not_yet_implemented: False
			end
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selectd_region' is empty, it does
			-- nothing.
		do
			check
				not_yet_implemented: False
			end
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			check
				not_yet_implemented: False
			end
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		do
			check
				not_yet_implemented: False
			end
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

feature -- Measurement

	extended_height: INTEGER is
			-- height of the combo-box when the children are
			-- visible.
		do
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
	
	set_maximum_line_length (len: INTEGER) is
		do
			gtk_entry_set_max_length (entry_widget, len)
		end
	
	select_region (start_pos, end_pos: INTEGER) is
		do
			gtk_entry_select_region (entry_widget, start_pos-1, end_pos-1)
		end	

	destroy is
			-- Destroy screen widget implementation and EV_LIST_ITEM objects
		do
			clear_items
			{EV_PRIMITIVE_IMP} Precursor 
		end


feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		do
			clear_ev_children
			gtk_list_clear_items (list_widget, 0, rows)
		end
	
feature -- Event - command association
	
	add_activate_command ( command: EV_COMMAND; 
			       arguments: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be
			-- executed when the button is pressed
		do
			add_command ( "activate", command,  arguments )
		end

	add_selection_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is	
			-- Make `command' executed when an item is
			-- selected.
		do
			add_command ("selection_changed", a_command, arguments)
			--add_command ("select_child", a_command, arguments)
		end

	add_double_click_selection_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Make `command' executed when an item is
			-- selected.
		do
			check
				not_yet_implemented: False
			end
		end

feature {EV_LIST_ITEM} -- Implementation

	add_item (item: EV_LIST_ITEM) is
			-- Add `item' to the list
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= item.implementation
			check
				correct_imp: item_imp /= Void
			end
			ev_children.extend (item_imp)
			c_gtk_add_list_item (widget, item_imp.widget)
		end

feature {NONE} -- Implementation

	entry_widget: POINTER

	list_widget: POINTER

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
