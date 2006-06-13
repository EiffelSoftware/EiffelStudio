indexing
	description: "Dialog to change conditioning statements."
	date: "$Date$"
	revision: "$Revision$"

class
	CONDITION_DIALOG

inherit
	PROPERTY_DIALOG [CONF_CONDITION_LIST]
		redefine
			is_in_default_state,
			initialize,
			on_ok
		end

	CONF_INTERFACE_NAMES
		undefine
			default_create, copy
		end

	CONF_ACCESS
		undefine
			default_create, copy
		end

	EB_LAYOUT_CONSTANTS
		undefine
			default_create,
			copy
		redefine
			default_button_width
		end

feature {NONE} -- Initialization

	initialize is
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
			hb.set_padding (default_padding_size)

			hb.extend (create {EV_CELL})
			create l_btn.make_with_text_and_action (dial_cond_add_and_term, agent on_add)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			l_btn.set_minimum_width (default_button_width)
			create remove_button.make_with_text_and_action (dial_cond_remove_and_term, agent on_remove)
			hb.extend (remove_button)
			hb.disable_item_expand (remove_button)
			remove_button.set_minimum_width (default_button_width)
			ok_button.set_minimum_width (default_button_width)
			cancel_button.set_minimum_width (default_button_width)

			set_size (400, 530)
			show_actions.extend (agent on_show)
		end

feature {NONE} -- Gui elements

	default_button_width: INTEGER is 100

	notebook: EV_NOTEBOOK
			-- Tabs for each and term.

	remove_button: EV_BUTTON
			-- Button to remove an item.

feature {NONE} -- Agents

	on_show is
			-- Fill in value.
		local
			l_tab: CONDITION_TAB
			l_new_value: like value
			l_cond: CONF_CONDITION
		do
			notebook.wipe_out
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
						notebook.set_item_text (l_tab, dial_cond_and_term_1)
					else
						notebook.set_item_text (l_tab, dial_cond_and_term_x (value.index))
					end
					value.forth
				end
				value := l_new_value
				notebook.selection_actions.extend (agent on_show_tab)
				remove_button.enable_sensitive
			else
				remove_button.disable_sensitive
			end
		end

	on_show_tab is
			-- Show a tab.
		do
			if notebook.selected_item /= Void then
				notebook.selected_item.show
			end
		end

	on_remove is
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

	on_add is
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
				notebook.set_item_text (l_tab, dial_cond_and_term_1)
			else
				notebook.set_item_text (l_tab, dial_cond_and_term_x (value.count))
			end
			notebook.select_item (l_tab)
			remove_button.enable_sensitive
			unlock_update
		end

	on_ok is
			-- Ok was pressed.
		local
			wd: EV_WARNING_DIALOG
		do
			if wd = Void then
				Precursor {PROPERTY_DIALOG}
			else
				wd.show_modal_to_window (Current)
			end
		end

	is_in_default_state: BOOLEAN is True
			-- Contract.

invariant
	elements: is_initialized implies remove_button /= Void

end
