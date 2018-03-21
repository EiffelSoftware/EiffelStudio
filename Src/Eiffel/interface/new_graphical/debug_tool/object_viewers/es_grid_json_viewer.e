note
	description: "Component to display valid JSON in GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRID_JSON_VIEWER

inherit
	JSON_VISITOR

	ES_SHARED_FOUNDATION_HELPERS

create
	make

feature {NONE} -- Initialization

	make
		do
			build_resources
			create tags_row_index.make

			create widget
			create grid

			grid.enable_tree
			grid.enable_single_row_selection
			grid.row_select_actions.extend (agent on_row_selected)
			grid.row_deselect_actions.extend (agent on_row_deselected)
			grid.set_separator_color (create {EV_COLOR}.make_with_8_bit_rgb (180,180,180))
			grid.enable_column_separators
			grid.disable_row_height_fixed

			init_colors
			build_pixmaps

			widget.extend (grid)
			create status_label
			widget.extend (status_label)
			status_label.set_minimum_width (10)
			widget.disable_item_expand (status_label)
		end

	status_label: EV_LABEL
			-- Label used to display parsing status.

	grid: ES_GRID
			-- Grid to display JSON tree.

feature -- Actions

	drop_actions: EV_PND_ACTION_SEQUENCE
		do
			Result := grid.drop_actions
		end

feature -- Access

	widget: EV_VERTICAL_BOX

	attach_to_container (c: EV_CONTAINER)
		do
			c.extend (widget)
		end

	clear
		do
			grid.set_row_count_to (0)
			status_label.remove_text
			status_label.refresh_now
			grid.wipe_out
		end

feature -- Change

	enable_files_dropping
			-- Enable file dropping.
		do
			if not is_file_dropping_enabled then
				is_file_dropping_enabled := True
				grid.file_drop_actions.extend (agent files_dropped)
			end
		end

feature -- Loading

	load_string (s: READABLE_STRING_GENERAL)
		local
			p: JSON_PARSER
		do
			grid.set_row_count_to (0)
			if s /= Void and then not s.is_empty then
				create p.make_with_string (s.as_string_8)
				p.parse_content
				if p.is_parsed and then p.is_valid then
					load_json (p.parsed_json_value)
				else
					clear
					on_error ("Invalid JSON content!")
					across
						p.errors as ic
					loop
						on_error (ic.item)
					end
				end
			else
				clear
				on_error ("Empty content!")
			end
			update_columns
		end

	load_file (fn: READABLE_STRING_GENERAL)
			--
		local
			f: RAW_FILE
			s: STRING
			p: JSON_PARSER
		do
			grid.set_row_count_to (0)
			create f.make_with_name (fn)
			if f.exists and then f.is_readable then
				create s.make (f.count)
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream (1_024)
					s.append (f.last_string)
				end
				f.close
				create p.make_with_string (s)
				p.parse_content
				if p.is_parsed and then p.is_valid then
					load_json (p.parsed_json_value)
				else
					clear
					on_error ("Invalid JSON content!")
					across
						p.errors as ic
					loop
						on_error (ic.item)
					end
				end
			else
				clear
				on_error ("File not found!")
			end
			update_columns
		end

	update_columns
		do
			if grid.column_count > 0 then
				grid.column (1).resize_to_content
				if grid.column_count > 1 then
					grid.column (2).resize_to_content
					if grid.column_count > 2 then
						grid.column (grid.column_count).resize_to_content
					end
				end
			end
		end

	load_json (j: detachable JSON_VALUE)
		do
			grid.set_column_count_to (2)
			grid.column (1).set_title ("Keys")
			grid.column (2).set_title ("Encoded values (double-click cell to view decoded value)")

			if j = Void then
				grid.wipe_out
			else
				on_start
				j.accept (Current)
				on_finish
			end
		end

