indexing
	description:
		"Test containers implemented as arrayed lists"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class ARRAYED_TEST_CONTAINER inherit

	TEST_CONTAINER
		undefine
			copy, is_equal
		end
	
	ARRAYED_ADAPTER [TESTABLE]
		rename
			count as test_count, item as selected_test, i_th as test,
			valid_index as valid_test_index, go_i_th as select_test
		export
			{NONE} all
		redefine
			extend, replace, remove
		end

feature -- Element change

	extend (v: TESTABLE) is
			-- At `v' to end.
		do
			v.set_number (test_count + 1)
			if has_standard_output then 
				v.set_standard_output (standard_output)
			end
			Precursor (v)
		ensure then
			number_correct: v.number = test_count
		end

	replace (v: TESTABLE; i: INTEGER) is
			-- Replace `i'-th item with `v'.
		do
			v.set_number (i)
			if has_standard_output then 
				v.set_standard_output (standard_output)
			end
			Precursor (v, i)
		ensure then
			number_correct: v.number = i
		end

feature -- Removal

	remove (i: INTEGER) is
			-- Remove `i'-th item.
		local
			old_idx: INTEGER
		do
			old_idx := index
			Precursor (i)
			from 
				select_test (i) 
				selected_test.set_number (0)
				selected_test.set_standard_output (Void)
			until 
				after 
			loop
				selected_test.set_number (index)
				forth
			end
			select_test (old_idx)
		end

end -- class ARRAYED_TEST_CONTAINER

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
