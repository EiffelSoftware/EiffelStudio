indexing

	description: 
		"EiffelVision menu_b_imp, gtk implementation.";
	status: "See notice at end of class";
	id: "$id: $";
	date: "$Date$";
	revision: "$Revision$"
	
class
	MENU_B_IMP

inherit

	MENU_B_I	
	BUTTON_IMP
	TEXT_CONTAINER
	
creation
	make


feature {NONE} -- Initialization

	make (a_menu_b: MENU_B; man: BOOLEAN; oui_parent: MENU) is
			-- Create a gtk menu button.
		do
			widget := gtk_menu_item_new ()	
			common_widget_make (man, oui_parent)
			
			
			!!label.make (a_menu_b.identifier, oui_parent)
			label.realize
			label.show
			
--XX			mel_cascade_make (a_menu_b.identifier, mc, man);
--			a_menu_b.set_font_imp (Current);
--XX			set_mnemonic_from_text (a_menu_b.identifier, False)
		end

feature -- Access

--XX	parent: MEL_ROW_COLUMN
			-- Parent of menu button

feature -- Element change

	attach_menu (a_menu: MENU_PULL) is
			-- Attach menu `a_menu' to the menu button, it will
			-- be the menu which will appear when the button
			-- is armed.
		local
			mel_rc: MEL_ROW_COLUMN
		do
			mel_rc ?= a_menu.implementation;
--XX			set_sub_menu (mel_rc);
		end;

feature {NONE} -- Implementation

	add_activate_action (a_command: COMMAND; argument: ANY) is
		do
		end
--XX
-- 	add_release_action (a_command: COMMAND; argument: ANY) is
-- 		do
-- 		end

-- 	add_arm_action (a_command: COMMAND; argument: ANY) is
-- 		do
-- 		end

	remove_activate_action (a_command: COMMAND; argument: ANY) is
		do
		end

-- 	remove_release_action (a_command: COMMAND; argument: ANY) is
-- 		do
-- 		end

-- 	remove_arm_action (a_command: COMMAND; argument: ANY) is
-- 		do
-- 		end
	
	
	label: LABEL
			-- Label inside the button
	
	label_widget: POINTER is
		do
			Result := c_widget_of_label (label)
		end

end

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
