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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

