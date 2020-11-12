note
	description: "A widget which provides a text field and a menu for setting a metric"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_SETTER

inherit
	EV_FRAME
		redefine
			initialize
		end

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			copy,
			default_create
		end

	EV_UTILITIES
		undefine
			copy,
			default_create
		end

feature{NONE} -- Initialization

	initialize
			-- Mark `Current' as initialized.
		local
			l_hor: EV_HORIZONTAL_BOX
			l_text: EV_TEXT_FIELD
		do
			create metric_text_field
			create drop_button
			create change_actions
			create delayed_timer.make (agent on_metric_name_text_change_confirmed, 500)

			Precursor

				-- Initialize layout.
			create l_text
			metric_text_field.set_background_color (l_text.background_color)
			metric_text_field.set_minimum_width (150)
			metric_text_field.drop_actions.extend (agent on_drop)
			metric_text_field.set_accept_cursor (cursors.cur_metric)
			metric_text_field.set_deny_cursor (cursors.cur_x_metric)
			metric_text_field.set_tooltip (metric_names.f_drop_metric_here)
			metric_text_field.change_actions.extend (agent on_metric_name_text_change)

			drop_button.set_pixmap (pixmaps.mini_pixmaps.toolbar_dropdown_icon)
			drop_button.select_actions.extend (agent on_open_metric_menu)
			drop_button.key_press_actions.extend (agent on_key_pressed_in_open_metric_btn)

			create l_hor
			l_hor.extend (metric_text_field)
			l_hor.disable_item_expand (metric_text_field)
			l_hor.extend (drop_button)
			l_hor.disable_item_expand (drop_button)
			extend (l_hor)
			set_style ({EV_FRAME_CONSTANTS}.ev_frame_etched_in)
		end

feature -- Access

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when selected metric changes in `metric_text_field'

	metric_text_field: EV_TEXT_FIELD
			-- Text field for metric name input

	drop_button: EV_BUTTON
			-- Button to popup a metric menu

	metric_name: STRING
			-- Metric name
		do
			Result := metric_text_field.text
		ensure
			result_attached: Result /= Void
		end

	metric_uuid: UUID
			-- Metric UUID
		do
			Result ?= metric_text_field.data
			if Result = Void then
				Result := metric_manager.uuid_generator.generate_uuid
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_read_only: BOOLEAN
			-- Is Current setter read-only?

feature -- Setting

	set_is_read_only (b: BOOLEAN)
			-- Set `is_read_only' with `b'.
		do
			is_read_only := b
			if is_read_only then
				metric_text_field.disable_edit
				attach_non_editable_warning_to_text (metric_names.t_predefined_text_not_editable, metric_text_field, parent_window (Current))
				drop_button.disable_sensitive
			else
				metric_text_field.enable_edit
				metric_text_field.key_press_actions.wipe_out
				drop_button.enable_sensitive
			end
		ensure
			is_read_only_set: is_read_only = b
		end

	load_metric_data (a_name: STRING)
			-- Load metric name `a_name' in Current.
		require
			a_name_attached: a_name /= Void
		do
			metric_text_field.change_actions.block
			metric_text_field.set_text (a_name)
			on_text_change_in_text_field (a_name)
			metric_text_field.change_actions.resume
		end

feature{NONE}	-- Acitons

	on_text_change_in_text_field (a_text: STRING)
			-- Action to be performed when text in `metric_text_field' changes to `a_text'.			
		require
			a_text_attached: a_text /= Void
		local
			l_metric_manager: like metric_manager
		do
			l_metric_manager := metric_manager
			if l_metric_manager.has_metric (a_text) then
				if l_metric_manager.is_metric_valid (a_text) then
					metric_text_field.set_foreground_color (black_color)
				else
					metric_text_field.set_foreground_color (red_color)
				end
			else
				metric_text_field.set_foreground_color (red_color)
			end
		end

	on_metric_name_text_change_confirmed
			-- Action to be performed when text change in `metric_text_field' is confirmed
		do
			on_text_change_in_text_field (metric_text_field.text)
			call_change_actions
		end

	on_metric_name_text_change
			-- Action to be performed when text changes in `metric_text_field'
		do
			delayed_timer.request_call
		end

	on_drop (a_pebble: ANY)
			-- Action to be performed when `a_pebble' is dropped on `metric_name_text'.
		local
			l_metric: EB_METRIC
		do
			if not is_read_only then
				l_metric ?= a_pebble
				if l_metric /= Void then
					if metric_manager.is_metric_calculatable (l_metric.name) then
						metric_text_field.set_foreground_color (black_color)
					else
						metric_text_field.set_foreground_color (red_color)
					end
					metric_text_field.set_text (l_metric.name)
				end
				call_change_actions
			end
		end

	on_open_metric_menu
			-- Action to be performed when open `metric_menu' at position related to `metric_text_field'.
		do
			if attached button_metric_menu as m and then m /= metric_menu then
				m.destroy
			end
			button_metric_menu := metric_menu
			setup_menu (button_metric_menu)
			button_metric_menu.show_at (metric_text_field, metric_text_field.width - approximate_width_of_menu (button_metric_menu) - 30, metric_text_field.height)
		end

	on_key_pressed_in_open_metric_btn (a_key: EV_KEY)
			-- Action to be performed when button pressed to open a metric menu
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				on_open_metric_menu
			end
		end

feature{NONE}	-- Implementation

	delayed_timer: ES_DELAYED_ACTION
			-- Timer for delayed change checking in `metric_text_field'.

	button_metric_menu: EV_MENU
			-- Menu to display all registered metrics				

	call_change_actions
			-- Invoke agents in `change_actions'.
		require
			not_is_read_only: not is_read_only
		do
			if not is_read_only then
				change_actions.call (Void)
			end
		end

	setup_menu (a_menu: EV_MENU)
			-- Setup menu selection actions for `metric_text_field'.
		require
			a_menu_attached: a_menu /= Void
		local
			l_menu: EV_MENU
			l_item: EV_MENU_ITEM
		do
			from
				a_menu.start
			until
				a_menu.after
			loop
				l_menu ?= a_menu.item
				if l_menu /= Void then
					from
						l_menu.start
					until
						l_menu.after
					loop
						l_item := l_menu.item
						l_item.select_actions.extend (agent on_drop (l_item.data))
						l_menu.forth
					end
				end
				a_menu.forth
			end
		end

invariant
	metric_text_field_attached: metric_text_field /= Void
	drop_button_attached: drop_button /= Void
	change_actions_attached: change_actions /= Void
	delayed_timer_attached: delayed_timer /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
