indexing
	description: "[
					Grid view used in class browser
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLASS_BROWSER_GRID_VIEW

inherit
	QL_OBSERVER

	EB_CONSTANTS

	EB_SHARED_PREFERENCES

	EVS_SEARCHABLE_COMPONENT
		rename
			make as old_make
		end

	SHARED_EDITOR_FONT
		redefine
			line_height
		end

	SHARED_EDITOR_DATA

feature{NONE} -- Initialization

	make (a_dev_window: like development_window; a_drop_actions: like drop_actions) is
			-- Initialize.
		require
			a_dev_window_attached: a_dev_window /= Void
		do
			development_window := a_dev_window
			drop_actions := a_drop_actions
			build_interface
		ensure
			drop_actions_set: drop_actions = a_drop_actions
		end

	build_grid is
			-- Build `grid'.
		deferred
		ensure
			grid_attached: grid /= Void
		end

	build_sortable_and_searchable is
			-- Build sortable and searchable facilities
		require
			grid_attached: grid /= Void
		deferred
		end

	build_interface is
			-- Build interface of current view.
		do
			check development_window /= Void end
				-- Build sortable and searchable `grid'.
			build_grid
			build_sortable_and_searchable

				-- Build rest of the interface
			if drop_actions /= Void then
				text.drop_actions.fill (drop_actions)
			end
			editor_preferences.keyword_font_preference.change_actions.extend (agent on_color_or_font_changed)
			editor_preferences.keyword_text_color_preference.change_actions.extend (agent on_color_or_font_changed)
			editor_preferences.normal_text_color_preference.change_actions.extend (agent on_color_or_font_changed)
			editor_preferences.editor_font_preference.change_actions.extend (agent on_color_or_font_changed)
			preferences.class_browser_data.odd_row_background_color_preference.change_actions.extend (agent on_color_or_font_changed)
			preferences.class_browser_data.even_row_background_color_preference.change_actions.extend (agent on_color_or_font_changed)
		end

feature -- Setting

	set_start_class (a_class: like start_class) is
			-- Set `start_class' with `a_class'.
		do
			start_class := a_class
		ensure
			start_class_set: start_class = a_class
		end

	lock_update_grid is
			-- Lock update on `grid'.
		do
			grid.lock_update
		end

	unlock_update_grid is
			-- Unlock update on `grid'.
		do
			grid.unlock_update
		end

feature -- View update

	update (a_observable: QL_OBSERVABLE; a_data: ANY) is
			-- Notification from `a_observable' indicating that `a_data' changed.
		require else
			a_observable_can_be_void: a_observable = Void
		do
			data ?= a_data
			is_up_to_date := False
			update_view
		end

	reset_display is
			-- Clear all graphical output
		do
			text.remove_text
			if grid.row_count > 0 then
				grid.remove_rows (1, grid.row_count)
			end
		end

feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Tool manager

	widget: EV_WIDGET is
			-- Widget of current view
		do
			if widget_internal = Void then
				create main_container
				text.disable_edit
				text.set_background_color (editor_preferences.normal_background_color)
				text.set_foreground_color (editor_preferences.normal_text_color)
				text.set_font (font)
				main_container.extend (text)
				main_container.extend (component_widget)
				component_widget.hide
				widget_internal := main_container
			end
			Result := widget_internal
		end

	control_bar: EV_WIDGET is
			-- Widget of a control bar through which, certain control can be performed upon current view
		deferred
		end

	start_class: QL_CLASS
			-- Class as root of tree
			-- If `start_class' is Void, don't build tree.

feature -- Actions

	on_color_or_font_changed is
			-- Action performed when color or font used to display editor tokens changes
		deferred
		end

feature -- Status report

	is_up_to_date: BOOLEAN
			-- Is current up-to_date?

feature{NONE} -- Implementation

	text: EV_TEXT is
			-- Text area to display warning/error message
		do
			if internal_text = Void then
				create internal_text
			end
			Result := internal_text
		ensure
			result_attached: Result /= Void
		end

	main_container: EV_VERTICAL_BOX
			-- Main container to hole current view

	widget_internal: like widget
			-- Implementation of `widget'

feature{NONE} -- Pick and drop

	on_pick_ended (a_item: EV_ABSTRACT_PICK_AND_DROPABLE) is
			-- Action performed when pick ends
		local
			l_item: EB_GRID_EDITOR_TOKEN_ITEM
		do
			l_item ?= last_picked_item
			if l_item /= Void then
				l_item.set_last_picked_token (0)
				l_item.redraw
			end
			last_picked_item := Void
		ensure
			last_picked_item_not_attached: last_picked_item = Void
		end

	on_pick (a_item: EV_GRID_ITEM): ANY is
			-- Action performed when pick on `a_item'.
		local
			l_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_stone: STONE
			l_index: INTEGER
		do
			l_item ?= a_item
			if l_item /= Void then
				l_index := l_item.token_index_at_current_position
				if l_index > 0 then
					Result := l_item.editor_token_pebble (l_index)
					l_stone ?= Result
					if l_stone /= Void then
						grid.remove_selection
						grid.set_accept_cursor (l_stone.stone_cursor)
						grid.set_deny_cursor (l_stone.x_stone_cursor)
						l_item.set_last_picked_token (l_index)
						l_item.redraw
						last_picked_item := l_item
					end
				end
			end
		end

	last_picked_item: EV_GRID_ITEM
			-- Last picked item	

feature{NONE} -- Implementation

	line_height: INTEGER is
			-- Line height
		do
			Result := Precursor
			Result := Result + Result // 5
		end

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Actions performed when drop occurs on current view	

	internal_text: like text
			-- Implementation of `text'

	data: QL_DOMAIN
			-- Data to be displayed in current view

	update_view is
			-- Update current view according to change in `model'.
		deferred
		ensure
			view_up_to_date: is_up_to_date
		end

invariant
	development_window_attached: development_window /= Void

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
        license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
        licensing_options:	"http://www.eiffel.com/licensing"
        copying: "[
                        This file is part of Eiffel Software's Eiffel Development Environment.
                        
                        Eiffel Software's Eiffel Development Environment is free
                        software; you can redistribute it and/or modify it under
                        the terms of the GNU General Public License as published
                        by the Free Software Foundation, version 2 of the License
                        (available at the URL listed under "license" above).
                        
                        Eiffel Software's Eiffel Development Environment is
                        distributed in the hope that it will be useful,	but
                        WITHOUT ANY WARRANTY; without even the implied warranty
                        of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
                        See the	GNU General Public License for more details.
                        
                        You should have received a copy of the GNU General Public
                        License along with Eiffel Software's Eiffel Development
                        Environment; if not, write to the Free Software Foundation,
                        Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
                ]"
        source: "[
                         Eiffel Software
                         356 Storke Road, Goleta, CA 93117 USA
                         Telephone 805-685-1006, Fax 805-685-6869
                         Website http://www.eiffel.com
                         Customer support http://support.eiffel.com
                ]"


end
