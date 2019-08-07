note
	description: "Objects that represents a database table row%
			%set and its graphical display."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make
			-- Initialize.
		do
			create necessary_table_list.make (0)
			create dependent_table_list.make (0)
			create subsearcher_list.make (0)
			create tablerow_set.make (0)
		end

feature -- Access

	table_description: detachable DB_TABLE_DESCRIPTION
			-- Description of table represented by component.

	selected_tablerows: ARRAYED_LIST [DB_TABLE]
			-- Last selected table row set.
		do
			Result := tablerow_set
		end

	selected_tablerow: detachable DB_TABLE
			-- Currently selected table row.
		do
			if not tablerow_set.is_empty then
				Result := tablerow_set.item
			end
		end

feature -- Status report

	can_be_activated: BOOLEAN
			-- Can component be activated?
		do
			Result := database_handler_set and then table_description /= Void
		end

	is_activated: BOOLEAN
			-- Is component activated?

	is_necessary_tablecode (code: INTEGER): BOOLEAN
			-- Does `code' correspond to a necessary
			-- table for represented table?
		do
			Result := attached table_description as l_descr and then l_descr.to_create_fkey_from_table.has (code)
		end

	is_dependent_tablecode (code: INTEGER): BOOLEAN
			-- Does `code' correspond to a dependent
			-- table on represented table?
		do
			Result := attached table_description as l_descr and then l_descr.to_delete_fkey_from_table.has (code)
		end

	is_writing: BOOLEAN
			-- Can the component write the database?
		do
			Result := writing_control /= Void
		end

	is_refreshing: BOOLEAN
			-- Can the component refresh display from the database?
		do
			Result := refreshing_control /= Void
		end

	is_creating: BOOLEAN
			-- Can the component create elements
			-- in the database?
		do
			Result := db_creator /= Void
		end

	is_deleting: BOOLEAN
			-- Can the component delete elements
			-- in the database?
		do
			Result := deleting_control /= Void
		end

	is_subcomponent: BOOLEAN
			-- Is this component determined by a calling
			-- component?
		do
			Result := is_dependent or else is_necessary
		end

	is_topcomponent: BOOLEAN
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

	db_searcher_set: BOOLEAN
			-- Is a component to search table rows set?
		do
			Result := db_searcher /= Void
		end

	status_handler_set: BOOLEAN
			-- Is a status information handler set?
		do
			Result := status_handler /= Void
		end

	warning_handler_set: BOOLEAN
			-- Is a warning handler set?
		do
			Result := warning_handler /= Void
		end

	confirmation_handler_set: BOOLEAN
			-- Is a confirmation handler set?
		do
			Result := confirmation_handler /= Void
		end

	table_corresponds (tr_list: ARRAYED_LIST [DB_TABLE]): BOOLEAN
			-- Does type of `tr_list' elements corresponds to represented
			-- table?
			--| Warning: verification is only done on first element.
		require
			not_void: tr_list /= Void
		do
			if not tr_list.is_empty then
				if attached table_description as l_descr then
					Result := tr_list.first.table_description.Table_code = l_descr.Table_code
				end
			else
				Result := True
			end
		end

feature -- Status setting

	set_writing_control (writing_ctrl: DV_SENSITIVE_CONTROL)
			-- Enable that component can
			-- write the database.
		require
			not_void: writing_ctrl /= Void
			not_activated: not is_activated
		do
			writing_control := writing_ctrl
			writing_ctrl.set_action (agent write)
			writing_ctrl.disable_sensitive
		ensure
			is_writing: is_writing
		end

	set_refreshing_control (refreshing_ctrl: DV_SENSITIVE_CONTROL)
			-- Enable that component can
			-- write the database.
		require
			not_void: refreshing_ctrl /= Void
			not_activated: not is_activated
		do
			refreshing_control := refreshing_ctrl
			refreshing_ctrl.set_action (agent refresh_from_database)
			refreshing_ctrl.disable_sensitive
		ensure
			is_refreshing: is_refreshing
		end

	set_db_creator (creator: DV_CREATOR)
			-- Enable that component can create
			-- elements in the database.
		require
			not_void: creator /= Void
			not_activated: not is_activated
		do
			db_creator := creator
			creator.set_table_component (Current)
		ensure
			is_creating: is_creating
		end

	set_deleting_control (deleting_ctrl: DV_SENSITIVE_CONTROL)
			-- Enable that component can
			-- write the database.
		require
			not_void: deleting_ctrl /= Void
			not_activated: not is_activated
		do
			deleting_control := deleting_ctrl
			deleting_ctrl.set_action (agent delete_after_confirmation)
			deleting_ctrl.disable_sensitive
		ensure
			is_deleting: is_deleting
		end

feature -- Basic operations

	set_warning_handler (w_handler: PROCEDURE [STRING])
			-- Set `w_handler' to `warning_handler'
		require
			not_activated: not is_activated
			not_void: w_handler /= Void
		do
			warning_handler := w_handler
		end

	set_status_handler (s_handler: PROCEDURE [STRING])
			-- Set `s_handler' to `status_handler'
		require
			not_activated: not is_activated
			not_void: s_handler /= Void
		do
			status_handler := s_handler
		end

	set_confirmation_handler (c_handler: PROCEDURE [STRING, PROCEDURE])
			-- Set `c_handler' to `confirmation_handler'
		require
			not_activated: not is_activated
			not_void: c_handler /= Void
		do
			confirmation_handler := c_handler
		end

	set_tablecode (tablecode: INTEGER)
			-- Initialize with `fields_set_comp' to display
			-- current selection.
		require
			not_activated: not is_activated
		do
			table_description := tables.description (tablecode)
		end

	add_necessary_table (comp: DV_TABLE_COMPONENT)
			-- Add a subcomponent representing a necessary
			-- table for represented table.
		require
			is_necessary_table: attached comp.table_description as l_descr and then is_necessary_tablecode (l_descr.Table_code)
			no_db_searcher_set: not comp.db_searcher_set
			not_activated: not is_activated
		local
			db_srcher: DV_TYPED_SEARCHER
			td: detachable DB_TABLE_DESCRIPTION
		do
			comp.enable_necessary (Current)
			necessary_table_list.extend (comp)
			create db_srcher.make
			db_srcher.set_behavior_type (db_srcher.Qualified_selection)
			td := comp.table_description
			check td /= Void and attached table_description as l_descr then
				db_srcher.set_criterion (td.Id_code)
				db_srcher.set_table_code (td.Table_code)
				db_srcher.set_row_attribute_code (l_descr.to_create_fkey_from_table.item (td.Table_code))
			end
			subsearcher_list.extend (db_srcher)
			comp.set_db_searcher (db_srcher)
		end

	add_dependent_table (comp: DV_TABLE_COMPONENT)
			-- Add a subcomponent representing a dependent
			-- table on represented table.
		require
			is_dependent_table: attached comp.table_description as l_descr and then is_dependent_tablecode (l_descr.Table_code)
			no_db_searcher_set: not comp.db_searcher_set
			not_activated: not is_activated
		local
			db_srcher: DV_TYPED_SEARCHER
			td: detachable DB_TABLE_DESCRIPTION
			tc: INTEGER
		do
			if attached table_description as l_descr then
				tc := l_descr.Table_code
			end
			comp.enable_dependent (Current)
			dependent_table_list.extend (comp)
			create db_srcher.make
			db_srcher.set_behavior_type (db_srcher.Qualified_selection)
			td := comp.table_description
			check td /= Void then
				db_srcher.set_criterion (td.to_create_fkey_from_table.item (tc))
				db_srcher.set_table_code (td.Table_code)
				db_srcher.set_row_attribute_code (td.Id_code)
			end
			subsearcher_list.extend (db_srcher)
			comp.set_db_searcher (db_srcher)
			set_handlers (comp)
		end

	set_db_searcher (db_srcher: DV_SEARCHER)
			-- Set component enabling to load table rows, eventually from
			-- database, to `db_srcher'.
		require
			not_void: db_srcher /= Void
			not_activated: not is_activated
		do
			db_searcher := db_srcher
			db_srcher.set_user_component (Current)
			if attached table_description as l_descr then
				db_srcher.set_table_code (l_descr.Table_code)
			end
			db_srcher.activate
		ensure
			db_searcher_set: db_searcher_set
		end

	set_db_fields_component (db_fields_comp: DV_TABLEROW_FIELDS)
			-- Set `db_fields_comp' to component displaying selected table row
			-- content.
		require
			not_void: db_fields_comp /= Void
			not_activated: not is_activated
		do
			db_fields_component := db_fields_comp
		end

	activate
			-- Activate component.
		do
			if attached db_fields_component as l_comp and attached table_description as l_descr then
				l_comp.set_table_description (l_descr)
				l_comp.activate
			end
			if attached db_tablerow_navigator as l_nav then
				l_nav.activate
			end
			if attached db_creator as l_db_creator then
				l_db_creator.activate
			end
			if not status_handler_set then
				status_handler := agent basic_message_handler
			end
			if not warning_handler_set then
				warning_handler := agent basic_message_handler
			end
			if not confirmation_handler_set then
				confirmation_handler := agent basic_confirmation_handler
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

	desactivate
			-- Desactivate component to add subcomponents.
		do
			is_activated := False
		ensure
			not_activated: not is_activated
		end

	replace_selected_tablerows (tr_set: ARRAYED_LIST [DB_TABLE])
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

	warning_handler: detachable PROCEDURE [STRING]
			-- Warning handler.

	status_handler: detachable PROCEDURE [STRING]
			-- Status information handler.

	confirmation_handler: detachable PROCEDURE [STRING, PROCEDURE]
			-- Confirmation handler.

	parent: detachable DV_TABLE_COMPONENT
			-- Calling component if this component is subcomponent table
			-- is necessary for calling component table.

feature {DV_COMPONENT} -- Status setting

	set_just_created
			-- Set `is_just_created' to `True'.
		require
			is_activated: is_activated
		do
			is_just_created := True
		end

	enable_dependent (par: DV_TABLE_COMPONENT)
			-- Enable that represented table is dependent on
			-- calling component table.
		require
			not_void: par /= Void
			is_current_dependent_table: attached par.table_description as l_descr and then is_necessary_tablecode (l_descr.Table_code)
			not_activated: not is_activated
		do
			parent := par
			is_dependent := True
			is_necessary := False
		ensure
			parent_set: parent /= Void
		end

	enable_necessary (par: DV_TABLE_COMPONENT)
			-- Enable that represented table is necessary for
			-- calling component table.
		require
			not_void: par /= Void
			not_is_creating: not is_creating
			is_current_necessary_table: attached par.table_description as l_descr and then is_dependent_tablecode (l_descr.Table_code)
			not_activated: not is_activated
		do
			parent := par
			is_dependent := False
			is_necessary := True
		ensure
			parent_set: parent /= Void
		end

