note
	description	: "Page in which the user choose..."
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
			create add_menu_bar.make_with_text (interface_names.l_menu_bar)
			create add_tool_bar.make_with_text (interface_names.l_tool_bar)
			create add_status_bar.make_with_text (interface_names.l_status_bar)
			create add_about_dialog.make_with_text (interface_names.l_about_dialogbox)

			create radio_box
			radio_box.extend (add_menu_bar)
			radio_box.disable_item_expand (add_menu_bar)
			radio_box.extend (add_tool_bar)
			radio_box.disable_item_expand (add_tool_bar)
			radio_box.extend (add_status_bar)
			radio_box.disable_item_expand (add_status_bar)
			radio_box.extend (add_about_dialog)
			radio_box.disable_item_expand (add_about_dialog)
			radio_box.extend (create {EV_CELL})

			if wizard_information.has_menu_bar then
				add_menu_bar.enable_select
			else
				add_menu_bar.disable_select
			end
			if wizard_information.has_tool_bar then
				add_tool_bar.enable_select
			else
				add_tool_bar.disable_select
			end
			if wizard_information.has_status_bar then
				add_status_bar.enable_select
			else
				add_status_bar.disable_select
			end
			if wizard_information.has_about_dialog then
				add_about_dialog.enable_select
			else
				add_about_dialog.disable_select
			end

			create preview_pixmap
			change_preview -- set the right pixmap depending on `dialog_information'.
			preview_pixmap.set_minimum_size (preview_pixmap.width, preview_pixmap.height)

			create hbox
			hbox.extend (radio_box)
			hbox.disable_item_expand (radio_box)
			hbox.extend (preview_pixmap)

			choice_box.extend (hbox)

			set_updatable_entries(<<
				add_menu_bar.select_actions,
				add_tool_bar.select_actions,
				add_status_bar.select_actions,
				add_about_dialog.select_actions>>)

				-- Connect actions.
			add_menu_bar.select_actions.extend (agent change_preview)
			add_tool_bar.select_actions.extend (agent change_preview)
			add_status_bar.select_actions.extend (agent change_preview)
			add_about_dialog.select_actions.extend (agent change_preview)
		end

	change_preview
			-- Change the pixmap used to preview the application.
		local
			fn: FILE_NAME
			bn: STRING
			index: INTEGER
		do
			create fn.make_from_string (wizard_pixmaps_path)
			bn := "Image0000"
				--| Number of characters in "Image"
			index := 5
			if add_menu_bar.is_selected then
				bn.put ('1', index + 1)
			end
			if add_tool_bar.is_selected then
				bn.put ('1', index + 2)
			end
			if add_status_bar.is_selected then
				bn.put ('1', index + 3)
			end
			if add_about_dialog.is_selected then
				bn.put ('1', index + 4)
			end
			fn.set_file_name (bn)
			fn.add_extension (pixmap_extension)
			preview_pixmap.set_with_named_file (fn)
		end

	proceed_with_current_info
		do
			Precursor
			proceed_with_new_state (create {WIZARD_FINAL_STATE}.make(wizard_information))
		end

	update_state_information
			-- Check User Entries
		do
			wizard_information.set_has_menu_bar (add_menu_bar.is_selected)
			wizard_information.set_has_tool_bar (add_tool_bar.is_selected)
			wizard_information.set_has_status_bar (add_status_bar.is_selected)
			wizard_information.set_has_about_dialog (add_about_dialog.is_selected)
			Precursor
		end


feature {NONE} -- Implementation

	display_state_text
		do
			title.set_text (interface_names.t_vision2_application_appearance)
			subtitle.set_text (interface_names.t_subtitle)
			message.set_text (interface_names.m_click_checkboxes_to)
		end

	add_menu_bar: EV_CHECK_BUTTON
			-- When checked, create a Dialog application

	add_status_bar: EV_CHECK_BUTTON
			-- When checked, create a Frame application

	add_tool_bar: EV_CHECK_BUTTON
			-- When checked, create a Frame application

	add_about_dialog: EV_CHECK_BUTTON
			-- When checked, create a Frame application

	vbox_dialog: EV_VERTICAL_BOX
			-- vbox that contains the dialog buttons

	preview_pixmap: EV_PIXMAP;
			-- Pixmap used to preview the application.

note
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
end -- class WIZARD_FIRST_STATE
