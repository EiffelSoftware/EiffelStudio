indexing
	description: 
		"Input field for a single line of `text'."
	appearance:
		"+-------------+%N%
		%| 'text'      |%N%
		%+-------------+"
	status: "See notice at end of class"
	keywords: "input, text, field, query"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_TEXT_FIELD

inherit
	EV_TEXT_COMPONENT
		redefine
			implementation
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES
		redefine
			implementation
		end

create
	default_create,
	make_with_text

feature -- Access

	capacity: INTEGER is
			-- Number of characters field can hold.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.capacity
		end

feature -- Element change

	set_capacity (a_capacity: INTEGER) is
			-- Assign `a_capacity' to `capacity'.
		require
			not_destroyed: not is_destroyed
			a_capacity_not_negative: a_capacity >= 0
		do
			implementation.set_capacity (a_capacity)
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_TEXT_FIELD_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TEXT_FIELD_IMP} implementation.make (Current)
		end
			
invariant
	capacity_not_negative: capacity >= 0

end -- class EV_TEXT_FIELD

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

