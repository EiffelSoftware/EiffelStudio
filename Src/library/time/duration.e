indexing 
	description: "Temporal intervals"
	status: "See notice at end of class" 
	date: "$Date$" 
	revision: "$Revision$" 
 
deferred class DURATION inherit

	PART_COMPARABLE

	GROUP_ELEMENT
		undefine
			is_equal
		end

feature -- Status report

	is_positive: BOOLEAN is
			-- Is duration positive?
		deferred
		end
	 
	is_negative: BOOLEAN is
			-- Is duration negative?
		do
			Result := not is_positive and not is_zero
		end

	is_zero: BOOLEAN is
			-- Is duration zero?
		do
			Result := equal (Current, zero)
		end
		
feature -- Element change

	prefix "+": like Current is
			-- Unary plus
		do
			Result := deep_clone (Current)
		end

	infix "-" (other: like Current): like Current is
			-- Difference with `other'
		do
			Result := Current + -other
		end
		
invariant

	sign_correctness: is_positive xor is_negative xor is_zero

end -- class DURATION

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
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


