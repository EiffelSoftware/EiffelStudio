note
	description	: "Page in which the user choose between a dialog and frame based application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_SECOND_STATE

inherit
	BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

	WIZARD_PROJECT_SHARED

create
	make

feature -- Basic Operation

	build
			-- Build entries.
		local
			radio_box: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
		do
			create win_application.make_with_text (interface_names.l_frame_application)
			create dialog_application.make_with_text (interface_names.l_dialog_application)

			create radio_box
			radio_box.extend (win_application)
			radio_box.disable_item_expand (win_application)
			radio_box.extend (dialog_application)
			radio_box.disable_item_expand (dialog_application)
			radio_box.extend (create {EV_CELL})

			create preview_pixmap
				-- Set the right pixmap depending on `dialog_information' and
				-- select the right radio button
			if wizard_information.dialog_application then
				preview_pixmap.set_with_named_file (Preview_dialog_pixmap)
				dialog_application.enable_select
			else
				preview_pixmap.set_with_named_file (Preview_frame_pixmap)
				win_application.enable_select
			end
			preview_pixmap.set_minimum_size (preview_pixmap.width, preview_pixmap.height)

			create hbox
			hbox.extend (radio_box)
			hbox.extend (preview_pixmap)
			choice_box.extend (hbox)
			choice_box.disable_item_expand (hbox)

			set_updatable_entries(<<win_application.select_actions, dialog_application.select_actions>>)

				-- Connect actions.
			win_application.select_actions.extend (agent change_preview)
			dialog_application.select_actions.extend (agent change_preview)
		end

	change_preview
			-- Change the pixmap used to preview the application.
		do
			if dialog_application.is_selected then
				preview_pixmap.set_with_named_file (Preview_dialog_pixmap)
			else
				preview_pixmap.set_with_named_file (Preview_frame_pixmap)
			end
		end

	proceed_with_current_info
		local
			next_window: WIZARD_STATE_WINDOW
			existing_target_files: TRAVERSABLE [STRING_GENERAL]
		do
			if dialog_application.is_selected then
				existing_target_files := (create {WIZARD_PROJECT_GENERATOR}.make (wizard_information)).existing_target_files
				if existing_target_files.is_empty then
						-- Go to code generation step.
					create {WIZARD_FINAL_STATE} next_window.make (wizard_information)
				else
						-- Warn that there are files to be overwritten.
					create {WIZARD_WARNING_FILE_PRESENCE} next_window.make_with_names (existing_target_files, wizard_information)
				end
			else
				create {WIZARD_THIRD_STATE} next_window.make(wizard_information)
			end
			Precursor
			proceed_with_new_state (next_window)
		end

	update_state_information
			-- Check User Entries
		do
			wizard_information.set_dialog_application (dialog_application.is_selected)
			Precursor
		end


feature {NONE} -- Implementation

	display_state_text
		do
			title.set_text (interface_names.t_wel_app_type)
			subtitle.set_text (interface_names.t_choose_type_subtitle)
			message.set_text (interface_names.m_a_frame_based_application)
		end

feature {NONE} -- Constants

	Preview_dialog_pixmap: FILE_NAME
			-- Filename for the pixmap representing a dialog-based application
		once
			create Result.make_from_string (wizard_pixmaps_path)
			Result.set_file_name ("dialog_application")
			Result.add_extension (pixmap_extension)
		end

	Preview_frame_pixmap: FILE_NAME
			-- Filename for the pixmap representing a frame-based application
		once
			create Result.make_from_string (wizard_pixmaps_path)
			Result.set_file_name ("frame_application")
			Result.add_extension (pixmap_extension)
		end

feature {NONE} -- Vision2 layout

	dialog_application: EV_RADIO_BUTTON
			-- When checked, create a Dialog application

	win_application: EV_RADIO_BUTTON
			-- When checked, create a Frame application

	vbox_dialog: EV_VERTICAL_BOX
			-- vbox that contains the dialog buttons

	preview_pixmap: EV_PIXMAP;
			-- Pixmap used to preview the application.

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
end -- class WIZARD_FIRST_STATE
