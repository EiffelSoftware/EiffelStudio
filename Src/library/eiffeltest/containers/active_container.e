indexing
	description:
		"Containers that have a current position"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
	date: "$Date$"
	revision: "$Revision$"

deferred class ACTIVE_CONTAINER [G] inherit

	BASIC_CONTAINER [G]

feature -- Access

	item: G is
			-- Current item
		require
			not_empty: not empty
		deferred
		ensure
			non_void_result: Result /= Void
		end

	i_th (i: INTEGER): G is
			-- `i'-th item
		require
			not_empty: not empty
			valid_index: valid_index (i)
		deferred
		ensure
			index_unchanged: index = old index
		end

	index: INTEGER is
			-- Current index
		deferred
		end
	
feature -- Status setting

	go_i_th (i: INTEGER) is
			-- Go to `i'-th position.
		require
			not_empty: not empty
			valid_index: valid_index (i)
		deferred
		ensure
			index_set: index = i
		end

invariant

	index_in_range: not empty implies valid_index (index)

end -- class ACTIVE_CONTAINER

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
