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
		rename
			add_double_click_command as old_double_click
		end

creation

	make, make_with_text

feature {NONE} -- Initialization

	make (par: EV_LIST) is
			-- Create an item with an empty name.
		do
			widget := gtk_list_item_new			
		end
	
	make_with_text (par: EV_LIST; txt: STRING) is
			-- Create an item with `txt' as label.
		local
			a: ANY
		do
			a ?= txt.to_c
			widget := gtk_list_item_new_with_label ($a)
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := False
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if flag then
				gtk_list_item_select (widget)
			else
				gtk_list_item_deselect (widget)
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposit status.
		do
			set_selected (not is_selected)
		end

feature -- Event : command association

	add_double_click_command (a_command: EV_COMMAND; 
			       arg: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be
			-- executed when the item is double clicked
		do
			old_double_click (1, a_command, arg)
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
