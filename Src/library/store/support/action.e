indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class ACTION

feature -- Basic operations

	start is
			-- Execute something whenever 
			-- routine `load_result' of DB_SELECTION is
			-- called with Current set as `stop_condition',
			-- before iterating on query result.
			-- (Default: do nothing)
		do
		end

	execute is
			-- Execute something whenever 
			-- routine `load_result' of DB_SELECTION is
			-- called with Current set as `stop_condition',
			-- before iterating on query result.
			-- (Default: do nothing)
		do
		end

	found: BOOLEAN is
			-- Is there any exit condition found
			-- while iterating on selection results in
			-- `load_result' of DB_SELECTION?
			-- (Default: do nothing)
		do
		end

feature -- Obsolete

	init is obsolete "Use ``start''"
		do
			start
		end

	status: BOOLEAN is obsolete "Use ``found''"
		do
			Result := found
		end

end -- class ACTION



--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
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

