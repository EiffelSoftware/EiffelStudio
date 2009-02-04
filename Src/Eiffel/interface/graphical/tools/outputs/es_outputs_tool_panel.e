note
	description: "[
		An output tools for displaying mulitple outputs in EiffelStudio from the output manager service.
		See {OUTPUT_MANAGER_S} for more information on the service.
		
		For panes displayable in the outputs tool, implement {ES_OUTPUT_PANE_I} and not just {OUTPUT_I}.
		See the helper base class {ES_OUTPUT_PANE}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OUTPUTS_TOOL_PANEL

inherit
	ES_DOCKABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		rename
			output_manager as deprecated_output_manager
		redefine
			internal_recycle,
			on_after_initialized,
			is_tool_bar_separated,
			create_right_tool_bar_items
		end

	OUTPUT_MANAGER_OBSERVER
		redefine
			on_output_registered,
			on_output_unregistered,
			on_output_activated
		end

	ES_OUTPUTS_COMMANDER_I
		export
			{ES_OUTPUTS_COMMANDER_I} all
		end

create {ES_OUTPUTS_TOOL}
	make

feature {NONE} -- User interface initialization

	build_tool_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		do
			register_action (selection_combo.change_actions, agent on_selected_editor_changed)
			register_action (clear_button.select_actions, agent on_clear)
		end

	on_after_initialized
			-- <Precursor>
		local
			l_output_manager: like output_manager
			l_active_outputs: !DS_LINEAR [OUTPUT_I]
			l_first_output: ES_OUTPUT_PANE_I
		do
			Precursor

				-- Hook up the output manager connection.
			l_output_manager := output_manager
			if l_output_manager.is_service_available then
				l_output_manager.service.output_manager_event_connection.connect_events (Current)
				l_active_outputs := l_output_manager.service.active_outputs
				from l_active_outputs.start until l_active_outputs.after loop
					if {l_output_pane: ES_OUTPUT_PANE_I} l_active_outputs.item_for_iteration then
						if l_first_output = Void then
							l_first_output := l_output_pane
						end
						extend_output (l_output_pane)
					end
					l_active_outputs.forth
				end

					-- Set best output
				if {l_active_output: ES_OUTPUT_PANE_I} l_output_manager.service.general_output then
						-- The general output is a EiffelStudio output pane.
					set_output (l_active_output)
				else
						-- The general output is not a EiffelStudio output pane, use the first output
						-- instead.
					check l_first_output_attached: l_first_output /= Void end
					set_output (l_first_output)
				end
			else
					-- The tool cannot be used if the output service is unavailable.
				widget.disable_sensitive
			end
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		local
			l_output_manager: like output_manager
		do
			l_output_manager := output_manager
			if l_output_manager.is_service_available then
				if l_output_manager.service.output_manager_event_connection.is_connected (Current) then
					l_output_manager.service.output_manager_event_connection.disconnect_events (Current)
				end
			end
			Precursor
		end

feature {ES_OUTPUTS_COMMANDER_I} -- Access

	output: ?ES_OUTPUT_PANE_I
			-- <Precursor>

feature {NONE} -- Access

	last_output: ?ES_OUTPUT_PANE_I
			-- The previously active output

feature -- Access: Help

	help_context_id: !STRING_GENERAL
			-- <Precursor>
		once
			Result := "BC9B2EF1-B4C4-773A-9BA8-97143FB2727A"
		end

feature {NONE} -- Access: User interface

	selection_combo: ?EV_COMBO_BOX
			-- Editor selection combo box.

	clear_button: ?SD_TOOL_BAR_BUTTON
			-- Tool bar button used to clear the editor.

feature -- Element change

	set_output (a_output: !ES_OUTPUT_PANE_I)
			-- <Precursor>
		local
			l_combo: like selection_combo
			l_actions_running: BOOLEAN
		do
			if output /= a_output then
				l_combo := selection_combo
				l_actions_running := l_combo.change_actions.state = {ACTION_SEQUENCE [TUPLE]}.normal_state
				if l_actions_running then
					l_combo.change_actions.block
				end

				l_combo.set_text (a_output.name.as_string_32)
				output := a_output
				a_output.widget_for_window (develop_window.as_attached).widget.show

				if l_actions_running then
					l_combo.change_actions.resume
				end
			end
		ensure then
