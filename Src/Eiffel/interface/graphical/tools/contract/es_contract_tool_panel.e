indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CONTRACT_TOOL_PANEL

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [EV_HORIZONTAL_BOX]
		redefine
			on_after_initialized,
			internal_recycle,
			create_right_tool_bar_items,
			query_set_stone
		end

	SESSION_EVENT_OBSERVER
		export
			{NONE} all
		redefine
			on_session_value_changed
		end

	ES_MODIFIABLE
		undefine
			internal_detach_entities
		redefine
			internal_recycle
		end

create {ES_CONTRACT_TOOL}
	make

feature {NONE} -- Initialization

    build_tool_interface (a_widget: EV_HORIZONTAL_BOX)
            -- Builds the tools user interface elements.
            -- Note: This function is called prior to showing the tool for the first time.
            --
            -- `a_widget': A widget to build the tool interface using.
		do
				-- `contract_editor'
			create contract_editor.make

			a_widget.extend (contract_editor.widget)

			register_action (add_contract_button.select_actions, agent on_add_contract)
			register_action (remove_contract_button.select_actions, agent on_remove_contract)
			register_action (edit_contract_button.select_actions, agent on_edit_contract)
			register_action (contract_mode_button.select_actions, agent on_contract_mode_selected)
			register_action (preconditions_menu_item.select_actions, agent on_contract_mode_changed ({ES_CONTRACT_TOOL_EDIT_MODE}.preconditions))
			register_action (postconditions_menu_item.select_actions, agent on_contract_mode_changed ({ES_CONTRACT_TOOL_EDIT_MODE}.postconditions))
			register_action (invaraints_menu_item.select_actions, agent on_contract_mode_changed ({ES_CONTRACT_TOOL_EDIT_MODE}.invariants))
			register_action (show_callers_button.select_actions, agent on_show_callers)
		end

	on_after_initialized
			-- <Precursor>
		local
			l_mode: NATURAL_8_REF
		do
			Precursor {ES_DOCKABLE_STONABLE_TOOL_PANEL}
			propagate_drop_actions (Void)

			if session_manager.is_service_available then
					-- Retrieve contract mode from the project session.
				l_mode ?= project_window_session_data.value (contract_mode_session_id)
				if l_mode /= Void then
					set_contract_mode (l_mode.item)
				end

					-- Connect session observer.
				project_window_session_data.connect_events (Current)
			end
		end

feature {NONE} -- Clean up

	internal_recycle
			-- To be called when the button has became useless.
			-- Note: It's recommended that you do not detach objects here.
		do
			if session_manager.is_service_available then
				if project_window_session_data.is_connected (Current) then
						-- Retrieve contract mode from the project session.
					project_window_session_data.disconnect_events (Current)
				end
			end

			Precursor {ES_MODIFIABLE}
			Precursor {ES_DOCKABLE_STONABLE_TOOL_PANEL}
		end

feature -- Access

	context_feature: ?E_ROUTINE
			-- Current feature being edited.
			-- Note: It's called `context_feature' because

	contract_mode: NATURAL_8 assign set_contract_mode
			-- Contract edition mode.
			-- See {ES_CONTRACT_TOOL_EDIT_MODE} for applicable modes.

feature {ES_STONABLE_I, ES_TOOL} -- Basic operations

	query_set_stone (a_stone: ?STONE): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_stone)
			if Result and then is_initialized then -- and then is_dirty then
					-- Delegate the query to the actual editor.
				if contract_editor.has_context then
						-- Note: Using Void is somewhat of a hack because a context cannot be set an incorrect stone (i.e Class context being set a feature stone)
						--       For this we use Void because it triggers a request to change the stone.
					Result := contract_editor.context.query_set_stone (Void)
				end
			end
		end

feature {NONE} -- Query

	context_for_mode: ?ES_CONTRACT_EDITOR_CONTEXT [CLASSC_STONE]
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
				Result.stone := stone
			end
		ensure
			stone_set: Result /= Void implies Result.stone = stone
		end

feature {NONE} -- User interface elements

	save_modifications_button:? SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button to save modified contracts.

	save_menu_item: ?EV_MENU_ITEM
			-- Menu item to save contracts.

	save_and_open_menu_item: ?EV_MENU_ITEM
			-- Menu item to save contracts and open modified class.

	add_contract_button: ?SD_TOOL_BAR_BUTTON
			-- Button to add a new contract to the current feature.

	remove_contract_button: ?SD_TOOL_BAR_BUTTON
			-- Button to remove a selected contract.

	edit_contract_button: ?SD_TOOL_BAR_BUTTON
			-- Button to edit a selected contract.

	contract_mode_button: ?SD_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Button to select the contract edit mode.

	show_callers_button: ?SD_TOOL_BAR_BUTTON
			-- Button to show the callers of the edited feature.

	preconditions_menu_item: ?EV_RADIO_MENU_ITEM
			-- Menu item to show preconditions.

	postconditions_menu_item: ?EV_RADIO_MENU_ITEM
			-- Menu item to show postconditions.

	invaraints_menu_item: ?EV_RADIO_MENU_ITEM
			-- Menu item to show invariants.

	contract_editor: ?ES_CONTRACT_EDITOR_WIDGET
			-- The editor used to edit the contracts.

