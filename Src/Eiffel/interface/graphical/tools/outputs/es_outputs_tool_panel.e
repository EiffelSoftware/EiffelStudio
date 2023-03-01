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
		redefine
			internal_recycle,
			on_before_initialize,
			on_after_initialized,
			is_tool_bar_separated,
			create_right_tool_bar_items
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		redefine
			is_help_available,
			help_provider,
			help_context_section,
			help_context_description
		end

	ES_OUTPUTS_COMMANDER_I
		export
			{ES_OUTPUTS_COMMANDER_I} all
		end

	OUTPUT_MANAGER_OBSERVER
		redefine
			on_output_unregistered,
			on_output_activated
		end

	LOCKABLE_OBSERVER
		rename
			on_locked as on_output_locked,
			on_unlocked as on_output_unlocked
		redefine
			on_output_locked,
			on_output_unlocked
		end

create {ES_OUTPUTS_TOOL}
	make

feature {NONE} -- User interface initialization

	build_tool_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		do
			register_action (selection_combo.select_actions, agent on_selected_editor_changed)
			register_action (save_button.select_actions, agent on_save)
			register_action (search_button.select_actions, agent on_search)
			register_action (clear_button.select_actions, agent on_clear)
		end

	on_before_initialize
			-- <Precursor>
		do
			Precursor
			create modified_outputs.make (10)
		end

	on_after_initialized
			-- <Precursor>
		local
			l_active_outputs: attached DS_LINEAR [OUTPUT_I]
			l_first_output: ES_OUTPUT_PANE_I
		do
			Precursor

				-- Hook up the output manager connection.
			if attached output_manager.service as s then
				s.output_manager_event_connection.connect_events (Current)
					-- Add all already activated outputs
				l_active_outputs := s.active_outputs
				from l_active_outputs.start until l_active_outputs.after loop
					if attached {ES_OUTPUT_PANE_I} l_active_outputs.item_for_iteration as l_output_pane then
						if l_first_output = Void then
							l_first_output := l_output_pane
						end
						extend_output (l_output_pane)
					end
					l_active_outputs.forth
				end

				if not attached output then
						-- No output is currently been set.

						-- Set best output
					if attached {ES_OUTPUT_PANE_I} s.general_output as l_active_output then
							-- The general output is a EiffelStudio output pane.
						set_output (l_active_output)
					else
							-- The general output is not a EiffelStudio output pane, use the first output
							-- instead.
						check l_first_output_attached: attached l_first_output end
						set_output (l_first_output)
					end
				end
			else
					-- The tool cannot be used if the output service is unavailable.
				widget.disable_sensitive
			end
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if
				attached output_manager.service as s and then
				s.output_manager_event_connection.is_connected (Current)
			then
				s.output_manager_event_connection.disconnect_events (Current)
			end
			Precursor
		end

feature {ES_OUTPUTS_COMMANDER_I} -- Access

	output: detachable ES_OUTPUT_PANE_I
			-- <Precursor>

feature {NONE} -- Access

	last_output: detachable ES_OUTPUT_PANE_I
			-- The previously active output

	modified_outputs: HASH_TABLE [TUPLE [output: attached ES_OUTPUT_PANE_I; button: attached SD_TOOL_BAR_BUTTON], IMMUTABLE_STRING_32]
			-- Modified output panes, used to manage the show modified outputs buttons

