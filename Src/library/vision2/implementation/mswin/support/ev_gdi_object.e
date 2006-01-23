indexing
	description: 
		"EiffelVision implentation for retrieving a WEL_GDI_OBJECT"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_GDI_PEN

