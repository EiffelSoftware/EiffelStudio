indexing	
	description: 
		"EiffelVision base item, implementation interface"
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_ITEM_I

inherit
	EV_ANY_I

feature -- Access

	parent_widget: EV_WIDGET is
			-- Parent widget of the current item
		require
			exists: not destroyed
		deferred
		end

	parent_imp: EV_ANY_I is
			-- The parent of the Current widget
			-- Can be void.
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_parent (par: EV_ANY) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		require
			exists: not destroyed
		deferred
		ensure
			parent_set: parent_set (par)
		end

feature -- Assertion

	parent_set (par: EV_ANY): BOOLEAN is
			-- Is the parent set
		do
			if parent_imp /= Void then
				Result := parent_imp.interface = par
			else
				Result := par = Void
			end				
		end

end -- class EV_ITEM_I

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