feature -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		do
			if (attached last_output as l_output) and then (attached {HELP_CONTEXT_I} l_output.widget_from_window (develop_window) as l_context) then
				Result := l_context.help_context_id
			else
				Result := once {STRING_32} "4f35254c-9a22-7773-21ed-aa740c3eddd5"
			end
		end

	help_context_section: detachable HELP_CONTEXT_SECTION_I
			-- <Precursor>
		do
			if (attached last_output as l_output) and then (attached {HELP_CONTEXT_I} l_output.widget_from_window (develop_window) as l_context) then
				Result := l_context.help_context_section
			else
				Result := Precursor
			end
		end

	help_context_description: detachable STRING_32
			-- <Precursor>
		do
			if (attached last_output as l_output) and then (attached {HELP_CONTEXT_I} l_output.widget_from_window (develop_window) as l_context) then
				Result := l_context.help_context_description
			else
				Result := Precursor
			end
		end

	help_provider: UUID
			-- <Precursor>
		do
			if (attached last_output as l_output) and then (attached {HELP_CONTEXT_I} l_output.widget_from_window (develop_window) as l_context) then
				Result := l_context.help_provider
			else
				Result := Precursor
			end
		end

feature {NONE} -- Access: User interface

	selection_combo: detachable EV_COMBO_BOX
			-- Editor selection combo box.

	save_button: detachable SD_TOOL_BAR_BUTTON
			-- Tool bar button used to save the content of the editor.

	search_button: detachable SD_TOOL_BAR_BUTTON
			-- Tool bar button used to search the content of the editor.

	clear_button: detachable SD_TOOL_BAR_BUTTON
			-- Tool bar button used to clear the editor.

	modified_outputs_tool_bar: detachable SD_TOOL_BAR
			-- Tool bar used to contain the modified outputs buttons.

	icon_animations: detachable ARRAYED_LIST [EV_PIXEL_BUFFER]
			-- Animation icons used to notify users output is being generated.

	icon_pixmap_animations: detachable ARRAYED_LIST [EV_PIXMAP]
			-- Animation icon pixmaps used to notify users output is being generated.

	icon_animation_timer: detachable EV_TIMEOUT
			-- Animation icon timer used to cycle frames.

feature {ES_OUTPUTS_COMMANDER_I} -- Element change

	set_output (a_output: attached ES_OUTPUT_PANE_I)
			-- <Precursor>
		local
			l_combo: like selection_combo
			l_name: STRING_32
			l_cursor: CURSOR
			l_actions_running: BOOLEAN
			l_old_output: like output
			l_widget: ES_WIDGET [EV_WIDGET]
			l_window: EB_DEVELOPMENT_WINDOW
			l_had_focus: BOOLEAN
			l_done: BOOLEAN
		do
			if not is_initialized then
					-- Force initialization.
					-- We set the output to prevent initialization from setting a default output.

				output := a_output
				initialize
				extend_output (a_output)
				output := Void
			end

			if output /= a_output then
				l_old_output := output
				if attached l_old_output then
						-- Clean up the old output
					if l_old_output.lockable_connection.is_connected (Current) then
							-- Disconnect the lock events
						l_old_output.lockable_connection.disconnect_events (Current)
					end
					if l_old_output.is_locked then
							-- The output was still locked after the disconnect, call unlock handler now.
						on_output_unlocked (l_old_output)
					end
				end

				l_combo := selection_combo
				if l_combo /= Void then
					l_actions_running := l_combo.select_actions.state = {ACTION_SEQUENCE [TUPLE]}.normal_state
					if l_actions_running then
						l_combo.select_actions.block
					end

						-- Change label in the combo box.
					l_name := a_output.name.as_string_32
					l_cursor := l_combo.cursor
					from l_combo.start until l_combo.after or l_done loop
						if l_name ~ l_combo.item.text then
							l_combo.item.enable_select
							l_done := True
						end
						l_combo.forth
					end
					--check done: l_done end
					l_combo.go_to (l_cursor)

					if l_actions_running then
						l_combo.select_actions.resume
					end
				end

				l_window := develop_window
				if attached l_old_output then
					l_widget := l_old_output.widget_from_window (l_window)
						-- Check if the old output has focus, so we can refocus set the last focused widget to be
						-- the new output widget.
					l_had_focus := l_widget.widget = last_focused_widget
					if l_widget.is_interface_usable then
						l_widget.widget.hide
					end
				end

				last_output := output
				output := a_output

				l_widget := a_output.widget_from_window (l_window)
				if l_widget.is_interface_usable then
					l_widget.widget.show
					if l_had_focus then
							-- Set the last focused widget, because if the output is switched
						set_last_focused_widget (l_widget)
						if is_shown then
								-- The tool is shown, so reset focus.
							l_widget.widget.set_focus
						end
					end
				else
						-- Why is the new widget not usable?
					check False end
				end

					-- Connect to lock events
				a_output.lockable_connection.connect_events (Current)
				if a_output.is_locked then
						-- The output is locked so raise the correct events.
					on_output_locked (a_output)
				end

				on_output_shown (a_output)
			end
		ensure then
