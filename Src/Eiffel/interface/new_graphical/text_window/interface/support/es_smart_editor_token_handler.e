indexing
	description: "[
		A token handler implementation for EiffelStudio's smart editor {EB_SMART_EDITOR}.
		
		Note: Currently commented code supports a contract editor, which will not be available in this release.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_SMART_EDITOR_TOKEN_HANDLER

inherit
	ES_EDITOR_TOKEN_HANDLER
		redefine
			can_perform_exit,
			is_applicable_token,
			perform_exit,
			perform_on_token_with_mouse_coords
		end

create
	make

feature {NONE} -- Access

	popup_window: ?ES_POPUP_EDITOR_TOKEN_CONTEXT_BUTTON
			-- Pop up window used to display the token options

	contract_keyword_token_images: !DS_HASH_TABLE [FUNCTION [ANY, TUPLE [!ES_CONTRACT_EDITOR_WIDGET_FACTORY], !EV_WIDGET], STRING_8]
			-- Design by contract editor keyword images.
		once
			create Result.make_default
			Result.set_key_equality_tester (create {KL_CASE_INSENSITIVE_STRING_EQUALITY_TESTER})

				-- Contract keywords match to widget factory functions
--			Result.force_last (agent {!ES_CONTRACT_EDITOR_WIDGET_FACTORY}.create_precondition_widget, "require")
--			Result.force_last (agent {!ES_CONTRACT_EDITOR_WIDGET_FACTORY}.create_postcondition_widget, "ensure")
		ensure
			result_equality_tester_set: Result.key_equality_tester /= Void
			result_contains_attached_items: not Result.has (Void)
		end

