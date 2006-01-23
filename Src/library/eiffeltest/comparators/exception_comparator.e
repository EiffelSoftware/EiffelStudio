indexing
	description:
		"Comparators for `is_assertion_exception' on RESULT_RECORD"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXCEPTION_COMPARATOR inherit

	COMPARATOR
		rename
			is_true as is_assertion_exception
		redefine
			callback
		end

create

	make
	
feature -- Status report

	is_assertion_exception (n: INTEGER): BOOLEAN is
			-- Is assertion `n' an exception?
		do
			Result := callback.is_assertion_exception (n)
		end

feature {NONE} -- Implementation

	callback: CASE_RESULT_RECORD [ASSERTION_RESULT];
			-- Reference to callback object


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




end -- class EXCEPTION_COMPARATOR

