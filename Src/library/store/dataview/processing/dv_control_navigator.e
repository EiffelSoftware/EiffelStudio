indexing
	description: "Objects that enable to navigate among a list %
			%of database table rows."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_CONTROL_NAVIGATOR

inherit
	DV_TABLEROWS_NAVIGATOR

create
	make

feature -- Initialization

	make is
			--Initialize.
		do
		end

feature -- Status report

	display_list_set: BOOLEAN is
			-- Has a display list been set?
		do
			Result := display_list /= Void
		end

	can_be_activated_with_list: BOOLEAN is
			-- Can the component be activated if a display list is set?
		do
			Result := db_selectable_component /= Void and then
					db_selectable_component.table_description /= Void
		end

	can_be_activated: BOOLEAN is
			-- Can the component be activated?
		do
			if display_list_set then
				Result := can_be_activated_with_list
			else
				Result := True
			end
		end

	is_activated: BOOLEAN
			-- Is component activated?

feature -- Basic operations

	set_display_list (display_l: DV_TABLEROW_LIST) is
			-- Set display list to navigate through selection results.
			-- `display_list' can be changed after activation to display
			-- different results on different lists. Please use this
			-- capability carefully and manage potential changes necessary
			-- on DV_TABLE_COMPONENT and DV_SEARCHER.
		require
			not_void: display_l /= Void
				-- If component is already activated, new state, i.e. having a list, 
				-- should verify `can_be_activated'.
			information_set_for_list_if_activated: is_activated implies can_be_activated_with_list 
		do
			display_list := display_l
			if is_activated then
						-- `has_select_action' doesn't work...
				if not display_list.has_select_action (~list_select_actions) then
					display_list.extend_select_actions (~list_select_actions)
				end
			end
		ensure
			display_list_set: display_list_set
		end

	set_list_edition_control (list_edition_ctrl: DV_SENSITIVE_CONTROL) is
			-- Set `list_edition_ctrl' as control to raise display list.
			-- Warning: action to raise the list is not added, component
			-- only manage sensitiveness.
			-- Note: `display_list_set' is not mandatory.
		require
			not_void: list_edition_ctrl /= Void
		do
			list_edition_control := list_edition_ctrl
			list_edition_control.disable_sensitive
		end

	set_previous_control (previous_ctrl: DV_SENSITIVE_CONTROL) is
			-- Set `previous_ctrl' as control to go to previous page.
		require
			not_void: previous_ctrl /= Void
		do
			previous_control := previous_ctrl
			previous_control.set_action (~previous)
			previous_control.disable_sensitive
		end

	set_next_control (next_ctrl: DV_SENSITIVE_CONTROL) is
			-- Set `next_ctrl' as control to go to next page.
		require
			not_void: next_ctrl /= Void
		do
			next_control := next_ctrl
			next_control.set_action (~next)
			next_control.disable_sensitive
		end

	reactivate is
			-- Reset component and reactivate it from `db_selectable_component'.
			-- (Simply activate it if it was not activated.)
		do
			if not is_activated then
				activate
			elseif display_list /= Void then
				display_list.set_tablecode (db_selectable_component.table_description.Table_code)
				display_list.build
			end
		end

feature {NONE} -- Implementation

	display_list: DV_TABLEROW_LIST
			-- Displayed list of table rows.

	refresh is
			-- Refresh table row set display
			-- from `db_selectable_component.selected_tablerows'.
		local
			tablerow_set: ARRAYED_LIST [DB_TABLE]
		do
			tablerow_set := db_selectable_component.selected_tablerows
			if display_list /= Void then
				display_list.refresh (tablerow_set)
			end
			if not tablerow_set.is_empty then
				if list_edition_control /= Void and then tablerow_set.count > 1 then
					list_edition_control.activate
				end
				update_controls_sensitive
			else
				disable_controls_sensitive
				if list_edition_control /= Void then
					list_edition_control.disable_sensitive
				end
			end
		end

	activate is
			-- Build display.
		do
			if display_list /= Void then
				display_list.extend_select_actions (~list_select_actions)
				if not display_list.information_set then
					display_list.set_tablecode (db_selectable_component.table_description.Table_code)
				end
				display_list.build
			end
			is_activated := True
		end

	list_select_actions is
			-- Action performed when a `display_list' item is
			-- selected.
		do
			db_selectable_component.change_selection (display_list.index)
			update_controls_sensitive
		end

	list_edition_control: DV_SENSITIVE_CONTROL
			-- Control to raise the display list.

	previous_control: DV_SENSITIVE_CONTROL
			-- Control to go to previous page.

	next_control: DV_SENSITIVE_CONTROL
			-- Control to go to next page.

	next is
			-- Move to next item in `db_selectable_component.selected_tablerows'.
		require
			not db_selectable_component.selected_tablerows.after
		do
			db_selectable_component.change_selection (db_selectable_component.selected_tablerows.index + 1)
			previous_control.enable_sensitive
			update_next_control
		end

	previous is
			-- Move to previous item in `db_selectable_component.selected_tablerows'.
		require
			not db_selectable_component.selected_tablerows.before
		do
			db_selectable_component.change_selection (db_selectable_component.selected_tablerows.index - 1)
			next_control.enable_sensitive
			update_previous_control
		end

	update_previous_control is
			-- Update previous control sensitiveness.
		require
			set_not_empty: db_selectable_component.selected_tablerows /= Void and then
					not db_selectable_component.selected_tablerows.is_empty
		do
			if db_selectable_component.selected_tablerows.index = 1 then
				previous_control.disable_sensitive
			else
				previous_control.enable_sensitive
			end
		end

	update_next_control is
			-- Update next control sensitiveness.
		require
			set_not_empty: db_selectable_component.selected_tablerows /= Void and then
					not db_selectable_component.selected_tablerows.is_empty
		do
			if db_selectable_component.selected_tablerows.index = 
					db_selectable_component.selected_tablerows.count then
				next_control.disable_sensitive
			else
				next_control.enable_sensitive
			end
		end

	disable_controls_sensitive is
			-- Disable previous and next controls set sensitive.
		do
			if previous_control /= Void then
				previous_control.disable_sensitive
			end
			if next_control /= Void then
				next_control.disable_sensitive
			end
		end

	update_controls_sensitive is
			-- Update every control set sensitiveness
			-- according to current position in
			-- `db_selectable_component.selected_tablerows'.
		do
			if list_edition_control /= Void then
				list_edition_control.enable_sensitive
			end
			if previous_control /= Void then
				update_previous_control
			end
			if next_control /= Void then
				update_next_control
			end
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

end -- class DV_CONTROL_NAVIGATOR


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

