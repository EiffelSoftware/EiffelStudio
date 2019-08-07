note
	description: "Objects that enable to retrieve foreign key values for table row %
		%creation. Foreign key values are selected dynamically by user using %
		%a navigator."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make (a_navigator: DV_TABLEROWS_NAVIGATOR)
			-- Initialize.
		do
			create db_all_searcher.make
			set_db_tablerow_navigator (a_navigator)
		end

feature -- Status report

	can_be_activated: BOOLEAN
			-- Can the component be activated?
		do
			Result := db_creator /= Void and then
					selecting_control /= Void and then
					raise_action /= Void and then
					db_tablerow_navigator /= Void
		end

	is_activated: BOOLEAN
			-- Is the component activated?

feature -- Basic operations

	set_raising_action (raising_action: PROCEDURE)
			-- Set `raising_action' to raise navigation component to
			-- select table row.
		require
			not_activated: not is_activated
			action_not_void: raising_action /= Void
		do
			raise_action := raising_action
		end

	set_selecting_control (selecting_ctrl: DV_SENSITIVE_CONTROL)
			-- Enable that component can
			-- select active table row.
		require
			not_activated: not is_activated
			not_void: selecting_ctrl /= Void
		do
			selecting_control := selecting_ctrl
			selecting_ctrl.set_action (agent ok)
		end

feature {DV_COMPONENT} -- Access

	table_description: detachable DB_TABLE_DESCRIPTION
			-- Description of table represented by component.

	selected_tablerows: ARRAYED_LIST [DB_TABLE]
			-- Base for database table row selection.
		do
			check attached tablerow_set as l_set then
				Result := l_set
			end
		end

feature {DV_COMPONENT} -- Basic operations

	set_db_creator (creator: DV_CHOICE_CREATOR)
			-- Set `creator' as calling component.
		require
			not_activated: not is_activated
			component_not_void: creator /= Void
		do
			db_creator := creator
		end

	select_from_table (table_code: INTEGER)
			-- Let user select a tablerow of table with
			-- `table_code'.
		require
			is_activated: is_activated
		local
			l_set: like tablerow_set
		do
			db_all_searcher.set_table_code (table_code)
			if not db_all_searcher.is_activated then
				db_all_searcher.activate
			end
			if db_all_searcher.is_activated then
				l_set := db_all_searcher.refresh
				tablerow_set := l_set
				l_set.start
				table_description := tables.description (table_code)
				if attached db_tablerow_navigator as l_nav then
					l_nav.reactivate
					l_nav.refresh
				end
				if attached raise_action as l_raise_action then
					l_raise_action.call ([])
				end
			end
		end

	activate
			-- Activate component.
		do
			if attached db_creator as l_db_creator and then attached l_db_creator.db_table_component as l_comp then
				db_all_searcher.set_user_component (l_comp)
				is_activated := True
			end
		end

feature {NONE} -- Implementation

	tablerow_set: detachable ARRAYED_LIST [DB_TABLE]
			-- Base for database table row selection.

	db_all_searcher: DV_TYPED_SEARCHER
			-- Component retrieving database table rows.

	db_creator: detachable DV_CHOICE_CREATOR
			-- Creation component requesting table IDs.

	selecting_control: detachable DV_SENSITIVE_CONTROL
			-- Control to select a database table row.

	raise_action: detachable PROCEDURE
			-- Action to perform to raise the navigator.

	update_controls_sensitiveness
			-- Update controls sensitiveness.
		do
			if attached selecting_control as l_ctrl and attached tablerow_set as l_set then
				if l_set.before then
					l_ctrl.disable_sensitive
				else
					l_ctrl.enable_sensitive
				end
			end
		end

	ok
			-- Select current table row and transmit its ID to creation component.
		do
			if attached tablerow_set as l_set and then not l_set.off and then attached db_creator as l_db_creator then
				l_db_creator.add_foreign_key_value (l_set.item.table_description.id)
			end
		end

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





end -- class DV_TABLEROW_ID_PROVIDER


