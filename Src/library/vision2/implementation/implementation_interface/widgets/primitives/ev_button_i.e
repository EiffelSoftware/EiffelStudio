indexing

	description: "General button implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	EV_BUTTON_I 

inherit

	EV_PRIMITIVE_I

	EV_BAR_ITEM_I

	EV_TEXT_CONTAINER_I

	EV_FONTABLE_I

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
 			-- Empty button
		deferred
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a push button implementation.
		deferred
        end	

feature -- Event - command association
	
	add_click_command ( command: EV_COMMAND; 
			    arguments: EV_ARGUMENTS) is	
		deferred
		end
	
end -- class EV_BUTTON_I


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

