indexing

	description:
		"Queues (first-in, first-out dispensers), without commitment %
		%to a particular representation";

	status: "See notice at end of class";
	names: queue, dispenser;
	access: fixed, fifo, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class QUEUE [G] inherit

	DISPENSER [G]
		export
			{NONE} prune, prune_all
		end

feature -- Element change

	 force (v: like item) is
			-- Add `v' as newest item.
		deferred
		end;

end -- class QUEUE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
