indexing
	description: "[
		Objects that permit comparison of EV_MULTI_COLUMN_LIST_ROW based on
		`text' of a paticular item.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_ROW_STRING_COMPARATOR
	
inherit
	KL_PART_COMPARATOR [EV_MULTI_COLUMN_LIST_ROW]
	
feature -- Status Setting
	
	set_sort_column (a_column: INTEGER) is
			-- Use column `a_column' for search comparison.
		do
			sort_column := a_column
		end

feature -- Measurement

	less_than (u, v: EV_MULTI_COLUMN_LIST_ROW): BOOLEAN is
			-- Is `u' considered less than `v'?
		do
			Result := u.i_th (sort_column) < v.i_th (sort_column)
		end
		
feature -- Access

	sort_column: INTEGER
		-- Column on which sorting is performed.

end -- class MULTI_COLUMN_LIST_ROW_STRING_COMPARATOR