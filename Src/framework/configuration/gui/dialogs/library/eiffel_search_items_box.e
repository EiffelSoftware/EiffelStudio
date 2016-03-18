note
	description: "[
			Box containing the result for library search.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SEARCH_ITEMS_BOX [G -> ES_LIBRARY_PROVIDER_ITEM]

inherit
	CONF_GUI_INTERFACE_CONSTANTS

	SHARED_BENCH_NAMES

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (a_target: like target)
		do
			target := a_target
			create on_item_selected_actions
			create on_item_deselected_actions
			create box
			build_interface (box)
		end

	build_interface (b: EV_VERTICAL_BOX)
		local
			g: like grid
			l_col: EV_GRID_COLUMN
		do
			create g
			grid := g
			g.enable_always_selected
			g.enable_single_row_selection
			g.set_column_count_to (last_column)
			l_col := g.column (name_column)
			l_col.set_title (conf_interface_names.dialog_create_library_name)
			l_col.set_width (100)
			l_col := g.column (void_safety_column)
			l_col.set_title (conf_interface_names.dialog_create_library_status)
			l_col.set_width (100)
			l_col := g.column (info_column)
			l_col.set_title (conf_interface_names.dialog_create_library_information)
			l_col.set_width (100)

			g.disable_border
			g.disable_row_height_fixed
