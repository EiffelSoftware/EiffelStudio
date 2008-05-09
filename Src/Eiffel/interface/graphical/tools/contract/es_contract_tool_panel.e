indexing
	description: "[
		The contract editor tool graphical panel.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CONTRACT_TOOL_PANEL

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [ES_GRID]
		redefine
			on_after_initialized,
			internal_recycle,
			query_set_stone,
			synchronize,
			create_right_tool_bar_items,
			on_show,
			on_handle_key
		end

	SESSION_EVENT_OBSERVER
		export
			{NONE} all
		redefine
			on_session_value_changed
		end

	CODE_TEMPLATE_CATALOG_OBSERVER
		export
			{NONE} all
		redefine
			on_catalog_changed
		end

	ES_MODIFIABLE
		undefine
			internal_detach_entities
		redefine
			internal_recycle,
			query_save_modified,
			on_dirty_state_changed
		end

create {ES_CONTRACT_TOOL}
	make

feature {NONE} -- Initialization

    build_tool_interface (a_widget: ES_GRID)
            -- Builds the tools user interface elements.
            -- Note: This function is called prior to showing the tool for the first time.
            --
            -- `a_widget': A widget to build the tool interface using.
		do
				-- Edit context menu
			create edit_menu
			create edit_menu_item.make_with_text (interface_names.m_edit)
			register_action (edit_menu_item.select_actions, agent on_edit_contract)
			edit_menu.extend (edit_menu_item)

				--
				-- Set up actions
				--
			register_action (contract_editor.source_selection_actions, agent on_source_selected_in_editor)

				-- Register action to edit on double click
			register_action (contract_editor.widget.pointer_double_press_item_actions, agent (ia_x, ia_y, ia_button: INTEGER_32)
				require
					is_interface_usable: is_interface_usable
					is_initialized: is_initialized
				do
					if ia_button = 1 and then contract_editor.widget.item_at_virtual_position (ia_x, ia_y) /= Void then
							-- The check above ensures there is actually an item at this location.
						if has_stone and then contract_editor.selected_line /= Void and then contract_editor.selected_line.is_editable then
							on_edit_contract
						end
					end
				end)

				-- Register action to show context menu on single click
			register_action (contract_editor.widget.pointer_button_press_item_actions, agent (ia_x, ia_y, ia_button: INTEGER_32)
				require
					is_interface_usable: is_interface_usable
					is_initialized: is_initialized
				local
					l_item: EV_GRID_ITEM
				do
					if ia_button = 3 then
						l_item := contract_editor.widget.item_at_virtual_position (ia_x, ia_y)
						if l_item /= Void then
							if not l_item.is_selected then
								contract_editor.widget.selected_rows.do_all (agent {EV_GRID_ROW}.disable_select)
								l_item.row.enable_select
								contract_editor.widget.enable_selection_on_click
							end
							on_row_selected_in_contract_editor (({!EV_GRID_ROW}) #? l_item.row, ia_x, ia_y + contract_editor.widget.header.height, ia_button)
						end
					end
				end)

			register_action (save_modifications_button.select_actions, agent on_save)
			register_action (add_contract_button.select_actions, agent add_contract_button.perform_select)
			register_action (remove_contract_button.select_actions, agent on_remove_contract)
			register_action (edit_contract_button.select_actions, agent on_edit_contract)
			register_action (move_contract_up_button.select_actions, agent on_move_contract_up)
			register_action (move_contract_down_button.select_actions, agent on_move_contract_down)
			register_action (refresh_button.select_actions, agent on_refresh)
			register_action (contract_mode_button.select_actions, agent on_contract_mode_selected)
			register_action (preconditions_menu_item.select_actions, agent set_contract_mode ({ES_CONTRACT_TOOL_EDIT_MODE}.preconditions))
			register_action (postconditions_menu_item.select_actions, agent set_contract_mode ({ES_CONTRACT_TOOL_EDIT_MODE}.postconditions))
			register_action (invaraints_menu_item.select_actions, agent set_contract_mode ({ES_CONTRACT_TOOL_EDIT_MODE}.invariants))
			register_action (show_all_lines_button.select_actions, agent on_show_all_rows)
			register_action (show_callers_button.select_actions, agent on_show_callers)

				-- Register action to perform updates on focus
			register_action (content.focus_in_actions, agent update_if_modified)

				-- Register menu item actions
			register_action (add_manual_menu_item.select_actions, agent on_add_contract)
			register_action (add_from_template_menu.select_actions, agent on_add_contract_from_template)
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor {ES_DOCKABLE_STONABLE_TOOL_PANEL}
			propagate_drop_actions (Void)

			if session_manager.is_service_available then
					-- Connect session observer.
				project_window_session_data.connect_events (Current)
			end

			if code_template_catalog.is_service_available then
					-- Connect code template catalog observer, to recieve change notifications.
				code_template_catalog.service.connect_events (Current)
			end

			if code_template_catalog.is_service_available then
					-- Update the menu
				update_code_template_list
			else
					-- Disable the menu entries because they cannot be used
--				add_from_template_for_entity_menu.disable_sensitive
				add_from_template_menu.disable_sensitive
			end

				-- Performs UI initialization
			set_contract_mode (contract_mode)
			set_is_showing_all_rows (is_showing_all_rows)

				-- Set button states
			update_stone_buttons
		end

feature {NONE} -- Clean up

	internal_recycle
			-- To be called when the button has became useless.
			-- Note: It's recommended that you do not detach objects here.
		do
			if is_initialized then
				if session_manager.is_service_available then
					if project_window_session_data.is_connected (Current) then
							-- Disconnect session value change observer.
						project_window_session_data.disconnect_events (Current)
					end
				end

				if code_template_catalog.is_service_available then
					if code_template_catalog.service.is_connected (Current) then
							-- Disconnect catalog change observer.
						code_template_catalog.service.disconnect_events (Current)
					end
				end
			end

			Precursor {ES_MODIFIABLE}
			Precursor {ES_DOCKABLE_STONABLE_TOOL_PANEL}
		end

feature {NONE} -- Access

	contract_mode: NATURAL_8 assign set_contract_mode
			-- Contract edition mode.
			-- See {ES_CONTRACT_TOOL_EDIT_MODE} for applicable modes.
		do
			if session_manager.is_service_available then
				if {l_mode: NATURAL_8_REF} project_window_session_data.value (contract_mode_session_id) and then (create {ES_CONTRACT_TOOL_EDIT_MODE}).is_valid_mode (l_mode.item) then
					Result := l_mode.item
				else
					Result := {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions
				end
			end
		end

	context: !ES_CONTRACT_EDITOR_CONTEXT [CLASSI_STONE]
			-- Available editor context.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
		do
			check contract_editor_has_context: contract_editor.has_context end
			Result ?= contract_editor.context
		end

	contract_code_templates: !DS_BILINEAR [!CODE_TEMPLATE_DEFINITION]
			-- Code template definitions for contracts.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
			code_template_catalog_is_service_available: code_template_catalog.is_service_available
		local
			l_categories: DS_ARRAYED_LIST [STRING_32]
		do
			create l_categories.make (2)
			l_categories.put_last ({CODE_TEMPLATE_ENTITY_NAMES}.contract_category)
			l_categories.put_last (context.template_category)
			Result ?= code_template_catalog.service.templates_by_category (l_categories, True)
		end

feature {NONE} -- Element change

	set_contract_mode (a_mode: like contract_mode)
			-- Sets the current contract edition mode.
			--
			-- `a_mode': The contract edition mode to see. See {ES_CONTRACT_TOOL_EDIT_MODE} for applicable modes
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_mode_is_valid_mode: (create {ES_CONTRACT_TOOL_EDIT_MODE}).is_valid_mode (a_mode)
		do
			contract_mode_button.set_text (contract_mode_label (a_mode))
			inspect a_mode
			when {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions then
				preconditions_menu_item.enable_select
			when {ES_CONTRACT_TOOL_EDIT_MODE}.postconditions then
				postconditions_menu_item.enable_select
			when {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
				invaraints_menu_item.enable_select
			end

			if session_manager.is_service_available then
				project_window_session_data.value_changed_event.perform_suspended_action (agent (ia_mode: like contract_mode)
					do
						project_window_session_data.set_value (ia_mode, contract_mode_session_id)
					end (a_mode))
			end

				-- Make this check before updating incase the mode determination changes in the future.
			check contract_mode_set: contract_mode = a_mode end
			if has_stone and stone_change_notified then
				refresh_stone
			end
		ensure
			contract_mode_set: contract_mode = a_mode
		end

feature {NONE} -- Status report

	is_showing_all_rows: BOOLEAN assign set_is_showing_all_rows
			-- Indicates if all contract rows should be shown.
			-- Note: By default only those entities with contracts are shown.
		require
			is_interface_usable: is_interface_usable
		do
			if session_manager.is_service_available then
				if {l_value: BOOLEAN_REF} window_session_data.value (show_all_lines_session_id) then
					Result := l_value.item
				end
			end
		end

	is_saving: BOOLEAN
			-- Indicates if Current's modifications are currently being saved

	is_class_file_modified_externally: BOOLEAN
			-- Indicates if the context class was modified externally.

feature {NONE} -- Status setting

	set_is_showing_all_rows (a_show: like is_showing_all_rows)
			-- Set status to show/hide rows without contracts.
			--
			-- `a_show': True to show all rows; False to show only rows with contracts
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_running: BOOLEAN
		do
			if show_all_lines_button.is_selected /= a_show then
				l_running := show_all_lines_button.select_actions.state = {ACTION_SEQUENCE [TUPLE]}.normal_state
				if l_running then
					show_all_lines_button.select_actions.block
				end
				if a_show then
					show_all_lines_button.enable_select
				else
					show_all_lines_button.disable_select
				end
				if l_running then
					show_all_lines_button.select_actions.resume
				end
			end

			contract_editor.is_showing_all_rows := a_show

			if session_manager.is_service_available then
				window_session_data.set_value (a_show, show_all_lines_session_id)
			end
		ensure
			is_showing_all_rows_set: is_showing_all_rows = a_show
		end

feature {ES_STONABLE_I, ES_TOOL} -- Query

	query_set_stone (a_stone: ?STONE): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_stone)
			if Result and then is_initialized then
				if is_dirty then
						-- Check with user if they want to save any modifications.
					Result := query_save_modified
				end

					-- Delegate the query to the actual editor.
				if Result and then has_stone then
						-- Note: Using Void is somewhat of a hack because a context cannot be set an incorrect stone (i.e Class context being set a feature stone)
						--       For this we use Void because it triggers a request to change the stone.
					Result := context.query_set_stone (Void)
				end
			end
		end

feature {NONE} -- Query

	context_for_mode: ?ES_CONTRACT_EDITOR_CONTEXT [CLASSI_STONE]
			-- Fetches an editor context given a stone
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
		do
			inspect contract_mode
			when {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions then
				create {ES_PRECONDITION_CONTRACT_EDITOR_CONTEXT} Result
			when {ES_CONTRACT_TOOL_EDIT_MODE}.postconditions then
				create {ES_POSTCONDITION_CONTRACT_EDITOR_CONTEXT} Result
			when {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
				create {ES_INVARIANT_CONTRACT_EDITOR_CONTEXT} Result
			end

			if Result /= Void and then Result.is_stone_usable (stone) then
					-- Set stone on context
				Result.set_stone_with_query (stone)
			else
				Result := Void
			end
		ensure
			stone_set: Result /= Void implies Result.stone = stone
		end

	query_save_modified: BOOLEAN
			-- Performs a query, generally involving some user interaction, determining if an action can be performed
			-- given a dirty state.
		local
			l_save_classes_prompt: ES_SAVE_CLASSES_PROMPT
			l_save_feature_prompt: ES_SAVE_FEATURES_PROMPT
			l_classes: DS_ARRAYED_LIST [CLASS_I]
			l_features: DS_ARRAYED_LIST [E_FEATURE]
			l_prompt: ES_PROMPT
		do
			check is_initialized: is_initialized end
			if contract_editor.has_context then
				if {l_feat_context: ES_FEATURE_CONTRACT_EDITOR_CONTEXT} context then
					create l_features.make_from_array (<<l_feat_context.context_feature>>)
					create l_save_feature_prompt.make_standard_with_cancel (
						"The Contract Tool has unsaved class feature changes.%N%N%
						%Do you wanted to save the following feature?")
					l_save_feature_prompt.features := l_features
					l_prompt := l_save_feature_prompt
				elseif {l_class_context: ES_CLASS_CONTRACT_EDITOR_CONTEXT} context then
					create l_classes.make_from_array (<<l_class_context.context_class>>)
					create l_save_classes_prompt.make_standard_with_cancel (
						"The Contract Tool has unsaved class changes.%N%N%
						%Do you wanted to save the following class?")
					l_save_classes_prompt.classes := l_classes
					l_prompt := l_save_classes_prompt
				end
				check l_prompt_attached: l_prompt /= Void end
				l_prompt.set_button_action (l_prompt.dialog_buttons.yes_button, agent on_save)
				l_prompt.show_on_active_window
				Result := l_prompt.dialog_result /= {ES_DIALOG_BUTTONS}.cancel_button
			else
				Result := Precursor
			end
		end

--	is_editable_row (a_row: !EV_GRID_ROW): BOOLEAN
--			-- Determines if a row is editable
--			--
--			-- `a_row': A row to determine editability.
--			-- `Result': True if the row is editable; False otherwise.
--		do
--			Result := True
--		end

feature {NONE} -- Basic operations

	refresh_context
			-- Refreshes the editor to include new changes.
			-- Note: This only refreshes the already set context information and will not go out to disk or the editor
			--       to refresh the context context. For this use `update'. However be sure the editor contains loaded
			--       text or your will recieve stale content.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
			not_is_dirty: not is_dirty
		do
			execute_with_busy_cursor (agent contract_editor.refresh)
		end

	update
			-- Updates the view with an new context.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_is_dirty: not is_dirty
		do
			if has_stone and then {l_context: !like context_for_mode} context_for_mode then
				execute_with_busy_cursor (agent contract_editor.set_context (l_context))
			end
			update_stone_buttons

				-- Update the templates to display only the applicable templates.
			update_code_template_list
		ensure
			not_is_dirty: not is_dirty
		end

	update_if_modified
			-- Performs an update if the class file has been modified
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if
				has_stone and then
				file_notifier.is_service_available and then
				{l_file_name: !FILE_NAME} context.context_class.file_name and then
				{l_fn: !STRING_32} l_file_name.string.as_string_32
			then
					-- Poll for modifications, which will call `on_file_modified' if have occurred.
				file_notifier.service.poll_modifications (l_fn).do_nothing
			end
		end

	save_contracts
			-- Saves the currently modified contracts.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			is_dirty: is_dirty
		do
			set_is_dirty (False)
		ensure
			not_is_dirty: not is_dirty
		end

feature {ES_STONABLE_I, ES_TOOL} -- Synchronization

	synchronize
			-- Synchronizes any new data (compiled or other wise)
		do
			if is_initialized then
				is_in_stone_synchronization := True
				update
				is_in_stone_synchronization := False
			end
		rescue
			is_in_stone_synchronization := False
		end

feature {NONE} -- Helpers

	frozen file_notifier: !SERVICE_CONSUMER [FILE_NOTIFIER_S]
			-- Access to the file notifier service
		once
			create Result
		end

	frozen code_template_catalog: !SERVICE_CONSUMER [CODE_TEMPLATE_CATALOG_S]
			-- Access to the code template catalog service
		once
			create Result
		end

feature {NONE} -- User interface elements

	save_modifications_button:? SD_TOOL_BAR_BUTTON
			-- Button to save modified contracts.

	add_contract_button: ?SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button to add a new contract to the current feature.

	add_menu: ?EV_MENU
			-- Menu to add contracts.

	add_manual_menu_item: ?EV_MENU_ITEM
			-- Menu item to add contracts manually.

	add_from_template_menu: ?EV_MENU
			-- Menu to save contracts and open modified class.

--	add_from_template_for_entity_menu: ?EV_MENU
--			-- Menu to add a template contract for a given argument/class attribute

	edit_menu: ?EV_MENU
			-- Menu to edit contracts.

	edit_menu_item: ?EV_MENU_ITEM
			-- Menu item to edit a selected contract.

	remove_contract_button: ?SD_TOOL_BAR_BUTTON
			-- Button to remove a selected contract.

	edit_contract_button: ?SD_TOOL_BAR_BUTTON
			-- Button to edit a selected contract.

	move_contract_up_button: ?SD_TOOL_BAR_BUTTON
			-- Button to move the selected contract up.

	move_contract_down_button: ?SD_TOOL_BAR_BUTTON
			-- Button to move the selected contract down.

	refresh_button: ?SD_TOOL_BAR_BUTTON
			-- Button to refresh the selected contract.

	contract_mode_button: ?SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button to select the contract edit mode.

	preconditions_menu_item: ?EV_RADIO_MENU_ITEM
			-- Menu item to show preconditions.

	postconditions_menu_item: ?EV_RADIO_MENU_ITEM
			-- Menu item to show postconditions.

	invaraints_menu_item: ?EV_RADIO_MENU_ITEM
			-- Menu item to show invariants.

	show_all_lines_button: ?SD_TOOL_BAR_TOGGLE_BUTTON
			-- Button to show/hide hidden non-contract enabled rows.

	show_callers_button: ?SD_TOOL_BAR_BUTTON
			-- Button to show the callers of the edited feature.

	contract_editor: ?ES_CONTRACT_EDITOR_WIDGET
			-- The editor used to edit the contracts.

feature {NONE} -- User interface manipulation

	update_stone_buttons
			-- Updates the buttons based on a stone.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if {l_fstone: FEATURE_STONE} stone then
					-- Feature context
				contract_mode_button.enable_sensitive
				invaraints_menu_item.disable_sensitive
				refresh_button.enable_sensitive
				show_all_lines_button.enable_sensitive
				show_callers_button.enable_sensitive
				show_callers_button.set_pixmap (stock_pixmaps.feature_callees_icon)
				show_callers_button.set_pixel_buffer (stock_pixmaps.feature_callees_icon_buffer)
			elseif contract_editor.has_context then
					-- Class context
				contract_mode_button.disable_sensitive
				refresh_button.enable_sensitive
				show_all_lines_button.enable_sensitive
				show_callers_button.enable_sensitive
				show_callers_button.set_pixmap (stock_pixmaps.class_descendents_icon)
				show_callers_button.set_pixel_buffer (stock_pixmaps.class_descendents_icon_buffer)
			else
					-- No context
				contract_mode_button.enable_sensitive
				invaraints_menu_item.enable_sensitive
				refresh_button.disable_sensitive
				show_all_lines_button.disable_sensitive
				show_callers_button.disable_sensitive
			end

--			if contract_editor.has_context then
--				if contract_mode = {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
--					add_from_template_for_entity_menu.set_text ("Add Contract for Class Attribute")
--				else
--					add_from_template_for_entity_menu.set_text ("Add Contract for Argument")
--				end
--			end

			update_editable_buttons
		end

	update_editable_buttons
			-- Updates the editable context buttons based on the contract editor's current state.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_editor: ?like contract_editor
			l_source: ?ES_CONTRACT_SOURCE_I
			l_line: ?ES_CONTRACT_LINE
			l_contracts: !DS_BILINEAR [!ES_CONTRACT_LINE]
		do
			l_editor := contract_editor
			l_source := l_editor.selected_source
			if l_source /= Void and then l_source.is_editable then
				add_contract_button.enable_sensitive
				l_line := l_editor.selected_line
				if l_line /= Void then
					remove_contract_button.enable_sensitive
					edit_contract_button.enable_sensitive
					l_contracts := l_editor.context_contracts
					if l_contracts.is_empty or else l_contracts.last /= l_line then
						move_contract_down_button.enable_sensitive
					else
						move_contract_down_button.disable_sensitive
					end
					if l_contracts.is_empty or else l_contracts.first /= l_line then
						move_contract_up_button.enable_sensitive
					else
						move_contract_up_button.disable_sensitive
					end
				else
					remove_contract_button.disable_sensitive
					edit_contract_button.disable_sensitive
					move_contract_down_button.disable_sensitive
					move_contract_up_button.disable_sensitive
				end
			else
				add_contract_button.disable_sensitive
				remove_contract_button.disable_sensitive
				edit_contract_button.disable_sensitive
				move_contract_down_button.disable_sensitive
				move_contract_up_button.disable_sensitive
			end
		end

	update_code_template_list
			-- Updates the code template list for the add from template menu.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			code_template_catalog_is_service_available: code_template_catalog.is_service_available
		local
			l_cursor: DS_BILINEAR_CURSOR [!CODE_TEMPLATE_DEFINITION]
			l_definition: !CODE_TEMPLATE_DEFINITION
			l_title: !STRING_32
			l_menu: !EV_MENU
			l_menu_item: EV_MENU_ITEM
		do
			l_menu ?= add_from_template_menu
			l_menu.wipe_out

			if has_stone and then contract_editor.has_context then
				l_cursor := contract_code_templates.new_cursor
				from l_cursor.start until l_cursor.after loop
					l_definition := l_cursor.item
					l_title := l_definition.metadata.title
					if l_title.is_empty then
						l_title := l_definition.metadata.shortcut
					end
					if not l_title.is_empty then
						create l_menu_item.make_with_text (l_title)
						l_menu_item.set_pixmap (stock_pixmaps.general_document_icon)
						l_menu_item.set_data (l_definition)
						l_menu_item.select_actions.extend (agent on_add_contract_from_template (l_definition))
						l_menu.extend (l_menu_item)
					end
					l_cursor.forth
				end
				add_from_template_menu.enable_sensitive
			else
				add_from_template_menu.disable_sensitive
			end
		end

feature {NONE} -- Actions handlers

	on_row_selected (a_row: EV_GRID_ROW)
			-- Called when a grid row is selected
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_row_attached: a_row /= Void
		do
			if {l_row: EV_GRID_ROW} a_row then
				--update_context_buttons (is_editable_row (l_row))
			end
		end

feature {SESSION_I} -- Event handlers

	on_session_value_changed (a_session: SESSION_I; a_id: STRING_8)
			-- <Precursor>
		local
			l_mode: NATURAL_8_REF
		do
			Precursor {SESSION_EVENT_OBSERVER} (a_session, a_id)
			if a_id.is_equal (contract_mode_session_id) then
				l_mode ?= project_window_session_data.value (contract_mode_session_id)
				if l_mode /= Void then
					set_contract_mode (l_mode.item)
				end
			end
		end

feature {CODE_TEMPLATE_CATALOG_S} -- Event handlers

	on_catalog_changed
			-- <Precursor>
		do
			Precursor {CODE_TEMPLATE_CATALOG_OBSERVER}
			if is_initialized then
					-- Update the code templates menu
				update_code_template_list
			end
		end

feature {NONE} -- Event handlers

	on_dirty_state_changed
			-- <Precursor>
		do
			Precursor
			if is_interface_usable and then is_initialized then
				if is_class_file_modified_externally then
						-- Update the save button, because it may have been modified due to external file
						-- modifications.
					save_modifications_button.set_pixel_buffer (stock_pixmaps.general_save_icon_buffer)
					save_modifications_button.set_pixmap (stock_pixmaps.general_save_icon)

					is_class_file_modified_externally := False
				end

				if is_dirty then
					save_modifications_button.enable_sensitive
				else
					save_modifications_button.disable_sensitive
				end
			end
		ensure then
			not_is_class_file_modified_externally: not is_class_file_modified_externally
		end

	on_file_modified (a_modification_type: NATURAL_8)
			-- Called when a file is modified externally of Current.
			--
			-- `a_modification_type': The type of modification applied to the file. See FILE_NOTIFIER_MODIFICATION_TYPES for the respective flags
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_new_buffer: EV_PIXEL_BUFFER
		do
			if is_initialized and then has_stone and then not is_saving then
				if shown then
					if (a_modification_type & {FILE_NOTIFIER_MODIFICATION_TYPES}.file_deleted) = {FILE_NOTIFIER_MODIFICATION_TYPES}.file_deleted then
						set_stone (Void)
					elseif not is_dirty then
						refresh_stone
					else
						check is_dirty: is_dirty end

							-- Add a warning overlay to the save button
						l_new_buffer := (create {EB_SHARED_PIXMAPS}).icon_buffer_with_overlay (stock_pixmaps.general_save_icon_buffer, stock_pixmaps.overlay_warning_icon_buffer, 0, 0)
						save_modifications_button.set_pixel_buffer (l_new_buffer)
						save_modifications_button.set_pixmap (l_new_buffer)
					end
				else
					last_file_change_notified_agent := agent on_file_modified (a_modification_type)
				end

				if is_dirty then
						-- There have been modifications so preseve the state because the next save should notify the user.
					is_class_file_modified_externally := True
				end
			end
		end

feature {NONE} -- Tool action handlers

	on_stone_changed (a_old_stone: ?like stone)
			-- <Precursor>
		local
			l_service: FILE_NOTIFIER_S
		do
			if file_notifier.is_service_available then
				l_service := file_notifier.service
				if a_old_stone /= Void and then {l_old_cs: !CLASSI_STONE} a_old_stone and then {l_old_fn: !STRING_32} l_old_cs.class_i.file_name.string.as_string_32 then
						-- Remove old monitor
					if l_service.is_monitoring (l_old_fn) then
						l_service.uncheck_modifications_with_callback (l_old_fn, agent on_file_modified)
					end
				end

				if stone /= Void and then {l_new_cs: !CLASSI_STONE} stone and then {l_new_fn: !STRING_32} l_new_cs.class_i.file_name.string.as_string_32 then
						-- Add monitor
					l_service.check_modifications_with_callback (l_new_fn, agent on_file_modified)
				end
			end

			if {l_fs: !FEATURE_STONE} stone then
				if contract_mode = {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
						-- A feature was dropped so we should switch to a feature contract mode.
						-- Calling `set_contract_mode' will call `update'
					set_contract_mode ({ES_CONTRACT_TOOL_EDIT_MODE}.preconditions)
				end
			else
				if {l_cs: !CLASSI_STONE} stone then
					if contract_mode /= {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
							-- A feature was dropped so we should switch to a feature contract mode.
							-- Calling `set_contract_mode' will call `update'
						set_contract_mode ({ES_CONTRACT_TOOL_EDIT_MODE}.invariants)
					end
				end
			end

			set_is_dirty (False)
			update

				-- Update session.
				-- This is done here because it only needs to be persisted when there is a stone change.
			if session_manager.is_service_available then
				project_window_session_data.set_value (contract_mode, contract_mode_session_id)
			end
		end

	on_show
			-- <Precursor>
		do
			Precursor
			if last_file_change_notified_agent /= Void then
					-- There was a file change notification issued when the tool was not shown
				last_file_change_notified_agent.call (Void)
				last_file_change_notified_agent := Void
			else
					-- Just for piece of mind, update if the file was modified
				update_if_modified
			end
		ensure then
			last_file_change_notified_agent_detached: last_file_change_notified_agent = Void
		end

	on_handle_key (a_key: EV_KEY; a_alt: BOOLEAN; a_ctrl: BOOLEAN; a_shift: BOOLEAN; a_released: BOOLEAN): BOOLEAN is
			-- <Precursor>
		do
			if contract_editor.has_context then
				if not a_released then
						-- Pressed actions
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_s then
							-- Save
						Result := not a_alt and not a_shift and a_ctrl
						if Result and is_dirty then
							on_save
						end
					else

					end
				else
						-- Released actions
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_f5 then
						Result := not a_alt and not a_shift and not a_ctrl
						if Result then
							on_refresh
						end
					when {EV_KEY_CONSTANTS}.key_n then
						Result := not a_alt and not a_shift and a_ctrl and then contract_editor.selected_source /= Void
						if Result then
							on_add_contract
						end
					when {EV_KEY_CONSTANTS}.key_delete then
						Result := not a_alt and not a_shift and not a_ctrl and then contract_editor.selected_source /= Void
						if Result then
							on_remove_contract
						end
					when {EV_KEY_CONSTANTS}.key_enter, {EV_KEY_CONSTANTS}.key_f2 then
						Result := not a_alt and not a_shift and not a_ctrl and then contract_editor.selected_line /= Void
						if Result then
							on_edit_contract
						end
					when {EV_KEY_CONSTANTS}.key_u then
							-- Using the button sensitive state is kind of a hack, but it's effective.
						Result := not a_alt and not a_shift and a_ctrl and then contract_editor.selected_line /= Void and then move_contract_up_button.is_sensitive
						if Result then
							on_move_contract_up
						end
					when {EV_KEY_CONSTANTS}.key_d then
							-- Using the button sensitive state is kind of a hack, but it's effective.
						Result := not a_alt and not a_shift and a_ctrl and then contract_editor.selected_line /= Void and then move_contract_down_button.is_sensitive
						if Result then
							on_move_contract_down
						end
					else

					end
				end
			end
			if not Result then
				Result := Precursor (a_key, a_alt, a_ctrl, a_shift, a_released)
			end
		end

feature {NONE} -- Action handlers

	on_save
			-- Called when the user chooses to save the modified contracts
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
			is_dirty: is_dirty
			not_is_saving: not is_saving
		local
			l_contracts: !DS_BILINEAR [!ES_CONTRACT_LINE]
			l_assertions: !DS_ARRAYED_LIST [STRING]
			l_error: ES_ERROR_PROMPT
			l_question: ES_QUESTION_WARNING_PROMPT
			l_check_modifier: ES_CLASS_TEXT_AST_MODIFIER
			retried: BOOLEAN
		do
			if not retried then
				is_saving := True

				if is_class_file_modified_externally then
					create l_question.make_standard (messages.w_contract_tool_merge_changes (context.context_class.name))
					l_question.show_on_active_window
				end

				if l_question = Void or else l_question.dialog_result = l_question.default_confirm_button then
						-- Warn user about syntax invalid class files
					create l_check_modifier.make (context.context_class)
					l_check_modifier.prepare
					if not l_check_modifier.is_ast_available then
							-- The class contains syntax errors
						create l_question.make_standard (messages.w_contract_tool_merge_syntax_invalid_changes (context.context_class.name))
						l_question.show_on_active_window
					end
				end

				if l_question = Void or else l_question.dialog_result = l_question.default_confirm_button then
					if {l_modifier: ES_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]} context.text_modifier then
						l_contracts := contract_editor.context_contracts
						if not l_contracts.is_empty then
							create l_assertions.make (l_contracts.count)
							from l_contracts.start until l_contracts.after loop
								l_assertions.put_last (l_contracts.item_for_iteration.string)
								l_contracts.forth
							end
						else
							create l_assertions.make (0)
						end
						l_modifier.replace_contracts (l_assertions)
						if l_modifier.is_dirty then
							l_modifier.commit

								-- Perform an update to recieve the most current information
							set_is_dirty (False)
							refresh_context
						else
							check False end
						end
					else
						check False end
					end
				end

				is_saving := False
			else
				create l_error.make_standard (messages.e_contract_tool_save_failed)
				l_error.show_on_active_window
			end

				-- Set focus back to editor.
			contract_editor.widget.set_focus
		ensure
			is_saving_unchanged: is_saving = old is_saving
		rescue
			retried := True
			is_saving := False
			retry
		end

	on_add_contract
			-- Called when the user chooses to add a new contract to the existing feature.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
			contract_editor_has_selected_source: contract_editor.selected_source /= Void
			contract_editor_source_is_editable: contract_editor.selected_source.is_editable
		local
			l_dialog: ES_ADD_CONTRACT_DIALOG
			l_source: !ES_CONTRACT_SOURCE_I
		do
			l_source ?= contract_editor.selected_source
			create l_dialog.make
			l_dialog.show_on_active_window
			if l_dialog.dialog_result = l_dialog.default_confirm_button then
				contract_editor.add_contract (l_dialog.contract.tag, l_dialog.contract.contract, l_source)
				set_is_dirty (True)
			end

				-- Set focus back to editor.
			contract_editor.widget.set_focus
		end

	on_add_contract_from_template (a_template: !CODE_TEMPLATE_DEFINITION) is
			-- Called when the user chooses to add a new contract, from a template, to the existing feature.
			--
			-- `a_template': The template to use to render a contract.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
			contract_editor_has_selected_source: contract_editor.selected_source /= Void
			contract_editor_source_is_editable: contract_editor.selected_source.is_editable
		local
			l_template: ?CODE_TEMPLATE
			l_dialog: !ES_CODE_COMPLETABLE_TEMPLATE_BUILDER_DIALOG
			l_provider: !EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER
			l_error: !ES_ERROR_PROMPT
			l_contract: !STRING_32
			l_symbol_table: !CODE_SYMBOL_TABLE
			l_value: !CODE_SYMBOL_VALUE
		do
			l_template := a_template.applicable_item
			if l_template /= Void and {l_source: ES_CONTRACT_SOURCE_I} contract_editor.selected_source then
				create l_dialog.make (l_template)

				if context.context_class.is_compiled then
						-- Set completion provider
					if {l_fcontext: ES_FEATURE_CONTRACT_EDITOR_CONTEXT} context then
						create l_provider.make (l_fcontext.context_class.compiled_class, l_fcontext.text_modifier.ast_feature)
					else
						create l_provider.make (context.context_class.compiled_class, Void)
					end
					l_dialog.set_completion_provider (l_provider)
				end

					-- Set context symbol information
				l_symbol_table := l_dialog.code_symbol_table
				if {l_fc: ES_FEATURE_CONTRACT_EDITOR_CONTEXT} context then
					if l_symbol_table.has_id (feature_name_symbol_id) then
						l_value := l_symbol_table.item (feature_name_symbol_id)
						l_value.set_value (({!STRING_32}) #? l_fc.context_feature.name.as_string_32)
					else
						create l_value.make (({!STRING_32}) #? l_fc.context_feature.name.as_string_32)
						l_symbol_table.put (l_value, feature_name_symbol_id)
					end
				end
				if {l_cc: ES_CLASS_CONTRACT_EDITOR_CONTEXT} context then
					if l_symbol_table.has_id (feature_name_symbol_id) then
						l_value := l_symbol_table.item (class_name_symbol_id)
						l_value.set_value (({!STRING_32}) #? l_cc.context_class.name.as_string_32)
					else
						create l_value.make (({!STRING_32}) #? l_cc.context_class.name.as_string_32)
						l_symbol_table.put (l_value, class_name_symbol_id)
					end
				end

				l_dialog.show_on_active_window
				if l_dialog.dialog_result = l_dialog.default_confirm_button then
						-- User committed changes
					l_contract ?= l_dialog.code_result
					if not l_contract.is_empty then
						contract_editor.add_contract_string (l_contract, l_source)
						set_is_dirty (True)
					end
				end
			else
				create l_error.make_standard (messages.e_code_template_unable_to_find_template)
				l_error.show_on_active_window
			end

				-- Set focus back to editor.
			contract_editor.widget.set_focus
		end

	on_remove_contract
			-- Called when the user chooses to remove a contract from the existing feature.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
			contract_editor_has_selected_source: contract_editor.selected_source /= Void
			contract_editor_source_is_editable: contract_editor.selected_source.is_editable
		local
			l_source: ?ES_CONTRACT_SOURCE_I
			l_question: ES_QUESTION_WARNING_PROMPT
		do
			l_source := contract_editor.selected_source
			if l_source /= Void then
				if {l_line: ES_CONTRACT_LINE} l_source then
						-- Remove selected contracts
					contract_editor.remove_contract (l_line)
					set_is_dirty (True)
				else
						-- User chooses to remove all contracts
					create l_question.make_standard (messages.w_contract_tool_removal_all)
					l_question.show_on_active_window
				end
			end

				-- Set focus back to editor.
			contract_editor.widget.set_focus
		end

	on_edit_contract
			-- Called when the user chooses to edit a contract from the existing feature.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
			contract_editor_has_selected_line: contract_editor.selected_line /= Void
			contract_editor_line_is_editable: contract_editor.selected_line.is_editable
		local
			l_line: !ES_CONTRACT_LINE
			l_contract: ?TUPLE [tag: !STRING_32; contract: !STRING_32]
			l_dialog: ES_EDIT_CONTRACT_DIALOG
		do
			l_line ?= contract_editor.selected_line
			create l_dialog.make
			l_dialog.set_contract (l_line.tag, l_line.contract)
			l_dialog.show_on_active_window
			if l_dialog.dialog_result = l_dialog.default_confirm_button and then l_dialog.is_dirty then
				l_contract := l_dialog.contract
				if not (l_line.tag.is_equal (l_contract.tag) and then l_line.contract.is_equal (l_contract.contract)) then
						-- Contract actually changed
					contract_editor.replace_contract (l_contract.tag, l_contract.contract, l_line)
					set_is_dirty (True)
				end
			end

				-- Set focus back to editor.
			contract_editor.widget.set_focus
		end

	on_move_contract_up
			-- Called when the user chooses to move a contract up.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
			contract_editor_has_selected_line: contract_editor.selected_line /= Void
			contract_editor_line_is_editable: contract_editor.selected_line.is_editable
		local
			l_contracts: !DS_BILINEAR [!ES_CONTRACT_LINE]
			l_other_line: !ES_CONTRACT_LINE
		do
			if {l_line: ES_CONTRACT_LINE} contract_editor.selected_line then
				l_contracts := contract_editor.context_contracts
				check l_contracts_has_l_line: l_contracts.has (l_line) end
				l_contracts.start
				l_contracts.search_forth (l_line)
				if not l_contracts.after then
					if l_contracts.first /= l_contracts.item_for_iteration then
						l_contracts.back
						l_other_line ?= l_contracts.item_for_iteration
						contract_editor.swap_contracts (l_line, l_other_line)
						set_is_dirty (True)
					else
							-- The up button should not be enabled!
						check False end
					end
				else
						-- You are using an outdate contract line, this is the only explaination.
					check False end
				end
			end

				-- Set focus back to editor.
			contract_editor.widget.set_focus
		ensure
			is_dirty: is_dirty
		end

	on_move_contract_down
			-- Called when the user chooses to move a contract down.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
			contract_editor_has_selected_line: contract_editor.selected_line /= Void
			contract_editor_line_is_editable: contract_editor.selected_line.is_editable
		local
			l_contracts: !DS_BILINEAR [!ES_CONTRACT_LINE]
			l_other_line: !ES_CONTRACT_LINE
		do
			if {l_line: ES_CONTRACT_LINE} contract_editor.selected_line then
				l_contracts := contract_editor.context_contracts
				check l_contracts_has_l_line: l_contracts.has (l_line) end
				l_contracts.start
				l_contracts.search_forth (l_line)
				if not l_contracts.after then
					if l_contracts.last /= l_contracts.item_for_iteration then
						l_contracts.forth
						l_other_line ?= l_contracts.item_for_iteration
						contract_editor.swap_contracts (l_line, l_other_line)
						set_is_dirty (True)
					else
							-- The down button should not be enabled!
						check False end
					end
				else
						-- You are using an outdate contract line, this is the only explaination.
					check False end
				end
			end

				-- Set focus back to editor.
			contract_editor.widget.set_focus
		ensure
			is_dirty: is_dirty
		end

	on_refresh
			-- Called when the user chooses to refresh the contracts
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
				-- We do not need to check for modifications because refresh_stone will do that job.
			refresh_stone

				-- Set focus back to editor.
			contract_editor.widget.set_focus
		end

	on_contract_mode_selected
			-- Called when the user selects the contract mode button.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_mode: like contract_mode
		do
			if contract_mode /= {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
				l_mode := contract_mode + 1
				if not (create {ES_CONTRACT_TOOL_EDIT_MODE}).is_valid_mode (l_mode) or l_mode = {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
					l_mode := {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions
				end
				perform_query_save_modified (agent set_contract_mode (l_mode))
			end

				-- Set focus back to editor.
			contract_editor.widget.set_focus
		end

	on_show_all_rows
			-- Called when the user chooses to show all the contract rows.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			set_is_showing_all_rows (show_all_lines_button.is_selected)

				-- Set focus back to editor.
			contract_editor.widget.set_focus
		end

	on_show_callers
			-- Called when the user chooses to show the callers of the edited contracts
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			has_stone: has_stone
		do
			if {l_fc: ES_FEATURE_CONTRACT_EDITOR_CONTEXT} context then
				if {l_ftool: !ES_FEATURE_RELATION_TOOL} develop_window.shell_tools.tool ({ES_FEATURE_RELATION_TOOL}) then
						-- Display feature relation tool using callers mode.
					l_ftool.set_mode_with_stone ({ES_FEATURE_RELATION_TOOL_VIEW_MODES}.callers, create {!FEATURE_STONE}.make (l_fc.context_feature))
					l_ftool.show (True)
				end
			elseif {l_cc: ES_CLASS_CONTRACT_EDITOR_CONTEXT} context then
				if {l_ctool: !ES_CLASS_TOOL} develop_window.shell_tools.tool ({ES_CLASS_TOOL}) then
						-- Display feature relation tool using callers mode.
					l_ctool.set_mode_with_stone ({ES_CLASS_TOOL_VIEW_MODES}.descendents, create {!CLASSI_STONE}.make (l_cc.context_class))
					l_ctool.show (True)
				end
			else
				check False end
			end
		end

	on_source_selected_in_editor (a_source: ?ES_CONTRACT_SOURCE_I)
			-- Called when the editor recieves a selection/deselection of a source row.
			--
			-- `a_source': A source row (or a contrac line {ES_CONTRACT_LINE}) or Void to indicate a deselection.
		do
			update_editable_buttons
		end

	on_row_selected_in_contract_editor (a_row: !EV_GRID_ROW; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER)
			-- Actions called when a row was selected in the editor.
			--
			-- `a_row': The row selected in the contract editor widget.
			-- `a_x': The X coordinate relative to the widget.
			-- `a_y': The Y coordinate relative to the widget.
			-- `a_button': The button index selected in the editor.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_row_parented: a_row.parent /= Void
			a_x_non_negative: a_x >= 0
			a_y_non_negative: a_y >= 0
		do
			if a_button = 3 then
				if has_stone and then contract_editor.selected_source /= Void and then contract_editor.selected_source.is_editable then
					if contract_editor.selected_line = Void then
							-- The contract item is select, show the add menu.
						add_menu.show_at (a_row.parent, a_x, a_y)
					else
							-- The contract is select, show the edit menu.
						edit_menu.show_at (a_row.parent, a_x, a_y)
					end
				end
			end
		end

feature {NONE} -- Action agents

	last_file_change_notified_agent: PROCEDURE [ANY, TUPLE]
			-- Last agent set for file notifications when the tool was not displayed

feature {NONE} -- Factory

    create_widget: ES_GRID
            -- Create a new container widget upon request.
            -- Note: You may build the tool elements here or in `build_tool_interface'
		do
				-- `contract_editor'
			create contract_editor.make (develop_window)
			Result := contract_editor.widget
		end

    create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display at the top of the tool.
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_dual_button: SD_TOOL_BAR_DUAL_POPUP_BUTTON
			l_menu: EV_MENU
			l_sub_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
			l_menu_radio_item: EV_RADIO_MENU_ITEM
		do
			create Result.make (13)

				-- Save contract button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_save_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_save_icon)
			l_button.set_tooltip (interface_names.t_contract_save_to_class)
			l_button.disable_sensitive
			save_modifications_button := l_button
			Result.put_last (l_button)
			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Add contract button
			create l_dual_button.make
			l_dual_button.set_pixel_buffer (stock_pixmaps.general_add_icon_buffer)
			l_dual_button.set_pixmap (stock_pixmaps.general_add_icon)
			l_dual_button.set_tooltip (interface_names.t_contract_add_contract)
			l_dual_button.disable_sensitive
			add_contract_button := l_dual_button
			Result.put_last (l_dual_button)

				-- Create menu for add selection button
			create l_menu
			add_menu := l_menu

			create l_menu_item.make_with_text (interface_names.m_contract_add_contract)
			l_menu.set_pixmap (stock_pixmaps.general_add_icon)
			l_menu.extend (l_menu_item)
			add_manual_menu_item := l_menu_item

			create l_sub_menu.make_with_text (interface_names.m_contract_add_contract_from_template)
			l_menu.extend (l_sub_menu)
			add_from_template_menu := l_sub_menu

--			create l_sub_menu.make_with_text ("&Add Contract for Entity")
--			l_menu.extend (l_sub_menu)
--			add_from_template_for_entity_menu := l_sub_menu

			l_dual_button.set_menu (l_menu)

				-- Remove contract button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_remove_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_remove_icon)
			l_button.set_tooltip (interface_names.t_contract_remove_selected)
			l_button.disable_sensitive
			remove_contract_button := l_button
			Result.put_last (l_button)

				-- Edit contracts button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_edit_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_edit_icon)
			l_button.set_tooltip (interface_names.t_contract_edit_selected)
			l_button.disable_sensitive
			edit_contract_button := l_button
			Result.put_last (l_button)

				-- Move contract up button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_move_up_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_move_up_icon)
			l_button.set_tooltip (interface_names.t_contract_move_selected_up)
			l_button.disable_sensitive
			move_contract_up_button := l_button
			Result.put_last (l_button)

				-- Move contract down button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_move_down_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_move_down_icon)
			l_button.set_tooltip (interface_names.t_contract_move_selected_down)
			l_button.disable_sensitive
			move_contract_down_button := l_button
			Result.put_last (l_button)

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Refresh contracts button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_refresh_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_refresh_icon)
			l_button.set_tooltip (interface_names.t_contract_refresh)
			l_button.disable_sensitive
			refresh_button := l_button
			Result.put_last (l_button)

				-- Contract selection button
			create l_dual_button.make
			l_dual_button.set_text (contract_mode_label (contract_mode))
			l_dual_button.set_pixel_buffer (stock_pixmaps.view_contracts_icon_buffer)
			l_dual_button.set_pixmap (stock_pixmaps.view_contracts_icon)
			l_dual_button.set_tooltip (interface_names.t_contract_select_mode)
			contract_mode_button := l_dual_button
			Result.put_last (l_dual_button)

				-- Create menu for contract selection button
			create l_menu
			create l_menu_radio_item.make_with_text (contract_mode_label ({ES_CONTRACT_TOOL_EDIT_MODE}.preconditions))
			l_menu.extend (l_menu_radio_item)
			l_menu_radio_item.enable_select
			preconditions_menu_item := l_menu_radio_item

			create l_menu_radio_item.make_with_text (contract_mode_label ({ES_CONTRACT_TOOL_EDIT_MODE}.postconditions))
			l_menu.extend (l_menu_radio_item)
			postconditions_menu_item := l_menu_radio_item

			create l_menu_radio_item.make_with_text (contract_mode_label ({ES_CONTRACT_TOOL_EDIT_MODE}.invariants))
			l_menu.extend (l_menu_radio_item)
			invaraints_menu_item := l_menu_radio_item
			l_dual_button.set_menu (l_menu)
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items that should be displayed at the top, but right aligned.
			-- Note: Redefine to add a right tool bar.
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_toggle_button: SD_TOOL_BAR_TOGGLE_BUTTON
		do
			create Result.make (3)

				-- Show hidden rows button
			create l_toggle_button.make
			l_toggle_button.set_pixel_buffer (stock_pixmaps.general_show_hidden_icon_buffer)
			l_toggle_button.set_pixmap (stock_pixmaps.general_show_hidden_icon)
			l_toggle_button.set_tooltip (interface_names.t_contract_show_all_lines)
			l_toggle_button.disable_sensitive
			show_all_lines_button := l_toggle_button
			Result.put_last (l_toggle_button)

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Show callers button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.feature_callees_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.feature_callees_icon)
			l_button.set_tooltip (interface_names.t_contract_show_callers)
			l_button.disable_sensitive
			show_callers_button := l_button
			Result.put_last (l_button)
		end

	contract_mode_label (a_mode: like contract_mode): !STRING_32
			-- Retrieve the edit label for a given an edit mode.
			--
			-- `a_mode': An edit mode. See {ES_CONTRACT_TOOL_EDIT_MODE} for possible values.
			-- `Result': A label for the given edit mode.
		require
			a_mode_is_valid: (create {ES_CONTRACT_TOOL_EDIT_MODE}).is_valid_mode (a_mode)
		local
			l_result: STRING_32
		do
			inspect a_mode
			when {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions then
				l_result := interface_names.m_edit_preconditions
			when {ES_CONTRACT_TOOL_EDIT_MODE}.postconditions then
				l_result := interface_names.m_edit_postconditions
			when {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
				l_result := interface_names.m_edit_invariants
			else
				l_result := interface_names.unknown_string
			end
				-- Remove ampersand from menu name.
			l_result ?= l_result.twin
			l_result.replace_substring_all ("&", "")
			create Result.make_from_string (l_result.as_string_32)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Constants

	contract_mode_session_id: !STRING = "com.eiffel.contract_tool.mode"
	show_all_lines_session_id: !STRING = "com.eiffel.contract_tool.show_all_lines"
	class_name_symbol_id: !STRING = "class_name"
	feature_name_symbol_id: !STRING = "feature_name"

invariant
	save_modifications_button_attached: (is_initialized and is_interface_usable) implies save_modifications_button /= Void
	add_contract_button_attached: (is_initialized and is_interface_usable) implies add_contract_button /= Void
	add_menu_attached: (is_initialized and is_interface_usable) implies add_menu /= Void
	add_manual_menu_item_attached: (is_initialized and is_interface_usable) implies add_manual_menu_item /= Void
	add_from_template_menu_attached: (is_initialized and is_interface_usable) implies add_from_template_menu /= Void
--	add_from_template_for_entity_menu_attached: (is_initialized and is_interface_usable) implies add_from_template_for_entity_menu /= Void
	edit_menu_attached: (is_initialized and is_interface_usable) implies edit_menu /= Void
	edit_menu_item_attached: (is_initialized and is_interface_usable) implies edit_menu_item /= Void
	remove_contract_button_attached: (is_initialized and is_interface_usable) implies remove_contract_button /= Void
	edit_contract_button_attached: (is_initialized and is_interface_usable) implies edit_contract_button /= Void
	move_contract_up_button_attached: (is_initialized and is_interface_usable) implies move_contract_up_button /= Void
	move_contract_down_button_attached: (is_initialized and is_interface_usable) implies move_contract_down_button /= Void
	refresh_button_attached: (is_initialized and is_interface_usable) implies refresh_button /= Void
	contract_mode_button_attached: (is_initialized and is_interface_usable) implies contract_mode_button /= Void
	preconditions_menu_item_attached: (is_initialized and is_interface_usable) implies preconditions_menu_item /= Void
	postconditions_menu_item_attached: (is_initialized and is_interface_usable) implies postconditions_menu_item /= Void
	invaraints_menu_item_attached: (is_initialized and is_interface_usable) implies invaraints_menu_item /= Void
	show_all_lines_button_attached: (is_initialized and is_interface_usable) implies show_all_lines_button /= Void
	show_callers_button_attached: (is_initialized and is_interface_usable) implies show_callers_button /= Void
	contract_editor_attached: (is_initialized and is_interface_usable) implies contract_editor /= Void

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
