indexing
	description	: "Command to open a file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
class
	EB_OPEN_FILE_COMMAND

inherit
	EB_FILEABLE_COMMAND
		redefine
			initialize
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_CONFIRM_SAVE_CALLBACK
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_o),
				True, False, False)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operation

	execute is
			-- Open a file.
		local
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			if is_sensitive then
				if target.changed then
						-- Ask confirmation if content has changed.
					create csd.make_and_launch (target, Current)
				else
					process
				end
			end
		end

feature -- Properties

	menu_name: STRING is
		do
			Result := Interface_names.m_Open_new
		end

	pixmap: EV_PIXMAP is
		do
			Result := Pixmaps.Icon_open_file
		end

	name: STRING is "Open_file"

	description: STRING is
		do
			Result := Interface_names.e_Open_file
		end

	tooltip: STRING is
		do
			Result := description
		end

	tooltext: STRING is
			-- Text of toolbar button
		do
			Result := Interface_names.b_Open
		end


feature {NONE} -- Implementation

	process is
		local
			fod: EB_FILE_OPEN_DIALOG
			l_env: EXECUTION_ENVIRONMENT
			l_dir: STRING
		do
			create fod.make_with_preference (preferences.dialog_data.last_opened_file_directory_preference)
			set_dialog_filters_and_add_all (fod, <<eiffel_class_files_filter>>)
			fod.open_actions.extend (agent execute_callback (fod))
			create l_env
			l_dir := l_env.current_working_directory
			fod.show_modal_to_window (window_manager.last_focused_development_window.window)
			l_env.change_working_directory (l_dir)
		end

	execute_callback (dialog: EB_FILE_OPEN_DIALOG) is
			-- Open a file.
		local
			fn: FILE_NAME
			f: PLAIN_TEXT_FILE
			efs: EXTERNAL_FILE_STONE
			bckfn: FILE_NAME
			backup_file: PLAIN_TEXT_FILE
			cd: EV_CONFIRMATION_DIALOG
			class_i: CLASS_I
			class_stone: CLASSI_STONE
			wd: EV_WARNING_DIALOG
		do
			create fn.make_from_string (dialog.file_name)
			if not fn.is_empty then
				bckfn := fn.twin
				bckfn.add_extension ("swp")
				create backup_file.make (bckfn)
				open_backup := False
				if backup_file.exists then
					ask_whether_to_open_backup
				end
				if open_backup then
					create f.make (bckfn)
				else
					create f.make (fn)
				end
				if f.exists and then f.is_readable and then f.is_plain then
					conf_todo
--					class_i := Eiffel_universe.class_with_file_name (fn)
					if class_i = Void then
						if allow_external_files_in_ide then
							create efs.make (f)
							target.set_stone (efs)
						else
							create wd.make_with_text (Warning_messages.w_Cannot_open_any_file)
							wd.show_modal_to_window (window_manager.last_focused_development_window.window)
						end
					else
						if class_i.compiled then
							create {CLASSC_STONE} class_stone.make (class_i.compiled_class)
						else
							create {CLASSI_STONE} class_stone.make (class_i)
						end
						target.set_stone (class_stone)
					end
				elseif f.exists and then not f.is_plain then
					create cd.make_with_text (Warning_messages.w_Not_a_file_retry (fn))
					cd.button ("OK").select_actions.extend (agent execute)
					cd.show_modal_to_window (window_manager.last_focused_development_window.window)
				else
					create cd.make_with_text (Warning_messages.w_Cannot_read_file_retry (fn))
					cd.button ("OK").select_actions.extend (agent execute)
					cd.show_modal_to_window (window_manager.last_focused_development_window.window)
				end
			else
				create cd.make_with_text (Warning_messages.w_Not_a_file_retry (fn))
				cd.button ("OK").select_actions.extend (agent execute)
				cd.show_modal_to_window (window_manager.last_focused_development_window.window)
			end
		end

	ask_whether_to_open_backup is
			-- Display a dialog asking the user whether he wants to open
			-- the original file or the backup one, and set `open_backup' accordingly.
		local
			dial: EV_DIALOG
			butbackup, butnormal: EV_BUTTON
			lab: EV_LABEL
			butcont: EV_HORIZONTAL_BOX
			maincont: EV_VERTICAL_BOX
		do
			create dial
			create butcont
			create maincont
			create butbackup.make_with_text (Interface_names.b_Open_backup)
			butbackup.select_actions.extend (agent open_backup_selected)
			butbackup.select_actions.extend (agent dial.destroy)
			create butnormal.make_with_text (Interface_names.b_Open_original)
			butnormal.select_actions.extend (agent open_normal_selected)
			butnormal.select_actions.extend (agent dial.destroy)
			create lab.make_with_text (Warning_messages.w_Found_backup)
			butcont.set_padding (3)
			butcont.extend (create {EV_CELL})
			butcont.extend (butbackup)
			butcont.disable_item_expand (butbackup)
			butcont.extend (butnormal)
			butcont.disable_item_expand (butnormal)
			butcont.extend (create {EV_CELL})
			maincont.set_padding (5)
			maincont.set_border_width (3)
			maincont.extend (lab)
			maincont.disable_item_expand (lab)
			maincont.extend (butcont)
			maincont.disable_item_expand (butcont)
			dial.set_title ("Backup found")
			dial.set_icon_pixmap (pixmaps.icon_dialog_window)
			dial.extend (maincont)
			dial.set_size (dial.minimum_width, dial.minimum_height)
			dial.disable_user_resize
			dial.set_default_push_button (butbackup)
			dial.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	open_normal_selected is
			-- The open normal button was pushed.
		do
			open_backup := False
		end

	open_backup_selected is
			-- The open backup button was pushed.
		do
			open_backup := True
		end

	open_backup: BOOLEAN
			-- If a backup file is present, indicates whether it should be opened or not.

	allow_external_files_in_ide: BOOLEAN is False;
			-- Flag to determine if we can load non-eiffel files in the environment

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EB_OPEN_FILE_CMD
