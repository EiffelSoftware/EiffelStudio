indexing
	description: "Objects that enable to retrieve foreign key values for table row %
		%creation. Foreign key values are selected dynamically by user using %
		%a navigator."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_TABLEROW_ID_PROVIDER

inherit
	DV_TABLEROWS_COMPONENT

	DB_TABLES_ACCESS_USE

create
	make

feature -- Initialization

	make is
			-- Initialize.
		do
			create db_all_searcher.make
		end

feature -- Status report

	can_be_activated: BOOLEAN is
			-- Can the component be activated?
		do
			Result := db_creator /= Void and then
					selecting_control /= Void and then
					raise /= Void and then
					db_tablerow_navigator /= Void
		end

	is_activated: BOOLEAN
			-- Is the component activated?

feature -- Basic operations

	set_raising_action (raising_action: PROCEDURE [ANY, TUPLE]) is
			-- Set `raising_action' to raise navigation component to
			-- select table row.
		require
			not_activated: not is_activated
			action_not_void: raising_action /= Void
		do
			raise := raising_action
		end

	set_selecting_control (selecting_ctrl: DV_SENSITIVE_CONTROL) is
			-- Enable that component can
			-- select active table row.
		require
			not_activated: not is_activated
			not_void: selecting_ctrl /= Void
		do
			selecting_control := selecting_ctrl
			selecting_control.set_action (~ok)
		end

feature {DV_COMPONENT} -- Access

	table_description: DB_TABLE_DESCRIPTION
			-- Description of table represented by component.

	selected_tablerows: ARRAYED_LIST [DB_TABLE] is
			-- Base for database table row selection.
		do
			Result := tablerow_set
		end

feature {DV_COMPONENT} -- Basic operations

	set_db_creator (creator: DV_CHOICE_CREATOR) is
			-- Set `creator' as calling component.
		require
			not_activated: not is_activated
			component_not_void: creator /= Void
		do
			db_creator := creator
		end

	select_from_table (table_code: INTEGER) is
			-- Let user select a tablerow of table with
			-- `table_code'.
		require
			is_activated: is_activated
		do
			db_all_searcher.set_table_code (table_code)
			if not db_all_searcher.is_activated then
				db_all_searcher.activate
			end
			tablerow_set := db_all_searcher.refresh
			tablerow_set.start
			table_description := tables.description (table_code)
			db_tablerow_navigator.reactivate
			db_tablerow_navigator.refresh
			raise.call ([])
		end

	activate is
			-- Activate component.
		do
			db_all_searcher.set_user_component (db_creator.db_table_component)
			is_activated := True
		end
		
feature {NONE} -- Implementation

	tablerow_set: ARRAYED_LIST [DB_TABLE]
			-- Base for database table row selection.

	db_all_searcher: DV_TYPED_SEARCHER
			-- Component retrieving database table rows.

	db_creator: DV_CHOICE_CREATOR
			-- Creation component requesting table IDs. 

	selecting_control: DV_SENSITIVE_CONTROL
			-- Control to select a database table row.

	raise: PROCEDURE [ANY, TUPLE]
			-- Action to perform to raise the navigator.

	update_controls_sensitiveness is
			-- Update controls sensitiveness.
		do
			if tablerow_set.before then
				selecting_control.disable_sensitive
			else
				selecting_control.enable_sensitive
			end
		end
		
	ok is
			-- Select current table row and transmit its ID to creation component.
		require
			valid_position: tablerow_set.valid_index (tablerow_set.index)
		do
			db_creator.add_foreign_key_value (tablerow_set.item.table_description.id)
		end

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

end -- class DV_TABLEROW_ID_PROVIDER
