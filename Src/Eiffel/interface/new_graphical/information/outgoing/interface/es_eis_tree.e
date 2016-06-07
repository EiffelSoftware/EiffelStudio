note
	description: "Information tree. Class tree + tag tree + affected tree"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_TREE

inherit
	EB_CLASSES_TREE
		redefine
			build_tree,
			on_post_folder_loaded,
			internal_recycle,
			refresh
		end

	CONF_ACCESS
		undefine
			default_create,
			copy,
			is_equal
		end

	ES_EIS_STORAGE_OBSERVER
		undefine
			default_create,
			copy,
			is_equal
		end

	ES_EIS_SHARED
		undefine
			default_create,
			copy,
			is_equal
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		undefine
			default_create,
			copy,
			is_equal
		end

create
	make_eis_tree

feature {NONE} -- Initialization

	make_eis_tree (a_context_menu_factory: EB_CONTEXT_MENU_FACTORY; a_widget: ES_EIS_TOOL_WIDGET)
			-- Initialization
		require
			a_context_menu_factory_not_void: a_context_menu_factory /= Void
			a_widget_not_void: a_widget /= Void
		do
			eis_tool_widget := a_widget
			create managed_tags.make
			managed_tags.compare_objects

			make_without_targets (a_context_menu_factory)
			add_single_click_action_to_classes (agent on_button_press_action)
			add_single_click_action_to_cluster (agent on_button_press_action)
			key_release_actions.extend (agent on_key_released)

				-- Register to EIS observer management.
			storage.add_observer (Current)
		end

	build_tree
			-- Remove and replace contents of `Current'.
		local
			l_sys: CONF_SYSTEM
			l_target_order: ARRAYED_LIST [CONF_TARGET]
			l_env: EV_ENVIRONMENT
			l_locked: BOOLEAN
		do
			create l_env
			if window /= Void and l_env.application.locked_window = Void then
					-- Lock update of window, so rebuilding of `Current'
					-- is hidden.			
				window.lock_update
				l_locked := True
			end

				-- Do not keep the old view when the tree has been rebuild,
				-- as the old view is most likely invalid.
				-- This should be done before `item_selected',
				-- otherwise `old_view' is set as current view.
			if attached old_view as l_view then
				l_view.wipe_out
				l_view.destroy
				old_view := Void
			end

				-- Store expanded state of `Current'
			store_expanded_state

			wipe_out
			if eiffel_project.initialized and then universe.target /= Void then
				l_sys := universe.target.system
				l_target_order := l_sys.target_order
				l_target_order.do_if (
					agent add_target (Current, ?),
					agent (aa_target: CONF_TARGET): BOOLEAN
						do
							Result := aa_target.extends = Void
						end)
			end

			create tag_header.make (interface_names.l_all_tags, pixmaps.icon_pixmaps.information_tags_icon)
			tag_header.pointer_button_press_actions.extend (agent on_button_press_action)
			extend (tag_header)

			build_affected_items

			build_tags

				-- Restore original expanded state, stored during last call to
				-- `store_expanded_state'
			restore_expanded_state
				-- Show content of selected item
			item_selected

			if window /= Void and l_locked then
					-- Unlock update of window as `Current' has
					-- been rebuilt.
				window.unlock_update
			end

			render_information_signs
			is_built := True
		end

	add_target (a_list: EV_DYNAMIC_LIST [EV_CONTAINABLE]; a_target: CONF_TARGET)
			-- Add targets to the tree, recursively.
		require
			a_list_not_void: a_list /= Void
			a_target_not_void: a_target /= Void
		local
			l_target_node: EB_CLASSES_TREE_TARGET_ITEM
		do
			create l_target_node.make (a_target)
			l_target_node.set_data (a_target)
			l_target_node.pointer_button_press_actions.extend (agent on_button_press_action)
			a_list.extend (l_target_node)
			if a_target = universe.target then
				build_tree_on_list (l_target_node)
			end
			a_target.child_targets.do_all (agent add_target (l_target_node, ?))
		end

	build_tags
			-- Build the Items without tag item.
		local
			l_item: ES_EIS_TREE_TAG_ITEM
			l_managed_tags: like managed_tags
			l_tags: HASH_TABLE [SEARCH_TABLE [EIS_ENTRY], STRING_32]
		do
			create l_item.make (interface_names.l_items_without_tag)
			l_item.set_pixmap (pixmaps.icon_pixmaps.information_no_tag_icon)
			l_item.pointer_button_press_actions.extend (agent on_button_press_action)
			tag_header.extend (l_item)

			create managed_tags.make
			managed_tags.compare_objects
			l_managed_tags := managed_tags
			l_tags := storage.tag_server.entries.twin
			from
				l_tags.start
			until
				l_tags.after
			loop
				if not l_tags.key_for_iteration.is_empty then
					l_managed_tags.extend (l_tags.key_for_iteration)
				end
				l_tags.forth
			end
			if not l_managed_tags.is_empty then
				from
					l_managed_tags.start
				until
					l_managed_tags.after
				loop
					create l_item.make (l_managed_tags.item_for_iteration)
					l_item.pointer_button_press_actions.extend (agent on_button_press_action)
					tag_header.extend (l_item)
					l_managed_tags.forth
				end
			end
			if tag_header.is_expandable then
				tag_header.expand
			end
		end

	build_affected_items
			-- Build affected items
		do
			create affected_target_header.make (interface_names.l_affected_target, pixmaps.icon_pixmaps.information_affected_target_icon)
			affected_target_header.pointer_button_press_actions.extend (agent on_button_press_action)
			extend (affected_target_header)

			create affected_resource_header.make (interface_names.l_affected_source, pixmaps.icon_pixmaps.information_affected_resource_icon)
			affected_resource_header.pointer_button_press_actions.extend (agent on_button_press_action)
			extend (affected_resource_header)
		end

feature -- Operation

	rebuild_list_if_possible
			-- Synchronize
		do
			render_information_signs
			if old_view /= Void then
				old_view.rebuild_and_refresh_grid
			end
		end

	item_selected
			-- Show content of selected item
		do
			on_component_click (selected_item)
		end

	render_information_sign_for_selected_node
			-- Draw or remove small sign on the icon of selected item
			-- to show if there is information connected to the node.
		do
			render_information_sign_for_node (selected_item)
		end

	render_information_signs
			-- Draw or remove small signs on the icons of the tree
			-- to show if there is information connected to the node.
		do
			recursive_render_information_signs (Current)
		end

	refresh
			-- <Precursor>
		local
			l_agent: like build_tree_agent
		do
			l_agent := build_tree_agent
			if l_agent = Void then
				l_agent := agent build_tree
				build_tree_agent := l_agent
			end
			eis_tool_widget.panel.execute_until_shown (l_agent)
		end

	build
			-- Build
		do
			build_tree
		end

feature -- Query

	is_built: BOOLEAN
			-- Is current tree built?

feature -- Access

	current_view: detachable ES_EIS_COMPONENT_VIEW [ANY]
			-- Current view of list
		do
			Result := old_view
		end

feature {NONE} -- Actions

	on_button_press_action (x_rel: INTEGER;
							y_rel: INTEGER;
							button: INTEGER;
							x_tilt: DOUBLE;
							y_tilt: DOUBLE;
							pression: DOUBLE;
							x_abs: INTEGER;
							y_abs: INTEGER)
		do
			on_component_click (last_pressed_item)
			eis_tool_widget.reset_stone
		end

	on_key_released (a_key: EV_KEY)
			-- On key released
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				on_component_click (selected_item)
				eis_tool_widget.reset_stone
			end
		end

	on_component_click (a_item: detachable EV_TREE_NODE)
			-- On target/cluster/class item clicked
		local
			l_view: ES_EIS_COMPONENT_VIEW [ANY]
		do
			l_view := view_from_item (a_item)
			if l_view /= Void then
					-- If old view is void
				if old_view = Void or else not l_view.same_view (old_view) then
					l_view.display
					eis_tool_widget.refresh_buttons (l_view)
					if old_view /= Void then
							-- Call destroy to recycle callbacks from the EIS grid.
						old_view.destroy
					end
					old_view := l_view
				end
				eis_tool_widget.display_list
			else
				if old_view /= Void then
					old_view.wipe_out
					old_view.destroy
					old_view := Void
				end
				eis_tool_widget.display_nothing
			end
			render_information_sign_for_node (a_item)
		end

feature {NONE} -- Component view factory

	view_from_item (a_item: detachable EV_TREE_NODE): detachable ES_EIS_COMPONENT_VIEW [ANY]
			-- Get view from
		local
			l_item: detachable EV_TREE_NODE
			l_sorted_cluster: detachable EB_SORTED_CLUSTER
		do
			l_item := a_item
			if l_item /= Void then
				if attached eis_tool_widget.entry_list as lt_grid and then lt_grid.is_usable then
					if attached {ES_EIS_TREE_TAG_ITEM} l_item as lt_item and then attached lt_item.text as lt_string then
						if tag_header.first = lt_item then
								-- Empty string indicates to view entries without tag.
							create {ES_EIS_TAG_VIEW}Result.make (create {STRING_32}.make_empty, lt_grid)
						else
							create {ES_EIS_TAG_VIEW}Result.make (lt_string, lt_grid)
						end
					elseif l_item = affected_target_header then
						create {ES_EIS_AFFECTED_VIEW} Result.make (True, lt_grid)
					elseif l_item = affected_resource_header then
						create {ES_EIS_AFFECTED_VIEW} Result.make (False, lt_grid)
					elseif attached {CLASS_I} l_item.data as lt_class then
						create {ES_EIS_CLASS_VIEW}Result.make (lt_class, lt_grid)
					elseif attached {CONF_TARGET} l_item.data as lt_target then
						create {ES_EIS_CONF_VIEW}Result.make (lt_target, lt_grid)
					else
						l_sorted_cluster ?= l_item.data
						if l_sorted_cluster /= Void then
							if attached {CONF_CLUSTER} l_sorted_cluster.actual_group as lt_cluster then
								create {ES_EIS_CONF_VIEW}Result.make (lt_cluster, lt_grid)
							elseif attached {CONF_LIBRARY} l_sorted_cluster.actual_group as lt_library and then attached lt_library.library_target as lt_target1 then
								create {ES_EIS_CONF_VIEW}Result.make (lt_target1, lt_grid)
							end
						end
					end
					if attached Result as l_result then
						l_result.set_eis_widget (eis_tool_widget)
					end
				end
			end
		end

feature {NONE} -- EIS observer

	on_tag_added (a_tag: STRING_32)
			-- <precursor>
		do
			eis_tool_widget.panel.execute_until_shown (
				agent (t: STRING_32)
				local
					l_node: ES_EIS_TREE_TAG_ITEM
				do
					if not managed_tags.has (t) then
						managed_tags.extend (t)

						create l_node.make (t)
						l_node.pointer_button_press_actions.extend (agent on_button_press_action)
							-- Here we plus one to shift the mapping between `managed_tags'
							-- and items under `tag_header'.
							-- This is because the first item is ocuppied by "Item without tag".
						tag_header.go_i_th (managed_tags.index + 1)
						tag_header.put_left (l_node)
					end
				end (a_tag)
			)
		end

	on_tag_removed (a_tag: STRING_32)
			-- <precursor>
		do
			eis_tool_widget.panel.execute_until_shown (
				agent (t: STRING_32)
				do
					managed_tags.start
					managed_tags.search (t)
					if not managed_tags.exhausted then
						managed_tags.remove
							-- Here we plus one to shift the mapping between `managed_tags'
							-- and items under `tag_header'.
							-- This is because the first item is ocuppied by "Item without tag".
						tag_header.go_i_th (managed_tags.index + 1)
						tag_header.remove
					end
				end (a_tag)
			)
		end

	on_entry_registered (a_entry: EIS_ENTRY; a_component_id: STRING)
			-- `a_entry' has been registered.
		do
			--| Leave empty for furture use
		end

	on_entry_deregistered (a_entry: EIS_ENTRY; a_component_id: STRING)
			-- Notify observers that `a_entry' has been deregistered.
		do
			--| Leave empty for furture use
		end

feature {NONE} -- Implemenation

	recursive_render_information_signs (tree_list: EV_TREE_NODE_LIST)
			-- Recursively draw or remove small signs on the icons of the tree.
		require
			tree_list_not_void: tree_list /= Void
		do
			from
				tree_list.start
			until
				tree_list.off
			loop
				render_information_sign_for_node (tree_list.item)
				recursive_render_information_signs (tree_list.item)
				tree_list.forth
			end
		end

	render_information_sign_for_node (a_node: EV_TREE_NODE)
			-- Render information sign for `a_node'.
		do
			if attached {EB_CLASSES_TREE_ITEM} a_node as current_node then
				if tree_node_has_information (current_node) then
					current_node.set_pixmap (eis_decorated_pixmap (current_node.pixmap))
				else
					current_node.set_pixmap (current_node.associated_pixmap)
				end
			end
		end

	tree_node_has_information (a_item: EV_TREE_NODE): BOOLEAN
			-- Does `a_item' contains EIS information?
		require
			a_node_not_void: a_item /= Void
		local
			l_class_extracter: ES_EIS_CLASS_EXTRACTOR
			l_conf_extracter: ES_EIS_CONF_EXTRACTOR
		do
			if attached {CLASS_I} a_item.data as lt_class then
				create l_class_extracter.make (lt_class, True)
				Result := not l_class_extracter.eis_entries.is_empty
			elseif attached {CONF_TARGET} a_item.data as lt_target then
				create l_conf_extracter.make (lt_target, True)
				Result := not l_conf_extracter.eis_entries.is_empty
			else
				if attached {EB_SORTED_CLUSTER} a_item.data as l_sorted_cluster then
					if attached {CONF_CLUSTER} l_sorted_cluster.actual_group as lt_cluster then
						create l_conf_extracter.make (lt_cluster, True)
						Result := not l_conf_extracter.eis_entries.is_empty
					elseif attached {CONF_LIBRARY} l_sorted_cluster.actual_group as lt_library and then attached lt_library.library_target as lt_target1 then
						create l_conf_extracter.make (lt_target1, True)
						Result := not l_conf_extracter.eis_entries.is_empty
					end
				end
			end
		end

	on_post_folder_loaded (a_item: EV_TREE_ITEM)
			-- Called when a folder item has been expanded
			-- for the first time.
		do
			Precursor {EB_CLASSES_TREE}(a_item)
			recursive_render_information_signs (a_item)
		end

	internal_recycle
			-- <precursor>
		do
			Precursor {EB_CLASSES_TREE}
			storage.remove_observer (Current)
		end

feature {NONE} -- Access

	old_view: detachable ES_EIS_COMPONENT_VIEW [ANY]
			-- Old view

	tag_header: EB_CLASSES_TREE_HEADER_ITEM
			-- Tag header

	affected_target_header: EB_CLASSES_TREE_HEADER_ITEM;
			-- Affected target header

	affected_resource_header: EB_CLASSES_TREE_HEADER_ITEM
			-- Affected resource header

	eis_tool_widget: ES_EIS_TOOL_WIDGET;
			-- The tool widget

	managed_tags: SORTED_TWO_WAY_LIST [STRING_32];
			-- Sorted tags. Do not change directly out of EIS observer.

	build_tree_agent: detachable PROCEDURE
			-- Agent of `build_tree'

invariant
	eis_tool_widget_not_void: eis_tool_widget /= Void
	managed_tags_not_void: managed_tags /= Void
	only_first_item_is_off_mapping: (tag_header /= Void and not is_recycled) implies managed_tags.count = tag_header.count - 1

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