feature {DV_COMPONENT} -- Basic operations

	display (tr_set: ARRAYED_LIST [DB_TABLE])
			-- Display `tr_set' in the component.
		require
			is_activated: is_activated
			not_void: tr_set /= Void
			table_corresponds: table_corresponds (tr_set)
		do
			tablerow_set := tr_set
			if is_topcomponent then
				if attached status_handler as l_handler then
					l_handler.call ([tablerows_selected (tablerow_set.count)])
				end
			elseif is_dependent and then attached parent as l_par and then attached db_creator as l_db_creator then
				l_db_creator.set_calling_fkey_value (l_par.selected_tablerows.item.table_description.id)
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

	refresh_from_database
			-- Refresh display from database.
		require
			is_activated: is_activated
		local
			last_current_tablerow: DB_TABLE
		do
			if not tablerow_set.off then
				last_current_tablerow := tablerow_set.item
				if is_just_created then
					check attached db_creator as l_db_creator then
						tablerow_set := l_db_creator.refresh
					end
				else
					check attached db_searcher as l_db_searcher then
						tablerow_set := l_db_searcher.refresh
					end
				end
				if not tablerow_set.is_empty then
					search_or_start (last_current_tablerow)
				end
			else
				if is_just_created then
					check attached db_creator as l_db_creator then
						tablerow_set := l_db_creator.refresh
					end
				else
					check attached db_searcher as l_db_searcher then
						tablerow_set := l_db_searcher.refresh
					end
				end
				tablerow_set.start
			end
			refresh
			if attached status_handler as l_handler then
				l_handler.call ([tablerows_selected (tablerow_set.count)])
			end
		end

	clear
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

	change_selection (position: INTEGER)
			-- Select `tablerow_set' element at `position'.
			-- Remove any selection if `position' = `No_selection'.
		do
			if selected_tablerows.index /= position then
				Precursor (position)
				if attached db_fields_component as l_comp then
					if position = No_selection then
						l_comp.clear
					else
						l_comp.refresh (tablerow_set.item.table_description)
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

	db_fields_component: detachable DV_TABLEROW_FIELDS
			-- Component displaying selected database table row.

	db_searcher: detachable DV_SEARCHER
			-- Component giving database table rows to display.

	db_creator: detachable DV_CREATOR
			-- Component creating database table rows.

	necessary_table_list: ARRAYED_LIST [DV_TABLE_COMPONENT]
			-- List of subcomponents representing a necessary table
			-- for represented table.

	dependent_table_list: ARRAYED_LIST [DV_TABLE_COMPONENT]
			-- List of subcomponents representing a dependent table
			-- on represented table.

	subsearcher_list: ARRAYED_LIST [DV_TYPED_SEARCHER]
			-- List of searchers corresponding to subcomponents.

	writing_control: detachable DV_SENSITIVE_CONTROL
			-- Enable the user to write the database at run-time.

	refreshing_control: detachable DV_SENSITIVE_CONTROL
			-- Enable the user to refresh display from the database at run-time.

	deleting_control: detachable DV_SENSITIVE_CONTROL
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

	update_controls_sensitiveness
			-- Update controls sensitiveness according to `tablerow_set'.
		do
			if is_cleared then
				if attached writing_control as l_write_ctrl then
					l_write_ctrl.disable_sensitive
				end
				if attached refreshing_control as l_refresh_ctrl then
					l_refresh_ctrl.disable_sensitive
				end
				if attached db_creator as l_db_creator then
					l_db_creator.disable_sensitive
				end
				if attached deleting_control as l_del_ctrl then
					l_del_ctrl.disable_sensitive
				end
			elseif tablerow_set.is_empty or else tablerow_set.before then
				if attached writing_control as l_write_ctrl then
					l_write_ctrl.disable_sensitive
				end
				if attached refreshing_control as l_refresh_ctrl then
					l_refresh_ctrl.enable_sensitive
				end
				if attached db_creator as l_db_creator then
					l_db_creator.enable_sensitive
				end
				if attached deleting_control as l_del_ctrl then
					l_del_ctrl.disable_sensitive
				end
			else
				if attached writing_control as l_write_ctrl then
					l_write_ctrl.enable_sensitive
				end
				if attached refreshing_control as l_refresh_ctrl then
					l_refresh_ctrl.enable_sensitive
				end
				if attached db_creator as l_db_creator then
					l_db_creator.enable_sensitive
				end
				if attached deleting_control as l_del_ctrl then
					l_del_ctrl.enable_sensitive
				end
			end
		end

	delete_after_confirmation
			-- Ask for confirmation and delete currently displayed table row in the database.
		require
			is_activated: is_activated
		do
			if attached confirmation_handler as l_conf_handler and attached table_description as l_descr then
				l_conf_handler.call ([deletion_confirmation (l_descr.Table_name), agent delete])
			end
		end

	delete
			-- Delete currently displayed table row in the database.
		require
			is_activated: is_activated
		do
			database_handler.delete_tablerow (tablerow_set.item)
			if database_handler.has_error then
				if attached warning_handler as l_warn_handler then
					if attached database_handler.error_message as l_msg then
						l_warn_handler.call ([l_msg])
					else
						l_warn_handler.call (["Unknown error"])
					end
				end
			else
						if attached status_handler as l_handler and attached table_description as l_descr then
					l_handler.call ([deletion_done (l_descr.Table_name)])
				end
				refresh_from_database
			end
		end

	write
			-- Write currently displayed table row in the database.
		require
			is_activated: is_activated
		local
			l_updated_table_row: detachable DB_TABLE
		do
			if attached db_fields_component as l_comp then
				l_updated_table_row := l_comp.updated_tablerow (tablerow_set.item)
				if l_updated_table_row /= Void then
					database_handler.update_tablerow (l_updated_table_row)
					if database_handler.has_error then
						if attached warning_handler as l_warn_handler then
							if attached database_handler.error_message as l_msg then
								l_warn_handler.call ([l_msg])
							else
								l_warn_handler.call (["Unknown error"])
							end
						end
					else
						if attached status_handler as l_handler and attached table_description as l_descr then
							l_handler.call ([update_done (l_descr.Table_name)])
						end
						refresh_from_database
					end
				elseif attached warning_handler as l_warn_handler then
					l_warn_handler.call ([l_comp.error_message])
				end
			end
		end

	refresh
			-- Refresh display from `tablerow_set'.
		require
			is_activated: is_activated
		do
			if attached db_tablerow_navigator as l_nav then
				l_nav.refresh
			end
			if attached db_fields_component as l_comp then
				if tablerow_set.is_empty then
					l_comp.clear
				else
					l_comp.refresh (tablerow_set.item.table_description)
				end
			end
			update_controls_sensitiveness
			if tablerow_set.is_empty then
				other_clear
			else
				other_read
			end
		end

	other_read
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

	other_clear
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

	set_handlers (comp: DV_TABLE_COMPONENT)
			-- Set lacking handlers of `comp' with existing handlers.
		require
			not_activated: not is_activated
		do
			if attached status_handler as l_status_handler and then not comp.status_handler_set then
				comp.set_status_handler (l_status_handler)
			end
			if attached warning_handler as l_warn_handler and then not comp.warning_handler_set then
				comp.set_warning_handler (l_warn_handler)
			end
			if attached confirmation_handler as l_conf_handler and then not comp.confirmation_handler_set then
				comp.set_confirmation_handler (l_conf_handler)
			end
		end

	search_or_start (item: DB_TABLE)
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





end -- class DV_TABLE_COMPONENT


