indexing

	description:
		"Queues (first-in, first-out dispensers), without commitment %
		%to a particular representation";

	copyright: "See notice at end of class";
	names: queue, dispenser;
	access: fixed, fifo, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class QUEUE [G] inherit

	DISPENSER [G]

feature

	extend, force, put (v: like item) is
			-- Add `v' as newest element.
		deferred
		end;

end -- class QUEUE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
