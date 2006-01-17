indexing
	description	: "Dialog to display an exception trace"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_EXCEPTION_DIALOG

inherit
	EV_DIALOG
		
	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
create
	make

feature {NONE} -- Initialization

	make (a_trace: STRING) is
			-- Perform clean quit of $EiffelGraphicalCompiler$
		local
			error_label: EV_LABEL
			error_pixmap: EV_PIXMAP
			buttons_box: EV_HORIZONTAL_BOX
			error_box: EV_HORIZONTAL_BOX
			main_box: EV_VERTICAL_BOX
			ignore_button: EV_BUTTON
			quit_button: EV_BUTTON
			restart_button: EV_BUTTON
			pixmap_box: EV_VERTICAL_BOX
			exception_frame: EV_FRAME
			exception_text: SELECTABLE_TEXT_PANEL
			save_button: EV_BUTTON
		do
			trace := a_trace
			
			default_create
			set_title ("Internal Error")
			set_icon_pixmap (pixmaps.icon_dialog_window)
			set_size (600, 440)

			create error_label.make_with_text (Warning_messages.w_internal_error)
			error_label.align_text_left
			error_pixmap := Pixmaps.error_pixmap.twin
			error_pixmap.set_minimum_size (error_pixmap.width, error_pixmap.height)
			
			create ignore_button.make_with_text_and_action ("Ignore", agent destroy)
			create quit_button.make_with_text_and_action ("Quit now!", agent execute_die)
			create restart_button.make_with_text_and_action ("Restart now!", agent restart)
			create save_button.make_with_text_and_action ("Save", agent save_exeption_trace)
			Layout_constants.set_default_size_for_button (ignore_button)
			Layout_constants.set_default_size_for_button (quit_button)
			Layout_constants.set_default_size_for_button (restart_button)
			Layout_constants.set_default_size_for_button (save_button)

			create exception_text
			exception_text.set_cursors (create {EB_EDITOR_CURSORS})
			exception_text.widget.set_minimum_height (Layout_constants.dialog_unit_to_pixels (60))
			exception_text.disable_line_numbers
			exception_text.load_text (trace)
			
			create pixmap_box
			pixmap_box.extend (error_pixmap)
			pixmap_box.disable_item_expand (error_pixmap)
			pixmap_box.extend (create {EV_CELL})
			
			create error_box
			error_box.set_padding (Layout_constants.Default_padding_size)
			error_box.extend (pixmap_box)
			error_box.disable_item_expand (pixmap_box)
			error_box.extend (error_label)
			error_box.disable_item_expand (error_label)
			error_box.extend (create {EV_CELL})
			
			create exception_frame
			exception_frame.extend (exception_text.widget)

			create buttons_box
			buttons_box.set_padding (Layout_constants.Default_padding_size)
			buttons_box.extend (create {EV_CELL})
			buttons_box.extend (ignore_button)
			buttons_box.disable_item_expand (ignore_button)
			buttons_box.extend (quit_button)
			buttons_box.disable_item_expand (quit_button)
			buttons_box.extend (restart_button)
			buttons_box.disable_item_expand (restart_button)
			buttons_box.extend (save_button)
			buttons_box.disable_item_expand (save_button)
			buttons_box.extend (create {EV_CELL})
			
			create main_box
			main_box.set_padding (Layout_constants.Default_padding_size)
			main_box.set_border_width (Layout_constants.Default_border_size)
			main_box.extend (error_box)
			main_box.disable_item_expand (error_box)
			main_box.extend (exception_frame) -- Expadable item
			main_box.extend (buttons_box)
			main_box.disable_item_expand (buttons_box)
			
			extend (main_box)
			set_default_push_button (ignore_button)
			set_default_cancel_button (ignore_button)
		end
		
feature {NONE} -- Implementation

	execute_die is
			-- Command call when a crash occurs to clean up disk
		do
				-- Ensure clean exit in case of exception
			(create {EXCEPTIONS}).die (-1)
		end

	restart is
		local
			launcher: COMMAND_EXECUTOR
		do
			create launcher
			launcher.execute ((create {EIFFEL_ENV}).Estudio_command_name)
			execute_die
		end

	save_exeption_trace is
			-- Save exception trace into a file
		local
			sfd: EB_FILE_SAVE_DIALOG
			text_file: PLAIN_TEXT_FILE
			retried: BOOLEAN
			l_env: EXECUTION_ENVIRONMENT
			l_dir: STRING
		do
			if not retried then
				create sfd.make_with_preference (preferences.dialog_data.last_saved_exception_directory_preference)
				set_dialog_filters_and_add_all (sfd, <<text_files_filter>>)
				create l_env
				l_dir := l_env.current_working_directory
				sfd.show_modal_to_window (Current)
				l_env.change_working_directory (l_dir)
				if not sfd.file_name.is_empty then
					create text_file.make_open_write (sfd.file_name)
					text_file.put_string (trace)
					text_file.close
				end
			end
		rescue
			retried := True
			retry
		end

	trace: STRING;
			-- displayed Trace
			
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_EXCEPTION_DIALOG
