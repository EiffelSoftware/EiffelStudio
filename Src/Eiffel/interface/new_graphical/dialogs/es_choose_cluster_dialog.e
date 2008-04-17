indexing
	description: "Dialog to choose a cluster in current system"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CHOOSE_CLUSTER_DIALOG

inherit
	EB_CHOOSE_CLASS_DIALOG
		rename
			selected_class_name as selected_cluster_name,
			class_name_entry as cluster_name_entry
		redefine
			prepare,
			on_ok,
			title,
			icon
		end

create
	make

feature -- Query

	selected_cluster_and_path: STRING
			-- Selected cluster name and path
			-- This value set by `On_ok'

	cluster_id, cluster_sub_path: STRING
			-- Cluster Id and its sub path.
			-- Maybe void if end user not pressed any cluster tree node.

feature {NONE} -- Redefine

	icon: EV_PIXEL_BUFFER is
			-- <Precursor>
		do
			Result := stock_pixmaps.folder_cluster_icon_buffer
		end

	prepare (a_context_menu_factory: EB_CONTEXT_MENU_FACTORY; a_container: EV_VERTICAL_BOX) is
			-- <Precursor>
		local
			controls_box: EV_VERTICAL_BOX
			l_layouts: EV_LAYOUT_CONSTANTS
		do
			create l_layouts

			set_button_action_before_close ({ES_DIALOG_BUTTONS}.ok_button, agent on_ok)
			set_button_action ({ES_DIALOG_BUTTONS}.cancel_button, agent on_cancel)

				-- Create the controls.
			create cluster_name_entry.make
			cluster_name_entry.disable_sensitive
			cluster_name_entry.change_actions.extend (agent on_cluster_name_changed)
			create classes_tree.make_with_options (a_context_menu_factory, False, False)
			classes_tree.set_minimum_width (l_layouts.dialog_unit_to_pixels(300))
			classes_tree.set_minimum_height (l_layouts.dialog_unit_to_pixels(200))

			classes_tree.associate_textable_with_classes (cluster_name_entry)
			classes_tree.add_double_click_action_to_classes (agent on_class_double_click)

			classes_tree.refresh

				-- Create the left panel: a Combo Box to type the name of the class
				-- and a tree to select the class.
			create controls_box
			controls_box.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			controls_box.set_border_width ({ES_UI_CONSTANTS}.dialog_border)
			controls_box.extend (cluster_name_entry)
			controls_box.disable_item_expand (cluster_name_entry)

			controls_box.extend (classes_tree)

				-- Pack the buttons_box and the controls.
			a_container.extend (controls_box)
		end

	on_ok is
			-- Terminate the dialog.
		local
			l_entry_text: STRING

			l_valid_cluster_and_path: BOOLEAN

			l_helper: ES_CLUSTER_NAME_AND_PATH_HELPER
			l_cluster_name_and_path: TUPLE [a_cluster_id, a_cluster_sub_path: STRING]
		do
			create l_helper

			l_entry_text := cluster_name_entry.text
			l_valid_cluster_and_path := l_helper.is_cluster_full_path_valid (l_entry_text)
			if not l_valid_cluster_and_path then -- No cluster has such a name.
				cluster_name_entry.set_text (Interface_names.l_unknown_cluster_name)
				cluster_name_entry.select_all

				veto_close
			else
				selected_cluster_and_path := l_entry_text

				l_cluster_name_and_path ?= cluster_name_entry.data
				if l_cluster_name_and_path /= Void then
					cluster_id := l_cluster_name_and_path.a_cluster_id
					cluster_sub_path := l_cluster_name_and_path.a_cluster_sub_path
				end
			end
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := Interface_names.t_choose_cluster
		end

	on_cluster_name_changed
			-- Handle cluster name entry (combo box) text change actions.
		local
			l_text: STRING
			l_valid: BOOLEAN
			l_stock_colors: EV_STOCK_COLORS
			l_helper: ES_CLUSTER_NAME_AND_PATH_HELPER
		do
			create l_helper

			l_text := cluster_name_entry.text
			if l_text /= Void and then not l_text.is_empty then
				-- Check if cluster name and path valid
				l_valid := l_helper.is_cluster_full_path_valid (l_text)
			end

			create l_stock_colors
			if l_valid then
				cluster_name_entry.set_foreground_color (l_stock_colors.default_foreground_color)
			else
				cluster_name_entry.set_foreground_color (l_stock_colors.red)
			end
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
