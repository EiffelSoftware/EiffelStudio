indexing
	description: "EiffelVision button. Basic GUI push button.%
		% This is also a base class for other buttons classes"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_BUTTON

inherit
	EV_PRIMITIVE
		redefine
			make, implementation
		end
		
	EV_BAR_ITEM
		redefine
			implementation
		end
	
	EV_TEXTABLE
		redefine
			implementation, make
		end

	EV_PIXMAPABLE
		redefine
			implementation
		end

	EV_FONTABLE
		redefine
			implementation
		end

creation
	make,
	make_with_text
	
feature {NONE} -- Initialization
	
 	make (par: EV_CONTAINER) is
 		-- Empty button
		do
 			!EV_BUTTON_IMP!implementation.make (par)
 			widget_make (par)
 		end
	
	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Button with 'par' as parent and 'txt' as 
			-- text label
		do
			!EV_BUTTON_IMP!implementation.make_with_text (par, txt)
			widget_make (par)
		end
	
feature -- Event - command association
	
	add_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed
			-- the button is pressed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_click_command (cmd, arg)
		end	

feature -- Event -- removing command association

	remove_click_commands is	
			-- Empty the list of commands to be executed when
			-- the button is pressed.
		require
			exists: not destroyed
		do
			implementation.remove_click_commands
		end

feature {EV_PIXMAP_CONTAINER_IMP} -- Implementation

	implementation: EV_BUTTON_I
			-- Implementation of button
	
end -- class EV_BUTTON

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
