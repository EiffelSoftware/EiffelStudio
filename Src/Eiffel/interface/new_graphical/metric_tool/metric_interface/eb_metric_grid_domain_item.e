note
	description: "Object that represents a grid domain grid item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_GRID_DOMAIN_ITEM [G]

inherit
	ES_GRID_LIST_ITEM
		redefine
			activate_action,
			deactivate
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

	EB_METRIC_TOOL_HELPER
		undefine
			copy,
			default_create
		end

create
	make

feature{NONE} -- Implementation

	make (a_domain: EB_METRIC_DOMAIN)
			-- Initialize.
		require
			a_domain_attached: a_domain /= Void
		do
			create change_actions
			create dialog_ok_actions
			create dialog_cancel_actions
			create ellipsis_actions
			default_create
			set_domain (a_domain)
			ellipsis_actions.extend (agent show_dialog)
			enable_component_pebble
		end

feature -- Access

	domain: EB_METRIC_DOMAIN
			-- Domain contained in Current
		do
			create Result.make
			if domain_internal /= Void then
				Result.append (domain_internal)
			end
		ensure
			result_attached: Result /= Void
		end

	value: G
			-- Value conttained in Current item

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when context of Current changes

	dialog_ok_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when OK button in `dialog' is pressed

	dialog_cancel_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when Cancel button in `dialog' is pressed

	dialog_function: FUNCTION [ANY, TUPLE, EB_METRIC_GRID_DOMAIN_ITEM_DIALOG [G]]
			-- Function to get a dialog from which domain and value manipulation can be done

	ellipsis_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called if the ellipsis button is pressed.

	popup_window: EV_POPUP_WINDOW
			-- Popup window used on activate.
			-- Void when `Current' isn't beeing activated.					

feature -- Status report

	is_activated: BOOLEAN
			-- Is Current item activated?

	is_pebble_droppable (a_pebble: ANY): BOOLEAN
			-- Can `a_pebble' be dropped on Current?
		local
			l_stone: STONE
			l_domain_item: EB_METRIC_DOMAIN_ITEM
			l_domain: like domain
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
					-- Pebble is a stone.
				l_domain_item := metric_domain_item_from_stone (l_stone)
				if l_domain_item /= Void then
					l_domain := domain
					l_domain.compare_objects
					Result := (not l_domain.has (l_domain_item)) and then (not l_domain.has_delayed_domain_item)
				end
			end
		end

feature -- Setting

	set_domain (a_domain: EB_METRIC_DOMAIN)
			-- Set Current to display `a_domain'.
		require
			a_domain_attached: a_domain /= Void
		do
			domain_internal := a_domain
			update_ui
			change_actions.call (Void)
		end

	set_value (a_value: like value)
			-- Set `value' with `a_value'.
		do
			value := a_value
			update_ui
			change_actions.call (Void)
		ensure
			value_set: value = a_value
		end

	set_dialog_function (a_func: like dialog_function)
			-- Set `dialog_function' with `a_func'.
		do
			dialog_function := a_func
		ensure
			dialog_function_set: dialog_function = a_func
		end

	add_pebble (a_pebble: ANY; a_agent: PROCEDURE [ANY, TUPLE])
			-- Add domain item contained in `a_pebble' if any.
			-- If `a_pebble' is added successfully, call `a_agent' is it's not Void.
		local
			l_stone: STONE
			l_target_stone: TARGET_STONE
			l_classi_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
			l_feature_stone: FEATURE_STONE
			l_domain: EB_METRIC_DOMAIN
			l_domain_item: EB_METRIC_DOMAIN_ITEM
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
					-- Pebble is a stone.
				l_target_stone ?= a_pebble
				l_classi_stone ?= a_pebble
				l_cluster_stone ?= a_pebble
				l_feature_stone ?= a_pebble
				if l_target_stone /= Void or l_classi_stone /= Void or l_cluster_stone /= Void or l_feature_stone /= Void then
					l_domain_item := metric_domain_item_from_stone (l_stone)
					l_domain := domain
					l_domain.compare_objects
					if not l_domain.has (l_domain_item) then
						l_domain.extend (l_domain_item)
						set_domain (l_domain)
						if a_agent /= Void then
							a_agent.call (Void)
						end
					end
				end
			end
		end

	show_dialog
			-- Show text editor.
		require
			parented: is_parented
			parent_window: parent_window (parent) /= Void
			popup_window: popup_window /= Void
			activated: is_activated
		local
			l_dialog: EB_METRIC_GRID_DOMAIN_ITEM_DIALOG [G]
			l_dev_window: EB_DEVELOPMENT_WINDOW
		do
			l_dialog := dialog_function.item (Void)
			if l_dialog /= Void then
				l_dialog.ok_actions.wipe_out
				l_dialog.ok_actions.extend (agent on_dialog_ok (l_dialog))
				l_dialog.cancel_actions.extend (agent on_dialog_cancel (l_dialog))
				l_dialog.cancel_actions.wipe_out
				l_dialog.set_domain (domain)
				l_dialog.set_value (value)
				l_dev_window := window_manager.last_focused_development_window
				if l_dev_window /= Void and l_dialog.domain_selector /= Void then
					l_dialog.set_context_menu_factory (l_dev_window.menus.context_menu_factory)
				end
				l_dialog.show_relative_to_window (parent_window (parent))
				l_dialog.set_focus
			end
		end