--			a_editor_parented: a_editor.widget.widget.parent = user_widget
--			a_editor_is_displayed: a_editor.widget.is_shown
--			not_old_editor_is_display: old editor /= Void implies not (old editor).widget.is_shown
			selection_combo_changed_actions_restored: selection_combo.change_actions.state = old selection_combo.change_actions.state
		end

feature -- Status report

	is_tool_bar_separated: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {NONE} -- Helpers

	frozen output_manager: !SERVICE_CONSUMER [OUTPUT_MANAGER_S]
			-- Shared access to the output manager service
		once
			create Result
		end

feature {NONE} -- Basic operations

	extend_output (a_editor: !ES_OUTPUT_PANE_I)
			-- Extends the panel with the given output panel.
			--
			-- `a_output': Output pane to extend current with.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_combo: like selection_combo
			l_item: EV_LIST_ITEM
			l_name: STRING_32
			l_match_name: STRING_32
			l_item_name: STRING_32
			l_actions_running: BOOLEAN
			l_already_added: BOOLEAN
			i: INTEGER
		do
			l_combo := selection_combo
			l_actions_running := l_combo.change_actions.state = {ACTION_SEQUENCE [TUPLE]}.normal_state
			if l_actions_running then
				l_combo.change_actions.block
			end
			from l_combo.start until l_combo.after or l_already_added loop
				l_item := l_combo.item_for_iteration
				l_already_added := l_item.data = a_editor
				l_combo.forth
			end
			if not l_already_added then
				l_name := a_editor.name.as_string_32
				if not l_combo.is_empty then
						-- Place new item in respects to a position sorted case-insensitvely
					l_match_name := l_name.as_lower
					from l_combo.start until l_combo.after or l_already_added loop
						l_item := l_combo.item_for_iteration
						l_item_name := l_item.text.as_lower
						if l_match_name > l_item_name then
							l_already_added := True
							if i > 0 then
								create l_name.make (l_name.count + 2)
								l_name.append (l_name)
								l_name.append_character (' ')
								l_name.append_integer (i)
							end
						elseif l_name ~ l_item_name then
							i := i + 1
							l_combo.forth
						else
							l_combo.forth
						end
					end
				end
				create l_item.make_with_text (l_name)
				l_item.set_data (a_editor)
				register_kamikaze_action (l_item.select_actions, agent inject_output_widget (a_editor))
				l_combo.extend (l_item)
			end
			if l_actions_running then
				l_combo.change_actions.resume
			end
		ensure
			selection_combo_changed_actions_restored: selection_combo.change_actions.state = old selection_combo.change_actions.state
		end

	remove_output (a_output: !ES_OUTPUT_PANE_I)
			-- Removes a output pane from the panel.
			--
			-- `a_output': The output pane to remove.
		require
			is_interface_usable: is_interface_usable
			a_output_is_interface_usable: a_output.is_interface_usable
		local
			l_items: ?LINEAR [EV_ITEM]
			l_item: EV_ITEM
			l_window: like develop_window
			l_widget: ES_WIDGET [EV_WIDGET]
			l_ev_widget: EV_WIDGET
		do
			l_items := selection_combo
			if l_items /= Void then

				l_item := l_items.item_for_iteration
			end

				-- Fetch the widget from the output pane interface
			l_window := develop_window
			check l_window_attached: l_window /= Void end
			l_widget := a_output.widget_for_window (l_window)
			remove_auto_recycle (l_widget)

				-- Fetch the EiffelVision2 widget and hide it, because it is not activated yet.
			l_ev_widget := l_widget.widget
			user_widget.prune (l_ev_widget)

				-- Recycle the widget.
			l_widget.recycle
		end

	inject_output_widget (a_output: !ES_OUTPUT_PANE_I)
			-- Extends the panel with the given output panel.
			--
			-- `a_output': Output pane to extend current with.
		require
			is_interface_usable: is_interface_usable
			a_output_is_interface_usable: a_output.is_interface_usable
		local
			l_window: like develop_window
			l_widget: ES_WIDGET [EV_WIDGET]
			l_ev_widget: EV_WIDGET
		do
			a_output.output_window.start_processing (False)
			a_output.output_window.add (a_output.name.as_string_8)
			a_output.output_window.end_processing

				-- Fetch the widget from the output pane interface
			l_window := develop_window
			check l_window_attached: l_window /= Void end
			l_widget := a_output.widget_for_window (l_window)
			check not_has_parent: not l_widget.widget.has_parent end
			auto_recycle (l_widget)

				-- Fetch the EiffelVision2 widget and hide it, because it is not activated yet.
			l_ev_widget := l_widget.widget
			l_ev_widget.hide
			user_widget.extend (l_ev_widget)
		end

feature {REGISTRAR_I} -- Event handlers

	on_output_registered (a_registrar: !OUTPUT_MANAGER_S; a_registration: !CONCEALER_I [OUTPUT_I]; a_key: !UUID)
			-- <Precursor>
		do
				-- We have to force revealing the object to retrieve the
			if {l_output_pane: ES_OUTPUT_PANE_I} a_registration.object then
				extend_output (l_output_pane)
			else
				check must_have_object: False end
			end
		end

	on_output_unregistered (a_registrar: !OUTPUT_MANAGER_S; a_registration: !CONCEALER_I [OUTPUT_I]; a_key: !UUID)
			-- <Precursor>
		do
			if a_registration.is_revealed then
				if {l_output_pane: ES_OUTPUT_PANE_I} a_registration.object then
					remove_output (l_output_pane)
				end
			end
		end

	on_output_activated (a_registrar: !OUTPUT_MANAGER_S; a_registration: !OUTPUT_I; a_key: !UUID)
			-- <Precursor>
		do
				-- The output pane has been created in the registrar (as `on_output_activated' is a renamed
				-- feature from {REGISTRAR_OBSERVER}. Now we can extend the UI to include the actual widget.
		end

