note
	description: "[
		Let you compare two groups (i.e. libraries/clusters) and show you the differences in terms
		of added/removed/modified classes and for modified classes in terms of added/removed/modified
		features.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMPARE_LIBRARY_CLASSES_TOOL

inherit
	ANY

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_development_window: like development_window)
			-- Initialize Current using `a_development_window'.
		require
			a_development_window_attached: a_development_window /= Void
		do
			development_window := a_development_window
			build_preferences
			build_interface
		ensure
			development_window_set: development_window = a_development_window
		end

	build_preferences
			-- Build preferences
		local
			l_manager: PREFERENCE_MANAGER
			l_pref_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_pref_factory
			l_manager := preferences.preferences.new_manager ("COMPARATOR")

			library_1_pref := l_pref_factory.new_string_preference_value (l_manager, "COMPARATOR.library_1", "")
			library_1_pref.set_hidden (True)

			library_2_pref := l_pref_factory.new_string_preference_value (l_manager, "COMPARATOR.library_2", "")
			library_2_pref.set_hidden (True)
		end

	build_interface
			-- Build UI.
		local
			l_ev_cell_1, l_ev_cell_2: EV_CELL
			l_ev_button_3: EV_BUTTON
			l_ev_horizontal_box_1, l_ev_horizontal_box_4: EV_HORIZONTAL_BOX
			l_ev_vertical_box_1, l_vbox: EV_VERTICAL_BOX
			l_box: EV_HORIZONTAL_BOX
			l_ev_frame_1, l_ev_frame_2: EV_FRAME
		do
			create window.make_with_title ("Library comparator")

				-- Create all widgets.
			create l_vbox
			create l_ev_horizontal_box_1
			create l_ev_vertical_box_1
			create l_ev_frame_1
			create l_ev_frame_2
			create l_ev_horizontal_box_4
			create split
			create l_ev_cell_1
			create l_ev_button_3
			create l_ev_cell_2
			create result_box
			create result_text
			create l_vbox
			create status_box

			create show_compiled_classes_check.make_with_text ("List compiled classes only")
			show_compiled_classes_check.enable_select

			l_ev_frame_1.set_text ("First library")
			l_ev_frame_2.set_text ("Second library")
			create library_1.make_without_targets (development_window.menus.context_menu_factory)
			library_1.set_minimum_size (Cluster_list_minimum_width, Cluster_list_minimum_height)
			library_1.refresh

			create library_2.make_without_targets (development_window.menus.context_menu_factory)
			library_2.set_minimum_size (Cluster_list_minimum_width, Cluster_list_minimum_height)
			library_2.refresh

			status_box.align_text_left
			status_box.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 0, 0))

				-- Build widget structure.
			window.extend (l_vbox)
			l_vbox.extend (split)
			l_vbox.extend (status_box)
			status_box.hide
			split.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.set_border_width (5)
			l_ev_horizontal_box_1.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_frame_1)
			l_ev_vertical_box_1.extend (l_ev_frame_2)
			create l_box
			l_box.set_border_width (5)
			l_box.extend (library_1)
			l_ev_frame_1.extend (l_box)
			create l_box
			l_box.set_border_width (5)
			l_box.extend (library_2)
			l_ev_frame_2.extend (l_box)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (l_ev_cell_1)
			l_ev_horizontal_box_4.extend (l_ev_button_3)
			l_ev_horizontal_box_4.extend (l_ev_cell_2)
			result_box.extend (result_text)
			result_box.set_minimum_width (500)

			l_ev_vertical_box_1.extend (show_compiled_classes_check)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.set_padding (10)
			l_ev_horizontal_box_4.set_border_width (4)
			l_ev_horizontal_box_4.disable_item_expand (l_ev_button_3)
			l_ev_button_3.set_text ("Compare")
			l_ev_button_3.select_actions.extend (agent compare_libraries)

			if library_1_pref.value /= Void then
				library_1.select_item_from_path (library_1_pref.value)
			end
			if library_2_pref.value /= Void then
				library_2.select_item_from_path (library_2_pref.value)
			end

				-- Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.
			window.close_request_actions.extend (agent window.hide)
			library_1.select_actions.extend (agent
				do
					if attached {EB_CLASSES_TREE_FOLDER_ITEM} library_1.selected_item as l_folder then
						library_1_pref.set_value (library_1.path_name_from_tree_node (l_folder))
					end
				end)
			library_2.select_actions.extend (agent
				do
					if attached {EB_CLASSES_TREE_FOLDER_ITEM} library_2.selected_item as l_folder then
						library_2_pref.set_value (library_1.path_name_from_tree_node (l_folder))
					end
				end)
		end

feature -- Access

	result_text: EV_TEXT
	result_box: EV_VERTICAL_BOX
	library_1, library_2: EB_CLASSES_TREE
	status_box: EV_LABEL
	show_compiled_classes_check: EV_CHECK_BUTTON
	split: EV_HORIZONTAL_SPLIT_AREA

feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Associated development window

feature -- Setting

	set_development_window (a_development_window: like development_window)
		require
			a_development_window_attached: a_development_window /= Void
		do
			development_window := a_development_window
		ensure
			development_window_set: development_window = a_development_window
		end

feature {NONE} -- Access

	window: EV_TITLED_WINDOW
			-- Associated window

	library_1_pref, library_2_pref: STRING_PREFERENCE
			-- Last processed libraries?

feature -- Display

	show
		do
			window.show
		end

feature {NONE} -- Actions

	compare_libraries
			-- Given two selected groups compare them.
		local
			l_cluster1, l_cluster2: CONF_GROUP
			l_classes1, l_classes2, l_new_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_name: STRING
		do
			if library_1.selected_item /= Void and then library_2.selected_item /= Void then
				if not split.full then
					split.extend (result_box)
				end
				l_cluster1 := cluster_from (library_1.selected_item)
				l_cluster2 := cluster_from (library_2.selected_item)
				result_text.remove_text
				l_classes1 := l_cluster1.classes
				l_classes2 := l_cluster2.classes
				if attached {CONF_LIBRARY} l_cluster1 as l_library and then l_library.name_prefix /= Void then
					create l_new_classes.make (l_classes1.count)
					from
						l_classes1.start
					until
						l_classes1.after
					loop
						l_name := l_classes1.key_for_iteration
						l_new_classes.put (l_classes1.item_for_iteration, l_name.substring (l_library.name_prefix.count, l_name.count))
						l_classes1.forth
					end
					l_classes1 := l_new_classes
				end
				if attached {CONF_LIBRARY} l_cluster2 as l_library and then l_library.name_prefix /= Void then
					create l_new_classes.make (l_classes2.count)
					from
						l_classes2.start
					until
						l_classes2.after
					loop
						l_name := l_classes2.key_for_iteration
						l_new_classes.put (l_classes2.item_for_iteration, l_name.substring (l_library.name_prefix.count + 1, l_name.count))
						l_classes2.forth
					end
					l_classes2 := l_new_classes
				end
				show_cluster_only_classes (l_cluster1, l_classes1, l_classes2)
				show_cluster_only_classes (l_cluster2, l_classes2, l_classes1)
				show_different_classes (l_classes1, l_classes2)
			else
				status_box.set_text ("No valid libraries have been selected")
				status_box.show
			end
		end

	show_cluster_only_classes (a_cluster1: CONF_GROUP; a_classes1, a_classes2: HASH_TABLE [CONF_CLASS, STRING])
			-- Show classes that are only in `a_classes1'.
		require
			a_cluster1_attached: a_cluster1 /= Void
			a_classes1_attached: a_classes1 /= Void
			a_classes2_attached: a_classes2 /= Void
		do
			from
				a_classes1.start
			until
				a_classes1.after
			loop
				if not a_classes2.has (a_classes1.key_for_iteration) then
					result_text.append_text ("Only in `")
					result_text.append_text (a_cluster1.name)
					result_text.append_text ("': ")
					result_text.append_text (a_classes1.key_for_iteration)
					result_text.append_text ("%N")
				end
				a_classes1.forth
			end
		end

	show_different_classes (a_classes1, a_classes2: HASH_TABLE [CONF_CLASS, STRING])
			-- Show classes that are both in `a_classes1' and `a_classes2' and different.
		require
			a_classes1_attached: a_classes1 /= Void
			a_classes2_attached: a_classes2 /= Void
		do
			from
				a_classes1.start
			until
				a_classes1.after
			loop
				if a_classes2.has (a_classes1.key_for_iteration) then
					if
						attached {CLASS_I} a_classes2.item (a_classes1.key_for_iteration) as l_class2 and then
						attached {CLASS_I} a_classes1.item_for_iteration as l_class1
					then
						if
							(l_class1.is_compiled and l_class2.is_compiled) and then
							(l_class1.compiled_class.has_feature_table and l_class2.compiled_class.has_feature_table)
						then
							show_class_only_features (l_class1.compiled_class, l_class2.compiled_class)
							show_class_only_features (l_class1.compiled_class, l_class2.compiled_class)
							show_different_features (l_class1.compiled_class, l_class2.compiled_class)
						elseif not show_compiled_classes_check.is_selected then
							if not l_class1.is_compiled and not l_class2.is_compiled then
								result_text.append_text ("Class ")
								result_text.append_text (a_classes1.key_for_iteration)
								result_text.append_text (" is not comparable because both not compiled.")
								result_text.append_text ("%N")
							else
								result_text.append_text ("Class ")
								result_text.append_text (a_classes1.key_for_iteration)
								result_text.append_text (" is not comparable because one is not compiled.")
								result_text.append_text ("%N")
							end
						end
					else
						result_text.append_text ("Class ")
						result_text.append_text (a_classes1.key_for_iteration)
						result_text.append_text (" is not comparable.")
						result_text.append_text ("%N")
					end
				end
				a_classes1.forth
			end
		end

	show_class_only_features (a_class1, a_class2: CLASS_C)
			-- Show features only in `a_class1'.
		require
			a_class1_attached: a_class1 /= Void
			a_class2_attached: a_class2 /= Void
			a_class1_has_features: a_class1.has_feature_table
			a_class2_has_features: a_class2.has_feature_table
		local
			l_features1: COMPUTED_FEATURE_TABLE
		do
			from
				l_features1 := a_class1.feature_table.features
				l_features1.start
			until
				l_features1.after
			loop
				if a_class2.feature_named (l_features1.item.feature_name) = Void then
					result_text.append_text ("Only in `")
					result_text.append_text (a_class1.name)
					result_text.append_text ("': ")
					result_text.append_text (l_features1.item.feature_name)
					result_text.append_text ("%N")
				end
				l_features1.forth
			end
		end

	show_different_features (a_class1, a_class2: CLASS_C)
			-- Show features that are both in `a_class1' and `a_class2' and different.
		require
			a_class1_attached: a_class1 /= Void
			a_class2_attached: a_class2 /= Void
			a_class1_has_features: a_class1.has_feature_table
			a_class2_has_features: a_class2.has_feature_table
		local
			l_features1: COMPUTED_FEATURE_TABLE
		do
			from
				l_features1 := a_class1.feature_table.features
				l_features1.start
			until
				l_features1.after
			loop
				if
					attached a_class2.feature_named (l_features1.item.feature_name) as l_feat2 and then
					not l_features1.item.same_signature (l_feat2)
				then
					result_text.append_text ("Different feature in class `")
					result_text.append_text (a_class1.name)
					result_text.append_text ("': ")
					result_text.append_text (l_features1.item.feature_name)
					result_text.append_text ("%N")
				end
				l_features1.forth
			end
		end

	cluster_from (a_node: EV_TREE_NODE_LIST): detachable CONF_GROUP
			-- From a tree node, gets the parent cluster.
		require
			a_node_attached: a_node /= Void
		local
			l_folder: detachable EB_CLASSES_TREE_FOLDER_ITEM
			clu: detachable EB_SORTED_CLUSTER
		do
			l_folder ?= a_node
			if l_folder /= Void then
				clu := l_folder.data
				Result := clu.actual_group
			elseif attached {EV_TREE_NODE_LIST} a_node.parent as l_node_parent then
				Result := cluster_from (l_node_parent)
			end
		end

feature {NONE} -- Implementation

	Cluster_list_minimum_width: INTEGER
			-- Minimum width for the cluster list.
		do
			Result := Layout_constants.Dialog_unit_to_pixels (250)
		end

	Cluster_list_minimum_height: INTEGER
			-- Minimum height for the cluster list.
		do
			Result := Layout_constants.Dialog_unit_to_pixels (100)
		end

invariant
	development_window_attached: development_window /= Void
	window_attached: window /= Void
	library_1_pref_attached: library_1_pref /= Void
	library_2_pref_attached: library_2_pref /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
