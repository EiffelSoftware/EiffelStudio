indexing
	description:
		"Comparators for characters"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	COMPARATOR

feature -- Access

	character_set: STRING is
			-- Character set represented by comparator
		deferred
		end

	contains (c: CHARACTER): BOOLEAN is
			-- Does comparator contain `c'?
		deferred
		end
	
invariant

	no_empty_comparator: character_set /= Void and then not character_set.empty

end -- class COMPARATOR

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1086-2001 Interactive Software Engineering Inc.
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


