indexing
	description:
		"Comparators for `is_assertion_pass' on RESULT_RECORD"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
	date: "$Date$"
	revision: "$Revision$"

class PASSED_COMPARATOR inherit

	COMPARATOR
		rename
			is_true as is_assertion_pass
		redefine
			callback
		end

create

	make
	
feature -- Status report

	is_assertion_pass (n: INTEGER): BOOLEAN is
			-- Is assertion `n' a pass?
		do
			Result := callback.is_assertion_pass (n)
		end

feature {NONE} -- Implementation

	callback: CASE_RESULT_RECORD [ASSERTION_RESULT]
			-- Reference to callback object


end -- class PASSED_COMPARATOR

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
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
