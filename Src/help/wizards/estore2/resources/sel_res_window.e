indexing
	description: "window popped up to show results of a select query"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	SEL_RES_WINDOW

inherit

	EV_TITLED_WINDOW

create
	make_window

feature -- Initialization

	make_window (appli: APPLICATION; result_list: LINKED_LIST [ANY]; row_titles: ARRAY [STRING]) is
			-- Initialize Current
		local
			v1: EV_VERTICAL_BOX
		do
			default_create
			set_height (300)
			set_width (300)
			create v1
			extend (v1)
			create multi_list
			multi_list.set_column_titles (row_titles)
			multi_list.disable_multiple_selection
			v1.extend (multi_list)
			
			fill_list (result_list, row_titles)
		end

	fill_list (li: LINKED_LIST [ANY]; titles: ARRAY [STRING]) is
			-- Fill the 'multi_list' with the features of objects of 'li' contained in 'titles'.
		require
			not_void: li /= Void and then titles /= Void
		local
			it: EV_MULTI_COLUMN_LIST_ROW
			qu: QUERYABLE
		do
			from
				li.start
			until
				li.after
			loop
				qu ?= li.item
				create it
				it.fill (qu.get_feature_values (titles))
				multi_list.extend (it)
				li.forth
			end
		end

	exit is
			-- Exit the window
		do
			destroy
		end

feature -- Implementation
		
	multi_list: EV_MULTI_COLUMN_LIST
		-- Display of the results

end -- class SEL_RES_WINDOW

--|----------------------------------------------------------------
--| Eiffel COOL:Jex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
