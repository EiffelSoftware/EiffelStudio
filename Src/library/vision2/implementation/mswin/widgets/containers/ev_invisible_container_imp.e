indexing

	description: 
		"EiffelVision invisible container. Allow several children.%
	     % Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_INVISIBLE_CONTAINER_IMP
	
inherit
	
	EV_INVISIBLE_CONTAINER_I

	EV_CONTAINER_IMP
		undefine
			add_child_ok
		redefine
			wel_window,
			add_child,
			set_insensitive
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize the container by creating children
		do
			!! children.make
		end

feature {NONE} -- Access
	
	children: LINKED_LIST [EV_WIDGET_IMP]
			-- List of the children of the box

feature -- Implementation

	add_child (child_imp: EV_WIDGET_IMP) is
		do
			child := child_imp
			children.extend (child_imp)
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		do
			if not children.empty then
				from
					children.start
				until
					children.after
				loop
					children.item.set_insensitive (flag)
					children.forth
				end
			end
			Precursor (flag)
		end

feature -- Implementation

	wel_window: EV_WEL_CONTROL_WINDOW
		-- Actual WEL component

end -- class EV_INVISIBLE_CONTAINER_IMP

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