feature {NONE} -- Callbacks

	tags_row_index: LINKED_STACK [INTEGER]

	log (a_message: READABLE_STRING_GENERAL)
		do
			status_label.set_text (a_message)
			status_label.refresh_now
		end

	on_start
		do
			current_depth := 0
			last_depth := 0
			tags_row_index.wipe_out
			log ("Start JSON parsing")
		end

	on_finish
		local
			r: EV_GRID_ROW
			i: INTEGER
		do
			log ("JSON parsing completed")
			from
				i := 1
			until
				i > grid.row_count
			loop
				r := grid.row (i)
				if r.is_expandable then
					r.expand
				end
				i := i + 1
			end

			from
			until
				tags_row_index.is_empty
			loop
				r := grid.row (tags_row_index.item)
				r.set_background_color (non_closed_color)
				tags_row_index.remove
			end
		end

feature -- Constants

	json_object_type: NATURAL_8 = 1
	json_array_type: NATURAL_8 = 2

feature -- Visitor Pattern

	visit_json_array (a_json_array: JSON_ARRAY)
			-- Visit `a_json_array'.
		local
			i: INTEGER
		do
			across
				a_json_array as c
			loop
				i := i + 1
				visit_json_item ("[" + i.out + "]", c.item, json_array_type)
			end
		end

	visit_json_object (a_json_object: JSON_OBJECT)
			-- Visit `a_json_object'.
		do
			across
				a_json_object as c
			loop
				--				c.item.accept (Current)
				visit_json_item (c.key, c.item, json_object_type)
			end
		end

	visit_json_item (a_key: JSON_STRING; a_value: JSON_VALUE; a_parent_type: NATURAL_8)
		local
			r: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
		do
			current_depth := current_depth + 1
			r := next_row
			lab := new_key_label (a_key.unescaped_string_32)
			lab.set_right_border (3)
			r.set_item (1, lab)

			lab.set_foreground_color (key_color)
			if a_parent_type = json_array_type then
				lab.set_foreground_color (info_color)
			end

			if attached {JSON_OBJECT} a_value as jo then
				if a_parent_type /= json_array_type then
					lab.set_foreground_color (key_color)
				end
				lab := new_object_label ("Object {" + jo.count.out + "}")
				if attached object_pixmap as obj_pix then
					lab.set_pixmap (obj_pix)
				end

				r.set_item (2, lab)
				jo.accept (Current)

			elseif attached {JSON_ARRAY} a_value as ja then
				lab.set_foreground_color (key_color)
				lab := new_array_label ("Array [" + ja.count.out + "]")
				if attached array_pixmap as arr_pix then
					lab.set_pixmap (arr_pix)
				end

				r.set_item (2, lab)

				ja.accept (Current)
			else
				if attached {JSON_STRING} a_value as js then
					lab := new_string_value_label (js, r)
				elseif attached {JSON_NUMBER} a_value as jnum then
					lab := new_value_label (jnum.item)
				elseif attached {JSON_BOOLEAN} a_value as jbool then
					lab := new_value_label (jbool.item.out.as_lower)
				else
					lab := new_value_label ("Null")
				end
				r.set_item (2, lab)
				if lab.text.occurrences ('%N') > 1 then
					r.set_height (value_font.string_size (lab.text).height)
				end
			end
			current_depth := current_depth - 1
		end

	visit_json_boolean (a_json_boolean: JSON_BOOLEAN)
			-- Visit `a_json_boolean'.
		do
		end

	visit_json_null (a_json_null: JSON_NULL)
			-- Visit `a_json_null'.
		do
		end

	visit_json_number (a_json_number: JSON_NUMBER)
			-- Visit `a_json_number'.
		do
		end

	visit_json_string (a_json_string: JSON_STRING)
			-- Visit `a_json_string'.

		do
		end

	on_error (a_message: READABLE_STRING_32)
		local
			r: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
		do
			log ({STRING_32} "JSON Error: " + a_message)
			current_depth := current_depth + 1
			r := next_row
			lab := new_error_label ("Error")

			r.set_item (1, lab)
			create lab.make_with_text (a_message)
			r.set_item (2, lab)
			r.set_background_color (non_closed_color)
			current_depth := current_depth - 1
		end

