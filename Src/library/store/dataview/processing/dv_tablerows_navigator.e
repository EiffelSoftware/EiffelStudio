indexing
	description: "Objects that enable to navigate among a list %
			%of database table rows."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DV_TABLEROWS_NAVIGATOR

inherit
	DV_COMPONENT

feature {DV_COMPONENT} -- Basic operations

	set_table_component (selectable_comp: DV_TABLEROWS_COMPONENT) is
			-- Set `selectable_comp' to `db_selectable_component'.
		require
			not_activated: not is_activated
			not_void: selectable_comp /= Void
		do
			db_selectable_component := selectable_comp
		end

	reactivate is
			-- Reset component and reactivate it from `db_selectable_component'.
		require
			can_be_activated: can_be_activated
		deferred
		ensure
			is_activated: is_activated
		end

	refresh is
			-- Refresh table row set display
			-- from `db_selectable_component'.
		require
			is_activated: is_activated
		deferred
		end

feature {NONE} -- Implementation

	db_selectable_component: DV_TABLEROWS_COMPONENT;
			-- Display of current database table row.

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_TABLEROWS_NAVIGATOR


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

