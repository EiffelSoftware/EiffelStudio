indexing
	description: 
		"EiffelVision implentation for retrieving a WEL_GDI_OBJECT"
	status: "See notice at end of class"
	date: "$Date:"
	revision: "$Revision:"

deferred class
	EV_GDI_OBJECT

inherit
	HASHABLE
		undefine
			is_equal
		end

feature -- Access

	hash_code: INTEGER is
			-- Hash code value.
		deferred
		end

	computed_hash_code: INTEGER
			-- Actual hash code value.

	weight: INTEGER
			-- Number of times this pen has been used.
	
	age: INTEGER
			-- Date of last access to `Current'.

	item: WEL_GDI_ANY
			-- WEL GDI object.

	value: INTEGER is
			-- Weighted value for Current.
		do
			Result := weight * age
		end

feature -- Element change

	set_weight (a_weight: INTEGER) is
			-- Set `weight' to `a_weight'.
		do
			weight := a_weight
		end

	update (new_age: INTEGER) is
			-- increase `weight' and set `age' to `new_age'.
		do
			if weight < 2147483646 then
				weight := weight + 1
			end
			age := new_age
		end

	set_item (an_item: like item) is
			-- Set the item value to `an_item'
		do
			item := an_item
			item.increment_reference
		end

feature -- Removal

	delete is
			-- Delete `Current'.
		do
			item.decrement_reference
			item := Void
		end

end -- class EV_GDI_PEN

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.3  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.2  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.2  2000/10/24 15:27:25  pichery
--| Improved the cache system for caching GDI objects. It now
--| takes into account the date of the last access to the object.
--|
--| Revision 1.1.2.1  2000/10/16 14:27:35  pichery
--| Improved WEL_BRUSH and WEL_PEN caching
--|
--| Revision 1.3.2.2  2000/08/15 16:38:51  rogers
--| Removed fixme not_reviewed. Comments, Added copyright clause and CVS log.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