--			a_editor_parented: a_editor.widget.widget.parent = user_widget
--			a_editor_is_displayed: a_editor.widget.is_shown
--			not_old_editor_is_display: old editor /= Void implies not (old editor).widget.is_shown
--			selection_combo_select_actions_restored: selection_combo.select_actions.state = old (selection_combo.select_actions).state
		end

feature -- Status report

	is_tool_bar_separated: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {NONE} -- Status report

	is_help_available: BOOLEAN
			-- <Precursor>
		do
			if (attached last_output as l_output) and then (attached {HELP_CONTEXT_I} l_output.widget_from_window (develop_window) as l_context) then
				Result := l_context.is_help_available
			else
				Result := Precursor
			end
		end

feature {NONE} -- Helpers

	frozen output_manager: attached SERVICE_CONSUMER [OUTPUT_MANAGER_S]
			-- Shared access to the output manager service
		once
			create Result
		end

feature {NONE} -- Basic operations

	extend_output (a_editor: attached ES_OUTPUT_PANE_I)
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
			l_actions_running := l_combo.select_actions.state = {ACTION_SEQUENCE [TUPLE]}.normal_state
			if l_actions_running then
				l_combo.select_actions.block
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
				l_item.set_pixmap (a_editor.icon_pixmap)
				l_item.set_data (a_editor)

					-- Inject the output widget into the UI now, so it receives updates.
				inject_output_widget (a_editor)

					-- Set up action to ensure users are notified when a hidden output changes.
				register_action (a_editor.text_changed_actions, agent (ia_sender: ES_NOTIFIER_FORMATTER; ia_output: ES_OUTPUT_PANE_I)
					require
						ia_sender_attached: ia_sender /= Void
						ia_output_attached: ia_output /= Void
					do
						if is_interface_usable then
							on_output_modified (ia_output)
						end
					end (?, a_editor))

				l_combo.extend (l_item)
			end
			if l_actions_running then
				l_combo.select_actions.resume
			end
		ensure
			selection_select_actions_restored: selection_combo.select_actions.state = old selection_combo.select_actions.state
		end

	remove_output (a_output: attached ES_OUTPUT_PANE_I)
			-- Removes a output pane from the panel.
			--
			-- `a_output': The output pane to remove.
		require
			is_interface_usable: is_interface_usable
			a_output_is_interface_usable: a_output.is_interface_usable
		local
			l_items: detachable LINEAR [EV_ITEM]
			l_item: EV_ITEM
			l_window: like develop_window
			l_widget: ES_WIDGET [EV_WIDGET]
			l_ev_widget: EV_WIDGET
		do
			l_items := selection_combo
			if attached l_items then
				l_item := l_items.item_for_iteration
			end

				-- Fetch the widget from the output pane interface
			l_window := develop_window
			check l_window_attached: l_window /= Void end
			l_widget := a_output.widget_from_window (l_window)
			remove_auto_recycle (l_widget)

				-- Fetch the EiffelVision2 widget and hide it, because it is not activated yet.
			l_ev_widget := l_widget.widget
			user_widget.prune (l_ev_widget)

				-- Recycle the widget.
			l_widget.recycle
		end

	inject_output_widget (a_output: attached ES_OUTPUT_PANE_I)
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
				-- Fetch the widget from the output pane interface
			l_window := develop_window
			check l_window_attached: attached l_window end
			l_widget := a_output.widget_from_window (l_window)
			check not_has_parent: not l_widget.widget.has_parent end
			auto_recycle (l_widget)

				-- Fetch the EiffelVision2 widget and hide it, because it is not activated yet.
			l_ev_widget := l_widget.widget
			l_ev_widget.hide
			user_widget.extend (l_ev_widget)
		end

	save_output (a_output: ES_OUTPUT_PANE_I; a_file_path: PATH)
			-- Saves the selected output to disk.
			--
			-- `a_output': The output to save to disk.
			-- `a_file_path': The full path to dump the output to.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_output_is_interface_usable: a_output.is_interface_usable
			not_a_file_path_is_empty: not a_file_path.is_empty
		local
			l_file: PLAIN_TEXT_FILE
			l_text: STRING_32
		do
			create l_file.make_with_path (a_file_path)
			l_file.open_write
			l_text := a_output.text_from_window (develop_window)
			l_file.put_string_32 (l_text)
			l_file.flush
			l_file.close
		rescue
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		end

	start_icon_animation
			-- Initializes the start of the icon animation on the output pane.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_icons: like icon_animations
			l_output_icons: ARRAY [EV_PIXEL_BUFFER]
			l_icon_pixmaps: like icon_pixmap_animations
			l_output_icon_pixmaps: ARRAY [EV_PIXMAP]
			l_timer: like icon_animation_timer
			i, l_upper: INTEGER
		do
				-- Set the new animation icon list
			if attached output as l_output then
				l_output_icons := l_output.icon_animations
				create l_icons.make (l_output_icons.upper)
				from
					i := 1
					l_upper := l_output_icons.upper
				until
					i > l_upper
				loop
					l_icons.extend (l_output_icons[i])
					i := i + 1
				end

				l_output_icon_pixmaps := l_output.icon_pixmap_animations
				create l_icon_pixmaps.make (l_output_icon_pixmaps.upper)
				from
					i := 1
					l_upper := l_output_icon_pixmaps.upper
				until
					i > l_upper
				loop
					l_icon_pixmaps.extend (l_output_icon_pixmaps[i])
					i := i + 1
				end
			else
				create l_icons.make (1)
				l_icons.extend (tool_descriptor.icon)
				create l_icon_pixmaps.make (1)
				l_icon_pixmaps.extend (tool_descriptor.icon_pixmap)
			end
				-- Reset the animation so the next icon will be the first
			l_icons.start
			l_icon_pixmaps.start
			l_icons.back
			l_icon_pixmaps.back
			icon_animations := l_icons
			icon_pixmap_animations := l_icon_pixmaps

				-- Perform the first animation step
			on_icon_animation_timeout

				-- Start the timer
			l_timer := icon_animation_timer
			check l_timer_detached: l_timer = Void end
			create l_timer.make_with_interval (200)
			register_action (l_timer.actions, agent on_icon_animation_timeout)
			icon_animation_timer := l_timer
		ensure
			icon_animations_attached: icon_animations /= Void
			icon_pixmap_animations_attached: icon_pixmap_animations /= Void
			icon_animation_timer_attached: icon_animation_timer /= Void
		end

	end_icon_animation
			-- Ends the icon animation on the output pane.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
				-- Remove timer.
			if attached icon_animation_timer as l_timer then
				l_timer.set_interval (0)
				unregister_action (l_timer.actions, agent on_icon_animation_timeout)
				l_timer.destroy
			else
				check l_timer_attached: False end
			end

			icon_animation_timer := Void
			icon_animations := Void
			icon_pixmap_animations := Void

				-- Put back the icon.
			if attached output as l_output then
				content.set_pixel_buffer (l_output.icon_active)
				content.set_pixmap (l_output.icon_active_pixmap)
			else
				content.set_pixel_buffer (tool_descriptor.icon)
				content.set_pixmap (tool_descriptor.icon_pixmap)
			end
		ensure
			icon_animations_detached: icon_animations = Void
			icon_pixmap_animations_detached: icon_pixmap_animations = Void
			icon_animation_timer_detached: icon_animation_timer = Void
		end

feature {NONE} -- Action handlers

	on_selected_editor_changed
			-- Called when the user opts to change the selected editor
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_item: EV_LIST_ITEM
		do
			l_item := selection_combo.selected_item
			check l_item_attached: l_item /= Void end
			if attached {like output} l_item.data as l_active_output then
				set_output (l_active_output)
			else
				check no_data: False end
			end
		end

	on_save
			-- Called when the user requests to save the active editor.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			output_attached: output /= Void
		local
			l_file_name: PATH
			l_dialog: ES_STANDARD_SAVE_DIALOG
		do
			on_output_modified (output)

				-- Create output file name.
			create l_file_name.make_from_string (output.name + ".txt")

				-- Show save dialog.
			create l_dialog.make_with_sticky_path (locale_formatter.formatted_translation (t_save_1, [output.name]), {ES_STANDARD_DIALOG_STICKY_IDS}.global_sticky_id)
			l_dialog.is_all_files_filter_supported := True
			l_dialog.set_start_file_name (l_file_name)
			l_dialog.show_on_active_window
			if l_dialog.is_confirmed then
				save_output (output, l_dialog.file_path)
			end
		end

	on_search
			-- Called when the user requests to search the active editor.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if attached last_output as l_output then
				check l_output.is_searchable end
				l_output.search_window (develop_window)
			end
		end

	on_clear
			-- Called when the user requests to clear the active editor.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_output_pane: like output
		do
			l_output_pane := output
			if attached l_output_pane then
				l_output_pane.clear
			end
		end

	on_icon_animation_timeout
			-- Steps the icon animation on the output tool panel.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			icon_animations_attached: icon_animations /= Void
			icon_pixmap_animations_attached: icon_pixmap_animations /= Void
		local
			l_icon: EV_PIXEL_BUFFER
			l_icon_pixmap: EV_PIXMAP
		do
				-- Retrieve active icon
			if attached output as l_output then
				l_icon := l_output.icon_active
				l_icon_pixmap := l_output.icon_active_pixmap
			else
				l_icon := tool_descriptor.icon
				l_icon_pixmap := tool_descriptor.icon_pixmap
			end

			if attached icon_animations as l_icons then
					-- Set the next pixel buffer
				if not l_icons.after then
					l_icons.forth
				end
				if l_icons.after then
					l_icons.start
				end
				l_icon := l_icons.item
				check l_icon_attached: l_icon /= Void end

					-- Set icon
				content.set_pixel_buffer (l_icon)
			else
				check no_icons_set: False end
			end
			if attached icon_pixmap_animations as l_icons then
					-- Set the next icon
				if not l_icons.after then
					l_icons.forth
				end
				if l_icons.after then
					l_icons.start
				end
				l_icon_pixmap := l_icons.item
				check l_icon_pixmap_attached: l_icon_pixmap /= Void end

					-- Set icon
				content.set_pixmap (l_icon_pixmap)
			else
				check no_icons_set: False end
			end
		end

feature {REGISTRAR_I} -- Event handlers

	on_output_unregistered (a_registrar: attached OUTPUT_MANAGER_S; a_registration: attached CONCEALER_I [OUTPUT_I]; a_key: attached UUID)
			-- <Precursor>
		do
			if a_registration.is_revealed then
				if attached {ES_OUTPUT_PANE_I} a_registration.object as l_output_pane then
					remove_output (l_output_pane)
				end
			end
		end

	on_output_activated (a_registrar: attached OUTPUT_MANAGER_S; a_registration: attached OUTPUT_I; a_key: attached UUID)
			-- <Precursor>
		do
				-- The output pane has been created in the registrar (as `on_output_activated' is a renamed
				-- feature from {REGISTRAR_OBSERVER}. Now we can extend the UI to include the actual widget.
			if attached {ES_OUTPUT_PANE_I} a_registration as l_output_pane then
				extend_output (l_output_pane)
			end
		end

