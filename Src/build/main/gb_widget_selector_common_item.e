indexing
	description: "Objects that represent items for the widget selector."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WIDGET_SELECTOR_COMMON_ITEM

inherit
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

	GB_GENERAL_UTILITIES
		export
			{NONE} all
		end

	ANY

feature -- Access

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	parent: GB_WIDGET_SELECTOR_COMMON_ITEM
		-- Parent of `Current' or `Void' if none.
		-- If `Void' must be parented in widget_selector.

	children: ARRAYED_LIST [GB_WIDGET_SELECTOR_COMMON_ITEM]
		-- All children contained in `Current'.

	tree_item: EV_TREE_ITEM
		-- Representation of `Current' as a tree item.

	name: STRING
		-- Name of `Current'.

	count: INTEGER is
			-- Number of items in `Current'.
		do
			Result := children.count
		ensure
			result_non_negative: Result >= 0
		end

feature -- Status report

	has_recursive (selector_item: GB_WIDGET_SELECTOR_COMMON_ITEM): BOOLEAN is
			-- Is `selector_item' contained within `Current' at any level?
		require
			selector_item_not_void: selector_item /= Void
		local
			cursor: CURSOR
		do
			cursor := children.cursor
			from
				children.start
			until
				children.off or Result
			loop
				if children.item = selector_item then
					Result := True
				else
					Result := children.item.has_recursive (selector_item)
				end
				children.forth
			end
			children.go_to (cursor)
		ensure
			index_not_changed: old children.index = children.index
		end

