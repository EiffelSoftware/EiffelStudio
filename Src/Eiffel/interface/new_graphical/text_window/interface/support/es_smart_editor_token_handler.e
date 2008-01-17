indexing
	description: "[
		A token handler implementation for EiffelStudio's smart editor {EB_SMART_EDITOR}.
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

	frozen contract_keyword_token_images: !DS_ARRAYED_LIST [STRING_8]
			-- Design by contract editor keyword images.
		once
			create Result.make_default
			Result.set_equality_tester (create {KL_CASE_INSENSITIVE_STRING_EQUALITY_TESTER})

			Result.force_last ("require")
			Result.force_last ("ensure")
			Result.force_last ("check")
			Result.force_last ("invariant")
			Result.force_last ("variant")
		ensure
			result_equality_tester_set: Result.equality_tester /= Void
			result_contains_attached_items: not Result.has (Void)
		end

feature -- Query

	is_applicable_token (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is applicable for processing
			--
			-- `a_token': Token to test for applicablity.
			-- `Result': True if the token can be user; False otherwise.
		do
			Result := Precursor {ES_EDITOR_TOKEN_HANDLER} (a_token)
			if not Result and then {l_ky_token: !EDITOR_TOKEN_KEYWORD} a_token and then {l_image: !STRING_8} a_token.image then
				Result := contract_keyword_token_images.has (l_image)
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
				Result := not popup_window.has_mouse_pointer and not popup_window.is_popup_widget_shown
			end
		end

feature {NONE} -- Query

	token_widget (a_token: !EDITOR_TOKEN): ?EV_WIDGET
			-- Retrieve's a token's widget structure for the token's popped up window
			--
			-- `a_token': The token to retrieve a widget structure for.
			-- `Result'
		require
			is_interface_usable: is_interface_usable
			a_token_is_applicable_token: is_applicable_token (a_token)
		do
			if {l_kw_token: !EDITOR_TOKEN_KEYWORD} a_token and then {l_image: !STRING_8} l_kw_token.image then
				if contract_keyword_token_images.has (l_image) then
					--Result := create_contract_widget (l_kw_token)
				end
			end
		ensure
			result_is_destroyed: Result /= Void implies not Result.is_destroyed
			not_result_unparented: Result /= Void implies not Result.has_parent
		end

	token_action (a_token: !EDITOR_TOKEN): ?PROCEDURE [ANY, TUPLE]
			-- Retrieve's an action for a token, called when the token in selected in the pop up window.
			--
			-- `a_token': The token to retrieve a action for.
			-- `Result': A token action or Void if there is no associated action.
		require
			is_interface_usable: is_interface_usable
			a_token_is_applicable_token: is_applicable_token (a_token)
		do

		end

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
						l_token_widget := token_widget (a_token)
						l_token_action := token_action (a_token)
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
						l_y_offset := (a_line - 1) * editor.line_height
					end
				end
			end

			if popup_window /= Void and last_token_handled /= a_token then
					-- Remove and clean up last window
				popup_window.recycle
				popup_window := Void
			end

			if popup_window = Void or else not popup_window.is_interface_usable then
					-- Create new window
				if {l_widget: !EV_WIDGET} l_token_widget then
					create popup_window.make_with_widget (editor, a_token, l_widget)
				else
					create popup_window.make (editor, a_token)
				end
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
					popup_window.show_relative_to_widget (l_editor_widget, l_x_offset, l_y_offset)
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

--	create_contract_widget (a_token: !EDITOR_TOKEN_KEYWORD) : !EV_WIDGET
--			-- Create a new contract editor widget from a token.
--			--
--			-- `a_token': A token to base the contract widget on.
--			-- `Result': The widget structure created from the specified token.
--		do
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
