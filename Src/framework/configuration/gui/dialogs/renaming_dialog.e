note
	description: "Dialog to configure class renamings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RENAMING_DIALOG

inherit
	PROPERTY_DIALOG [EQUALITY_HASH_TABLE [STRING_32, STRING_32]]
		redefine
			initialize
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create,
			copy
		end

feature {NONE} -- Initialization

	initialize
			-- Initialization
		local
			hb: EV_HORIZONTAL_BOX
			vb_grid: EV_VERTICAL_BOX
			l_btn: EV_BUTTON
		do
			Precursor {PROPERTY_DIALOG}

			create vb_grid
			element_container.extend (vb_grid)
			vb_grid.set_border_width (1)
			vb_grid.set_background_color ((create {EV_STOCK_COLORS}).black)

			create grid
			vb_grid.extend (grid)
			grid.set_column_count_to (2)
			grid.column (1).set_title (conf_interface_names.dialog_renaming_old_name)
			grid.column (2).set_title (conf_interface_names.dialog_renaming_new_name)
			grid.enable_last_column_use_all_width
			grid.enable_single_row_selection

			create hb
			hb.set_padding (layout_constants.default_padding_size)
			element_container.extend (hb)
			element_container.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			create l_btn.make_with_text_and_action (conf_interface_names.general_add, agent on_add)
			l_btn.set_pixmap (conf_pixmaps.general_add_icon)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			layout_constants.set_default_width_for_button (l_btn)
			create l_btn.make_with_text_and_action (conf_interface_names.general_remove, agent on_remove)
			l_btn.set_pixmap (conf_pixmaps.general_remove_icon)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			layout_constants.set_default_width_for_button (l_btn)

			set_size (300, 400)
			show_actions.extend (agent on_show)
		end

feature {NONE} -- Gui elements

	grid: ES_GRID
			-- Grid for the renamings.

feature {NONE} -- Agents

	on_show
			-- Called if the dialog is shown.
		require
			initialized: is_initialized
		do
			refresh
			grid.set_focus
			if grid.row_count > 0 then
				grid.select_row (1)
			end
		end

	on_add
			-- Called if we add a new renaming.
		require
			initialized: is_initialized
		do
			if value = Void then
				create value.make (1)
			end
			if not (value.has (conf_interface_names.dialog_renaming_create_old) or value.has_item (conf_interface_names.dialog_renaming_create_new)) then
				value.force (conf_interface_names.dialog_renaming_create_new, conf_interface_names.dialog_renaming_create_old)
				refresh
				grid.set_focus
			end
		end

	on_remove
			-- Called if we remove a renaminge.
		require
			initialized: is_initialized
		local
			l_item: TEXT_PROPERTY [STRING_GENERAL]
		do
			if grid.single_selected_row /= Void then
				l_item ?= grid.single_selected_row.item (1)
				value.remove (l_item.value)
				if value.is_empty then
					value := Void
				end
				refresh
			end
		end

feature {NONE} -- Implementation

	update_key (an_old_key, a_new_key: STRING_32)
			-- Update `an_old_key' with `a_new_key'.
		require
			an_old_key_ok: value /= Void and then value.has (an_old_key)
		local
			l_string: STRING_32
		do
			l_string := conf_interface_names.string_general_as_upper (a_new_key)
			if a_new_key /= Void and then not a_new_key.is_empty and then not value.has (l_string) then
				value.replace_key (l_string, an_old_key)
			end
			refresh
		end

	update_value (a_key, a_new_value: STRING_32)
			-- Update value of `a_key' to `a_new_value'
		require
			a_key_ok: value /= Void and then value.has (a_key)
		local
			l_string: STRING_32
		do
			l_string := conf_interface_names.string_general_as_upper (a_new_value)
			if a_new_value /= Void and then not a_new_value.is_empty and then not value.has_item (l_string) then
				value.force (l_string, a_key)
			end
			refresh
		end

	refresh
			-- Refresh the displayed values.
		require
			initialized: is_initialized
		local
			l_tp: STRING_PROPERTY
			i: INTEGER
		do
			grid.clear
			if value /= Void then
				from
					value.start
					i := 1
				until
					value.after
				loop
					create l_tp.make ("")
					l_tp.pointer_button_press_actions.wipe_out
					l_tp.pointer_double_press_actions.force_extend (agent l_tp.activate)
					l_tp.set_value (value.key_for_iteration)
					l_tp.change_value_actions.extend (agent update_key (value.key_for_iteration, ?))
					grid.set_item (1, i, l_tp)

					create l_tp.make ("")
					l_tp.pointer_button_press_actions.wipe_out
					l_tp.pointer_double_press_actions.force_extend (agent l_tp.activate)
					l_tp.set_value (value.item_for_iteration)
					l_tp.change_value_actions.extend (agent update_value (value.key_for_iteration, ?))
					grid.set_item (2, i, l_tp)

					i := i + 1
					value.forth
				end
			end
		end

invariant
	elements: is_initialized implies grid /= Void

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
