indexing

	description: "Element for a scrollable list";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SCROLLABLE_LIST_ELEMENT

feature -- Access

	value: STRING is
			-- String to appear in scrollable list box
		deferred
		end

invariant

	value_not_void: value /= Void

end -- class SCROLLABLE_LIST_ELEMENT



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

