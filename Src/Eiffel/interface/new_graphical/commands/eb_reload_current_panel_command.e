note
	description: "[
					Command to reload current panel (maybe a tab in editor/tool panel)
																						]"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RELOAD_CURRENT_PANEL_COMMAND

inherit
	EB_FOCUS_PANEL_COMMAND
		redefine
			new_menu_item
		end

	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			target as develop_window
		redefine
			make
		end

	EB_SHARED_PREFERENCES

	ES_DIALOG_BUTTONS

create
	make

feature {NONE} -- Creation method

	make (a_develop_window: EB_DEVELOPMENT_WINDOW)
			-- Creation method
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}(a_develop_window)

			l_shortcut := preferences.misc_shortcut_data.Shortcuts.item ("reload_current_tab")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			accelerator.actions.extend (agent execute)
			set_referred_shortcut (l_shortcut)

			update_accelerator (develop_window.window)
		end

feature -- Query

	menu_name: STRING_GENERAL
			-- <Precursor>
		do
			Result := interface_names.m_reload_tab
		end

	new_menu_item: EB_COMMAND_MENU_ITEM
			-- <Precursor>
		do
			Result := Precursor
			Result.set_pixmap (pixmaps.icon_pixmaps.general_refresh_icon)
		end

feature -- Command

	execute
			-- <Precursor>
		local
			l_manager: EB_EDITORS_MANAGER
			dev_window: EB_DEVELOPMENT_WINDOW
			l_smart_editor: EB_SMART_EDITOR
			l_content: like current_focused_content
			l_save_request: ES_DISCARDABLE_QUESTION_PROMPT
		do
			l_content := current_focused_content
			if l_content /= Void then
				if l_content.type = {SD_ENUMERATION}.editor then
					dev_window := window_manager.last_focused_development_window
					l_manager := dev_window.editors_manager
					l_smart_editor := l_manager.editor_with_content (l_content)
					if l_smart_editor /= Void then
						if l_smart_editor.text_displayed.is_modified then
							create l_save_request.make (warning_messages.w_Must_save_before_reloading (l_smart_editor.stone.stone_name),
									yes_no_buttons,
									no_button,
									yes_button,
									no_button,
									interface_names.l_Discard_save_before_reloading_dialog,
									create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.confirm_save_before_reloading_preference, True)
								)
							l_save_request.set_title (interface_names.t_eiffelstudio_question)
							l_save_request.set_button_text (yes_button, interface_names.b_continue)

							l_save_request.set_button_action (yes_button, agent (i_dev_window: EB_DEVELOPMENT_WINDOW; i_smart_editor: EB_SMART_EDITOR)
									do
										i_dev_window.save_text
										i_smart_editor.reload
									end(dev_window, l_smart_editor)
								)
							l_save_request.show_on_active_window
						else
							l_smart_editor.reload
						end
					else
						check not_possible: False end
					end
				elseif l_content.type = {SD_ENUMERATION}.tool then
					-- FIXME
				end
			end
		end

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