feature -- Status setting

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		require
			a_name_not_void: a_name /= Void
		do
			name := a_name
			tree_item.set_text (name)
		ensure
			name_set: name.is_equal (a_name)
		end

	set_parent (new_parent: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Assign `new_parent' to `parent'.
		do
			parent := new_parent
		ensure
			parent_set: parent = new_parent
		end

	unparent is
			-- Remove `Current' from its parent.
		local
			parent_item: GB_WIDGET_SELECTOR_COMMON_ITEM
			window_item: GB_WIDGET_SELECTOR_ITEM
		do
			parent_item := parent

				--|FIXME not clean Redefine in descendent when change is complete.
			if parent /= Void then
				parent := Void

				window_item ?= Current
				if window_item /= Void then
					components.tools.widget_selector.update_for_removal (window_item)
					parent_item.children.prune_all (Current)
					if parent_item /= components.tools.widget_selector then
						components.tools.widget_selector.item_removed_from_directory (parent_item, window_item)
					end
				else
					-- Only for directories.
					parent_item.children.prune_all (Current)
				end
			end
			if tree_item.parent /= Void then
				tree_item.parent.prune_all (tree_item)
			end
		ensure
			parent_void: parent = Void
		end

	directory_object_from_name (path_name: ARRAYED_LIST [STRING]): GB_WIDGET_SELECTOR_DIRECTORY_ITEM is
			-- `Result' is directory item returned by traversing the directory path `path_name'
			-- from `Current'.
		require
			path_name_not_void: path_name /= Void
		local
			path_name_cursor: CURSOR
		do
			path_name_cursor := path_name.cursor
			path_name.start
			Result ?= internal_directory_object_from_name (Current, path_name)
			path_name.go_to (path_name_cursor)
		ensure
			Cursor_not_moved: old children.index = children.index
		end

	window_object_from_name (path_name: ARRAYED_LIST [STRING]): GB_WIDGET_SELECTOR_ITEM is
			-- `Result' is directory item returned by traversing the directory path `path_name'
			-- from `Current'.
		require
			path_name_not_void: path_name /= Void
		local
			path_name_cursor: CURSOR
		do
			path_name_cursor := path_name.cursor
			path_name.start
			Result ?= internal_directory_object_from_name (Current, path_name)
			path_name.go_to (path_name_cursor)
		ensure
			Cursor_not_moved: old children.index = children.index
		end

	prune_all (v: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Remove all occurrences of `v'.
		do
			v.unparent
		end

	wipe_out is
			-- Remove all items from `Current'.
		do
			from
			until
				children.is_empty
			loop
				children.start
				children.item.unparent
			end
		end

	add_alphabetically (new_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Add `representation of `new_item' to `Current' alphabetically.
		require
			new_item_not_void: new_item /= Void
			new_item_not_parented: new_item.parent = Void
		local
			l_text: STRING
		do
				-- Note that we always go from the final position to the start. This is because if we are building
				-- a tree that is already in order we do not have to iterate all of the items  in a node to find
				-- out that it needs to be the final node. This will optimize the loading in Build as it should
				-- be saved in order.

			l_text := new_item.name.as_lower
			from
				children.go_i_th (children.count)
			until
				children.off or else children.item.name.as_lower < l_text
			loop
				children.back
			end
			children.put_right (new_item)
			add_to_tree_node_alphabetically (tree_item, new_item.tree_item)
			new_item.set_parent (Current)
			components.tools.widget_selector.item_added_to_directory (Current, new_item)
		end

	recursive_do_all (action: PROCEDURE [ANY, TUPLE [GB_WIDGET_SELECTOR_COMMON_ITEM]]) is
			-- Apply `action' to very item recusively.
		do
			from
				children.start
			until
				children.off
			loop
				children.item.recursive_do_all (action)
				action.call ([children.item])
				children.forth
			end
		end

	recursive_check_all (action: FUNCTION [ANY, TUPLE [GB_WIDGET_SELECTOR_COMMON_ITEM], BOOLEAN]): BOOLEAN is
			-- For all items in `Current' recursively, call `action'.
			-- `Result' is True if one call to `action' returns True, False otherwise.
		require
			action_not_void: action /= Void
		do
			from
				children.start
			until
				children.off or Result
			loop
				if not Result then
					action.call ([children.item])
					Result := action.last_result
					if not Result then
						Result := children.item.recursive_check_all (action)
					end
				end
				children.forth
			end
		end

	enable_select is
			-- Select `Current'
		require
			tree_item.is_selectable
		do
			tree_item.enable_select
		ensure
			tree_item_is_selected: tree_item.is_selected
		end

	disable_select is
			-- Unselect `Current'
		do
			tree_item.disable_select
		ensure
			tree_item_is_not_selected: not tree_item.is_selected
		end

	expand is
			-- Expand `Current'.
		do
			if tree_item /= Void and then tree_item.is_expandable then
				tree_item.expand
			end
		end

	expand_recursive is
			-- Expand `Current'.
		do
			if tree_item.is_expandable then
				expand
				recursive_do_all (agent internal_expand_recursive)
			end
		ensure
			(tree_item /= Void and then tree_item.is_expandable) implies tree_item.is_expanded
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to graphical representations of `Current'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			tree_item.set_pixmap (a_pixmap)
		end

	directory_names: ARRAYED_LIST [STRING] is
			-- `Result' is names of all directories contained in `Current'.
		local
			l_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			create Result.make (4)
			from
				children.start
			until
				children.off
			loop
				l_directory ?= children.item
				if l_directory /= Void then
					Result.extend (l_directory.name)
				end
				children.forth
			end
		end

	destroy is
			-- Destroy `Current'.
		do
			tree_item.destroy
		end


feature {NONE} -- Implementation

	common_make is
			-- Initialize structures required by `Current'.
		do
			create tree_item
			create children.make (5)
			name := ""
		end

	internal_directory_object_from_name (parent_object: GB_WIDGET_SELECTOR_COMMON_ITEM; texts: ARRAYED_LIST [STRING]): GB_WIDGET_SELECTOR_COMMON_ITEM is
			-- `Result' is directory item returned by traversing the directory path `path_name'
			-- from the current `index' of `texts' from directory object `parent_object'.
		require
			parent_object_not_void: parent_object /= Void
			texts_not_void: texts /= Void
			texts_not_empty: not texts.is_empty
		local
			current_text: STRING
			children_cursor: CURSOR
			l_children: ARRAYED_LIST [GB_WIDGET_SELECTOR_COMMON_ITEM]
			current_window_item: GB_WIDGET_SELECTOR_ITEM
		do
			l_children := parent_object.children
			children_cursor := l_children.cursor
			current_text := texts.item
			from
				l_children.start
			until
				l_children.off or Result /= Void
			loop
				current_window_item ?= l_children.item
				if l_children.item.name.is_equal (current_text) or else (current_window_item /= Void and current_text.is_equal (current_window_item.object.name.as_upper)) then
					if texts.index = texts.count then
						Result ?= l_children.item
					else
						texts.forth
						Result ?= internal_directory_object_from_name (l_children.item, texts)
					end
				end
				l_children.forth
			end
			l_children.go_to (children_cursor)
		ensure
			children_index_unchanged: old parent_object.children.index = parent_object.children.index
		end

	internal_expand_recursive (widget_selector_common_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Expand `Current' .
		require
			widget_selector_common_item_not_void: widget_selector_common_item /= Void
		do
			if widget_selector_common_item.tree_item.is_expandable then
				widget_selector_common_item.expand
			end
		end

invariant
	tree_item_not_void: tree_item /= Void

indexing
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


end -- class GB_WIDGET_SELECTOR_COMMON_ITEM
