indexing

	description:
		"Tables whose keys are integers or equivalent";

	copyright: "See notice at end of class";
	names: indexable, access;
	access: index, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class INDEXABLE [G, H -> INTEGER] inherit

	TABLE [G, H]
		rename
			valid_key as valid_index
		end

end -- class INDEXABLE


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
