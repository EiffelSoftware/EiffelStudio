indexing
	description: "Object that represents a dependency row in dependency view"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_DEPENDENCY_ROW

inherit
	EB_CLASS_BROWSER_GRID_ROW

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY

create
	make

feature{NONE} -- Initialization

	make (a_item: like item; a_row_node: like row_node; a_browser: EB_CLASS_BROWSER_DEPENDENCY_VIEW) is
			-- Initialize `item' with `a_item', `row_node' with `a_row_node' and `browser' with `a_browser'.
		require
			a_item_attached: a_item /= Void
			a_row_node_attached: a_row_node /= Void
			a_browser_attached: a_browser /= Void
		do
			set_item (a_item)
			set_row_node (a_row_node)
			set_browser (a_browser)
		end

feature -- Access

	item: QL_ITEM
			-- Item to be displayed in current row

	row_node: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]
			-- Row node where current belongs

	grid_item: EB_GRID_COMPILER_ITEM is
			-- Grid item to be displayed
		local
			l_style: like item_style
		do
			if grid_item_internal = Void then
				l_style := item_style
				create grid_item_internal
				l_style.set_item (item)
				if should_path_be_displayed then
					l_style.enable_parent
				else
					l_style.disable_parent
				end
				grid_item_internal.set_text_with_tokens (item_style.text)
				grid_item_internal.set_pixmap (pixmap_for_query_lanaguage_item (item))
				grid_item_internal.set_image (grid_item_internal.text)
			end
			Result := grid_item_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	should_path_be_displayed: BOOLEAN is
			-- Should path of `item' be displayed?
		do
			Result := item.is_group
		end

	is_expanded: BOOLEAN
			-- Is current row expanded?

	has_been_expanded: BOOLEAN
			-- Has current row been expanded?

	is_referencer_class_row: BOOLEAN
			-- Is current row for referencer class?

feature -- Setting

	set_item (a_item: like item) is
			-- Set `item' with `a_item'.
		require
			a_item_attached: a_item /= Void
		do
			item := a_item
		ensure
			item_set: item = a_item
		end

	set_row_node (a_row_node: like row_node) is
			-- Set `row_node' with `a_row_node'.
		do
			row_node := a_row_node
		ensure
			row_node_set: row_node = a_row_node
		end


	set_is_expanded (a_expanded: BOOLEAN) is
			-- Set `is_expanded' with `a_expanded'.
		do
			is_expanded := a_expanded
			if not has_been_expanded and then a_expanded then
				has_been_expanded := True
			end
		ensure
			is_expanded_set: is_expanded = a_expanded
		end

	set_is_referencer_class (a_referencer_class: BOOLEAN) is
			-- Set `is_referencer_class_row' with `a_referencer_class'.
		do
			is_referencer_class_row := a_referencer_class
			if is_referencer_class_row then
				grid_item.set_tooltip (warning_messages.w_slow_process_to_expand)
			end
		ensure
			is_referencer_class_set_row: is_referencer_class_row = a_referencer_class
		end

feature -- Grid binding

	bind_row (a_row: EV_GRID_ROW; a_column: INTEGER) is
			-- Bind current in `a_row' at `a_column'.
		require
			a_row_attached: a_row /= Void
			a_column_valid: a_column > 0
		do
			a_row.clear
			a_row.set_data (Current)
			a_row.set_item (a_column, grid_item)
			set_grid_row (a_row)
		end

feature{NONE} -- Implementation

	item_style: EB_PATH_EDITOR_TOKEN_STYLE is
			-- Style to generate text for `grid_item'
		once
			create Result
			Result.enable_parent
			Result.enable_self
			Result.disable_target
		ensure
			result_attached: Result /= Void
		end

	grid_item_internal: like grid_item
			-- Implementation of `grid_item'.	

invariant
	item_attached: item /= Void
	row_node_attached: row_node /= Void

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