--			g.set_row_height (5 * g.row_height // 4)
			g.enable_row_separators
			g.enable_column_separators

			b.extend (g)
			grid := g
		end

feature -- Access

	widget: EV_WIDGET
			-- Widget representing Current box.
		do
			Result := box
		end

	target: CONF_TARGET
			-- Target where we add the group.

	items: detachable LIST [G] assign set_items
			-- CONF_SYSTEM_VIEW indexed by path.

feature -- Change

	set_items (a_lst: like items)
		do
			items := a_lst
		end

	select_row_by_value (p: ANY)
		local
			g: like grid
			i, n: INTEGER
			l_done: BOOLEAN
		do
			g := grid
			n := g.row_count
			if n > 0 then
				from
					i := 1
				until
					l_done or i > n
				loop
					if
						attached g.row (i) as r and then
						attached {G} r.data as l_search_item
					then
						if l_search_item.value = p then
							l_done := True
							r.ensure_visible
							r.enable_select
						end
					end
					i := i + 1
				end
			end
		end

feature -- Callback

	on_item_selected (a_row: EV_GRID_ROW; a_item: G)
			-- Called when an item is selected.
		do
			on_item_selected_actions.call ([a_item])
		end

	on_item_deselected (a_row: EV_GRID_ROW; a_item: G)
			-- Called when an item is deselected..
		do
			on_item_deselected_actions.call ([a_item])
		end

	on_item_selected_actions: ACTION_SEQUENCE [TUPLE [data: G]]
			-- Actions to be triggered when a package is selected.		

	on_item_deselected_actions: ACTION_SEQUENCE [TUPLE [data: G]]
			-- Actions to be triggered when a package is deselected.		

feature -- Event

	hide
		do
			widget.hide
		end

	show
		do
			widget.show
		end

	set_focus
		do
			grid.set_focus
		end

	set_minimum_size (w,h: INTEGER)
		do
			grid.set_minimum_size (w, h)
		end

	update_grid
			-- Update grid
		require
			populated_items_attached: items /= Void
		local
			lst: like items
			g: like grid
			l_row: EV_GRID_ROW
			l_col: EV_GRID_COLUMN
			l_widths: ARRAY [INTEGER]
			i: INTEGER
			l_width: INTEGER
		do
			g := grid
			g.remove_and_clear_all_rows

			lst := items
			if
				lst.count > 0
			then
					-- Build item widgets
				g.set_row_count_to (lst.count)
				from
					create l_widths.make_filled (0, name_column, last_column)
					i := 0
					lst.start
				until
					lst.after
				loop
					i := i + 1
					check same_index: i = lst.index end
					l_row := g.row (i)

					if
						attached lst.item as l_search_item
					then
						l_row.set_data (l_search_item)
						compute_grid_row (l_row, l_widths)
						l_row.select_actions.extend (agent on_item_selected (l_row, l_search_item))
						l_row.deselect_actions.extend (agent on_item_deselected (l_row, l_search_item))
					end
					lst.forth
				end

				l_col := g.column (info_column)
				l_col.resize_to_content
				l_col.set_width (l_col.width + 3)

				l_col := g.column (name_column)
				l_width := l_widths[name_column]
				if l_col.width < l_width then
					l_col.set_width (l_width)
				end
			end
		end

	compute_grid_row (a_row: EV_GRID_ROW; a_max_widths: ARRAY [INTEGER])
		local
			l_item: EV_GRID_LABEL_ITEM
			l_path: READABLE_STRING_GENERAL
			l_description: READABLE_STRING_32
			l_name_item: EV_GRID_LABEL_ITEM
			s: STRING_32
			l_is_installed: BOOLEAN
			l_information: STRING_32
			nb_lines, l_row_font_height: INTEGER
		do
			if attached {G} a_row.data as l_data then
				if
					attached {CONF_SYSTEM_VIEW} l_data.value as l_cfg_data
				then
					l_path := l_cfg_data.original_location

						-- Extract description
					l_description := l_cfg_data.description
					if l_description = Void or else l_description.is_empty then
						l_description := once "No description available"
					end

						-- Library name
					create l_name_item.make_with_text (l_cfg_data.system_name)
					if l_path.starts_with ("iron:") then
						l_name_item.set_pixmap (conf_pixmaps.library_iron_library_icon)
					else
						l_name_item.set_pixmap (conf_pixmaps.new_library_icon)
					end
					l_name_item.set_tooltip (l_description)
					l_name_item.align_text_top
					a_row.set_item (name_column, l_name_item)

						-- Void safety status.
					if attached l_cfg_data.conf_option as l_options then
						create l_item.make_with_text (conf_interface_names.option_void_safety_value [l_options.void_safety.index] + {STRING_32} " void-safety")
						l_item.set_tooltip (conf_interface_names.option_void_safety_value_description [l_options.void_safety.index])
						if l_options.is_void_safety_supported (target.options) then
								-- Library void-safety setting perfectly matches the one used by the target.
							l_item.set_pixmap (conf_pixmaps.general_tick_icon)
						elseif l_options.is_void_safety_sufficient (target.options) then
								-- Library void-safety setting is usable by the target with a warning.
							l_item.set_pixmap (conf_pixmaps.general_warning_icon)
						else
								-- Library void-safety setting is too weak for the target.
							a_row.hide
						end
						a_row.set_item (void_safety_column, l_item)
						l_item.align_text_top
					else
						a_row.set_item (void_safety_column, create {EV_GRID_LABEL_ITEM})
					end

						-- Information
					create l_information.make_empty
					l_information.append ("Location=")
					l_information.append_string_general (l_path)
					if attached l_cfg_data.info ("tags") as l_tags then
						l_information.append_character ('%N')
						l_information.append ("Tags=")
						l_information.append (l_tags)
					end

					create l_item.make_with_text (l_information)
					l_item.align_text_top
					a_row.set_item (info_column, l_item)

					nb_lines := l_information.occurrences ('%N') + 1
					if nb_lines > 1 then
						a_row.set_height (nb_lines * a_row.height)
					end

				elseif attached {IRON_PACKAGE} l_data.value as l_iron_package then
					l_path := l_iron_package.location.string

						-- Extract description
					l_description := l_iron_package.description
					if l_description = Void or else l_description.is_empty then
						l_description := once "No description available"
					end

					l_is_installed := attached {BOOLEAN} l_data.info ("is_installed") as b and then b

						-- Library name
					create l_name_item.make_with_text (l_iron_package.identifier)
					l_name_item.set_pixmap (conf_pixmaps.library_iron_package_icon)
					l_name_item.set_tooltip (l_description)
					l_name_item.align_text_top
					a_row.set_item (name_column, l_name_item)

						-- Void safety status.
					if l_is_installed then
						create l_item.make_with_text ("Is installed")
					else
						create l_item.make_with_text ("Not yet installed")
						l_item.set_pixmap (conf_pixmaps.general_add_icon)
					end
					a_row.set_item (void_safety_column, l_item)
					l_item.align_text_top

						-- Information
					create l_information.make_empty
					l_information.append ("Location=" + l_path)
					if attached l_iron_package.tags as l_tags and then not l_tags.is_empty then
						l_information.append_character ('%N')
						create s.make_empty
						across
							l_tags as ic
						loop
							if not s.is_empty then
								s.append_character (',')
								s.append_character (' ')
							end
							s.append (ic.item)
						end
						l_information.append ("Tags=")
						l_information.append (s)
					end

					create l_item.make_with_text (l_information)
					l_item.align_text_top
					a_row.set_item (info_column, l_item)
					nb_lines := l_information.occurrences ('%N') + 1
					if nb_lines > 1 then
						a_row.set_height (nb_lines * a_row.height)
					end
					l_item.align_text_top
				else
					create l_item.make_with_text ("Score=" + l_data.score.out)
					l_item.align_text_top
					a_row.set_item (name_column, l_item)
				end
--DEBUG				a_row.item (1).set_tooltip (l_data.score.out)
				if attached a_row.item (name_column) as i then
					a_max_widths[name_column] := (a_max_widths[name_column]).max (i.required_width + 10)
				end
			end
		end

feature -- Widgets		

	box: EV_VERTICAL_BOX

	grid: ES_GRID

feature {NONE} -- Constants

	name_column: INTEGER = 1
			-- Index of a column with name.

	void_safety_column: INTEGER = 2
			-- Index of a column with void-safety status.

	info_column: INTEGER = 3
			-- Index of a column with a information.

--	location_column: INTEGER = 4
--			-- Index of a column with location.

	last_column: INTEGER = 3


;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
