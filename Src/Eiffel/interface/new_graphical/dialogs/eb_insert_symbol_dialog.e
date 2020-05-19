class
	EB_INSERT_SYMBOL_DIALOG

inherit
	EB_DIALOG
		redefine
			create_interface_objects
		end

	EV_LAYOUT_CONSTANTS
		undefine
			default_create, copy
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create, copy
		end

	EB_CONSTANTS
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Creation

	make (a_text_panel: like editor)
			-- Make with text panel
		require
			text_panel_not_void: a_text_panel /= Void
		do
			update_editor (a_text_panel)
			default_create
			build_interface
		ensure
			editor_set: editor = a_text_panel
		end

feature -- Element change

	update_editor (a_text_panel: like editor)
			-- Set or update `editor` with `a_text_panel`.
		require
			text_panel_not_void: a_text_panel /= Void
		do
			editor := a_text_panel
		ensure
			editor_set: editor = a_text_panel
		end

feature {NONE} -- Initialization

	build_interface
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			li: EV_LIST_ITEM
			sep: EV_HORIZONTAL_SEPARATOR
			lab: EV_LABEL
			ft: EV_FONT
		do
			set_title ("Insert symbols")
			create vb
			vb.set_border_width (default_border_size)
			vb.set_padding_width (tiny_padding_size)

			create hb; hb.set_padding_width (tiny_padding_size)
			create lab.make_with_text ("Category")
			hb.extend (lab); hb.disable_item_expand (lab)
			hb.extend (categories_choice)
			vb.extend (hb); vb.disable_item_expand (hb)

			create hb; hb.set_padding_width (tiny_padding_size)
			create lab.make_with_text ("Search")
			hb.extend (lab); hb.disable_item_expand (lab)
			hb.extend (search_field)
			vb.extend (hb); vb.disable_item_expand (hb)

			vb.extend (symbols_grid)

			create sep
			vb.extend (sep); vb.disable_item_expand (sep)

			create hb
			hb.set_border_width (default_border_size)
			hb.set_padding_width (default_padding_size)
			vb.extend (hb); vb.disable_item_expand (hb)
			cancel_button.set_text (interface_names.b_cancel)
			cancel_button.select_actions.extend (agent on_close)
			clipboard_button.set_pixmap (pixmaps.icon_pixmaps.general_copy_icon)
			clipboard_button.set_tooltip (interface_names.l_copy_text_to_clipboard)
			clipboard_button.select_actions.extend (agent on_copy_symbol)
			insert_button.set_text (interface_names.b_insert)
			insert_button.select_actions.extend (agent on_insert_symbol)
			set_default_cancel_button (cancel_button)
			set_default_push_button (insert_button)
			ft := editor.font
			create ft.make_with_values (ft.family, ft.weight, ft.shape, 3 * ft.height)
			preview_label.set_font (ft)
			preview_label.set_foreground_color (preferences.editor_data.normal_text_color)
			preview_label.set_background_color (preferences.editor_data.normal_background_color)
			hb.extend (preview_label)
			hb.extend (create {EV_CELL})
			hb.extend (cancel_button); hb.disable_item_expand (cancel_button); cancel_button.hide
			hb.extend (insert_button); hb.disable_item_expand (insert_button)
			hb.extend (clipboard_button); hb.disable_item_expand (clipboard_button)

			across
				symbols.sections as ic
			loop
				if not ic.item.is_empty then
					create li.make_with_text (ic.key)
					categories_choice.extend (li)
				end
			end
			categories_choice.change_actions.extend (agent on_category_changed)

			extend (vb)

			search_field.change_actions.extend (agent on_search_input (search_field))
			show_actions.extend_kamikaze (agent on_category_changed)

			symbols_grid.hide_header
			symbols_grid.item_select_actions.extend (agent on_grid_item_selected)
			symbols_grid.pointer_double_press_item_actions.extend (agent on_grid_item_double_pressed)
			symbols_grid.pointer_button_press_item_actions.extend (agent on_grid_item_single_pressed)
			symbols_grid.enable_column_separators
			symbols_grid.enable_row_separators
			symbols_grid.enable_row_height_fixed

			preview_label.pointer_double_press_actions.extend (agent (i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
					do
						on_copy_symbol
					end
				)

			on_category_changed
			show_actions.extend (agent categories_choice.set_focus)
		end

	create_interface_objects
		do
			Precursor
			create categories_choice
			create search_field
			create symbols_grid
			create insert_button
			create cancel_button
			create clipboard_button
			create preview_label
		end

feature -- Events

	on_search_input (a_field: EV_TEXTABLE)
		local
			s: STRING_32
			a: like search_action
		do
			s := a_field.text
			if s.is_whitespace then
				categories_choice.enable_sensitive
			else
				categories_choice.disable_sensitive
				s.adjust
				a := search_action
				if a = Void then
					create a.make (agent on_search_updated (a_field), 50)
					search_action := a
				end
				a.request_call
			end
		end

	search_action: detachable ES_DELAYED_ACTION

	on_search_updated (a_field: EV_TEXTABLE)
		local
			lst: ARRAYED_LIST [TUPLE [symbol: READABLE_STRING_32; description: READABLE_STRING_GENERAL]]
			s: READABLE_STRING_GENERAL
			m: WILD_COMPLETION_NAME_MATCHER
			l_query: STRING_32
		do
			search_action := Void
			l_query := a_field.text
			current_section := Void
			create lst.make (symbols.count)
			create m
			across
				symbols as ic
			loop
				s := ic.key
				if m.prefix_string (l_query, s.to_string_32) then
					if ic.item.count = 1 then
						lst.extend ([ic.item, ic.key])
					end
				end
			end
			fill_grid_with (lst)
		end

	on_symbol_selected
		local
			s: STRING_32
		do
			if attached current_symbol as cs then
				create s.make_filled (cs.symbol, 1)
				preview_label.set_text (s)
			else
				preview_label.remove_text
			end
		end

	on_category_changed
		local
			cat: READABLE_STRING_GENERAL
		do
			cat := categories_choice.text
			current_section := cat.to_string_32
			fill_grid_with (symbols.sections.item (cat))
--			symbols_grid.set_focus
		end

	fill_grid_with (lst: detachable LIST [TUPLE [symbol: READABLE_STRING_32; description: READABLE_STRING_GENERAL]])
		local
			i,j: INTEGER
			colw,nb,n: INTEGER
			gi: EV_GRID_LABEL_ITEM
			sym, s: STRING_32
			g: like symbols_grid
		do
			g := symbols_grid
			g.clear
			g.wipe_out
			if lst /= Void and then not lst.is_empty then
				n := lst.count
				i := 1
				j := 0
				colw := 5 * (create {EV_GRID_LABEL_ITEM}.make_with_text ("_")).text_width
				nb := (g.width // colw)
				if nb <= 0 then
					nb := 3
				end
				g.set_column_count_to (nb + 1)
				g.set_row_height (colw)

				g.insert_new_rows (n // nb, 1)
				across
					lst as ic
				loop
					sym := ic.item.symbol
					if sym.count = 1 then
						create s.make_from_string (sym)
						create gi.make_with_text (s)
						gi.align_text_center
						gi.align_text_vertically_center
						gi.set_tooltip (ic.item.description)
						gi.set_data ([sym [1], ic.item.description])
						gi.select_actions.extend (agent (i_data: attached like current_symbol)
							do
								current_symbol := i_data
							end([sym [1], ic.item.description]))

						j := j + 1
						if j > nb then
							j := 1
							i := i + 1
						end
						g.set_item (j, i, gi)
					end
				end
				across
					1 |..| g.column_count as ic
				loop
					if attached {EV_GRID_COLUMN} g.column (ic.item) as col then
						col.set_width (colw)
--						col.resize_to_content
					end
				end
			end
		end

	on_grid_item_selected (a_grid_item: EV_GRID_ITEM)
		do
			current_symbol := Void
			if
				a_grid_item /= Void and then
				attached {TUPLE [symbol: CHARACTER_32; description: READABLE_STRING_GENERAL]} a_grid_item.data as d
			then
				current_symbol := d
				on_symbol_selected
			end
		end

	on_grid_item_double_pressed (a_x_pos: INTEGER; a_y_pos: INTEGER; a_button: INTEGER; a_grid_item: detachable EV_GRID_ITEM)
		do
			on_grid_item_single_pressed (a_x_pos, a_y_pos, a_button, a_grid_item)
			on_insert_symbol
		end

	on_grid_item_single_pressed (a_x_pos: INTEGER; a_y_pos: INTEGER; a_button: INTEGER; a_grid_item: detachable EV_GRID_ITEM)
		do
			on_grid_item_selected (a_grid_item)
		end

	on_copy_symbol
		local
			s: STRING_32
		do
			if attached current_symbol as curr then
				create s.make_filled (curr.symbol, 1)
				ev_application.clipboard.set_text (s)
			end
		end

	on_insert_symbol
		do
			if attached current_symbol as curr then
				editor.text_displayed.insert_char (curr.symbol)
				on_close
			end
		end

	on_close
		do
			hide
		end

feature -- Access

	preview_label: EV_LABEL

	clipboard_button,
	insert_button,
	cancel_button: EV_BUTTON

	categories_choice: EV_COMBO_BOX

	search_field: EV_TEXT_FIELD

	symbols_grid: ES_GRID

	symbols: EB_COMPLETION_UNICODE_SYMBOLS
		once
			create Result.make
		end

feature -- Access: data

	current_section: detachable READABLE_STRING_32

	current_symbol: detachable TUPLE [symbol: CHARACTER_32; description: READABLE_STRING_GENERAL]


feature {NONE} -- Implementation

	editor: EB_CLICKABLE_EDITOR
			-- Editor to search		
invariant
	has_editor: editor /= Void

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
