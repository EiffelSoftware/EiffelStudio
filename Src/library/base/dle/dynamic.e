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
--| EiffelBase: library of reusable components for ISE Eiffel.
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