feature

	editor_class: EIFFEL_CLASS_I
		require
			is_interface_usable: is_interface_usable
			is_editing_eiffel_class: is_editing_eiffel_class
		do
			if {l_class_stone: !CLASSI_STONE} editor.stone and then {l_class: !EIFFEL_CLASS_I} l_class_stone.class_i then
				Result := l_class
			end
		end

	is_editing_eiffel_class: BOOLEAN
			-- Indicates if the editor is currently editing an Eiffel class
		require
			is_interface_usable: is_interface_usable
		do
			Result := {l_class_stone: !CLASSI_STONE} editor.stone and then {l_class: !EIFFEL_CLASS_I} l_class_stone.class_i
		ensure
			editor_has_class_i_stone: Result implies (({CLASSI_STONE}) #? editor.stone /= Void and then ({EIFFEL_CLASS_I}) #? (({CLASSI_STONE}) #? editor.stone).class_i /= Void)
		end

feature -- Query

	is_applicable_token (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is applicable for processing
			--
			-- `a_token': Token to test for applicablity.
			-- `Result': True if the token can be user; False otherwise.
		do
			if is_editing_eiffel_class then
				if {l_class_stone: !CLASSI_STONE} editor.stone then -- Nested if because of a code generation bug.
					Result := {l_ky_token: !EDITOR_TOKEN_FEATURE_START} a_token
--					if
--						{l_class_i: !EIFFEL_CLASS_I} l_class_stone.class_i and then
--						{l_ky_token: !EDITOR_TOKEN_KEYWORD} a_token and then
--						{l_image: !STRING_8} a_token.image
--					then
--						Result := contract_keyword_token_images.has (l_image)
--					end
				end

				if Result then
						-- Check the editor is in edit mode and has focus
					Result := editor.has_focus and editor.is_editable
				end
			end

		end

	can_perform_exit (a_force: BOOLEAN): BOOLEAN
			-- Deterines if clients can perform a exit operation on an actively handled token.
			--
			-- `a_force': True to indicate a forced close operation, False to indicate a regular request to close.
			-- `Result': True if the handler can perform an exit at this time; False otherwise.
		do
			Result := Precursor {ES_EDITOR_TOKEN_HANDLER} (a_force) and then popup_window /= Void and then
				popup_window.is_interface_usable and then
				popup_window.is_shown

			if Result then
					-- Exit cannot be peformed if the window has the mouse pointer
				Result := not popup_window.has_mouse_pointer -- and not popup_window.is_popup_widget_shown
			end
		end

feature {NONE} -- Query

	token_widget (a_token: !EDITOR_TOKEN; a_line: INTEGER): ?EV_WIDGET
			-- Retrieve's a token's widget structure for the token's popped up window
			--
			-- `a_token': The token to retrieve a widget structure for.
			-- `a_line': The line number where the token is located in the editor.
			-- `Result': A token widget or Void if there is no associated widget.
		require
			is_interface_usable: is_interface_usable
			a_token_is_applicable_token: is_applicable_token (a_token)
			a_line_positive: a_line > 0
		local
			l_viewer: !ES_CONTRACT_VIEWER_WIDGET
		do
			if {l_fstart: !EDITOR_TOKEN_FEATURE_START} a_token then
					-- Create contract viewer widget
				create l_viewer.make
				l_viewer.set_is_showing_full_contracts (True)
				Result := l_viewer.widget
--			elseif {l_kw_token: !EDITOR_TOKEN} a_token and then {l_image: !STRING_8} l_kw_token.image and then contract_keyword_token_images.has (l_image) then
--					-- Create a contract widget
--				Result := create_contract_editor_widget (l_kw_token, a_line)
			end
		ensure
			result_is_destroyed: Result /= Void implies not Result.is_destroyed
			not_result_unparented: Result /= Void implies not Result.has_parent
		end

	token_action (a_token: !EDITOR_TOKEN; a_line: INTEGER): ?PROCEDURE [ANY, TUPLE]
			-- Retrieve's an action for a token, called when the token in selected in the pop up window.
			--
			-- `a_token': The token to retrieve a action for.
			-- `a_line': The line number where the token is located in the editor.
			-- `Result': A token action or Void if there is no associated action.
		require
			is_interface_usable: is_interface_usable
			a_token_is_applicable_token: is_applicable_token (a_token)
			a_line_positive: a_line > 0
		do
			--| No actions here
		end

--feature {NONE} -- Helpers

--	contract_widget_factory: !ES_CONTRACT_EDITOR_WIDGET_FACTORY
--			-- Factory used to create contract editor widgets to display in the popup window.
--		once
--			create Result
--		end

feature -- Basic operations

	perform_on_token_with_mouse_coords (a_token: !EDITOR_TOKEN; a_line: INTEGER; a_x: INTEGER; a_y: INTEGER; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Performs an action on a token, respecting the current mouse x and y coordinates.
			--
			-- `a_token': The editor token to process.
			-- `a_line': The line number where the token is located in the editor.
			-- `a_x': The relative x position of the mouse pointer, to the editor,  when processing was requested.
			-- `a_y': The relative y position of the mouse pointer, to the editor, when processing was requested.
			-- `a_screen_x': The absolute screen x position of the mouse pointer when processing was requested.
			-- `a_screen_y': The absolute screen y position of the mouse pointer when processing was requested.
		local
			l_cursor: EIFFEL_EDITOR_CURSOR
			l_line: EDITOR_LINE
			l_token: EDITOR_TOKEN
			l_x_offset: INTEGER
			l_y_offset: INTEGER
			l_token_widget: EV_WIDGET
			l_token_action: PROCEDURE [ANY, TUPLE]
			l_can_show: BOOLEAN
			l_cursor_token: EDITOR_TOKEN
		do
				-- Offset position by margin width
			l_x_offset := editor.left_margin_width

				-- Offset y position by 1 because of padding.
			l_y_offset := 1

			if {l_text: !CLICKABLE_TEXT} editor.text_displayed then
					-- Determine if a pop window can be shown.
				l_can_show := not editor.is_empty and then editor.text_displayed /= Void
				if l_can_show then
					l_cursor_token := editor.text_displayed.cursor.token
					l_can_show := l_cursor_token /= a_token or else last_token_handled /= a_token

					if l_can_show then
						l_token_widget := token_widget (a_token, a_line)
						l_token_action := token_action (a_token, a_line)
						l_can_show := l_token_widget /= Void or l_token_action /= Void
					end
				end

				if l_can_show then
						-- Locate token in line
					create l_cursor.make_from_character_pos (1, a_line, l_text)
					l_line := l_cursor.line
					from l_line.start until l_line.after or l_token = a_token loop
						if l_token /= Void and then l_token.length > 0 then
							l_x_offset := l_x_offset + l_token.width
						end
						l_token := l_line.item
						l_line.forth
					end

					if l_token = a_token then
							-- Token located, adjust the offset
						l_y_offset := a_y - (a_y \\ editor.line_height)
					end
				end
			end

			if popup_window /= Void and last_token_handled /= a_token then
					-- Remove and clean up last window
				popup_window.recycle
				popup_window := Void
			end

			if l_can_show and then (popup_window = Void or else not popup_window.is_interface_usable) then
					-- Create new window
				if {l_widget: !EV_WIDGET} l_token_widget then
					create popup_window.make_with_widget (editor, a_token, l_widget)
				else
					create popup_window.make (editor, a_token)
				end

					-- Ensure the token is hidden on showing the pop up widget
				popup_window.set_is_token_hidden_on_popup_widget_shown (True)

				if {l_action: !PROCEDURE [ANY, TUPLE]} l_token_action then
					popup_window.register_action (popup_window.token_select_actions, l_action)
				end

					-- Register action on hide to reset the active state.
				popup_window.register_action (popup_window.hide_actions, agent do is_active := False end)

					-- Deactivate handler, when the token is selected
				popup_window.register_action (popup_window.token_select_actions, agent on_token_selected (popup_window, ?, ?, ?, ?))
			end

				-- Display window
			if l_can_show then
				check
					popup_window_attached: popup_window /= Void
					popup_window_is_interface_usable: popup_window.is_interface_usable
				end

					-- Show window
				if {l_editor_widget: !EV_WIDGET} editor.editor_drawing_area then
					popup_window.show_relative_to_widget (l_editor_widget, l_x_offset, l_y_offset, a_x, a_y)
						-- The precusor will not be called because the handler is to be considered "active".
					last_token_handled := a_token
					is_active := True
				end
			end

			if not is_active then
					-- The token was already handled and the handler is active, so we shouldn't visit the previous implementation!
				Precursor {ES_EDITOR_TOKEN_HANDLER} (a_token, a_line, a_x, a_y, a_screen_x, a_screen_y)
			end
		ensure then
			is_active: (popup_window /= Void and then popup_window.is_shown) implies is_active
		end

	perform_exit (a_force: BOOLEAN)
			-- Exits a function being performed. This is called when a non applicable token or no token needs processing.
			-- It allows the handler to perform exit or shutdown functionality.
			--
			-- `a_force': True to ignore check and perform an exit; False otherwise
		do
				-- Exit is only performed if the popup window doesn't have the mouse.
			if popup_window /= Void and then popup_window.is_interface_usable then
				popup_window.recycle
				popup_window := Void
			end

			last_token_handled := Void
			is_active := False
		ensure then
			not_popup_window_is_interface_usable: old popup_window /= Void implies not (old popup_window).is_interface_usable
			popup_window_detached: popup_window = Void
		end

feature {NONE} -- Action handlers

	on_token_selected (a_window: like popup_window; a_x: INTEGER; a_y: INTEGER; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Called when a popup window's editor token is selected.
			--
			-- `a_window': The popup window on which the token was clicked.
			-- `a_x': Relative X position in the token where the selection was made.
			-- `a_y': Relative Y position in the token where the selection was made.
		require
			is_interface_usable: is_interface_usable
			a_window_attached: a_window /= Void
			a_x_non_negative: a_x >= 0
			a_y_non_negative: a_y >= 0
			a_screen_x_non_negative: a_screen_x >= 0
			a_screen_y_non_negative: a_screen_y >= 0
		local
			l_x: INTEGER
			l_y: INTEGER
			l_editor: like editor
			l_drawing: EV_DRAWING_AREA
			l_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			l_state: INTEGER
		do
			if a_window /= Void and then a_window.is_interface_usable and then not a_window.is_popup_widget_shown then
				l_editor := editor
				if l_editor.is_interface_usable then
					l_drawing := l_editor.editor_drawing_area

						-- Calculate position in the editor drawing area
					l_x := a_screen_x - l_drawing.screen_x
					l_y := a_screen_y - l_drawing.screen_y
				end

					-- Remove window
				a_window.recycle
				is_active := False

					-- Forward call to editor drawing area
				if editor.is_interface_usable then
					check l_drawing_attached: l_drawing /= Void end

					l_actions := l_drawing.pointer_button_press_actions
					l_state := l_actions.state
					if l_state /= l_actions.normal_state then
						l_actions.resume
					end

						-- Fake pointer press call to ensure editor recieves it
					l_actions.call ([l_x, l_y, 1, .0, .0, .0, a_screen_x, a_screen_y])

					if l_state /= l_actions.normal_state then
						if l_state = l_actions.blocked_state then
							l_actions.block
						elseif l_state = l_actions.paused_state then
							l_actions.pause
						else
							check False end
						end
					end
				end
			end
		ensure
			last_token_handled_unchanged: last_token_handled = old last_token_handled
		end

--feature {NONE} -- Factory

--	create_contract_editor_widget (a_token: !EDITOR_TOKEN; a_line: INTEGER): !EV_WIDGET is
--			-- Create a new contract editor widget from a token.
--			--
--			-- `a_token': A token to base the contract widget on.
--			-- `Result': The widget structure created from the specified token.
--		require
--			is_editing_eiffel_class: is_editing_eiffel_class
--			a_line_positive: a_line > 0
--		local
--			l_factory: like contract_widget_factory
--			l_factory_function: FUNCTION [ANY, TUPLE [!ES_CONTRACT_EDITOR_WIDGET_FACTORY], !EV_WIDGET]
--			l_widget: EV_WIDGET
--		do
--			l_factory := contract_widget_factory
--			l_factory.reset_context

--			if {l_class: !EIFFEL_CLASS_I} editor_class and then {l_text: !STRING_GENERAL} editor.text then
--					-- Use the contract factory to try and fetch a widget
--				if contract_keyword_token_images.has (a_token.image) then
--					l_factory_function := contract_keyword_token_images.item (a_token.image)
--					if l_factory_function /= Void then
--							-- Set factory context.
--						l_factory.set_context (l_class, l_text, a_line)
--						if l_factory.has_full_context then
--							l_widget := l_factory_function.item ([l_factory])
--						end
--					end
--				end
--			end

--			if l_widget = Void then
--					-- Could not create the widget because of some error or another.
--					-- So create a widget that explains that error.
--				l_widget := l_factory.create_invalid_context_widget
--			end
--			Result ?= l_widget
--		end

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