feature -- Properties

	build_pixmaps
		local
			bg: EV_COLOR
			ft: EV_FONT
			w,h: INTEGER
		do
			w := 10
			h := 12

			create ft
			ft.set_height_in_points (7)
			ft.set_weight ({EV_FONT_CONSTANTS}.weight_thin)
			create bg.make_with_8_bit_rgb (255, 255, 255)

--			object_pixmap := new_pixmap ("{..}", w, h, key_color, bg, ft)
--			array_pixmap := new_pixmap ("[..]", w, h, key_color, bg, ft)
			string_pixmap := new_pixmap ("String", w, h, key_color, bg, ft)
			error_pixmap := new_pixmap ("Error", w, h, error_color, bg, ft)
			info_pixmap := new_pixmap ("(i)", w, h, info_color, bg, ft)
		end

	new_pixmap (a_text: STRING; w,h: INTEGER; fg,bg: detachable EV_COLOR; ft: EV_FONT): EV_PIXMAP
		local
			sw, tw: INTEGER
			l_fg: EV_COLOR
		do
			sw := ft.string_width (a_text)
			tw := (sw + 4).max (w)

			create Result.make_with_size (tw, h)
			l_fg := Result.foreground_color

			Result.set_font (ft)
			Result.clear
			if bg /= Void then
				Result.set_foreground_color (bg)
				Result.set_background_color (bg)
			end
			Result.fill_rectangle (0, 0, tw, h)
			if fg /= Void then
				Result.set_foreground_color (fg)
			else
				Result.set_foreground_color (l_fg)
			end
			Result.draw_text_top_left ((tw - sw) // 2, 0, a_text)
		end

	object_pixmap: detachable EV_PIXMAP
			-- Pixmap for tag

	key_pixmap: detachable EV_PIXMAP
			-- Pixmap for key

	array_pixmap: detachable EV_PIXMAP
			-- Pixmap for Array

	string_pixmap: detachable EV_PIXMAP
			-- Pixmap for string value

	error_pixmap: detachable EV_PIXMAP
			-- Pixmap for error	

	info_pixmap: detachable EV_PIXMAP
			-- Pixmap for information

feature -- Change pixmaps

	set_object_pixmap (p: like object_pixmap)
			-- Set Pixmap for tag
		do
			object_pixmap := p
		end

	set_key_pixmap (p: like key_pixmap)
			-- Set Pixmap for attribute
		do
			key_pixmap := p
		end

	set_array_pixmap (p: like array_pixmap)
			-- Set Pixmap for attribute
		do
			array_pixmap := p
		end

	set_string_pixmap (p: like string_pixmap)
			-- Set Pixmap for string
		do
			string_pixmap := p
		end

	set_error_pixmap (p: like error_pixmap)
			-- Set Pixmap for error	
		do
			error_pixmap := p
		end

	set_info_pixmap (p: like info_pixmap)
			-- Set Pixmap for information
		do
			info_pixmap := p
		end

feature {NONE} -- Grid event

	is_file_dropping_enabled: BOOLEAN

	files_dropped (files: LIST [STRING_32])
			-- If ever you drop an 'xml' file inside the grid
		do
			if is_file_dropping_enabled then
				load_file (files.first)
			end
		end

	on_row_selected (r: EV_GRID_ROW)
		local
			i: INTEGER
		do
			colorize_row (r, True)
			if r.subrow_count > 0 then
				from
					i := 1
				until
					i > r.subrow_count
				loop
					on_row_selected (r.subrow (i))
					i := i + 1
				end
			end
		end

	on_row_deselected (r: EV_GRID_ROW)
		local
			i: INTEGER
		do
			if r.subrow_count > 0 then
				from
					i := 1
				until
					i > r.subrow_count
				loop
					on_row_deselected (r.subrow (i))
					i := i + 1
				end
			end
			colorize_row (r, False)
		end

feature {NONE} -- Row management

	new_key_label (t: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
		do
			create Result.make_with_text (t)
			Result.set_foreground_color (key_color)
			if attached key_pixmap as pix then
				Result.set_pixmap (pix)
			end
			Result.set_font (key_font)
		end

	new_object_label (t: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
			--
		do
			create Result.make_with_text (t)
			Result.set_foreground_color (info_color)
			if attached object_pixmap as pix then
				Result.set_pixmap (pix)
			end
			Result.set_font (info_font)
		end

	new_array_label (t: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
			--
		do
			create Result.make_with_text (t)
			Result.set_foreground_color (info_color)
			if attached array_pixmap as pix then
				Result.set_pixmap (pix)
			end
			Result.set_font (info_font)
		end

	new_string_value_label (js: JSON_STRING; r: EV_GRID_ROW): EV_GRID_LABEL_ITEM
		local
			lab: EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM
		do
			create lab.make_with_text (js.unescaped_string_32)
			lab.set_font (value_font)
			if attached string_pixmap as pix then
				lab.set_pixmaps_on_right_count (1)
				lab.put_pixmap_on_right (pix, 1)
--				Result.set_pixmap (pix)
			end
			Result := lab
			Result.set_foreground_color (string_value_color)
			Result.pointer_double_press_actions.extend (agent safe_view_multiple_lines_string (Result, js, ?,?,?,?,?,?,?,?))
		end

	new_value_label (t: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
			--
		do
			create Result.make_with_text (t)
			Result.set_font (value_font)
			Result.set_foreground_color (value_color)
		end

	new_info_label (t: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
			--
		do
			create Result.make_with_text (t)
			Result.set_foreground_color (info_color)
			if attached info_pixmap as pix then
				Result.set_pixmap (pix)
			end
		end

	new_error_label (t: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
			--
		do
			create Result.make_with_text (t)
			Result.set_foreground_color (error_color)
			if attached error_pixmap as pix then
				Result.set_pixmap (pix)
			end
		end

	last_row: EV_GRID_ROW
		do
			Result := grid.row (grid.row_count)
		end

	new_child: EV_GRID_ROW
		local
			r: EV_GRID_ROW
		do
			if grid.row_count = 0 then
				grid.insert_new_row (1)
			else
				r := last_row
				r.insert_subrow (r.subrow_count + 1)
			end
			Result := last_row
		end

	new_row: EV_GRID_ROW
		do
			if grid.row_count = 0 then
				grid.insert_new_row (1)
			elseif attached last_row.parent_row as p then
				p.insert_subrow (p.subrow_count + 1)
			else
				grid.insert_new_row (grid.row_count + 1)
			end
			Result := last_row
		end

	new_parent_row (n: INTEGER): EV_GRID_ROW
		local
			i: INTEGER
			p: detachable EV_GRID_ROW
			r: EV_GRID_ROW
		do
			if grid.row_count = 0 then
				grid.insert_new_row (1)
			else
				r := last_row
				from
					p := r.parent_row
					i := n + 1
				until
					i <= 1 or p = Void
				loop
					p := p.parent_row
					i := i - 1
				end
				if p /= Void then
					p.insert_subrow (p.subrow_count + 1)
				else
					grid.insert_new_row (grid.row_count + 1)
				end
			end
			Result := last_row
		end

	last_depth, current_depth: INTEGER

	next_row: EV_GRID_ROW
		do
			if current_depth > last_depth then
				last_depth := last_depth + 1
				Result := new_child
			elseif current_depth = last_depth then
				Result := new_row
			else
				Result := new_parent_row (last_depth - current_depth)
				last_depth := current_depth
			end
			colorize_row (Result, False)
		end

feature -- Grid behavior

	safe_view_multiple_lines_string (gi: EV_GRID_ITEM; js: JSON_STRING; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Activate `gi` if possible.
		local
			vb: EV_VERTICAL_BOX
			dlg: EV_DIALOG
			txt: EV_TEXT
			but: EV_BUTTON
			bgcolor: EV_COLOR
		do
				-- We need to protect the case when `gi' has already been deactivated.
			if
				a_button = {EV_POINTER_CONSTANTS}.left and then
				not gi.is_destroyed and then
				gi.is_parented
			then
				create dlg.make_with_title ("View text")
				create vb
				dlg.extend (vb)
				vb.set_border_width (3)
				vb.set_padding_width (3)
				create txt.make_with_text (js.unescaped_string_32)
				bgcolor := txt.background_color
				txt.disable_edit
				txt.set_background_color (bgcolor)
				vb.extend (txt)
				create but.make_with_text_and_action ("Close", agent dlg.destroy)
				vb.extend (but)
				vb.disable_item_expand (but)
				dlg.set_size (300, 200)
				if attached helpers.widget_top_level_window (widget) as win then
					dlg.show_modal_to_window (win)
				else
					dlg.show
				end
			end
		end

	safe_activate_editing (gi: EV_GRID_ITEM; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Activate `gi` if possible.
			--| Note: this is used to enter editing mode on `gi` when double-clicking on associated label item.
		do
				-- We need to protect the case when `gi' has already been deactivated.
			if
				a_button = {EV_POINTER_CONSTANTS}.left and then
				not gi.is_destroyed and then
				gi.is_parented
			then
				gi.activate
			end
		end

feature -- Colors

	init_colors
		do
			create key_color.make_with_8_bit_rgb (0, 0, 128)
			create string_value_color.make_with_8_bit_rgb (115, 85, 0)
			create value_color.make_with_8_bit_rgb (128, 0, 255)
			create error_color.make_with_8_bit_rgb (255, 0, 0)
			create info_color.make_with_8_bit_rgb (128, 0, 0)
		end

	key_color, string_value_color, value_color: EV_COLOR

	info_color,	error_color: EV_COLOR

feature -- Change color

	set_key_color (c: like key_color)
		do
			key_color := c
		end

	set_string_value_color (c: like string_value_color)
		do
			string_value_color := c
		end

	set_value_color (c: like value_color)
		do
			value_color := c
		end

	set_info_color (c: like info_color)
		do
			info_color := c
		end

	set_error_color (c: like error_color)
		do
			error_color := c
		end

feature {NONE} -- Style management

	colorize_row (r: EV_GRID_ROW; is_selected: BOOLEAN)
		local
			bg: detachable EV_COLOR
		do
			bg := r.background_color
			if is_selected then
				if bg = Void or else not bg.is_equal (non_closed_color) then
					r.set_background_color (selected_row_colors [r.index \\ 2])
				end
			else
				if bg = Void or else not bg.is_equal (non_closed_color) then
					r.set_background_color (row_colors [r.index \\ 2])
				end
			end
		end

	build_resources
		local
			c: EV_COLOR
		do
			create c.make_with_8_bit_rgb (240, 255, 240)
			create selected_row_colors.make_filled (c, 2)
			selected_row_colors.put (create {EV_COLOR}.make_with_8_bit_rgb (225, 255, 225), 1)

			create c.make_with_8_bit_rgb (255, 255, 255)
			create row_colors.make_filled (c, 2)
			row_colors.put (create {EV_COLOR}.make_with_8_bit_rgb (245, 245, 245), 1)

			create non_closed_color.make_with_8_bit_rgb (255, 220, 220)

			create info_font
			info_font.set_shape ({EV_FONT_CONSTANTS}.shape_italic)

			create key_font
			create value_font
		end

	selected_row_colors: SPECIAL [EV_COLOR]

	row_colors: SPECIAL [EV_COLOR]

	non_closed_color: EV_COLOR

	key_font: EV_FONT

	value_font: EV_FONT

	info_font: EV_FONT

invariant

	selected_row_colors_not_void: selected_row_colors /= Void
	row_colors_not_void: row_colors /= Void
	non_closed_color_not_void: non_closed_color /= Void
	key_font_not_void: key_font /= Void
	info_font_not_void: info_font /= Void
	value_font_not_void: value_font /= Void

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
