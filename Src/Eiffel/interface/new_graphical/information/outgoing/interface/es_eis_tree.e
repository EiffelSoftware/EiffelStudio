indexing
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
			internal_recycle
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

create
	make_eis_tree

feature {NONE} -- Initialization

	make_eis_tree (a_context_menu_factory: EB_CONTEXT_MENU_FACTORY; a_widget: !ES_EIS_TOOL_WIDGET) is
			-- Initialization
		require
			a_context_menu_factory_not_void: a_context_menu_factory /= Void
		do
			create managed_tags.make
			managed_tags.compare_objects

			make_without_targets (a_context_menu_factory)
			add_double_click_action_to_classes (agent on_class_double_click)
			add_double_click_action_to_cluster (agent on_cluster_double_click)
			key_release_actions.extend (agent on_key_released)
			eis_tool_widget := a_widget

				-- Register to EIS observer management.
			storage.add_observer (Current)
		end

	build_tree is
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
			if eiffel_project.initialized and then universe.target /= Void then
				wipe_out
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
			extend (tag_header)
			--create affected_header.make (interface_names.l_affected_items, pixmaps.icon_pixmaps.information_affected_items_icon)
			--extend (affected_header)

			build_tags

			-- build_affected_items

			if window /= Void and l_locked then
					-- Unlock update of window as `Current' has
					-- been rebuilt.
				window.unlock_update
			end
		end

	add_target (a_list: EV_DYNAMIC_LIST [EV_CONTAINABLE]; a_target: CONF_TARGET) is
			-- Add targets to the tree, recursively.
		require
			a_list_not_void: a_list /= Void
			a_target_not_void: a_target /= Void
		local
			l_target_node: EB_CLASSES_TREE_TARGET_ITEM
		do
			create l_target_node.make (a_target)
			l_target_node.set_data (a_target)
			l_target_node.pointer_double_press_actions.extend (agent on_target_double_click)
			a_list.extend (l_target_node)
			if a_target = universe.target then
				build_tree_on_list (l_target_node)
			end
			a_target.child_targets.do_all (agent add_target (l_target_node, ?))
		end

	build_tags is
			-- Build the Items without tag item.
		local
			l_item: ES_EIS_TREE_TAG_ITEM
			l_managed_tags: like managed_tags
			l_tags: HASH_TABLE [!SEARCH_TABLE [!EIS_ENTRY], !STRING_32]
		do
			create l_item.make (interface_names.l_items_without_tag)
			l_item.set_pixmap (pixmaps.icon_pixmaps.information_no_tag_icon)
			l_item.pointer_double_press_actions.extend (agent on_tag_double_clicked)
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
				l_managed_tags.extend (l_tags.key_for_iteration)
				l_tags.forth
			end
			if not l_managed_tags.is_empty then
				from
					l_managed_tags.start
				until
					l_managed_tags.after
				loop
					create l_item.make (l_managed_tags.item_for_iteration)
					l_item.pointer_double_press_actions.extend (agent on_tag_double_clicked)
					tag_header.extend (l_item)
					l_managed_tags.forth
				end
			end
			if tag_header.is_expandable then
				tag_header.expand
			end
		end

	build_affected_items is
			-- Build affected items
		local
			l_item: ES_EIS_TREE_TAG_ITEM
		do
			create l_item.make ("ANY")
			l_item.set_pixmap (pixmaps.icon_pixmaps.class_normal_icon)
			affected_header.extend (l_item)
		end

feature -- Synchronization

	synchronize is
			-- Synchronize
		do
			if old_view /= Void then
				old_view.rebuild_and_refresh_grid
			end
		end

feature -- Access

	current_view: ?ES_EIS_COMPONENT_VIEW [ANY] is
			-- Current view of list
		do
			Result := old_view
		end

feature {NONE} -- Actions

	on_class_double_click (	x_rel: INTEGER;
							y_rel: INTEGER;
							button: INTEGER;
							x_tilt: DOUBLE;
							y_tilt: DOUBLE;
							pression: DOUBLE;
							x_abs: INTEGER;
							y_abs: INTEGER) is
			-- Display entries corresponding to the class double clicked.
		do
			on_component_click
		end

	on_cluster_double_click (x_rel: INTEGER;
							y_rel: INTEGER;
							button: INTEGER;
							x_tilt: DOUBLE;
							y_tilt: DOUBLE;
							pression: DOUBLE;
							x_abs: INTEGER;
							y_abs: INTEGER) is
			-- Display entries corresponding to the cluster double clicked.
		do
			on_component_click
		end

	on_target_double_click (x_rel: INTEGER;
							y_rel: INTEGER;
							button: INTEGER;
							x_tilt: DOUBLE;
							y_tilt: DOUBLE;
							pression: DOUBLE;
							x_abs: INTEGER;
							y_abs: INTEGER) is
			-- Display entries corresponding to the target double clicked.
		do
			on_component_click
		end

	on_tag_double_clicked (x_rel: INTEGER;
							y_rel: INTEGER;
							button: INTEGER;
							x_tilt: DOUBLE;
							y_tilt: DOUBLE;
							pression: DOUBLE;
							x_abs: INTEGER;
							y_abs: INTEGER) is
			-- Display entries corresponding to the double double clicked
		do
			on_component_click
		end

	on_key_released (a_key: EV_KEY) is
			-- On key released
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				on_component_click
			end
		end

	on_component_click is
			-- On target/cluster/class item clicked
		local
			l_view: ES_EIS_COMPONENT_VIEW [ANY]
		do
			l_view := view_from_selected_item
			if l_view /= Void then
					-- If old view is void
				if old_view = Void or else not l_view.same_view (old_view) then
					l_view.display
					if old_view /= Void then
							-- Call destroy to recycle callbacks from the EIS grid.
						old_view.destroy
					end
					old_view := l_view
				end
			elseif old_view /= Void then
				old_view.wipe_out
				old_view.destroy
				old_view := Void
			end
		end

feature {NONE} -- Component view factory

	view_from_selected_item: ?ES_EIS_COMPONENT_VIEW [ANY] is
			-- Get view from
		local
			l_item: EV_TREE_NODE
			l_sorted_cluster: ?EB_SORTED_CLUSTER
		do
			l_item := selected_item
			if l_item /= Void then
				if {lt_grid: ES_EIS_ENTRY_GRID}eis_tool_widget.entry_list and then lt_grid.is_usable then
					if {lt_item: ES_EIS_TREE_TAG_ITEM}selected_item and then {lt_string: STRING_32}lt_item.text.as_string_32 then
						if tag_header.first = lt_item then
								-- Empty string indicates to view entries without tag.
							create {ES_EIS_TAG_VIEW}Result.make (create {STRING_32}.make_empty, lt_grid)
						else
							create {ES_EIS_TAG_VIEW}Result.make (lt_string, lt_grid)
						end
					elseif {lt_class: CLASS_I}l_item.data then
						create {ES_EIS_CLASS_VIEW}Result.make (lt_class, lt_grid)
					elseif {lt_target: CONF_TARGET}l_item.data then
						create {ES_EIS_CONF_VIEW}Result.make (lt_target, lt_grid)
					else
						l_sorted_cluster ?= l_item.data
						if l_sorted_cluster /= Void then
							if {lt_cluster: CONF_CLUSTER}l_sorted_cluster.actual_group then
								create {ES_EIS_CONF_VIEW}Result.make (lt_cluster, lt_grid)
							elseif {lt_library: CONF_LIBRARY}l_sorted_cluster.actual_group and then {lt_target1: CONF_TARGET}lt_library.library_target then
								create {ES_EIS_CONF_VIEW}Result.make (lt_target1, lt_grid)
							end
						end
					end
				end
			end
		end

feature {NONE} -- EIS observer

	on_tag_added (a_tag: !STRING_32) is
			-- <precursor>
		local
			l_node: ES_EIS_TREE_TAG_ITEM
		do
			if not managed_tags.has (a_tag) then
				managed_tags.extend (a_tag)

				create l_node.make (a_tag)
				l_node.pointer_double_press_actions.extend (agent on_tag_double_clicked)
					-- Here we plus one to shift the mapping between `managed_tags'
					-- and items under `tag_header'.
					-- This is because the first item is ocuppied by "Item without tag".
				tag_header.go_i_th (managed_tags.index + 1)
				tag_header.put_left (l_node)
			end
		end

	on_tag_removed (a_tag: !STRING_32) is
			-- <precursor>
		do
			managed_tags.start
			managed_tags.search (a_tag)
			if not managed_tags.exhausted then
				managed_tags.remove
					-- Here we plus one to shift the mapping between `managed_tags'
					-- and items under `tag_header'.
					-- This is because the first item is ocuppied by "Item without tag".
				tag_header.go_i_th (managed_tags.index + 1)
				tag_header.remove
			end
		end

feature {NONE} -- Implemenation

	internal_recycle is
			-- <precursor>
		do
			Precursor {EB_CLASSES_TREE}
			storage.remove_observer (Current)
		end

feature {NONE} -- Access

	old_view: ES_EIS_COMPONENT_VIEW [ANY]

	tag_header: EB_CLASSES_TREE_HEADER_ITEM

	affected_header: EB_CLASSES_TREE_HEADER_ITEM;

	eis_tool_widget: !ES_EIS_TOOL_WIDGET;
			-- The tool widget

	managed_tags: !SORTED_TWO_WAY_LIST [!STRING_32];
			-- Sorted tags. Do not change directly out of EIS observer.

invariant
	only_first_item_is_off_mapping: managed_tags.count = tag_header.count - 1

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
