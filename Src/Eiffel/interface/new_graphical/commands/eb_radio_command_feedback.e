note
	description: "Command linked with a menu and a radio tool bar button."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_RADIO_COMMAND_FEEDBACK

inherit
	EB_COMMAND_FEEDBACK
		redefine
			button,
			sd_button,
			menu_item
		end

feature -- Status setting

	enable_select
			-- Set both `button' and `menu_entry'
			-- to be selected.
		do
			if button /= Void then
				button.select_actions.block
				button.enable_select
				button.select_actions.resume
			end
			if sd_button /= Void then
				sd_button.select_actions.block
				sd_button.enable_select
				sd_button.select_actions.resume
			end
			if menu_item /= Void then
				menu_item.select_actions.block
				menu_item.enable_select
				menu_item.select_actions.resume
			end
			if
				combo /= Void and then
				(combo.text.is_empty or else
				not combo.text.is_equal(capital_command_name))
			then
				combo.change_actions.block
				combo.set_text (capital_command_name)
				combo.change_actions.resume
			end
		ensure
			button_selected: not safety_flag and button /= Void implies button.is_selected
			menu_selected: not safety_flag and menu_item /= Void implies menu_item.is_selected
			combo_updated: not safety_flag and combo /= Void implies combo.text.is_equal (capital_command_name)
		end

feature -- Interface

	command_name: STRING_GENERAL
			-- Name of current command throughout the interface (in lower case).
		deferred
		ensure
			valid_result: valid_string (Result)
			lower_case: is_lower_case (Result)
		end

	capital_command_name: STRING_GENERAL
			-- Name of current command throughout the interface (in lower case, but the first letter).
		deferred
		end

	menu_name: STRING_GENERAL
			-- String representation in the associated menu.
		deferred
		ensure
			valid_result: Result /= Void
		end

feature -- Status setting

	set_combo_box (a_combo: EV_COMBO_BOX)
			-- Set `combo' to `a_combo'.
		do
			combo := a_combo
		end

feature -- Access

	menu_item: EV_RADIO_MENU_ITEM
			-- Menu entry in the menu.

	combo: EV_COMBO_BOX
			-- Combo box giving a choice between several radio commands.

	selected: BOOLEAN
			-- Is current command selected?
		do
			if sd_button /= Void then
				Result := sd_button.is_selected
			elseif button /= Void then
				Result := button.is_selected
			elseif menu_item /= Void then
				Result := menu_item.is_selected
			elseif combo /= Void then
				Result := combo.text.is_equal (capital_command_name)
			end
		end

feature -- Implementation

	valid_string (str: STRING_GENERAL): BOOLEAN
			-- Is `str' neither Void nor empty
			-- It used to be nor filled with blanks with STRING_8
			--| Cannot be in a non exported part because post conditions use it.
		do
			Result := str /= Void and then not str.is_empty
		end

	is_lower_case (str: STRING_GENERAL): BOOLEAN
			-- Is `str' lower case?
			--| Cannot be in a non exported part because post conditions use it.
		do
			Result := interface_names.is_string_general_lower (str)
		end

	is_button_sensitive: BOOLEAN
			-- Is button appear sensitive?
		do
			check
				only_one_button_is_available: (button /= Void or sd_button /= Void) and not (button = Void and sd_button = Void)
			end
			if button /= Void then
				Result := button.is_sensitive
			elseif sd_button.is_sensitive then
				Result := sd_button.is_sensitive
			end
		end

feature {NONE} -- Access

	button: EV_TOOL_BAR_RADIO_BUTTON
			-- Button on the toolbar.

	sd_button: SD_TOOL_BAR_RADIO_BUTTON
			-- Button on the toolbar.

feature {NONE} -- Implementation

	safety_flag: BOOLEAN;
			-- Are we modifying the select status? (to prevent stack overflows)

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

end -- class EB_RADIO_COMMAND_FEEDBACK
