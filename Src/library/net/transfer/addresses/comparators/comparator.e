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

	no_empty_comparator: character_set /= Void and then 
			not character_set.is_empty

end -- class COMPARATOR

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

