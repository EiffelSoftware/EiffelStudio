note
	description:
		"Components consisting of two lists, one typically%N%
		%for inclusion and one for exclusion of items.%N%
		%Together, they contain all possible items."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_INCLUDE_EXCLUDE_GRID

inherit
	EV_VERTICAL_BOX
		redefine
			initialize,
			is_in_default_state
		end

	EB_CONSTANTS
		undefine
			default_create,
			is_equal,
			copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	initialize
			-- Set defaults.
		local
			hb: EV_HORIZONTAL_BOX
		do
			Precursor {EV_VERTICAL_BOX}
			set_padding (5)

			create selection_grid
			selection_grid.enable_multiple_row_selection
			selection_grid.pointer_button_press_item_actions.extend (agent on_selection_item_pressed)
			selection_grid.hide_header
			extend (selection_grid)

			create hb
			hb.set_padding (5)
			hb.set_minimum_width (40)

			extend (hb)
			disable_item_expand (hb)

			create include_button.make_with_text (interface_names.l_include_selection)
			include_button.select_actions.extend (agent on_include)
			hb.extend (include_button)
			hb.disable_item_expand (include_button)

			create exclude_button.make_with_text (interface_names.l_exclude_selection)
			exclude_button.select_actions.extend (agent on_exclude)
			hb.extend (exclude_button)
			hb.disable_item_expand (exclude_button)

		end

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default sate.
		do
			Result := Precursor or padding = 5
		end

feature -- Access

	include_button: EV_BUTTON
			-- When clicked, all selected items in `exclude_list' are moved to `include_list'.

	exclude_button: EV_BUTTON
			-- When clicked, all selected items in `include_list' are moved to `exclude_list'.

	selection_grid: ES_GRID
			-- Selection grid.

	excluded_items_string_8: LIST [STRING]
		local
			g: like selection_grid
			r,n: INTEGER
		do
			g := selection_grid
			from
				r := 1
				n := selection_grid.row_count
				create {ARRAYED_LIST [STRING]} Result.make (n)
			until
				r > n
			loop
				if
					attached {EV_GRID_CHECKABLE_LABEL_ITEM} g.item (1, r) as cl and then
					not cl.is_checked
				then
					Result.extend (cl.text)
				end
				r := r + 1
			end
		end

	included_items_string_8: LIST [STRING]
		local
			g: like selection_grid
			r,n: INTEGER
		do
			g := selection_grid
			from
				r := 1
				n := selection_grid.row_count
				create {ARRAYED_LIST [STRING]} Result.make (n)
			until
				r > n
			loop
				if
					attached {EV_GRID_CHECKABLE_LABEL_ITEM} g.item (1, r) as cl and then
					cl.is_checked
				then
					Result.extend (cl.text)
				end
				r := r + 1
			end
		end

	included_items_data: LIST [ANY]
		local
			g: like selection_grid
			r,n: INTEGER
		do
			g := selection_grid
			from
				r := 1
				n := selection_grid.row_count
				create {ARRAYED_LIST [ANY]} Result.make (n)
			until
				r > n
			loop
				if
					attached {EV_GRID_CHECKABLE_LABEL_ITEM} g.item (1, r) as cl and then
					cl.is_checked
				then
					Result.extend (cl.data)
				end
				r := r + 1
			end
		end

feature -- UI

	has_pixmap_function: BOOLEAN
			-- Has pixmap function available?
		do
			Result := pixmap_function /= Void
		end

	pixmap_function: detachable FUNCTION [ANY, TUPLE [ANY], like pixmap]
			-- Function to return the pixmap associated with argument data

	set_pixmap_function (a_fct: like pixmap_function)
			-- Set `pixmap_function' to `a_fct'
		do
			pixmap_function := a_fct
		end

	pixmap (a_data: ANY): detachable EV_PIXMAP
		do
			if attached pixmap_function as fct then
				Result := fct.item ([a_data])
			end
		end

feature -- Element change

	clear_all
			-- Clear all includes and excluded items
		do
			selection_grid.set_row_count_to (0)