feature {NONE} -- User interface manipulation

	update_context_buttons (a_enable: BOOLEAN)
			-- Updates the context buttons based on a supplied state.
			--
			-- `a_enable': True to enable the context button; False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if a_enable then
				add_contract_button.enable_sensitive
				remove_contract_button.enable_sensitive
				edit_contract_button.enable_sensitive
			else
				add_contract_button.disable_sensitive
				remove_contract_button.disable_sensitive
				edit_contract_button.disable_sensitive
			end
		end

feature {NONE} -- Query

	is_editable_row (a_row: !EV_GRID_ROW): BOOLEAN
			-- Determines if a row is editable
			--
			-- `a_row': A row to determine editability.
			-- `Result': True if the row is editable; False otherwise.
		do
			Result := True
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
				update_context_buttons (is_editable_row (l_row))
			end
		end

feature {NONE} -- Basic operations

	update
			-- Updates the view with a compiled feature
		local
--			l_text: STRING_32
--			l_feature: FEATURE_I
--			l_class: CLASS_C
--			l_class_as: CLASS_AS
--			l_feature_as: FEATURE_AS
--			l_routine_as: ROUTINE_AS
--			l_require_as: REQUIRE_AS
--			l_assertions: EIFFEL_LIST [TAGGED_AS]
--			l_assertion: TAGGED_AS
--			l_yank: YANK_STRING_WINDOW
--			l_class_text: STRING_8
--			l_assert_server: ASSERTION_SERVER
--			l_cassert: CHAINED_ASSERTIONS
--			l_decorator: FEAT_TEXT_FORMATTER_DECORATOR
		do
			if has_stone and then {l_context: !like context_for_mode} context_for_mode then
				contract_editor.set_context (l_context)
			end
--			create l_text.make_empty
--			if {l_routine: !like context_feature} context_feature then
--				l_text.append (l_routine.feature_signature + "%N")
--				l_feature := l_routine.associated_class.feature_of_feature_id (l_routine.feature_id)
--				if l_feature /= Void then
--					l_class := context_feature.written_class
--					if l_class /= Void then
--						l_class_text := l_class.text
--						l_class_as := l_class.ast
--						if l_class_as /= Void and {l_name: !STRING_GENERAL} l_routine.name then
--							l_feature_as := l_class_as.feature_of_name (l_name, False)

--							create l_assert_server.make_for_feature (l_feature, l_feature_as)
--							l_cassert := l_assert_server.current_assertion

--							create l_yank.make
--							create l_decorator.make (l_class, l_yank)
--							--l_decorator.set_context_group (l_class.group)
--							l_decorator.init_feature_context (l_feature, l_feature, l_feature_as)
--							l_cassert.format_precondition (l_decorator)

--							l_text.append (l_yank.stored_output)

----							l_routine_as ?= l_feature_as.body.content
----							if l_routine_as /= Void then
----								l_require_as := l_routine_as.precondition
----								if l_require_as /= Void then
----									l_assertions := l_require_as.assertions
----									if l_assertions /= Void and then not l_assertions.is_empty then

----										from l_assertions.start until l_assertions.after loop
----											l_assertion := l_assertions.item
----											if l_assertion /= Void then
----												l_yank.put_string (l_class_text.substring (l_assertion.start_position, l_assertion.end_position))
----												l_yank.put_new_line
----												l_yank.put_new_line
----											end
----											l_assertions.forth
----										end

----									end
----									l_text.append (l_yank.stored_output)
----								end
----							end
--						end
--					end
--					if l_routine.has_precondition then
--						l_text.append ("PRECONDITIONS: %N")
--					end
--				else
--					check False end
--				end
--			end
----			contract_view.set_text (l_text)
		end

feature {SESSION_I} -- Event handlers

	on_session_value_changed (a_session: SESSION_I; a_id: STRING_8)
			-- Called when a event item is added to the event service.
			--
			-- `a_session': The session where the value changed.
			-- `a_id': The session data identifier of the changed value.
		local
			l_mode: NATURAL_8_REF
		do
			Precursor {SESSION_EVENT_OBSERVER} (a_session, a_id)
			if a_id.is_equal (contract_mode_session_id) then
				l_mode ?= session_data.value (contract_mode_session_id)
				if l_mode /= Void then
					set_contract_mode (l_mode.item)
				end
			end
		end

feature {NONE} -- Action handlers

	on_stone_changed
			-- Called when the set stone changes.
			-- Note: This routine can be called when `stone' is Void, to indicate a stone has been cleared.
			--       Be sure to check `is_in_stone_synchronization' to determine if a stone has change through an explicit
			--       setting or through compile synchronization.
		do
			if {l_stone: !FEATURE_STONE} stone then
				context_feature ?= l_stone.e_feature
				add_contract_button.enable_sensitive
				remove_contract_button.enable_sensitive
				show_callers_button.enable_sensitive

				if contract_mode = {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
						-- A feature was dropped so we should switch to a feature contract mode.
						-- Calling `set_contract_mode' will call `update'
					set_contract_mode ({ES_CONTRACT_TOOL_EDIT_MODE}.preconditions)
				else
					update
				end

					-- Modes can be switched
				contract_mode_button.enable_sensitive
			else
				context_feature := Void
				add_contract_button.disable_sensitive
				remove_contract_button.disable_sensitive
				show_callers_button.disable_sensitive

				if contract_mode /= {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
						-- A feature was dropped so we should switch to a feature contract mode.
						-- Calling `set_contract_mode' will call `update'
					set_contract_mode ({ES_CONTRACT_TOOL_EDIT_MODE}.invariants)
				else
					update
				end

					-- Modes can be switched
				contract_mode_button.disable_sensitive
			end

				-- Update session.
				-- This is done here because it only needs to be persisted when there is a stone change.
			if session_manager.is_service_available then
				project_window_session_data.set_value (contract_mode, contract_mode_session_id)
			end
		end

	on_show_callers
			-- Called when the user chooses to show the callers of the edited contracts
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			context_feature_attached: context_feature /= Void
		do
			if {l_feature: !E_FEATURE} context_feature then
				if {l_tool: !ES_FEATURE_RELATION_TOOL} develop_window.shell_tools.tool ({ES_FEATURE_RELATION_TOOL}) then
						-- Display feature relation tool using callers mode.
					l_tool.set_mode_with_stone ({ES_FEATURE_RELATION_TOOL_VIEW_MODES}.callers, create {!FEATURE_STONE}.make (l_feature))
					l_tool.show (True)
				end
			end
		end

	on_add_contract
			-- Called when the user chooses to add a new contract to the existing feature.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			context_feature_attached: context_feature /= Void
		do

		end

	on_remove_contract
			-- Called when the user chooses to remove a contract from the existing feature.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			context_feature_attached: context_feature /= Void
		do

		end

	on_edit_contract
			-- Called when the user chooses to edit a contract from the existing feature.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			context_feature_attached: context_feature /= Void
		do

		end

feature {NONE} -- Factory

    create_widget: EV_HORIZONTAL_BOX
            -- Create a new container widget upon request.
            -- Note: You may build the tool elements here or in `build_tool_interface'
		do
			create Result
		end

    create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display at the top of the tool.
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_dual_button: SD_TOOL_BAR_DUAL_POPUP_BUTTON
			l_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
		do
			create Result.make (8)

				-- Save contract button
			create l_dual_button.make
			l_dual_button.set_pixel_buffer (stock_pixmaps.general_save_icon_buffer)
			l_dual_button.set_pixmap (stock_pixmaps.general_save_icon)
			l_dual_button.set_tooltip ("Save modifications to class.")
		--	l_dual_button.disable_sensitive

			save_modifications_button := l_dual_button
			Result.put_last (l_dual_button)

				-- Create menu for contract selection button
			create l_menu
			create l_menu_item.make_with_text ("&Save")
			l_menu.set_pixmap (stock_pixmaps.general_save_icon)
			l_menu.extend (l_menu_item)
			save_menu_item := l_menu_item

			create l_menu_item.make_with_text ("S&ave and Open Modified")
			l_menu.set_pixmap (stock_pixmaps.general_save_icon)
			l_menu.extend (l_menu_item)
			save_and_open_menu_item := l_menu_item
			l_dual_button.set_menu (l_menu)

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Add contract button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_add_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_add_icon)
			l_button.set_tooltip ("Adds a new contract.")
			l_button.disable_sensitive

			add_contract_button := l_button
			Result.put_last (l_button)

				-- Remove contract button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_remove_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_remove_icon)
			l_button.set_tooltip ("Removes the selected contract(s).")
			l_button.disable_sensitive
			remove_contract_button := l_button
			Result.put_last (l_button)

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Edit contracts button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_edit_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_edit_icon)
			l_button.set_tooltip ("Edit the selected contract.")
			l_button.disable_sensitive

			edit_contract_button := l_button
			Result.put_last (l_button)
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items that should be displayed at the top, but right aligned.
			-- Note: Redefine to add a right tool bar.
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_dual_button: SD_TOOL_BAR_DUAL_POPUP_BUTTON
			l_menu: EV_MENU
			l_menu_item: EV_RADIO_MENU_ITEM
		do
			create Result.make (3)

				-- Contract selection button
			create l_dual_button.make
			l_dual_button.set_text ("Preconditions")
			l_dual_button.set_pixel_buffer (stock_pixmaps.view_contracts_icon_buffer)
			l_dual_button.set_pixmap (stock_pixmaps.view_contracts_icon)
			l_dual_button.set_tooltip ("Select the contracts to edit.")
			contract_mode_button := l_dual_button
			Result.put_last (l_dual_button)

				-- Create menu for contract selection button
			create l_menu
			create l_menu_item.make_with_text (contract_mode_label ({ES_CONTRACT_TOOL_EDIT_MODE}.preconditions))
			l_menu.extend (l_menu_item)
			l_menu_item.enable_select
			preconditions_menu_item := l_menu_item

			create l_menu_item.make_with_text (contract_mode_label ({ES_CONTRACT_TOOL_EDIT_MODE}.postconditions))
			l_menu.extend (l_menu_item)
			postconditions_menu_item := l_menu_item

			create l_menu_item.make_with_text (contract_mode_label ({ES_CONTRACT_TOOL_EDIT_MODE}.invariants))
			l_menu.extend (l_menu_item)
			invaraints_menu_item := l_menu_item
			l_dual_button.set_menu (l_menu)

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

				-- Show callers button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.feature_callees_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.feature_callees_icon)
			l_button.set_tooltip ("Show the callers of the currently edited feature.")
			l_button.disable_sensitive
			show_callers_button := l_button
			Result.put_last (l_button)
		end

	on_contract_mode_selected
			-- Called when the user selects the contract mode button.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_mode: like contract_mode
		do
			l_mode := contract_mode + 1
			if l_mode > {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
				l_mode := {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions
			end
			set_contract_mode (l_mode)
		end

	set_contract_mode (a_mode: like contract_mode)
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if contract_mode /= a_mode then
				inspect a_mode
				when {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions then
					preconditions_menu_item.enable_select
				when {ES_CONTRACT_TOOL_EDIT_MODE}.postconditions then
					postconditions_menu_item.enable_select
				when {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
					invaraints_menu_item.enable_select
				end
				on_contract_mode_changed (a_mode)
			end
		ensure
			contract_mode_set: contract_mode = a_mode
		end

	on_contract_mode_changed (a_mode: like contract_mode)
			-- Called when the user changes the edit mode.
			--
			-- `a_mode': An edit mode. See {ES_CONTRACT_TOOL_EDIT_MODE} for possible values.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_mode_is_valid: (create {ES_CONTRACT_TOOL_EDIT_MODE}).is_valid_mode (a_mode)
		do
			if contract_mode /= a_mode then
				contract_mode := a_mode
				contract_mode_button.set_text (contract_mode_label (a_mode))
				update
			end
		ensure
			contract_mode_set: contract_mode = a_mode
		end

	contract_mode_label (a_mode: like contract_mode): !STRING_32
			-- Retrieve the edit label for a given an edit mode.
			--
			-- `a_mode': An edit mode. See {ES_CONTRACT_TOOL_EDIT_MODE} for possible values.
			-- `Result': A label for the given edit mode.
		require
			a_mode_is_valid: (create {ES_CONTRACT_TOOL_EDIT_MODE}).is_valid_mode (a_mode)
		local
			l_result: STRING_GENERAL
		do
			inspect a_mode
			when {ES_CONTRACT_TOOL_EDIT_MODE}.preconditions then
				l_result := interface_names.m_edit_preconditions.as_string_32
			when {ES_CONTRACT_TOOL_EDIT_MODE}.postconditions then
				l_result := interface_names.m_edit_postconditions.as_string_32
			when {ES_CONTRACT_TOOL_EDIT_MODE}.invariants then
				l_result := interface_names.m_edit_invariants.as_string_32
			else
				l_result := interface_names.unknown_string.as_string_32
			end
			create Result.make_from_string (l_result.as_string_32)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Constants

	contract_mode_session_id: !STRING = "com.eiffel.contract_tool.mode"

invariant
	add_contract_button_attached: is_initialized implies add_contract_button /= Void
	remove_contract_button_attached: is_initialized implies remove_contract_button /= Void
	edit_contract_button_attached: is_initialized implies edit_contract_button /= Void
	contract_mode_button_attached: is_initialized implies contract_mode_button /= Void
	show_callers_button_attached: is_initialized implies show_callers_button /= Void
	preconditions_menu_item_attached: is_initialized implies preconditions_menu_item /= Void
	postconditions_menu_item_attached: is_initialized implies postconditions_menu_item /= Void
	invaraints_menu_item_attached: is_initialized implies invaraints_menu_item /= Void
	contract_editor_attached: is_initialized implies contract_editor /= Void

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
