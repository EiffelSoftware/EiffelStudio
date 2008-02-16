indexing
	description: "Dialog to change the maximum call stack depth"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CALL_STACK_DEPTH_DIALOG

inherit
	ES_DIALOG
		redefine
			on_shown
		end

create
	make_with_debugger

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make_with_debugger (a_debugger: DEBUGGER_MANAGER) is
			-- Instanciate Current with `a_debugger'
		do
			debugger_manager := a_debugger
			make
		end

	build_dialog_interface (a_container: EV_VERTICAL_BOX) is
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			rb2: EV_RADIO_BUTTON
			l: EV_LABEL
			okb, cancelb: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
		do
				-- Create widgets.
			create show_all_radio.make_with_text (Interface_names.l_show_all_call_stack)
			create rb2.make_with_text (Interface_names.l_Show_only_n_elements)
			create l.make_with_text (Interface_names.l_Elements)
			create set_as_default.make_with_text (Interface_names.l_Set_as_default)
			create element_nb.make_with_value_range (1 |..| 500)
			create okb.make_with_text (Interface_names.b_Ok)
			create cancelb.make_with_text (Interface_names.b_Cancel)

				-- Set widget properties.
			element_nb.enable_sensitive
			if Debugger_manager.maximum_stack_depth > 500 then
				element_nb.set_value (500)
			elseif Debugger_manager.maximum_stack_depth = -1 then
				element_nb.set_value (50)
				show_all_radio.enable_select
				element_nb.disable_sensitive
			else
				element_nb.set_value (Debugger_manager.maximum_stack_depth)
			end

				-- Organize widgets.
			vb := a_container
			vb.extend (show_all_radio)
			vb.disable_item_expand (show_all_radio)

			create hb
			hb.merge_radio_button_groups (vb)
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			hb.extend (rb2)
			hb.disable_item_expand (rb2)
			hb.extend (element_nb)
			hb.disable_item_expand (element_nb)
			hb.extend (l)
			hb.disable_item_expand (l)
			hb.extend (create {EV_CELL})
			vb.extend (hb)
			vb.disable_item_expand (hb)

			vb.extend (set_as_default)
			vb.disable_item_expand (set_as_default)

				-- Set up actions.
			set_button_action_before_close (dialog_buttons.ok_button, agent on_ok)
			set_button_action_before_close (dialog_buttons.cancel_button, agent on_cancel)

			show_all_radio.select_actions.extend (agent element_nb.disable_sensitive)
			rb2.select_actions.extend (agent element_nb.enable_sensitive)

			rb2.enable_select
		end

	on_shown is
			-- Called once the foundation widget has been shown.
		do
			element_nb.set_focus
		end

feature -- Properties

	debugger_manager: DEBUGGER_MANAGER
			-- Associated debugger manager

	set_as_default: EV_CHECK_BUTTON
			-- Button that decides whether the chosen stack depth should be saved in the preferences.

	element_nb: EV_SPIN_BUTTON
			-- Spin button that indicates how many stack elements should be displayed.

	show_all_radio: EV_RADIO_BUTTON
			-- Radio button that indicates whether all stack elements should be displayed.

feature -- Actions

	on_cancel is
			-- Close `dialog' without doing anything.
		do
		end

	on_ok is
			-- Close `dialog' without doing anything.
		local
			nb: INTEGER
		do
			if show_all_radio.is_selected then
				nb := -1
			else
				nb := element_nb.value
			end
			if set_as_default.is_selected then
				preferences.debugger_data.default_maximum_stack_depth_preference.set_value (nb)
			end
			debugger_manager.set_maximum_stack_depth (nb)
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
			Result := interface_names.t_Set_stack_depth
		end

	buttons: DS_SET [INTEGER] is
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.ok_cancel_buttons
		end

	default_button: INTEGER is
			-- The dialog's default action button
		do
			Result := dialog_buttons.cancel_button
		end

	default_cancel_button: INTEGER is
			-- The dialog's default cancel button
		do
			Result := dialog_buttons.cancel_button
		end

	default_confirm_button: INTEGER is
			-- The dialog's default confirm button		
		do
			Result := dialog_buttons.cancel_button
		end

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

end -- class ES_CALL_STACK_DEPTH_DIALOG
