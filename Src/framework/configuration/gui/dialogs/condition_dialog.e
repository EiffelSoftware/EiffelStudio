note
	description: "Dialog to change conditioning statements."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONDITION_DIALOG

inherit
	PROPERTY_DIALOG [CONF_CONDITION_LIST]
		redefine
			is_in_default_state,
			initialize
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create, copy
		end

	CONF_ACCESS
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	initialize
			-- Initialization
		local
			l_btn: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
		do
			Precursor

			create notebook
			element_container.extend (notebook)

			create hb
			element_container.extend (hb)
			element_container.disable_item_expand (hb)
			hb.set_padding (layout_constants.default_padding_size)

			hb.extend (create {EV_CELL})
			create l_btn.make_with_text_and_action (conf_interface_names.dial_cond_add_and_term, agent on_add)
			l_btn.set_pixmap (conf_pixmaps.general_add_icon)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			layout_constants.set_default_width_for_button (l_btn)
			create remove_button.make_with_text_and_action (conf_interface_names.dial_cond_remove_and_term, agent on_remove)
			remove_button.set_pixmap (conf_pixmaps.general_remove_icon)
			hb.extend (remove_button)
			hb.disable_item_expand (remove_button)
			layout_constants.set_default_width_for_button (remove_button)
			layout_constants.set_default_width_for_button (ok_button)
			layout_constants.set_default_width_for_button (cancel_button)

			set_size (400, 530)
			show_actions.extend (agent on_show)
		end

feature {NONE} -- Gui elements

	notebook: EV_NOTEBOOK
			-- Tabs for each and term.

	remove_button: EV_BUTTON
			-- Button to remove an item.

feature {NONE} -- Agents

	on_show
			-- Fill in value.
		local
			l_tab: CONDITION_TAB
			l_new_value: like value
			l_cond: CONF_CONDITION
		do
			notebook.wipe_out
			notebook.selection_actions.extend (agent on_show_tab)
			if value /= Void and then not value.is_empty then
					-- create a copy of the value, so that we can cancel without modifying anything
				create l_new_value.make (value.count)
				from
					value.start
				until
					value.after
				loop
					l_cond := value.item.twin
					l_new_value.force (l_cond)
					create l_tab.make (l_cond)
					notebook.extend (l_tab)
					if value.item = value.first then
						notebook.set_item_text (l_tab, conf_interface_names.dial_cond_and_term_1)
					else
						notebook.set_item_text (l_tab, conf_interface_names.dial_cond_and_term_x (value.index))
					end
					value.forth
				end
				value := l_new_value
				remove_button.enable_sensitive
			else
				remove_button.disable_sensitive
			end
		end

	on_show_tab
			-- Show a tab.
		do
			if notebook.selected_item /= Void then
				notebook.selected_item.show
			end
		end

	on_remove
			-- Remove a file rule.
		do
			if notebook.selected_item /= Void and value /= Void then
				lock_update
				value.go_i_th (notebook.selected_item_index)
				value.remove
				notebook.go_i_th (notebook.selected_item_index)
				notebook.remove
				if value.is_empty then
					remove_button.disable_sensitive
				end
				unlock_update
			end
		end

	on_add
			-- Add a new file rule.
		local
			l_cond: CONF_CONDITION
			l_tab: CONDITION_TAB
		do
			lock_update
			if value = Void then
				create value.make (1)
			end
			create l_cond.make
			value.force (l_cond)
			create l_tab.make (l_cond)
			notebook.extend (l_tab)
			if value.count = 1 then
				notebook.set_item_text (l_tab, conf_interface_names.dial_cond_and_term_1)
			else
				notebook.set_item_text (l_tab, conf_interface_names.dial_cond_and_term_x (value.count))
			end
			notebook.select_item (l_tab)
			remove_button.enable_sensitive
			unlock_update
		end

	is_in_default_state: BOOLEAN = True
			-- Contract.

invariant
	elements: is_initialized implies remove_button /= Void

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
end