feature {NONE} -- Event handler

	on_selected_editor_changed
			-- Called when the user opts to change the selected editor
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_item: EV_LIST_ITEM
			l_widget: ES_WIDGET [EV_WIDGET]
			l_window: EB_DEVELOPMENT_WINDOW
		do
			l_item := selection_combo.selected_item
			check l_item_attached: l_item /= Void end
			if {l_active_output: like output} l_item.data then
				l_window := develop_window.as_attached
				if {l_old_output: like output} output then
					l_widget := l_old_output.widget_for_window (l_window)
					if l_widget.is_interface_usable then
						l_widget.widget.hide
					end
				end

				last_output := output
				output := l_active_output

				l_widget := l_active_output.widget_for_window (l_window)
				if l_widget.is_interface_usable then
					l_widget.widget.show
				else
						-- Why is the new widget not available?
					check False end
				end
			else
				check no_data: False end
			end
		end

	on_clear
			-- Called when the user requests to clear the active editor
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_output_pane: like output
		do
			l_output_pane := output
			if l_output_pane /= Void then
				l_output_pane.clear
			end
		end

feature {NONE} -- Factory

	create_widget: EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_box: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
			l_combo: EV_COMBO_BOX
			l_widget: SD_TOOL_BAR_RESIZABLE_ITEM
		do
			create Result.make (1)

			create l_box
			l_box.set_minimum_width (280)
			l_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

				-- Output Label
			create l_label.make_with_text (locale_formatter.translation (l_output) + ":")
			l_box.extend (l_label)
			l_box.disable_item_expand (l_label)

				-- Selection list
			create l_combo
			l_combo.set_minimum_width (220)
			l_box.extend (l_combo)
			selection_combo := l_combo

			create l_widget.make (l_box)
			Result.put_last (l_widget)
		ensure then
			result_attached: Result /= Void
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_button: SD_TOOL_BAR_BUTTON
		do
			create Result.make (1)

				-- Clear button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_reset_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_reset_icon)
			Result.put_last (l_button)
			clear_button := l_button
		ensure then
			result_attached: Result /= Void
		end

feature {NONE} -- Internationalization

	l_output: STRING = "Output"

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
