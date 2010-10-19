note
	description	: "Command to save a file. Used by the development window and the dynamic lib window"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SAVE_FILE_COMMAND

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
			tooltext,
			pixel_buffer
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

	EB_SAVE_FILE

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
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("save")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			accelerator.actions.extend (agent execute)
			set_referred_shortcut (l_shortcut)
			disable_sensitive
			data_lose_warning := True
		end

feature -- Execution

	execute
			-- Save a file with the chosen name.
		local
			compileok: BOOLEAN
		do
				-- FIXME XR: We add a test `is_sensitive' to prevent calls from the accelerator.
				-- It would be nicer to use the `executable' feature but tshat's 5.1 :)
			if is_sensitive and target.file_name /= Void then
				target.perform_check_before_save
				compileok := True
				target.on_before_text_saved
				if
					target.check_passed and then
					compileok
				then
					if data_lose_warning then
						presave_process (target.text, target.encoding, target.bom)
						if last_process_lost_data then
							warn_and_suggest_encoding
						else
							real_save
						end
					else
						real_save
					end
				end
			end
		end

feature -- Status

	data_lose_warning: BOOLEAN
			-- Warn when there is data lose?

feature -- Status setting

	set_data_lose_warning (a_b: BOOLEAN)
			-- Enable/disable data lose warning dialog.
		do
			data_lose_warning := a_b
		ensure
			data_lose_warning_set: data_lose_warning = a_b
		end

feature {NONE} -- Implementation

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Save_new
		end

	pixmap: EV_PIXMAP
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_save_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_save_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Save
		end

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_Save
		end

	description: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Save
		end

	name: STRING = "Save_file"
			-- Name of the command. Used to store the command in the
			-- preferences.

	on_text_edited (directly_edited: BOOLEAN)
			-- make the command sensitive
		do
			enable_sensitive
		end

	on_text_reset
			-- make the command insensitive
		do
			if attached target as l_target then
				l_target.update_save_symbol
			end
		end

	on_text_back_to_its_last_saved_state
			-- make the command insensitive
		do
			disable_sensitive
		end

	real_save
			-- Save the text without warning
		do
			save (target.file_name, target.text, target.encoding, target.bom)
			if last_saving_success then
				target.set_last_saving_date (last_saving_date)
				target.on_text_saved
				target.update_save_symbol
			else
				target.set_last_save_failed (True)
			end
		end

	set_unicode_encoding_and_save
			-- Set the target to be unicode encoding and save.
		do
			target.set_encoding (utf8)
			target.set_bom (bom_utf8)
			real_save
		end

	warn_and_suggest_encoding
			-- Warn data lose and suggest saving encoding.
		local
			l_dialog: ES_SAVE_CLASSES_PROMPT
			l_list: DS_ARRAYED_LIST [CLASS_I]
		do
			create l_dialog.make_standard_with_cancel (interface_names.l_save_file_in_unicode)
			create l_list.make (1)
			if attached {CLASSI_STONE}target.stone as l_cs then
				l_list.force_last (l_cs.class_i)
			end
			l_dialog.classes := l_list
			l_dialog.set_button_action (l_dialog.dialog_buttons.yes_button, agent set_unicode_encoding_and_save)
			l_dialog.set_button_action (l_dialog.dialog_buttons.no_button, agent real_save)
			l_dialog.set_sub_title (interface_names.st_unicode_cannot_save)
			l_dialog.show_on_active_window
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
