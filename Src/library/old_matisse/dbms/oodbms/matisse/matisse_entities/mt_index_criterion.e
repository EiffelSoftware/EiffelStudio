class MT_INDEX_CRITERION 

inherit

	MATISSE_CONST

feature -- Status Report

	type : INTEGER is  
		-- The type of the index creterion
		-- Do nothing
		do
		end -- type

	size : INTEGER is
		-- The size of the criterion as described in the meta-schema
		-- Do nothing
		do
		end -- size

	ordering : INTEGER is
		-- Ordering of the indexation for the criterion as described in the meta-schema
		-- Do nothing
		do
		ensure
			ascend_or_descend : Result = Mtascend or else Result = Mtdescend
		end -- ordering

feature {NONE} -- Implementation

	icid : INTEGER -- Identifier in database

end -- class MT_INDEX_CRITERION

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
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

