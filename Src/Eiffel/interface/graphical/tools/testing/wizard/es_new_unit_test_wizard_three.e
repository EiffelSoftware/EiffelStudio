indexing
	description: "[
						Third page of new unit test wizard

																			]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NEW_UNIT_TEST_WIZARD_THREE

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			make,
			wizard_information
		end

create
	make

feature {NONE} -- Initialization

	make (an_info: like wizard_information) is
			-- <Precursor>
		do
			wizard_information := an_info
		end

feature {NONE} -- Redefine

	wizard_information: ES_NEW_UNIT_TEST_WIZARD_INFORMATION
			-- <Precursor>

	display_state_text is
			-- <Precursor>
		do
			title.set_text (interface_names.t_select_cluster)
			subtitle.set_text (interface_names.l_please_select)
		end

	proceed_with_current_info is
			-- <Precursor>
		do
			if wizard_information.is_cluster_valid then
				proceed_with_new_state (create {ES_NEW_UNIT_TEST_WIZARD_TWO}.make (wizard_information))
			end
		end

	build
			-- <Precursor>
		local
			l_top_container: EV_BOX
			l_window_manager: EB_SHARED_WINDOW_MANAGER
			l_horizontal_box: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			l_top_container := wizard_information.helper.parent_parent_of (choice_box)

			create l_horizontal_box
			l_horizontal_box.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			l_horizontal_box.set_padding ({ES_UI_CONSTANTS}.label_horizontal_padding)
			l_top_container.extend (l_horizontal_box)
			l_top_container.disable_item_expand (l_horizontal_box)

			create l_label.make_with_text (interface_names.l_cluster_colon)
			l_horizontal_box.extend (l_label)
			l_horizontal_box.disable_item_expand (l_label)

			create label.make_with_text (interface_names.l_unselected)
			l_horizontal_box.extend (label)
			l_horizontal_box.disable_item_expand (label)
			l_horizontal_box.extend (create {EV_CELL})

			create l_window_manager
			if {l_a_win: EB_DEVELOPMENT_WINDOW} l_window_manager.window_manager.last_focused_development_window then
				ui_builder.prepare (l_a_win.menus.context_menu_factory, l_top_container)
				ui_builder.cluster_name_entry.change_actions.extend (agent on_cluster_changed)
				ui_builder.cluster_name_entry.hide
			else
				check not_possible: False end
			end

			update_ui_with_wizard_information
		end

feature {NONE} -- Wizard UI Implementation

	on_cluster_changed is
			--  Just after end user choosed one cluster, we record it
		local
			l_cluster_name_and_path: TUPLE [a_cluster_id: STRING_8; a_cluster_sub_path: STRING_8]
			l_cluster_id: STRING
			l_cluster_path: STRING
			l_cluster_id_solution: EB_SHARED_ID_SOLUTION
			l_conf_group: CONF_GROUP
		do
			-- Synchronize `label''s text with hidden combo box
			label.set_text (ui_builder.cluster_name_entry.text)

			l_cluster_name_and_path ?= ui_builder.cluster_name_entry.data
			if l_cluster_name_and_path /= Void then
				l_cluster_id := l_cluster_name_and_path.a_cluster_id
				l_cluster_path := l_cluster_name_and_path.a_cluster_sub_path
				create l_cluster_id_solution
				l_conf_group := l_cluster_id_solution.group_of_id (l_cluster_id)
				if l_conf_group /= Void and then not l_conf_group.is_readonly then
					wizard_information.set_cluster_id_and_path (l_cluster_id, l_cluster_path)
				else
					wizard_information.set_cluster_id_and_path ("", "")
				end
			end
			update_next_button_state
		end

	update_next_button_state is
			-- Update next button state base on current information
		do
			if wizard_information.is_cluster_valid then
				first_window.enable_next_button
			else
				first_window.disable_next_button
			end
		end

	update_ui_with_wizard_information is
			-- Update ui with wizard information
		local
			l_path: STRING
		do
			if wizard_information.cluster /= Void then
				-- Expand tree node which selected
				l_path := wizard_information.cluster_path
				if l_path = Void then
					create l_path.make_empty
				end
				ui_builder.classes_tree.show_subfolder (wizard_information.cluster, l_path)
			else
				first_window.disable_next_button
			end
		end

	ui_builder: !ES_CHOOSE_CLUSTER_UI_BUILDER is
			-- UI builder
		once
			create Result
		end

	uodate_ui_with_wizard_information is
			-- Update ui state with wizard information if possible
		local
			l_full_cluster: STRING
			l_cluster_path: STRING
			l_helper: ES_CLUSTER_NAME_AND_PATH_HELPER
		do
			if wizard_information.cluster /= Void then
				l_full_cluster := wizard_information.cluster.cluster_name.twin
				l_cluster_path := wizard_information.cluster_path
				if l_cluster_path /= Void and then not l_cluster_path.is_empty then
					create l_helper
					l_full_cluster.append (l_helper.cluster_separator)
					l_full_cluster.append (l_cluster_path)
				end
				ui_builder.cluster_name_entry.set_text (l_full_cluster)
			end
		end

	label: EV_LABEL
			-- Label to show current selected cluster

;indexing
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
