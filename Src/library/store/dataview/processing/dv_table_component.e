indexing
	description: "Objects that represents a database table row%
			%set and its graphical display."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_TABLE_COMPONENT

inherit
	DV_DATABASE_HANDLE

	DV_TABLEROWS_COMPONENT
		redefine
			change_selection
		end

	DB_TABLES_ACCESS_USE

	DV_MESSAGES

create
	make

feature -- Initialization

	make is
			-- Initialize.
		do
			create necessary_table_list.make (0)
			create dependent_table_list.make (0)
			create subsearcher_list.make (0)
			create tablerow_set.make (0)
		end

feature -- Access

	table_description: DB_TABLE_DESCRIPTION
			-- Description of table represented by component.

	selected_tablerows: ARRAYED_LIST [DB_TABLE] is
			-- Last selected table row set.
		do
			Result := tablerow_set
		end
		
	selected_tablerow: DB_TABLE is
			-- Currently selected table row.
		do
			Result := tablerow_set.item
		end
		
feature -- Status report

	can_be_activated: BOOLEAN is
			-- Can component be activated?
		do
			Result := database_handler_set and then table_description /= Void
		end

	is_activated: BOOLEAN
			-- Is component activated?

	is_necessary_tablecode (code: INTEGER): BOOLEAN is
			-- Does `code' correspond to a necessary
			-- table for represented table?
		do
			Result := table_description.to_create_fkey_from_table.has (code)
		end

	is_dependent_tablecode (code: INTEGER): BOOLEAN is
			-- Does `code' correspond to a dependent
			-- table on represented table?
		do
			Result := table_description.to_delete_fkey_from_table.has (code)
		end

	is_writing: BOOLEAN is
			-- Can the component write the database?
		do
			Result := writing_control /= Void
		end

	is_refreshing: BOOLEAN is
			-- Can the component refresh display from the database?
		do
			Result := refreshing_control /= Void
		end

	is_creating: BOOLEAN is
			-- Can the component create elements
			-- in the database?
		do
			Result := db_creator /= Void
		end

	is_deleting: BOOLEAN is
			-- Can the component delete elements
			-- in the database?
		do
			Result := deleting_control /= Void
		end

	is_subcomponent: BOOLEAN is
			-- Is this component determined by a calling
			-- component?
		do
			Result := is_dependent or else is_necessary
		end

	is_topcomponent: BOOLEAN is
			-- Is this component not determined by any calling
			-- component?
		do
			Result := not is_subcomponent
		end

	is_necessary: BOOLEAN
			-- Is this subcomponent table necessary for
			-- calling component table?

	is_dependent: BOOLEAN
			-- Is this subcomponent table dependent on
			-- calling component table?

	db_searcher_set: BOOLEAN is
			-- Is a component to search table rows set?
		do
			Result := db_searcher /= Void
		end

	status_handler_set: BOOLEAN is
			-- Is a status information handler set?
		do
			Result := status_handler /= Void
		end

	warning_handler_set: BOOLEAN is
			-- Is a warning handler set?
		do
			Result := warning_handler /= Void
		end

	confirmation_handler_set: BOOLEAN is
			-- Is a confirmation handler set?
		do
			Result := confirmation_handler /= Void
		end

	table_corresponds (tr_list: ARRAYED_LIST [DB_TABLE]): BOOLEAN is
			-- Does type of `tr_list' elements corresponds to represented
			-- table?
			--| Warning: verification is only done on first element.
		require
			not_void: tr_list /= Void
		do
			if not tr_list.is_empty then
				Result := tr_list.first.table_description.Table_code = table_description.Table_code
			else
				Result := True
			end
		end
	
feature -- Status setting

	set_writing_control (writing_ctrl: DV_SENSITIVE_CONTROL) is
			-- Enable that component can
			-- write the database.
		require
			not_void: writing_ctrl /= Void
			not_activated: not is_activated
		do
			writing_control := writing_ctrl
			writing_control.set_action (~write)
			writing_control.disable_sensitive
		ensure
			is_writing: is_writing
		end

	set_refreshing_control (refreshing_ctrl: DV_SENSITIVE_CONTROL) is
			-- Enable that component can
			-- write the database.
		require
			not_void: refreshing_ctrl /= Void
			not_activated: not is_activated
		do
			refreshing_control := refreshing_ctrl
			refreshing_control.set_action (~refresh_from_database)
			refreshing_control.disable_sensitive
		ensure
			is_refreshing: is_refreshing
		end

	set_db_creator (creator: DV_CREATOR) is
			-- Enable that component can create
			-- elements in the database.
		require
			not_void: creator /= Void
			not_activated: not is_activated
		do
			db_creator := creator
			db_creator.set_table_component (Current)
		ensure
			is_creating: is_creating
		end

	set_deleting_control (deleting_ctrl: DV_SENSITIVE_CONTROL) is
			-- Enable that component can
			-- write the database.
		require
			not_void: deleting_ctrl /= Void
			not_activated: not is_activated
		do
			deleting_control := deleting_ctrl
			deleting_control.set_action (~delete_after_confirmation)
			deleting_control.disable_sensitive
		ensure
			is_deleting: is_deleting
		end

feature -- Basic operations

	set_warning_handler (w_handler: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Set `w_handler' to `warning_handler'
		require
			not_activated: not is_activated
			not_void: w_handler /= Void
		do
			warning_handler := w_handler
		end

	set_status_handler (s_handler: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Set `s_handler' to `status_handler'
		require
			not_activated: not is_activated
			not_void: s_handler /= Void
		do
			status_handler := s_handler
		end

	set_confirmation_handler (c_handler: PROCEDURE [ANY, TUPLE [STRING, PROCEDURE [ANY, TUPLE]]]) is
			-- Set `c_handler' to `confirmation_handler'
		require
			not_activated: not is_activated
			not_void: c_handler /= Void
		do
			confirmation_handler := c_handler
		end

	set_tablecode (tablecode: INTEGER) is
			-- Initialize with `fields_set_comp' to display
			-- current selection.
		require
			not_activated: not is_activated
		do
			table_description := tables.description (tablecode)
		end

	add_necessary_table (comp: DV_TABLE_COMPONENT) is
			-- Add a subcomponent representing a necessary
			-- table for represented table.
		require
			is_necessary_table: is_necessary_tablecode (comp.table_description.Table_code)
			no_db_searcher_set: not comp.db_searcher_set
			not_activated: not is_activated
		local
			db_srcher: DV_TYPED_SEARCHER
			td: DB_TABLE_DESCRIPTION
		do
			comp.enable_necessary (Current)
			necessary_table_list.extend (comp)
			create db_srcher.make
			db_srcher.set_behavior_type (db_srcher.Qualified_selection)
			td := comp.table_description
			db_srcher.set_criterion (td.Id_code)
			db_srcher.set_table_code (td.Table_code)
			db_srcher.set_row_attribute_code (table_description.to_create_fkey_from_table.item (td.Table_code))
			subsearcher_list.extend (db_srcher)
			comp.set_db_searcher (db_srcher)
		end

	add_dependent_table (comp: DV_TABLE_COMPONENT) is
			-- Add a subcomponent representing a dependent
			-- table on represented table.
		require
			is_dependent_table: is_dependent_tablecode (comp.table_description.Table_code)
			no_db_searcher_set: not comp.db_searcher_set
			not_activated: not is_activated
		local
			db_srcher: DV_TYPED_SEARCHER
			td: DB_TABLE_DESCRIPTION
			tc: INTEGER
		do
			tc := table_description.Table_code
			comp.enable_dependent (Current)
			dependent_table_list.extend (comp)
			create db_srcher.make
			db_srcher.set_behavior_type (db_srcher.Qualified_selection)
			td := comp.table_description
			db_srcher.set_criterion (td.to_create_fkey_from_table.item (tc))
			db_srcher.set_table_code (td.Table_code)
			db_srcher.set_row_attribute_code (td.Id_code)
			subsearcher_list.extend (db_srcher)
			comp.set_db_searcher (db_srcher)
			set_handlers (comp)
		end

	set_db_searcher (db_srcher: DV_SEARCHER) is
			-- Set component enabling to load table rows, eventually from
			-- database, to `db_srcher'.
		require
			not_void: db_srcher /= Void
			not_activated: not is_activated
		do
			db_searcher := db_srcher
			db_searcher.set_user_component (Current)
			db_searcher.set_table_code (table_description.Table_code)
			db_searcher.activate
		ensure
			db_searcher_set: db_searcher_set
		end

	set_db_fields_component (db_fields_comp: DV_TABLEROW_FIELDS) is
			-- Set `db_fields_comp' to component displaying selected table row
			-- content.
		require
			not_void: db_fields_comp /= Void
			not_activated: not is_activated
		do
			db_fields_component := db_fields_comp
		end

	activate is
			-- Activate component.
		do
			if db_fields_component /= Void then
				db_fields_component.set_table_description (table_description)
				db_fields_component.activate
			end
			if db_tablerow_navigator /= Void then
				db_tablerow_navigator.activate
			end
			if db_creator /= Void then
				db_creator.activate
			end
			if not status_handler_set then
				status_handler := ~basic_message_handler
			end
			if not warning_handler_set then
				warning_handler := ~basic_message_handler
			end
			if not confirmation_handler_set then
				confirmation_handler := ~basic_confirmation_handler
			end
			from
				dependent_table_list.start
			until
				dependent_table_list.after
			loop
				set_handlers (dependent_table_list.item)
				dependent_table_list.item.activate
				dependent_table_list.forth
			end
			from
				necessary_table_list.start
			until
				necessary_table_list.after
			loop
				set_handlers (necessary_table_list.item)
				necessary_table_list.item.activate
				necessary_table_list.forth
			end
			is_activated := True
		end

	desactivate is
			-- Desactivate component to add subcomponents.
		do
			is_activated := False
		ensure
			not_activated: not is_activated
		end

	replace_selected_tablerows (tr_set: ARRAYED_LIST [DB_TABLE]) is
			-- Replace current table row set with `tr_set'. Use this capability
			-- when component is activated to switch between different
			-- results. Database searcher set may have to afford to
			-- refresh different searches.
		require
			is_activated: is_activated
			not_void: tr_set /= Void
			table_corresponds: table_corresponds (tr_set)
		do
			tablerow_set := tr_set
		end

feature {DV_COMPONENT} -- Access

	warning_handler: PROCEDURE [ANY, TUPLE [STRING]]
			-- Warning handler.

	status_handler: PROCEDURE [ANY, TUPLE [STRING]]
			-- Status information handler.

	confirmation_handler: PROCEDURE [ANY, TUPLE [STRING, PROCEDURE [ANY, TUPLE]]]
			-- Confirmation handler. 

	parent: DV_TABLE_COMPONENT
			-- Calling component if this component is subcomponent table
			-- is necessary for calling component table.

feature {DV_COMPONENT} -- Status setting

	set_just_created is
			-- Set `is_just_created' to `True'.
		require
			is_activated: is_activated
		do
			is_just_created := True
		end

	enable_dependent (par: DV_TABLE_COMPONENT) is
			-- Enable that represented table is dependent on
			-- calling component table.
		require
			not_void: par /= Void
			is_current_dependent_table: is_necessary_tablecode (par.table_description.Table_code)
			not_activated: not is_activated
		do
			parent := par
			is_dependent := True
			is_necessary := False
		ensure
			parent_set: parent /= Void
		end

	enable_necessary (par: DV_TABLE_COMPONENT) is
			-- Enable that represented table is necessary for
			-- calling component table.
		require
			not_void: par /= Void
			not_is_creating: not is_creating
			is_current_necessary_table: is_dependent_tablecode (par.table_description.Table_code)
			not_activated: not is_activated
		do
			parent := par
			is_dependent := False
			is_necessary := True
		ensure
			parent_set: parent /= Void
		end

feature {DV_COMPONENT} -- Basic operations

	display (tr_set: ARRAYED_LIST [DB_TABLE]) is
			-- Display `tr_set' in the component.
		require
			is_activated: is_activated
			not_void: tr_set /= Void
			table_corresponds: table_corresponds (tr_set)
		do
			tablerow_set := tr_set
			if is_topcomponent then
				status_handler.call ([tablerows_selected (tablerow_set.count)])
			elseif is_dependent and then db_creator /= Void then
				db_creator.set_calling_fkey_value (parent.selected_tablerows.item.table_description.id)
			end
			is_cleared := False
			is_just_created := False
			if not tablerow_set.is_empty then
				tablerow_set.start
			end
			refresh
		ensure
			is_not_cleared: not is_cleared
			is_not_created: not is_just_created
		end

	refresh_from_database is
			-- Refresh display from database.
		require
			is_activated: is_activated
		local
			last_current_tablerow: DB_TABLE
		do
			if tablerow_set.valid_index (tablerow_set.index) then
				last_current_tablerow := tablerow_set.item
				if is_just_created then
					tablerow_set := db_creator.refresh
				else
					tablerow_set := db_searcher.refresh
				end
				check
					table_row_set_exists: tablerow_set /= Void
				end
				if not tablerow_set.is_empty then
					search_or_start (last_current_tablerow)
				end
			else
				if is_just_created then
					tablerow_set := db_creator.refresh
				else
					tablerow_set := db_searcher.refresh
				end
				check
					table_row_set_exists: tablerow_set /= Void
				end
				tablerow_set.start
			end
			refresh
			status_handler.call ([tablerows_selected (tablerow_set.count)])
		end

	clear is
			-- Erase component content.
		require
			is_not_on_top: not is_topcomponent
			is_activated: is_activated
		do
			tablerow_set.wipe_out
			is_cleared := True
			refresh
		ensure
			is_cleared: is_cleared
		end

	change_selection (position: INTEGER) is
			-- Select `tablerow_set' element at `position'.
			-- Remove any selection if `position' = `No_selection'.
		do
			if selected_tablerows.index /= position then
				Precursor (position)
				if db_fields_component /= Void then
					if position = No_selection then
						db_fields_component.clear
					else
						db_fields_component.refresh (tablerow_set.item.table_description)
					end
				end
				if tablerow_set.before then
					other_clear
				else
					other_read
				end
			end
		end

feature {NONE} -- Access

	tablerow_set: ARRAYED_LIST [DB_TABLE]
			-- Current set of table rows reference.

	db_fields_component: DV_TABLEROW_FIELDS
			-- Component displaying selected database table row.

	db_searcher: DV_SEARCHER
			-- Component giving database table rows to display.

	db_creator: DV_CREATOR
			-- Component creating database table rows.

	necessary_table_list: ARRAYED_LIST [DV_TABLE_COMPONENT]
			-- List of subcomponents representing a necessary table
			-- for represented table.

	dependent_table_list: ARRAYED_LIST [DV_TABLE_COMPONENT]
			-- List of subcomponents representing a dependent table
			-- on represented table.

	subsearcher_list: ARRAYED_LIST [DV_TYPED_SEARCHER]
			-- List of searchers corresponding to subcomponents.

	writing_control: DV_SENSITIVE_CONTROL
			-- Enable the user to write the database at run-time.

	refreshing_control: DV_SENSITIVE_CONTROL
			-- Enable the user to refresh display from the database at run-time.

	deleting_control: DV_SENSITIVE_CONTROL
			-- Enable the user to delete rows in the database at run-time.

feature {NONE} -- Status report

	is_cleared: BOOLEAN
			-- Is component cleared?
			-- Component is cleared when a table row would not
			-- make sense. If component is not cleared but displays
			-- no table row, a table row can be created.
			-- Top component cannot be cleared as a new table row
			-- always makes sense.

	is_just_created: BOOLEAN
			-- Has a database table row just been created?

feature {NONE} -- Basic operations

	update_controls_sensitiveness is
			-- Update controls sensitiveness according to `tablerow_set'.
		do
			if is_cleared then
				if writing_control /= Void then
					writing_control.disable_sensitive
				end
				if refreshing_control /= Void then
					refreshing_control.disable_sensitive
				end
				if db_creator /= Void then
					db_creator.disable_sensitive
				end
				if deleting_control /= Void then
					deleting_control.disable_sensitive
				end
			elseif tablerow_set.is_empty or else tablerow_set.before then
				if writing_control /= Void then
					writing_control.disable_sensitive
				end
				if refreshing_control /= Void then
					refreshing_control.enable_sensitive
				end
				if db_creator /= Void then
					db_creator.enable_sensitive
				end
				if deleting_control /= Void then
					deleting_control.disable_sensitive
				end
			else
				if writing_control /= Void then
					writing_control.enable_sensitive
				end
				if refreshing_control /= Void then
					refreshing_control.enable_sensitive
				end
				if db_creator /= Void then
					db_creator.enable_sensitive
				end
				if deleting_control /= Void then
					deleting_control.enable_sensitive
				end
			end
		end
			
	delete_after_confirmation is
			-- Ask for confirmation and delete currently displayed table row in the database.
		require
			is_activated: is_activated
		do
			confirmation_handler.call ([deletion_confirmation (table_description.Table_name), ~delete])
		end

	delete is
			-- Delete currently displayed table row in the database.
		require
			is_activated: is_activated
		do
			database_handler.delete_tablerow (tablerow_set.item)
			if database_handler.has_error then
				warning_handler.call ([database_handler.error_message])
			else
				status_handler.call ([deletion_done (table_description.Table_name)])
				refresh_from_database
			end
		end

	write is
			-- Write currently displayed table row in the database.
		require
			is_activated: is_activated
		do
			db_fields_component.update_tablerow (tablerow_set.item)
			if db_fields_component.is_update_valid then
				database_handler.update_tablerow (db_fields_component.updated_tablerow)
				if database_handler.has_error then
					warning_handler.call ([database_handler.error_message])
				else
					status_handler.call ([update_done (table_description.Table_name)])
					refresh_from_database
				end
			else
				warning_handler.call ([db_fields_component.error_message])
			end
		end

	refresh is
			-- Refresh display from `tablerow_set'.
		require
			is_activated: is_activated
		do
			if db_tablerow_navigator /= Void then
				db_tablerow_navigator.refresh
			end
			if db_fields_component /= Void then
				if tablerow_set.is_empty then
					db_fields_component.clear
				else
					db_fields_component.refresh (tablerow_set.item.table_description)
				end
			end
			update_controls_sensitiveness
			if tablerow_set.is_empty then
				other_clear
			else
				other_read
			end
		end

	other_read is
			-- Refresh subcomponents from `tablerow_set.item'.
		require
			is_activated: is_activated
			not_empty: not tablerow_set.is_empty
			valid_index: tablerow_set.valid_index (tablerow_set.index)
		do
			from
				subsearcher_list.start
			until
				subsearcher_list.after
			loop
				subsearcher_list.item.read_from_tablerow (tablerow_set.item)
				subsearcher_list.forth
			end
		end

	other_clear is
			-- Clear subcomponents.
		require
			is_activated: is_activated
		do
			from
				subsearcher_list.start
			until
				subsearcher_list.after
			loop
				subsearcher_list.item.clear
				subsearcher_list.forth
			end
		end

	set_handlers (comp: DV_TABLE_COMPONENT) is
			-- Set lacking handlers of `comp' with existing handlers.
		require
			not_activated: not is_activated
		do
			if status_handler_set and then not comp.status_handler_set then
				comp.set_status_handler (status_handler)
			end
			if warning_handler_set and then not comp.warning_handler_set then
				comp.set_warning_handler (warning_handler)
			end
			if confirmation_handler_set and then not comp.confirmation_handler_set then
				comp.set_confirmation_handler (confirmation_handler)
			end
		end

	search_or_start (item: DB_TABLE) is
			-- If `tablerow_set' contains `item', go to `item'. Otherwise,
			-- go to first element.
			-- Equality used is ID equality.
			--| FIXME: Remove this awful thing.
		require
			is_activated: is_activated
			set_not_empty: not tablerow_set.is_empty
		local
			searched_id: ANY
			found: BOOLEAN
		do
			searched_id := item.table_description.id
			from
				tablerow_set.start
			until
				found or else tablerow_set.after
			loop
				found := searched_id.is_equal (tablerow_set.item.table_description.id)
				if not found then
					tablerow_set.forth
				end
			end
			if tablerow_set.after then
				tablerow_set.start
			end
		end

invariant
	top_is_not_cleared: is_topcomponent implies not is_cleared

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

end -- class DV_TABLE_COMPONENT


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

