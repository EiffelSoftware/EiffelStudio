indexing

	description:
		"Tables whose keys are integers or equivalent";

	status: "See notice at end of class";
	names: indexable, access;
	access: index, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class INDEXABLE [G, H -> INTEGER] inherit

	TABLE [G, H]
		rename
			valid_key as valid_index
		redefine
			put
		end

feature -- Element change

	put (v: G; k: H) is
			-- Associate value `v' with key `k'.
		deferred
		ensure then
			insertion_done: item (k) = v
		end;

end -- class INDEXABLE


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