feature {LOCKABLE_I} -- Event handlers

	on_output_locked (a_lock: attached ES_OUTPUT_PANE_I)
			-- <Precursor>
		do
			if is_interface_usable and then is_initialized and then a_lock = output then
				clear_button.disable_sensitive
				start_icon_animation
			end
		end

	on_output_unlocked (a_lock: attached ES_OUTPUT_PANE_I)
			-- <Precursor>
		do
			if is_interface_usable and then is_initialized and then a_lock = output then
				clear_button.enable_sensitive
				end_icon_animation
			end
		end

feature {NONE} -- Events handlers

	on_output_modified (a_output: attached ES_OUTPUT_PANE_I)
			-- Called when an output pane has been modified with new text.
			--
			-- `a_output': The output containing modifications.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_output_is_interface_usable: a_output.is_interface_usable
		local
			l_outputs: like modified_outputs
			l_tool_bar: like modified_outputs_tool_bar
			l_main_tool_bar: like tool_bar_widget
			l_name: attached IMMUTABLE_STRING_32
			l_button: SD_TOOL_BAR_BUTTON
		do
			if a_output /= last_output then
				l_outputs := modified_outputs
				l_name := a_output.name
				if not l_outputs.has (l_name) then
					l_tool_bar := modified_outputs_tool_bar
					l_main_tool_bar := tool_bar_widget
					check
						l_tool_bar_attached: attached l_tool_bar
						l_main_tool_bar_attached: attached l_main_tool_bar
					end

						-- Add the output to the table of modified outputs.
					create l_button.make
					l_button.set_pixel_buffer (stock_pixmaps.icon_buffer_with_overlay (a_output.icon, stock_pixmaps.overlay_warning_icon_buffer, 0, 0))
					l_button.set_pixmap (stock_pixmaps.icon_with_overlay (a_output.icon_pixmap, stock_pixmaps.overlay_warning_icon_buffer, 0, 0))
					l_button.set_tooltip (locale_formatter.formatted_translation (tt_show_modified_output_1, [l_name]))
					register_action (l_button.select_actions, agent set_output (a_output))
					l_tool_bar.extend (l_button)
					l_tool_bar.compute_minimum_size
					l_tool_bar.update_size
					l_main_tool_bar.compute_minimum_size
					l_main_tool_bar.update_size
					if l_outputs.is_empty then
						l_tool_bar.show
					end
					l_outputs.force ([a_output, l_button], l_name)
				end
			end
		ensure
			modified_outputs_has_a_output: (a_output /= last_output) implies modified_outputs.has (a_output.name)
			modified_outputs_tool_bar_is_displayed: (a_output /= last_output and is_shown) implies modified_outputs_tool_bar.is_displayed
		end

	on_output_shown (a_output: attached ES_OUTPUT_PANE_I)
			-- Called when an output pane is shown on the UI.
			--
			-- `a_output': The output shown on the UI.
		require
			is_interface_usable: is_interface_usable
			a_output_is_interface_usable: a_output.is_interface_usable
		local
			l_outputs: like modified_outputs
			l_tool_bar: like modified_outputs_tool_bar
			l_main_tool_bar: like tool_bar_widget
			l_name: attached IMMUTABLE_STRING_32
			l_item: TUPLE [output: attached ES_OUTPUT_PANE_I; button: attached SD_TOOL_BAR_BUTTON]
		do
			l_outputs := modified_outputs
			l_name := a_output.name
			if l_outputs.has (l_name) then
				l_tool_bar := modified_outputs_tool_bar
				l_main_tool_bar := tool_bar_widget
				check
					l_tool_bar_attached: attached l_tool_bar
					l_main_tool_bar_attached: attached l_main_tool_bar
				end

					-- Need to remove the tool bar button
				l_item := l_outputs.item (l_name)
				check l_item_attached: attached l_item end
				unregister_action (l_item.button.select_actions, agent set_output (a_output))
					-- Remove from the modified list and the button from the toolbar.
				l_outputs.remove (l_name)
					-- Remove the tooltip from the button. This addresses bug#16262.
				l_item.button.set_tooltip (Void)
					-- Remove button from the tool bar.
				l_tool_bar.prune (l_item.button)

				if l_outputs.is_empty then
						-- No more outputs, hide the tool bar.
					l_tool_bar.hide
				end
				l_tool_bar.compute_minimum_size
				l_tool_bar.update_size
				l_main_tool_bar.compute_minimum_size
				l_main_tool_bar.update_size
			end

				-- Enable search functionality.
			if a_output.is_searchable then
				search_button.enable_sensitive
			else
				search_button.disable_sensitive
			end

				-- Ensure the last output is set.
			last_output := a_output

				-- Set the tab icons.
			content.set_pixel_buffer (a_output.icon_active)
			content.set_pixmap (a_output.icon_active_pixmap)
		ensure
			last_output_set: last_output = a_output
			not_modified_outputs_has_a_output: not modified_outputs.has (a_output.name)
			not_modified_outputs_tool_bar_is_displayed: modified_outputs.is_empty implies not modified_outputs_tool_bar.is_displayed
		end

