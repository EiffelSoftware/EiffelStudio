
indexing

	description:
		"Priority queues, without commitment to a particular representation";

	status: "See notice at end of class";
	names: priority_queue, dispenser;
	access: fixed, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class PRIORITY_QUEUE [G -> PART_COMPARABLE] inherit

	DISPENSER [G]

end -- class PRIORITY_QUEUE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
