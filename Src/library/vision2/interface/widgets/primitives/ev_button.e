indexing

	description: 
	"EiffelVision button. Basic GUI push button. This is also a% 
	%base class for other buttons classes"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_BUTTON

inherit

	EV_BAR_ITEM
		redefine
			make, implementation
		end
	
	EV_TEXT_CONTAINER
		redefine
			make, implementation
		end

creation
	
	make
	
feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a push button with, `par' as
                        -- parent
		do
			!EV_BUTTON_IMP!implementation.make (par)
			widget_make (par)
		end
	

feature -- Access

--	pixmap: PIXMAP
			-- Pixmap inside button
	
feature -- Status setting
	
	
	
feature {NONE} -- Implementation

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



