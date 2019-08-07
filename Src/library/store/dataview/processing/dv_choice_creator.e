note
	description: "Objects that enable to create a%
			% database table row and let user%
			% select foreign keys of new row."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make
			-- Initialize.
		do
			create fkey_table.make (0)
			create db_searcher.make
			create calling_fkey_value
		end

feature -- Status report

	can_be_activated: BOOLEAN
			-- Can the component be activated?
		do
			Result := Precursor and then
				control /= Void and then
				db_tablerow_selector /= Void
		end

	control_set: BOOLEAN
			-- Has a controller for creation been set?
		do
			Result := control /= Void
		end

	is_activated: BOOLEAN
			-- Is component activated?

feature -- Basic operations

	set_control (ctrl: DV_SENSITIVE_CONTROL)
			-- Set control to trigger the creation to `ctrl'.
		require
			not_activated: not is_activated
			control_not_void: ctrl /= Void
		do
			control := ctrl
			ctrl.set_action (agent ask_for_creation)
		ensure
			control_set: control_set
		end

	set_tablerow_selector (tr_selector: DV_TABLEROW_ID_PROVIDER)
			-- Set associated component to select foreign key values.
		require
			not_activated: not is_activated
			component_not_void: tr_selector /= Void
		do
			tr_selector.set_db_creator (Current)
			db_tablerow_selector := tr_selector
		end

feature {DV_COMPONENT} -- Basic operations

	activate
			-- Activate component.
		do
			if attached db_table_component as l_comp then
				if l_comp.is_dependent and then attached l_comp.parent as l_parent and then attached l_parent.table_description as l_descr then
					calling_table_code := l_descr.Table_code
				end
				if attached db_tablerow_selector as l_selector then
					l_selector.activate
				end
				is_activated := True
			end
		end

	set_table_component (table_comp: DV_TABLE_COMPONENT)
			-- Set associated table component.
		local
			td: detachable DB_TABLE_DESCRIPTION
		do
			Precursor (table_comp)
			td := table_comp.table_description
			db_searcher.set_behavior_type (db_searcher.Id_selection)
			check td /= Void then
				db_searcher.set_table_code (td.Table_code)
			end
			db_searcher.set_user_component (table_comp)
			db_searcher.activate
			fkey_table := td.to_create_fkey_from_table
		end

	enable_sensitive
			-- Enable creation.
		do
			if attached control as l_ctrl then
				l_ctrl.enable_sensitive
			end
		end

	disable_sensitive
			-- Disable creation.
		do
			if attached control as l_ctrl then
				l_ctrl.disable_sensitive
			end
		end

	refresh: ARRAYED_LIST [DB_TABLE]
			-- Refresh selection showing created table row.
		do
			Result := db_searcher.refresh
		end

	add_foreign_key_value (value: ANY)
			-- Add `value' to field constrained by current foreign key
			-- in `'.
		require
			is_activated: is_activated
			not_void: value /= Void
		do
			if attached tablerow_to_create as l_table then
				l_table.table_description.set_attribute (fkey_table.item_for_iteration, value)
			end
			fkey_table.forth
			request_foreign_key_value
		end

feature {NONE} -- Implementation

	ask_for_creation
			-- Create a tablerow (eventually
			-- ask user before).
		require
			is_activated: is_activated
		do
			if attached db_table_component as l_comp then
				if attached tablerow_to_create as l_table then
					l_table.set_default
				elseif attached l_comp.table_description as l_descr then
					tablerow_to_create := tables.obj (l_descr.Table_code)
				end
				fkey_table.start
				request_foreign_key_value
			end
		end

 	request_foreign_key_value
 			-- Request a value for next foreign key attribute in table row to
 			-- create or create the table ro if all foreign key values are set.
		require
			is_activated: is_activated
 		do
 			if attached db_table_component as l_comp and attached calling_fkey_value as l_calling_fkey_value then
	 			if not fkey_table.after then
	 				if fkey_table.key_for_iteration = calling_table_code then
	 					add_foreign_key_value (l_calling_fkey_value)
	 				elseif attached db_tablerow_selector as l_selector then
	 					l_selector.select_from_table (fkey_table.key_for_iteration)
	 				end
	 			elseif attached l_comp.confirmation_handler as l_conf_handler and attached l_comp.table_description as l_descr then
					l_conf_handler.call ([creation_confirmation
							(l_descr.Table_name), agent create_tablerow])
	 			end
	 		end
 		end

 	create_tablerow
 			-- Actually create the table row with information
 			-- contained in `tablerow_to_create'.
 		require
			is_activated: is_activated
		local
 			db_handler: ABSTRACT_DB_TABLE_MANAGER
 		do
 			if attached tablerow_to_create as l_table and attached db_table_component as l_comp then
	 			db_handler := l_comp.database_handler
	 			db_handler.set_id_and_create_tablerow (l_table)
				if db_handler.has_error then
					if attached l_comp.warning_handler as l_warn_handler then
						if attached db_handler.error_message as l_msg then
							l_warn_handler.call ([l_msg])
						else
							l_warn_handler.call (["Unknown error"])
						end
					end
				else
					if attached l_comp.status_handler as l_handler and then attached l_comp.table_description as l_descr then
						l_handler.call ([creation_done (l_descr.Table_name)])
					end
					if l_comp.is_dependent then
						l_comp.refresh_from_database
					else
						db_searcher.read_from_tablerow (l_table)
						l_comp.set_just_created
					end
	 			end
	 		end
 		end

	control: detachable DV_SENSITIVE_CONTROL
			-- Control to trigger creation.

	db_searcher: DV_TYPED_SEARCHER
			-- Component retrieving created table row from database.

	fkey_table: HASH_TABLE [INTEGER, INTEGER]
			-- Table containing table foreign keys and
			-- associated tables.

	db_tablerow_selector: detachable DV_TABLEROW_ID_PROVIDER
			-- Component asking the user for a database table row.

	tablerow_to_create: detachable DB_TABLE
			-- Table row describing the table row to create in the
			-- database.

	calling_table_code: INTEGER;
			-- Code of calling table. Associated foreign key value must be
			-- calling component current table row ID.

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"





end -- class DV_CHOICE_CREATOR


