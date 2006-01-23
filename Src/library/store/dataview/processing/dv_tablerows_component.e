indexing
	description: "Objects that ask user to select%
			%a database table row from a set through%
			%class DV_TABLEROWS_NAVIGATOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DV_TABLEROWS_COMPONENT

inherit
	DV_COMPONENT

feature -- Basic operations

	set_db_tablerow_navigator (db_tr_navigator: DV_TABLEROWS_NAVIGATOR) is
			-- Set `db_tr_navigator' to component enabling to navigate among
			-- retrieved database table rows.
		require
			not_void: db_tr_navigator /= Void
			not_activated: not is_activated
		do
			db_tablerow_navigator := db_tr_navigator
			db_tablerow_navigator.set_table_component (Current)
		end

feature {DV_COMPONENT} -- Access

	selected_tablerows: ARRAYED_LIST [DB_TABLE] is
			-- Base for database table row selection.
		require
			is_activated: is_activated
		deferred
		ensure
			result_not_void: Result /= Void
		end

	No_selection: INTEGER is 0
			-- No selection in the database table row list.

	table_description: DB_TABLE_DESCRIPTION is
			-- Description of table represented by component.
		deferred
		end

feature {DV_COMPONENT} -- Basic operations

	change_selection (position: INTEGER) is
			-- Select `tablerow_set' element at `position'.
			-- Remove any selection if `position' = `No_selection'.
		require
			is_activated: is_activated
			valid_position: position = No_selection or else selected_tablerows.valid_index (position)
		do
			if selected_tablerows.index /= position then
				selected_tablerows.go_i_th (position)
				update_controls_sensitiveness
			end
		end

feature {NONE} -- Implementation

	db_tablerow_navigator: DV_TABLEROWS_NAVIGATOR
			-- Component enabling user to browse selected database table rows.

	update_controls_sensitiveness is
			-- Update controls sensitiveness.
		require
			is_activated: is_activated
		deferred
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





end -- class DV_TABLEROWS_COMPONENT


