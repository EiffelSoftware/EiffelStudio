indexing
	description: 
		"EiffelVision fixed. Invisible container that allows unlimited number of other widgets to be put inside it. The location of each widget inside is specified by the coordinates of the widget."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_FIXED

inherit
	EV_INVISIBLE_CONTAINER
		redefine
			make,
			implementation,
			manager
		end
	
creation
	make
	
feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a fixed widget with, `par' as
			-- parent
		do
			!EV_FIXED_IMP!implementation.make
			widget_make (par)
		end

feature -- Access
	
	manager: BOOLEAN is 
			-- Does the container manage its children?
		do
			Result := False
		end
	
feature {NONE} -- Implementation
	
	implementation: EV_FIXED_I
			
end -- class EV_FIXED

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
