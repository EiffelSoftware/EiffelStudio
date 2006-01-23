indexing
	description:
		"Test containers implemented as arrayed lists"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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




end -- class ARRAYED_TEST_CONTAINER

