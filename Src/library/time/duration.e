indexing 
	description: "Temporal intervals"
	legal: "See notice at end of class."
	status: "See notice at end of class." 
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
			Result := deep_twin
		end

	infix "-" (other: like Current): like Current is
			-- Difference with `other'
		do
			Result := Current + -other
		end
		
invariant

	sign_correctness: is_positive xor is_negative xor is_zero

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




end -- class DURATION


