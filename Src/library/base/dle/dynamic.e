indexing

	description:
		"Instances of dynamically loadable classes";

	keywords: "Dynamic Linking in Eiffel";
	product: DLE;
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DYNAMIC creation

	make

feature -- Initialization

	make (argument: ANY) is
			-- Creation procedure.
		do
		end;

feature -- Dynamic features

	apply (feat: DYNAMIC_FEATURE) is
			-- Apply feature represented by `feat' to current object,
			-- using the arguments specified earlier for `feat'.
			-- If `feat' represents a query. make the result accessible
			-- through `feat.e_result'.
		require
			feature_description_exists: feat /= Void
		do
		end;

end -- class DYNAMIC


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
