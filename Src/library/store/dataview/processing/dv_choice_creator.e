indexing
	description: "Objects that enable to create a%
			% database table row and let user%
			% select foreign keys of new row."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_CHOICE_CREATOR

inherit
	DV_CREATOR
		redefine
			can_be_activated,
			set_table_component
		end

	DB_TABLES_ACCESS_USE

	DV_MESSAGES

create
	make

feature -- Initialization

	make is
			-- Initialize.
		do
		end

feature -- Status report

	can_be_activated: BOOLEAN is
			-- Can the component be activated?
		do
			Result := Precursor and then
				control /= Void and then
				db_tablerow_selector /= Void
		end

	control_set: BOOLEAN is
			-- Has a controller for creation been set?
		do
			Result := control /= Void
		end

	is_activated: BOOLEAN
			-- Is component activated?

feature -- Basic operations

	set_control (ctrl: DV_SENSITIVE_CONTROL) is
			-- Set control to trigger the creation to `ctrl'.
		require
			not_activated: not is_activated
			control_not_void: ctrl /= Void
		do
			control := ctrl
			control.set_action (~ask_for_creation)
		ensure
			control_set: control_set
		end

	set_tablerow_selector (tr_selector: DV_TABLEROW_ID_PROVIDER) is
			-- Set associated component to select foreign key values.
		require
			not_activated: not is_activated
			component_not_void: tr_selector /= Void
		do
			tr_selector.set_db_creator (Current)
			db_tablerow_selector := tr_selector
		end

feature {DV_COMPONENT} -- Basic operations

	activate is
			-- Activate component.
		do
			if db_table_component.is_dependent then
				calling_table_code := db_table_component.parent.table_description.Table_code
			end
			db_tablerow_selector.activate
			is_activated := True
		end

	set_table_component (table_comp: DV_TABLE_COMPONENT) is
			-- Set associated table component.
		local
			td: DB_TABLE_DESCRIPTION
		do
			Precursor (table_comp)
			td := table_comp.table_description
			create db_searcher.make
			db_searcher.set_behavior_type (db_searcher.Id_selection)
			db_searcher.set_table_code (td.Table_code)
			db_searcher.set_user_component (table_comp)
			db_searcher.activate
			fkey_table := td.to_create_fkey_from_table
		end

	enable_sensitive is
			-- Enable creation.
		do
			control.enable_sensitive
		end

	disable_sensitive is
			-- Disable creation.
		do
			control.disable_sensitive
		end

	refresh: ARRAYED_LIST [DB_TABLE] is
			-- Refresh selection showing created table row.
		do
			Result := db_searcher.refresh
		end

	add_foreign_key_value (value: ANY) is
			-- Add `value' to field constrained by current foreign key
			-- in `'.
		require
			is_activated: is_activated
			not_void: value /= Void
		do
			tablerow_to_create.table_description.set_attribute (fkey_table.item_for_iteration, value)
			fkey_table.forth
			request_foreign_key_value
		end

feature {NONE} -- Implementation

	ask_for_creation is
			-- Create a tablerow (eventually
			-- ask user before).
		require
			is_activated: is_activated
		do
			if tablerow_to_create = Void then
				tablerow_to_create := tables.obj (db_table_component.table_description.Table_code)
			else
				tablerow_to_create.set_default
			end
			fkey_table.start
			request_foreign_key_value
		end
 
 	request_foreign_key_value is
 			-- Request a value for next foreign key attribute in table row to
 			-- create or create the table ro if all foreign key values are set.
		require
			is_activated: is_activated
 		do
 			if not fkey_table.after then
 				if fkey_table.key_for_iteration = calling_table_code then
 					add_foreign_key_value (calling_fkey_value)
 				else
 					db_tablerow_selector.select_from_table (fkey_table.key_for_iteration)
 				end
 			else
				db_table_component.confirmation_handler.call ([creation_confirmation 
						(db_table_component.table_description.Table_name), ~create_tablerow])
 			end
 		end
 
 	create_tablerow is
 			-- Actually create the table row with information
 			-- contained in `tablerow_to_create'.
 		require
			is_activated: is_activated
		local
 			db_handler: ABSTRACT_DB_TABLE_MANAGER
 		do
 			db_handler := db_table_component.database_handler
 			db_handler.set_id_and_create_tablerow (tablerow_to_create)
			if db_handler.has_error then
				db_table_component.warning_handler.call ([db_handler.error_message])
			else
				db_table_component.status_handler.call ([creation_done (db_table_component.table_description.Table_name)])
				if db_table_component.is_dependent then
					db_table_component.refresh_from_database
				else
					db_searcher.read_from_tablerow (tablerow_to_create)
					db_table_component.set_just_created
				end
 			end
 		end
 
	control: DV_SENSITIVE_CONTROL
			-- Control to trigger creation.

	db_searcher: DV_TYPED_SEARCHER
			-- Component retrieving created table row from database.

	fkey_table: HASH_TABLE [INTEGER, INTEGER]
			-- Table containing table foreign keys and
			-- associated tables.
	
	db_tablerow_selector: DV_TABLEROW_ID_PROVIDER
			-- Component asking the user for a database table row.

	tablerow_to_create: DB_TABLE
			-- Table row describing the table row to create in the
			-- database.

	calling_table_code: INTEGER;
			-- Code of calling table. Associated foreign key value must be
			-- calling component current table row ID.

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
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_CHOICE_CREATOR
