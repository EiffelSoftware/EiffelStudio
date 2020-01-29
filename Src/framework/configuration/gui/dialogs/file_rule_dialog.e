note
	description: "Dialog to edit file rules."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_RULE_DIALOG

inherit
	PROPERTY_DIALOG [ARRAYED_LIST [CONF_FILE_RULE]]
		redefine
			create_interface_objects,
			initialize
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create,
			copy
		end

feature {NONE} -- Initialization

	create_interface_objects
		do
			Precursor
			create remove_button
			create notebook
		end

	initialize
			-- Initialization
		local
			l_btn: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
		do
			Precursor
			enable_user_resize
			set_minimum_height (600)

--			create notebook
			element_container.extend (notebook)

			create hb
			element_container.extend (hb)
			element_container.disable_item_expand (hb)
			hb.set_padding (layout_constants.default_padding_size)

			hb.extend (create {EV_CELL})
			create l_btn.make_with_text_and_action (conf_interface_names.dialog_file_rule_add_rule, agent on_add)
			l_btn.set_pixmap (conf_pixmaps.general_add_icon)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			layout_constants.set_default_width_for_button (l_btn)
--			create remove_button
			remove_button.set_text (conf_interface_names.dialog_file_rule_remove_rule)
			remove_button.select_actions.extend (agent on_remove)
			remove_button.set_pixmap (conf_pixmaps.general_remove_icon)
			hb.extend (remove_button)
			hb.disable_item_expand (remove_button)
			layout_constants.set_default_width_for_button (remove_button)
			layout_constants.set_default_width_for_button (cancel_button)
			layout_constants.set_default_width_for_button (ok_button)

			show_actions.extend (agent on_show)
		end

feature {NONE} -- GUI Elements

	notebook: EV_NOTEBOOK
			-- Notebook for the file rule tabs.

	remove_button: EV_BUTTON
			-- Remove button to remove rules.

feature {NONE} -- Agents

	on_show
			-- Fill in value.
		local
			l_tab: FILE_RULE_TAB
			l_new_value: like value
			l_fr: CONF_FILE_RULE
		do
			notebook.wipe_out
			notebook.selection_actions.extend (agent on_show_tab)
			if attached value as l_value and then not l_value.is_empty then
					-- create a copy of the value, so that we can cancel without modifying anything
				create l_new_value.make (l_value.count)
				from
					l_value.start
				until
					l_value.after
				loop
					l_fr := l_value.item.twin
					l_new_value.force (l_fr)
					create l_tab.make (l_fr)
					notebook.extend (l_tab)
					notebook.set_item_text (l_tab, conf_interface_names.dialog_file_rule_file_rule_x (l_value.index))
					l_value.forth
				end
				notebook.set_focus
				value := l_new_value
				remove_button.enable_sensitive
			else
				remove_button.disable_sensitive
			end
		end

	on_show_tab
			-- Show a tab.
		do
			if attached notebook.selected_item as l_selected_item then
				l_selected_item.show
			end
		end

	on_remove
			-- Remove a file rule.
		do
			if
				attached notebook.selected_item as l_selected_item and
				attached value as l_value
			then
				l_value.go_i_th (notebook.selected_item_index)
				l_value.remove
				notebook.go_i_th (notebook.selected_item_index)
				notebook.remove
				if l_value.is_empty then
					remove_button.disable_sensitive
				end
			end
		end

	on_add
			-- Add a new file rule.
		local
			l_fr: CONF_FILE_RULE
			l_tab: FILE_RULE_TAB
			l_value: like value
		do
			l_value := value
			if l_value = Void then
				create l_value.make (1)
				value := l_value
			end
			create l_fr.make
			l_value.force (l_fr)
			create l_tab.make (l_fr)
			notebook.extend (l_tab)
			notebook.set_item_text (l_tab, conf_interface_names.dialog_file_rule_file_rule_x (l_value.count))
			notebook.select_item (l_tab)
			remove_button.enable_sensitive
		end

invariant
	elements_created: is_initialized implies notebook /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
