note
	description: "Dialog to attach debuggee"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EXEC_ATTACH_DIALOG

inherit
	ES_DIALOG
		redefine
			on_shown,
			on_handle_key
		end

create
	make

feature {NONE} -- Initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			okb, cancelb: EV_BUTTON
		do
				-- Create widgets.
			create port_field.make_with_value_range (1000 |..| 65535)
			port_field.set_text ("Port number")
			port_field.set_value (1050)
			create label.make_with_text (Interface_names.e_exec_attach_on_port)
			create okb.make_with_text (Interface_names.b_exec_attach)
			create cancelb.make_with_text (Interface_names.b_Cancel)

			attach_button := okb

				-- Set widget properties.
			port_field.enable_sensitive

			a_container.extend (label)
			a_container.disable_item_expand (label)
			a_container.extend (port_field)
			a_container.disable_item_expand (port_field)

				-- Set up actions.
			set_button_action_before_close (dialog_buttons.ok_button, agent on_ok)
			set_button_action_before_close (dialog_buttons.cancel_button, agent on_cancel)
			port_field.change_actions.extend (agent on_value_changed)
		end

feature -- Access

	label: EV_LABEL
			-- Label

	port_field: EV_SPIN_BUTTON
			-- Field to enter port number

	attach_button: EV_BUTTON
			-- "Attach" button

	attaching_confirmed: BOOLEAN
			-- Is attaching operation confirmed?		

feature -- Actions

	on_ok
			-- Close `dialog' with attaching
		do
			attaching_confirmed := True
		end

	on_cancel
			-- Close `dialog' without doing anything.
		do
			attaching_confirmed := False
		end

feature {NONE} -- Implementation

	on_shown
			-- Called once the foundation widget has been shown.
		do
			port_field.set_focus
		end

	on_handle_key (a_key: EV_KEY; a_alt: BOOLEAN; a_ctrl: BOOLEAN; a_shift: BOOLEAN; a_released: BOOLEAN): BOOLEAN
			-- Called when the tool recieve a key event
			--
			-- `a_key': The key pressed.
			-- `a_alt': True if the ALT key was pressed; False otherwise
			-- `a_ctrl': True if the CTRL key was pressed; False otherwise
			-- `a_shift': True if the SHIFT key was pressed; False otherwise
			-- `a_released': True if the key event pertains to the release of a key, False to indicate a press.
			-- `Result': True to indicate the key was handled
			-- (export status {NONE})
			-- Key was pressed in line number text field box
		do
			if
				not a_ctrl and a_key.code = {EV_KEY_CONSTANTS}.key_enter and then
				port_field.value >= 1000
			then
				attach_button.enable_sensitive
				Result := True
				on_dialog_button_pressed (attach_button_id)
			else
				attach_button.disable_sensitive
			end
		end

	on_value_changed (i: INTEGER)
			-- Text field changed
		local
--			i: INTEGER
		do
--			i := port_field.value
			if i >= 1000 then
				attach_button.enable_sensitive
			else
				attach_button.disable_sensitive
			end
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.general_dialog_icon_buffer
		end

	title: STRING_32
			-- The dialog's title
		do
			Result := interface_names.e_exec_attach
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.ok_cancel_buttons
		end

	attach_button_id: INTEGER
		do
			Result := dialog_buttons.ok_button
		end

	default_button: INTEGER
			-- The dialog's default action button
		do
			Result := dialog_buttons.cancel_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
		do
			Result := dialog_buttons.cancel_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button		
		do
			Result := dialog_buttons.cancel_button
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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

end
