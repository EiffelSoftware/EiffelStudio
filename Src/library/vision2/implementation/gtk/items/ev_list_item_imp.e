indexing
	description: ""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I

	EV_SIMPLE_ITEM_IMP
		redefine
			create_text_label,
			has_parent
		end

creation
	make,
	make_with_text,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make is
			-- Create a list item with an empty name.
		do
			widget := gtk_list_item_new
			gtk_object_ref (widget)		
			box := gtk_hbox_new (False, 0)
			gtk_widget_show (box)
			gtk_container_add (GTK_CONTAINER (widget), box)
		end
	
	make_with_text (txt: STRING) is
			-- Create a list item with `txt' as label.
		local
			a: ANY
		do
			make
			create_text_label (txt)
		end

	make_with_index (par: EV_LIST; value: INTEGER) is
			-- Create an item with `par' as parent and `value'
			-- as index.
		do
		end

	make_with_all (par: EV_LIST; txt: STRING; value: INTEGER) is
			-- Create an item with `par' as parent, `txt' as text
			-- and `value' as index.
		do
		end

feature -- Access

	parent_imp: EV_LIST_IMP
			-- Parent of the Current item

	index: INTEGER is
			-- Index of the current item.
		do
			Result := gtk_list_child_position(parent_imp.widget, Current.widget) + 1 
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := False
		end

	is_first: BOOLEAN is
			-- Is the item first in the list ?
		do
			Result := ( gtk_list_child_position (parent_imp.widget, Current.widget) + 1 = 1 )
		end

	is_last: BOOLEAN is
			-- Is the item last in the list ?
		do
			Result := ( gtk_list_child_position (parent_imp.widget, Current.widget) + 1 = c_gtk_list_rows (parent_imp.widget) )
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if flag then
				c_gtk_list_item_select (widget)
			else
				c_gtk_list_item_unselect (widget)
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposit status.
		do
			set_selected (not is_selected)
		end

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item in the
			-- list.
		do
		end

	create_text_label (txt: STRING) is
		local
                        a: ANY
		do
			a := txt.to_c
			
			set_label_widget (gtk_label_new ($a))
			gtk_widget_show (label_widget)
			gtk_box_pack_start (GTK_BOX (box), label_widget, False, True, 0)
		end			

feature -- element change

	set_parent (par: EV_LIST) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void.
		do
			if parent_imp /= Void then
				gtk_object_ref (widget)
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				check
					parent_not_void: parent_imp /= Void
				end
				parent_imp.add_item (Current)
				show
				gtk_object_unref (widget)
			end
		end

feature -- Assertion

	has_parent : BOOLEAN is
			-- Redefinition of has_a_parent, already defined
			-- in EV_WIDGET_I, because parent_imp has been
			-- redefined as widget_parent_imp
		do
			Result := parent_imp /= void
		end

feature -- Event : command association

	add_activate_command (command: EV_COMMAND; arguments: EV_ARGUMENT) is
			-- Add 'command' to the list of commands to be
			-- executed when the menu item is activated
			-- The toggle event doesn't work on gtk, then
			-- we add both event command.
		do
			add_command (widget, "select", command, arguments)
		end

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Make `cmd' the executed command when the item is
			-- unactivated.
		do
			add_command (widget, "deselect", cmd, arg)
		end	

	add_double_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be
			-- executed when the item is double clicked
		do
			old_add_dblclk (1, cmd, arg)
		end	

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		do
			remove_commands (widget, select_id)
		end	

	remove_deactivate_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		do	
			remove_commands (widget, deselect_id)
		end

	remove_double_click_commands is
			-- Empty the list of commands to be executed when
			-- the item is double-clicked.
		do
			old_remove_dblclk (1)
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
