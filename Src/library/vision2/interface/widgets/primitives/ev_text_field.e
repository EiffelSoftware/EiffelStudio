indexing

	description: 
	"EiffelVision text field. To query single line of text from the user"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_TEXT_FIELD

inherit

	EV_TEXT_COMPONENT
		redefine
			make, implementation
		end

	EV_BAR_ITEM
	
creation
	
	make
	
	
feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a text field with, `par' as
                        -- parent
		do
			!EV_TEXT_FIELD_IMP!implementation.make (par)
			widget_make (par)
		end
	

feature -- Event - command association
	
	add_activate_command ( command: EV_COMMAND; 
			       arguments: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be
			-- executed when the text field is activated
		require
			valid_command: command /= Void
		do
			implementation.add_activate_command ( command, 
							      arguments )
		end	

feature {NONE} -- Implementation

	implementation: EV_TEXT_FIELD_I
			-- Implementation 
			
end -- class EV_TEXT_AREA

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

