note
	description	: "Command to save all files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SAVE_ALL_FILE_COMMAND

inherit
	EB_FILEABLE_COMMAND
		redefine
			make
		end

	TEXT_OBSERVER
		redefine
			on_text_reset, on_text_edited,
			on_text_back_to_its_last_saved_state
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SHARED_WORKBENCH

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	SYSTEM_ENCODINGS
		export
			{NONE} all
		end

	BOM_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (a_manager: like target)
			-- Create a formatter associated with `a_manager'.
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			Precursor (a_manager)
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("save_all")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			accelerator.actions.extend (agent execute)
			set_referred_shortcut (l_shortcut)
			disable_sensitive
		end

feature -- Execution

	execute
			-- Save a file with the chosen name.
		local
			l_dev_win: EB_DEVELOPMENT_WINDOW
			l_editors, l_data_lost_editors: ARRAYED_LIST [EB_SMART_EDITOR]
			l_editor, l_ed: EB_SMART_EDITOR
			l_editors_manager: EB_EDITORS_MANAGER
			cst: CLASSC_STONE
			l_cmd: EB_SAVE_FILE_COMMAND
		do
			l_dev_win ?= target
			if l_dev_win /= Void then
				l_dev_win.lock_update
				l_editors_manager := l_dev_win.editors_manager
				l_editor := l_editors_manager.current_editor
				l_editors := l_editors_manager.unsaved_editors
				l_cmd := l_dev_win.save_cmd
				create l_data_lost_editors.make (l_editors.count)
				from
					l_editors.start
				until
					l_editors.after
				loop
					l_ed := l_editors.item_for_iteration
					l_editors_manager.select_editor (l_ed, True)
					l_cmd.presave_process (l_dev_win.text, l_dev_win.encoding, l_dev_win.bom)
						-- Save file
					if not l_cmd.last_process_lost_data then
						l_cmd.set_data_lose_warning (False)
						l_cmd.execute
						l_cmd.set_data_lose_warning (True)
					else
						l_data_lost_editors.extend (l_ed)
					end

						-- Set changed in project
					cst ?= l_editors.item.stone
					if cst /= Void and then cst.is_valid then
						l_dev_win.set_classi_changed (cst.e_class)
					end
					l_editors.forth
				end
				if not l_data_lost_editors.is_empty then
					warn_and_suggest_encoding (l_data_lost_editors)
				end
				if l_editor /= Void then
					l_editors_manager.select_editor (l_editor, True)
				end
				l_dev_win.unlock_update
			end
		end

feature {NONE} -- Status

	has_unsaved_file: BOOLEAN
			-- Has unsaved file?
		local
			l_dev: EB_DEVELOPMENT_WINDOW
		do
			l_dev ?= target
			Result := l_dev.any_editor_changed
		end

feature {NONE} -- Implementation

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_save_all
		end

	pixmap: EV_PIXMAP
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_save_all_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_save_all_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_save_all
		end

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_save_all
		end

	description: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_save_all
		end

	name: STRING = "Save_all_file"
			-- Name of the command. Used to store the command in the
			-- preferences.

	on_text_edited (directly_edited: BOOLEAN)
			-- make the command sensitive
		do
			if not is_recycled then
				enable_sensitive
			end
		end

	on_text_reset
			-- make the command insensitive
		do
			if not is_recycled and then not has_unsaved_file then
				disable_sensitive
			end
		end

	on_text_back_to_its_last_saved_state
			-- make the command insensitive
		do
			if not is_recycled and then not has_unsaved_file then
				disable_sensitive
			end
		end

	warn_and_suggest_encoding (a_editors: ARRAYED_LIST [EB_SMART_EDITOR])
			-- Warn data lose and suggest saving encoding.
		require
			a_editors_not_void: a_editors /= Void
			a_editors_not_empty: not a_editors.is_empty
		local
			l_dialog: ES_SAVE_CLASSES_PROMPT
			l_list: DS_ARRAYED_LIST [CLASS_I]
		do
			create l_list.make_default
			from a_editors.start
			until
				a_editors.after
			loop
				if attached {CLASSI_STONE}a_editors.item_for_iteration.stone as l_cs then
					l_list.force_last (l_cs.class_i)
				end
				a_editors.forth
			end
			create l_dialog.make_standard_with_cancel (interface_names.l_save_file_in_unicode)
			l_dialog.classes := l_list
			l_dialog.set_sub_title (interface_names.st_unicode_cannot_save)
			l_dialog.set_button_action (l_dialog.dialog_buttons.yes_button, agent save_editors (a_editors, True))
			l_dialog.set_button_action (l_dialog.dialog_buttons.no_button, agent save_editors (a_editors, False))
			l_dialog.show_on_active_window
		end

	save_editors (a_editors: ARRAYED_LIST [EB_SMART_EDITOR]; a_unicode: BOOLEAN)
			-- Save text in given editors in Unicode encoding or not.
		require
			a_editors_not_void: a_editors /= Void
		local
			l_cmd: EB_SAVE_FILE_COMMAND
		do
			if attached {EB_DEVELOPMENT_WINDOW}target as l_dev_win then
				from
					a_editors.start
					l_cmd := l_dev_win.save_cmd
					l_cmd.set_data_lose_warning (False)
				until
					a_editors.after
				loop
					l_dev_win.editors_manager.select_editor (a_editors.item_for_iteration, True)
					if a_unicode then
						l_dev_win.set_encoding (Utf8)
						l_dev_win.set_bom (Bom_utf8)
					end
					l_cmd.execute
					a_editors.forth
				end
				l_cmd.set_data_lose_warning (True)
			end
		end

feature {NONE} -- Implementation

	enable_toolbar_items
			-- make toolbar items sensitive
		do
			from
				managed_sd_toolbar_items.start
			until
				managed_sd_toolbar_items.exhausted
			loop
				managed_sd_toolbar_items.item.enable_sensitive
				managed_sd_toolbar_items.forth
			end
		end

	disable_toolbar_items
			-- make toolbar items insensitive
		do
			from
				managed_sd_toolbar_items.start
			until
				managed_sd_toolbar_items.exhausted
			loop
				managed_sd_toolbar_items.item.disable_sensitive
				managed_sd_toolbar_items.forth
			end
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class EB_SAVE_FILE_COMMAND
