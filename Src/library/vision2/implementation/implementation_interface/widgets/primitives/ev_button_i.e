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

	EV_TEXTABLE_I

	EV_PIXMAPABLE_I
		redefine
			pixmap_size_ok
		end

	EV_FONTABLE_I

feature {NONE} -- Initialization

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a widget with `par' as parent and `txt'
			-- as text.
		require
			valid_parent: is_valid (par)
			valid_string: txt /= Void
		deferred
        end	

feature -- Event - command association
	
	add_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add 'cmd' to the list of commands to be executed
			-- the button is pressed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature {EV_PIXMAP} -- Implementation

	pixmap_size_ok (pixmap: EV_PIXMAP): BOOLEAN is
			-- Check if the size of the pixmap is ok for
			-- the container.
		do
			Result := True
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

