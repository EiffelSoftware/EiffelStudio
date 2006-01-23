indexing
	description: "Objects that enable to navigate among a list %
			%of database table rows."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_TABLEROWS_NAVIGATOR


