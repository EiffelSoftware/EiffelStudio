indexing
	description: ""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I

	EV_ITEM_IMP
		redefine
			create_text_label
		end

creation
	make, make_with_text

feature {NONE} -- Initialization

	make (par: EV_LIST) is
			-- Create an item with an empty name.
		do
			widget := gtk_list_item_new
			show		
			initialize
		end
	
	make_with_text (par: EV_LIST; txt: STRING) is
			-- Create an item with `txt' as label.
		local
			a: ANY
		do
			make (par)
			create_text_label (txt)

--			a ?= txt.to_c
--			widget := gtk_list_item_new_with_label ($a)
--			initialize
		end

	initialize is
			-- Common initialization for buttons
		do
			box := gtk_hbox_new (False, 0)
			gtk_widget_show (box)
			gtk_container_add (GTK_CONTAINER (widget), box)
		end			


feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := False
		end

	index: INTEGER is
			-- Index of the current item.
		do
			check
				not_yet_implemented: False
			end
		end

	is_first: BOOLEAN is
			-- Is the item first in the list ?
		do
			check
				not_yet_implemented: False
			end
		end

	is_last: BOOLEAN is
			-- Is the item last in the list ?
		do
			check
				not_yet_implemented: False
			end
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

	create_text_label (txt: STRING) is
		local
                        a: ANY
		do
			a ?= txt.to_c
			
			set_label_widget (gtk_label_new ($a))
			gtk_widget_show (label_widget)
			gtk_box_pack_start (GTK_BOX (box), label_widget, False, True, 0)
		end			


feature -- Event : command association

	add_double_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be
			-- executed when the item is double clicked
		do
			old_add_dblclk (1, cmd, arg)
		end	

feature -- Event -- removing command association

	remove_double_click_commands is
			-- Empty the list of commands to be executed when
			-- the item is double-clicked.
		do
			check False end
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
