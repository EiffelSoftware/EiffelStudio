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

feature -- Access

	editor_class: EIFFEL_CLASS_I
			-- Editor's class.
		require
			is_interface_usable: is_interface_usable
			is_editing_eiffel_class: is_editing_eiffel_class
		do
			if {l_class_stone: !CLASSI_STONE} editor.stone and then {l_class: !EIFFEL_CLASS_I} l_class_stone.class_i then
				Result := l_class
			end
		end

feature {NONE} -- Access

	popup_window: ?ES_POPUP_EDITOR_TOKEN_CONTEXT_BUTTON
			-- Pop up window used to display the token options

feature -- Status report

	is_active: BOOLEAN
			-- <Precursor>
		local
			l_window: ?like popup_window
		do
			l_window := popup_window
			if l_window /= Void then
				Result := l_window.is_interface_usable and then l_window.is_shown
--				if Result and then l_window.is_popup_widget_available then
--					Result := l_window.is_popup_widget_shown
--				end
			end
		end

	is_editing_eiffel_class: BOOLEAN
			-- Indicates if the editor is currently editing an Eiffel class.
		require
			is_interface_usable: is_interface_usable
		do
			Result := {l_class_stone: !CLASSI_STONE} editor.stone and then {l_class: !EIFFEL_CLASS_I} l_class_stone.class_i
		ensure
			editor_has_class_i_stone: Result implies (({CLASSI_STONE}) #? editor.stone /= Void and then ({EIFFEL_CLASS_I}) #? (({CLASSI_STONE}) #? editor.stone).class_i /= Void)
		end

feature -- Query

	is_applicable_token (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is applicable for processing.
			--
			-- `a_token': Token to test for applicablity.
			-- `Result': True if the token can be user; False otherwise.
		local
			l_editor: like editor
		do
			if is_editing_eiffel_class then
				l_editor := editor

					-- Check the editor is in edit mode and has focus
				if
					l_editor.has_focus and then
					l_editor.dev_window /= Void and then
					{l_formatter: !EB_BASIC_TEXT_FORMATTER} l_editor.dev_window.selected_formatter
				then
					if {l_class_stone: !CLASSI_STONE} l_editor.stone then -- Nested if because of a code generation bug.
						Result := {l_ky_token: !EDITOR_TOKEN_FEATURE_START} a_token
					end
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
				(a_force or else popup_window.is_shown)

			if Result then
					-- Exit cannot be peformed if the window has the mouse pointer
				Result := not popup_window.has_mouse_pointer and not popup_window.is_popup_widget_shown
			end
		end

feature {NONE} -- Query

	token_widget (a_token: !EDITOR_TOKEN; a_line: INTEGER): ?EV_WIDGET
			-- Retrieve's a token's widget structure for the token's popped up window.
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
			l_feature: E_FEATURE
		do
			if editor_class /= Void and then editor_class.is_compiled and then {l_class: !CLASS_C} editor_class.compiled_class then
				if l_class.has_feature_table then
					if {l_fstart: !EDITOR_TOKEN_FEATURE_START} a_token then
							-- Create contract viewer widget
						l_feature := l_class.feature_with_name (l_fstart.wide_image)
						if {l_feat: !E_FEATURE} l_feature then
							create l_viewer.make
								-- Register the close action for the widget
							l_viewer.register_action (l_viewer.edit_contract_label.select_actions, agent
								do
									if popup_window /= Void then
										popup_window.recycle
										popup_window := Void
									end
								end)
							l_viewer.is_showing_full_contracts := True
							l_viewer.set_context (l_class, l_feat)
							Result := l_viewer.widget
						end
					end
				end
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

feature -- Basic operations

	perform_on_token_with_mouse_coords (a_instant: BOOLEAN; a_token: !EDITOR_TOKEN; a_line: INTEGER; a_x: INTEGER; a_y: INTEGER; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- <Precursor>
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
			l_window: like popup_window
		do

			if a_instant or else editor.preferences.editor_data.auto_show_feature_contract_tooltips then
				l_window := popup_window
				if last_token_handled /= a_token or else l_window = Void or else not l_window.is_interface_usable or else not l_window.is_shown then
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
								l_y_offset := (a_y - (a_y \\ editor.line_height))
							end
						end
					end

					if l_window /= Void then
							-- Remove and clean up last window
						l_window.recycle
						l_window := Void
						popup_window := Void
					end

					if l_can_show and then (l_window = Void or else not l_window.is_interface_usable) then
							-- Create new window
						if {l_widget: !EV_WIDGET} l_token_widget then
							create l_window.make_with_widget (editor, a_token, l_widget)
						else
							create l_window.make (editor, a_token)
						end

							-- Ensure the token is hidden on showing the pop up widget
						l_window.set_is_token_hidden_on_popup_widget_shown (False)
						l_window.set_is_beam_indicator (True)
						if a_instant then
								-- Show the popup widget immmediately.
							l_window.show_popup_widget
						end

						if {l_action: !PROCEDURE [ANY, TUPLE]} l_token_action then
							l_window.register_action (l_window.token_select_actions, l_action)
						end

							-- Deactivate handler, when the token is selected
						l_window.register_action (l_window.token_select_actions, agent on_token_selected (l_window, ?, ?, ?, ?))

						popup_window := l_window
					end

						-- Display window
					if l_can_show then
						check
							l_window_attached: l_window /= Void
							l_window_is_interface_usable: l_window.is_interface_usable
						end

							-- Show window
						if {l_editor_widget: !EV_WIDGET} editor.editor_drawing_area then
							l_window.show_relative_to_widget (l_editor_widget, l_x_offset, l_y_offset, a_x, a_y)

								-- The precusor will not be called because the handler is to be considered "active".
							last_token_handled := a_token
						end
					end

					if not is_active then
							-- The token was already handled and the handler is active, so we shouldn't visit the previous implementation!
						Precursor {ES_EDITOR_TOKEN_HANDLER} (a_instant, a_token, a_line, a_x, a_y, a_screen_x, a_screen_y)
					end
				end
			else
					-- Not instant so we default to the parent implementation
				Precursor {ES_EDITOR_TOKEN_HANDLER} (a_instant, a_token, a_line, a_x, a_y, a_screen_x, a_screen_y)
			end
		ensure then
			is_active: (popup_window /= Void and then popup_window.is_shown) implies is_active
		end

	perform_exit (a_force: BOOLEAN)
			-- Exits a function being performed. This is called when a non applicable token or no token needs processing.
			-- It allows the handler to perform exit or shutdown functionality.
			--
			-- `a_force': True to ignore check and perform an exit; False otherwise
		local
			l_window: ?like popup_window
		do
				-- Exit is only performed if the popup window doesn't have the mouse.
			l_window := popup_window
			if l_window /= Void and then l_window.is_interface_usable then
				l_window.recycle
				popup_window := Void
			end

			last_token_handled := Void
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

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