feature -- Drop

	drop_pebble (a_pebble: ANY)
			-- Drop `a_pebble' into Current.
		local
			l_domain: like domain
			l_stone: STONE
		do
			l_stone ?= a_pebble
			if l_stone /= Void and then is_pebble_droppable (l_stone) then
				l_domain := domain.twin
				l_domain.extend (metric_domain_item_from_stone (l_stone))
				set_domain (l_domain)
			end
		end

feature {EV_GRID_I} -- Implementation

	activate_action (a_popup_window: EV_POPUP_WINDOW)
			-- Activate action.
		local
			l_hb: EV_HORIZONTAL_BOX
		do
			popup_window := a_popup_window
			popup_window.set_background_color (implementation.displayed_background_color)

			create domain_field
			display (domain_field, False, False)

			create l_hb
			l_hb.extend (domain_field)

			create button
			button.set_pixmap (ellipsis)
			l_hb.extend (button)
			l_hb.disable_item_expand (button)
			button.set_minimum_height (popup_window.height-1)

			popup_window.extend (l_hb)

			popup_window.show_actions.extend (agent initialize_actions)
			popup_window.set_x_position (popup_window.x_position + 1)
			popup_window.set_size (popup_window.width - 1, popup_window.height -1 )
			is_activated := True
		ensure then
			is_activated: is_activated
		end

	deactivate
			-- Cleanup from previous call to `activate'.
		do
			Precursor
			if button /= Void then
				button.focus_out_actions.wipe_out
				button.destroy
				button := Void
			end
			if domain_field /= Void then
				domain_field.destroy
				domain_field := Void
			end
			is_activated := False
			if not parent.is_destroyed then
				parent.set_focus
			end
		ensure then
			button_void: button = Void
			domain_field_void: domain_field = Void
			not_activated: not is_activated
		end

feature{NONE} -- Implementation

	button: EV_BUTTON
			-- Ellipsis button used to edit `Current' on activate.
			-- Void when `Current' isn't being activated.

	domain_field: EV_DRAWING_AREA
			-- Domain field used to display domain on activate.
			-- Void when `Current' isn't being activated.

	ellipsis: EV_PIXMAP
			-- Icon for ellipsis
		do
			Result := ellipsis_pixmap
		ensure
			Result_set: Result /= Void
		end

	initialize_actions
			-- Setup the actions sequences when the item is shown.
		do
			button.set_focus
			button.focus_out_actions.extend (agent focus_lost)
			button.select_actions.append (ellipsis_actions)
		end

	focus_lost
			-- Check if no other element in the popup has the focus.
		do
			if is_activated and then not has_focus then
				deactivate
			end
		end

	has_focus: BOOLEAN
			-- Does this property have the focus?
		require
			is_activated
		do
			Result := domain_field.has_focus or button.has_focus
		end

	on_dialog_ok (a_dialog: EB_METRIC_GRID_DOMAIN_ITEM_DIALOG [G])
			-- Action to be performed when "OK" button is pressed in prompted dialog `a_dialog'
		require
			a_dialog_attached: a_dialog /= Void
		do
			change_actions.block
			set_value (a_dialog.value)
			set_domain (a_dialog.domain)
			change_actions.resume
			change_actions.call (Void)
			dialog_ok_actions.call (Void)
		end

	on_dialog_cancel (a_dialog: EB_METRIC_GRID_DOMAIN_ITEM_DIALOG [G])
			-- Action to be performed when "Cancel" button in `a_dialog' in prompted dialog `a_dialog'
		require
			a_dialog_attached: a_dialog /= Void
		do
			dialog_cancel_actions.call (Void)
		end

	domain_internal: EB_METRIC_DOMAIN
			-- Domain contained in Current

	prepare_components
			-- Prepare components for display.
		do
			components_for_domain.do_all (agent append_component)
		end

	components_for_domain: LIST [ES_GRID_ITEM_COMPONENT]
			-- Component list for `domain'
		local
			l_domain: like domain_internal
			l_item: EB_GRID_DOMAIN_ITEM_COMPONENT
		do
			create {LINKED_LIST [ES_GRID_ITEM_COMPONENT]}Result.make
			from
				l_domain := domain_internal
				l_domain.start
			until
				l_domain.after
			loop
				create l_item.make (l_domain.item, 2)
				Result.extend (l_item)
				l_domain.forth
			end
		ensure
			result_attached: Result /= Void
		end

	update_ui
			-- Update UI.
		local
			l_items: like components
		do
				-- Remove all existing components.
			l_items := components
			l_items.do_all (agent (a_item: like component_type) do a_item.set_grid_item (Void) end)
			l_items.wipe_out

				-- Retrieve new components.
			prepare_components

				-- Redraw.
			set_required_width (required_dimension_for_items.width)
			safe_redraw
		end

invariant
	dialog_ok_actions_attached: dialog_ok_actions /= Void
	dialog_cancel_actions_attached: dialog_cancel_actions /= Void
	ellipsis_actions_attached: ellipsis_actions /= Void
	domain_internal_attached: domain_internal /= Void
	change_actions_attached: change_actions /= Void

note
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
