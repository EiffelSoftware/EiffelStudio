indexing
	description: "Tree row in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_TREE_ROW

inherit
	EB_CLASS_BROWSER_GRID_ROW

create
	make

feature{NONE} -- Initialization

	make (a_browser: like browser; a_class: like class_item; collapsed: BOOLEAN) is
			-- Initialize `class_item' with `a_class'.
		require
			a_class_attached: a_class /= Void
			a_class_item_valid: a_class.is_valid_domain_item
		do
			class_item := a_class
			is_collapsed := collapsed
			browser := a_browser
		ensure
			class_item_set: class_item = a_class
			is_collapsed_set: is_collapsed = collapsed
		end

feature -- Grid binding

	bind_row (a_row: EV_GRID_ROW; a_grid: EV_GRID; a_background_color: EV_COLOR; a_height: INTEGER; a_path: BOOLEAN) is
			-- Bind current as a subrow of `a_row' in `a_grid'. if `a_row' is Void, insert a new
			-- row in `a_grid' directly.
			-- Set backgroud color of inserted row with `a_background_color',
			-- set row height with `a_height'.
			-- If `a_path' is True, display path of associated item.
		require
			a_grid_not_void: a_grid /= Void
			a_grid_valid: a_grid.is_tree_enabled
			a_background_color_not_void: a_background_color /= Void
			a_height_non_negative: a_height >= 0
		local
			l_row: EV_GRID_ROW
			l_children: like children
		do
			if a_row /= Void then
				a_row.insert_subrow (a_row.subrow_count + 1)
				l_row := a_row.subrow (a_row.subrow_count)
			else
				a_grid.insert_new_row (a_grid.row_count + 1)
				l_row := a_grid.row (a_grid.row_count)
			end
			l_row.set_item (1, class_grid_item)
			if a_path then
				l_row.set_item (2, path_grid_item)
			end
			set_grid_row (l_row)
			l_children := children
			if not l_children.is_empty then
				from
					l_children.start
				until
					l_children.after
				loop
					l_children.item_for_iteration.bind_row (l_row, a_grid, a_background_color, a_height, a_path)
					l_children.forth
				end
			end
			if l_row.is_expandable then
				l_row.expand
			end
		end

	expand_row is
			-- Expand Current and its parent recursively.
		local
			l_row: like Current
			l_grid_row: EV_GRID_ROW
		do
			from
				l_row := Current
			until
				l_row = Void
			loop
				l_grid_row := l_row.grid_row
				check l_grid_row /= Void end
				if l_grid_row.is_expandable then
					l_grid_row.expand
				end
				l_row := l_row.parent
			end
		end

feature -- Element change

	add_child (a_child: like Current) is
			-- Add `a_child' into `children'.
		require
			a_child_attached: a_child /= Void
			a_child_valid: a_child /= Current
		do
			a_child.set_parent (Current)
			children.force_last (a_child)
		end

feature -- Access

	class_item: QL_CLASS
			-- Class assoicated with current row

	children: DS_ARRAYED_LIST [like Current] is
			-- Children rows of current row
		do
			if children_internal = Void then
				create children_internal.make (2)
			end
			Result := children_internal
		ensure
			result_attached: Result /= Void
		end

	class_grid_item: EB_GRID_COMPILER_ITEM is
			-- Class item
		local
			l_complete_generic_class_style: like complete_generic_class_no_star_style
			l_agent_style: like agent_style
			l_class_item_internal: like class_item_internal
		do
			if class_item_internal = Void then
				l_complete_generic_class_style := complete_generic_class_no_star_style
				create l_class_item_internal
				l_class_item_internal.set_pixmap (pixmap_for_query_lanaguage_item (class_item))
				l_complete_generic_class_style.set_ql_class (class_item)
				if is_collapsed then
					l_agent_style := agent_style
					l_agent_style.set_text_function (agent: STRING do Result := "..." end)
					l_class_item_internal.set_text_with_tokens ((l_complete_generic_class_style + l_agent_style).text)
					l_class_item_internal.set_tooltip (interface_names.f_go_to_first_occurrence)
				else
					l_class_item_internal.set_text_with_tokens (l_complete_generic_class_style.text)
				end
				class_item_internal := l_class_item_internal
			end
			Result := class_item_internal
		ensure
			result_attached: Result /= Void
		end

	path_grid_item: EB_GRID_COMPILER_ITEM is
			-- Path item
		local
			l_path_style: like path_style
		do
			if path_grid_item_internal = Void then
				create path_grid_item_internal
				l_path_style := path_style
				l_path_style.set_item (class_item)
				path_grid_item_internal.set_text_with_tokens (l_path_style.text)
				path_grid_item_internal.set_image (path_grid_item_internal.text)
				if class_item.parent /= Void then
					path_grid_item_internal.set_pixmap (pixmap_for_query_lanaguage_item (class_item.parent))
				else
					path_grid_item_internal.set_pixmap (pixmaps.icon_pixmaps.general_blank_icon)
				end
			end
			Result := path_grid_item_internal
		ensure
			result_attached: Result /= Void
		end

	parent: like Current
			-- Parent of Current row

	is_collapsed: BOOLEAN
			-- Should current row remain collapsed all the times?

feature{NONE} -- Implementation

	children_internal: like children
			-- Implementation of `children'

	class_item_internal: like class_grid_item
			-- Internal `class_grid_item'

	path_grid_item_internal: like path_grid_item
			-- Implementation of `path_grid_item'

	complete_generic_class_no_star_style: EB_CLASS_EDITOR_TOKEN_STYLE is
			-- Editor token style to generate class information in complete generic form without star.
			-- e.g., HASH_TABLE [G, H -> HASHABLE].
		once
			create Result
			Result.enable_complete_generic_form
			Result.disable_processed
			Result.disable_star
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_parent (a_parent: like parent) is
			-- Set `parent' with `a_parent'.
		require
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent /= Current
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

invariant
	class_item_attached: class_item /= Void
	class_item_valid: class_item.is_valid_domain_item

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


end