--			include_list.wipe_out
--			exclude_list.wipe_out
		end

	add_include_item (a_name: STRING_GENERAL; a_data: ANY)
		do
			add_item (True, a_name, a_data, Void)
		end

	add_exclude_item (a_name: STRING_GENERAL; a_data: ANY)
		do
			add_item (False, a_name, a_data, Void)
		end

	add_include_item_with_parent (a_name: STRING_GENERAL; a_data: ANY; a_parent_data: detachable ANY)
		do
			add_item_with_parent (True, a_name, a_data, a_parent_data)
		end

	add_exclude_item_with_parent (a_name: STRING_GENERAL; a_data: ANY; a_parent_data: detachable ANY)
		do
			add_item_with_parent (False, a_name, a_data, a_parent_data)
		end

	set_excluded_items_from_strings (strs: ARRAY [STRING_GENERAL])
			-- Add items according to the list of strings `strs'
		require
			strs_attached: strs /= Void
		local
			i: INTEGER
		do
			from
				i := strs.lower
			until
				i > strs.upper
			loop
				add_exclude_item (strs[i], Void)
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	add_item_with_parent (a_is_include: BOOLEAN; a_name: STRING_GENERAL; a_data: ANY; a_parent_data: detachable ANY)
		do
			if
				a_parent_data /= Void and then
				attached row_by_data (a_parent_data) as r
			then
				add_item (a_is_include, a_name, a_data, r)
			else
				add_item (a_is_include, a_name, a_data, Void)
			end
		end

	add_item (a_is_include: BOOLEAN; a_name: STRING_GENERAL; a_data: ANY; a_parent_row: detachable EV_GRID_ROW)
		local
			cl: EV_GRID_CHECKABLE_LABEL_ITEM
			n: INTEGER
			g: like selection_grid
			r: EV_GRID_ROW
		do
			g := selection_grid
			create cl.make_with_text (a_name)
			cl.set_is_checked (a_is_include)
			cl.checked_changed_actions.extend (agent on_checked_changed)
			cl.set_data (a_data)
			if
				attached pixmap (a_data) as pix
			then
				cl.set_pixmap (pix)
			end

			if a_parent_row = Void then
				n := g.row_count + 1
				g.insert_new_row (n)
				r := g.row (n)
			else
				ensure_tree_behavior
				n := a_parent_row.subrow_count + 1
				a_parent_row.insert_subrow (n)
				r := a_parent_row.subrow (n)
				if a_parent_row.is_expandable and then not a_parent_row.is_expanded then
					a_parent_row.expand
				end
			end
			r.set_item (1, cl)
			r.set_data (a_data)
		end

	row_by_data (a_data: detachable ANY): detachable EV_GRID_ROW
		local
			r,n: INTEGER
			g: like selection_grid
		do
			from
				g := selection_grid
				r := 1
				n := g.row_count
			until
				r > n or Result /= Void
			loop
				Result := g.row (r)
				if Result.data /= a_data then
					Result := Void
				end
				r := r + 1
			end
		end

	ensure_tree_behavior
			-- Ensure `selection_grid' has tree enabled
		do
			if not selection_grid.is_tree_enabled then
				selection_grid.enable_tree
			end
		ensure
			selection_grid.is_tree_enabled
		end

	on_selection_item_pressed (a_x_pos: INTEGER; a_y_pos: INTEGER; a_button: INTEGER; i: detachable EV_GRID_ITEM)
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
		do
			if a_button = {EV_POINTER_CONSTANTS}.right and attached {EV_GRID_CHECKABLE_LABEL_ITEM} i as cl then
				create m.default_create
				if cl.is_checked then
					create mi.make_with_text_and_action (interface_names.b_uncheck, agent set_status_on (False, cl, False))
				else
					create mi.make_with_text_and_action (interface_names.b_check, agent set_status_on (True, cl, False))
				end
				m.extend (mi)
				if selection_grid.is_tree_enabled then
					create mi.make_with_text_and_action (interface_names.b_check_recursively, agent set_status_on (True, cl, True))
					m.extend (mi)
					create mi.make_with_text_and_action (interface_names.b_uncheck_recursively, agent set_status_on (False, cl, True))
					m.extend (mi)
				end
				m.show
			end
		end

	on_checked_changed (a_item: EV_GRID_CHECKABLE_LABEL_ITEM)
			-- Event triggered when `a_item' checkable state has changed.
		do
			if attached a_item.row as l_row and then not l_row.is_expanded then
				set_status_on (a_item.is_checked, a_item, True)
			end
		end

	set_status_on (a_status: BOOLEAN; a_item: EV_GRID_CHECKABLE_LABEL_ITEM; a_propagate: BOOLEAN)
		local
			l_row: EV_GRID_ROW
			r,n: INTEGER
		do
			a_item.set_is_checked (a_status)
			if a_propagate then
				if attached a_item.parent as g then
					l_row := a_item.row
					from
						r := l_row.index
						n := r + l_row.subrow_count_recursive
						r := r + 1
					until
						r > n
					loop
						l_row := g.row (r)
						if l_row.count > 0 and then attached {EV_GRID_CHECKABLE_LABEL_ITEM} l_row.item (1) as cl then
							cl.set_is_checked (a_status)
						end
						r := r + 1
					end
				end
			end
		end

	on_include
			-- `include_button' button has been pressed.
		do
			if attached selection_grid.selected_rows as rows then
				from
					rows.start
				until
					rows.after
				loop
					if attached {EV_GRID_CHECKABLE_LABEL_ITEM} rows.item.item (1) as cl then
						cl.set_is_checked (True)
					end
					rows.forth
				end
			end
		end

	on_exclude
			-- `exclude_button' button has been pressed.
		do
			if attached selection_grid.selected_rows as rows then
				from
					rows.start
				until
					rows.after
				loop
					if attached {EV_GRID_CHECKABLE_LABEL_ITEM} rows.item.item (1) as cl then
						cl.set_is_checked (False)
					end
					rows.forth
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
