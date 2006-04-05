indexing
	description	: "Dialog to type the name of a folder."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_TYPE_FOLDER_DIALOG

inherit
	EV_DIALOG

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_VISION2_FACILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize the dialog
		do
			default_create
			set_title (Interface_names.t_Choose_folder_name)
			set_icon_pixmap (pixmaps.icon_dialog_window)
			prepare
		end

	prepare is
			-- Create the controls and setup the layout
		local
			buttons_box: EV_VERTICAL_BOX
			controls_box: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
				-- Create the button box
			create buttons_box
			buttons_box.set_padding (Layout_constants.Default_padding_size)
			buttons_box.set_border_width (Layout_constants.Default_padding_size)
	
			create ok_button.make_with_text_and_action (Interface_names.b_Ok, agent on_ok)
			extend_button (buttons_box, ok_button)

			create cancel_button.make_with_text_and_action (Interface_names.b_Cancel, agent on_cancel)
			extend_button (buttons_box, cancel_button)

				-- Create the controls
			create folder_name_entry
			create label.make_with_text (Interface_names.l_Enter_folder_name)
			
				-- Create the left panel: a Combo Box to type the name of the class
				-- and a tree to select the class.
			create controls_box
			controls_box.set_padding (Layout_constants.Small_padding_size)
			controls_box.set_border_width (Layout_constants.Default_padding_size)
			extend_no_expand (controls_box, label)
			extend_no_expand (controls_box, folder_name_entry)
			controls_box.extend (create {EV_CELL})

				-- Pack the buttons_box and the controls.
			create hb
			hb.extend (controls_box)
			extend_no_expand (hb, buttons_box)
			extend (hb)
			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
			show_actions.extend (agent folder_name_entry.set_focus)
		end

feature -- Access

	selected: BOOLEAN
			-- Has the user selected a class (True) or pushed
			-- the cancel button (False)

	folder_name: STRING
			-- Folder name entered by the user, if any.

feature {NONE} -- Vision2 events

	on_ok is
			-- Terminate the dialog
		local
			wd: EV_WARNING_DIALOG
		do
			folder_name := folder_name_entry.text
			if folder_name.is_empty then
				create wd.make_with_text (Warning_messages.w_Invalid_folder_name)
				wd.show_modal_to_window (Current)
			else
				selected := True
				destroy
			end
		end

	on_cancel is
			-- Terminate the dialog and clear the selection.
		do
			selected := False
			folder_name := ""
			destroy
		end

feature {NONE} -- Controls

	ok_button: EV_BUTTON
			-- "Ok" button

	cancel_button: EV_BUTTON
			-- "Cancel" button

	folder_name_entry: EV_TEXT_FIELD;
			-- Text field where the user can type its folder name.

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

end -- class EB_TYPE_FOLDER_DIALOG
	
