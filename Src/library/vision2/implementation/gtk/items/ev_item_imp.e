indexing
	description: "EiffelVision item, gtk implementation";
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_ITEM_IMP

inherit
	EV_ITEM_I

	EV_TEXT_CONTAINER_IMP
		rename
			-- We want to maintain the name make_with_text
			-- although the signature is different
			make as old_make,
			make_with_text as old_make_with_text
		end

	EV_WIDGET_IMP
			-- Inheriting from widget,
			-- because items are widget in gtk
		rename
			make as old_make
		end

feature {NONE} -- Implementation
	
	set_label_widget (new_label_widget: POINTER) is
		do
			check
				do_not_call: False
			end
		end
	
        label_widget: POINTER is
                        -- gtk widget of the label inside the button
                do
                        Result := c_gtk_get_label_widget (widget)
		end
	
feature -- Event : command association

	add_activate_command ( command: EV_COMMAND; 
			       arguments: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be
			-- executed when the menu item is activated
		do
			add_command ( "activate", command,  arguments )
		end	

end -- class EV_ITEM_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