feature {NONE} -- Factory

	create_widget: EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

	create_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_box: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
			l_combo: EV_COMBO_BOX
			l_button: SD_TOOL_BAR_BUTTON
			l_widget: SD_TOOL_BAR_RESIZABLE_ITEM
			l_tool_bar: SD_TOOL_BAR
		do
			create Result.make (4)

			create l_box
			l_box.set_minimum_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (280))
			l_box.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

				-- Output Label
			create l_label.make_with_text (locale_formatter.translation (lb_output) + ":")
			l_box.extend (l_label)
			l_box.disable_item_expand (l_label)

				-- Selection list
			create l_combo
			l_combo.set_tooltip (locale_formatter.translation (tt_output_list))
			l_combo.set_minimum_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (220))
			l_combo.disable_edit
			l_box.extend (l_combo)
			selection_combo := l_combo

			create l_widget.make (l_box)
			Result.extend (l_widget)

				-- Save button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_save_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_save_icon)
			l_button.set_tooltip (locale_formatter.translation (tt_save_output))
			Result.extend (l_button)
			save_button := l_button

				-- Search button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.tool_search_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.tool_search_icon)
			l_button.set_tooltip (locale_formatter.translation (tt_search_output))
			Result.extend (l_button)
			search_button := l_button

				-- Tool bar for modified outputs
			create l_tool_bar.make
			l_tool_bar.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
			l_tool_bar.hide
			Result.extend (create {SD_TOOL_BAR_WIDGET_ITEM}.make (l_tool_bar))
			modified_outputs_tool_bar := l_tool_bar
		ensure then
			result_attached: Result /= Void
		end

	create_right_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_button: SD_TOOL_BAR_BUTTON
		do
			create Result.make (1)

				-- Clear button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_reset_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_reset_icon)
			Result.extend (l_button)
			clear_button := l_button
		ensure then
			result_attached: Result /= Void
		end

feature {NONE} -- Internationalization

	t_save_1: STRING = "Save $1 Output"

	lb_output: STRING = "Output"

	tt_output_list: STRING = "Select an alternative the output"
	tt_save_output: STRING = "Save current output to disk"
	tt_search_output: STRING = "Search the output"
	tt_clear_output: STRING = "Clear current output"
	tt_show_modified_output_1: STRING = "Show the modified $1 output"

;note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
