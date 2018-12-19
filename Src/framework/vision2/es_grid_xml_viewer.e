note
	description: "Component to display valid XML in GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRID_XML_VIEWER

inherit
	XML_CALLBACKS

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
			grid.set_separator_color (create {EV_COLOR}.make_with_8_bit_rgb (180,180,180))
			grid.enable_column_separators
			grid.disable_row_height_fixed

			grid.set_column_count_to (2)
			grid.column (1).set_title ("Nodes")
			grid.column (2).set_title ("Values")

			init_colors

			widget.extend (grid)
			create status_label
			widget.extend (status_label)
			status_label.set_minimum_width (10)
			widget.disable_item_expand (status_label)

			grid.row_select_actions.extend (agent on_row_selected)
			grid.row_deselect_actions.extend (agent on_row_deselected)
		end

	status_label: EV_LABEL
			-- Label used to display parsing status.

	grid: ES_GRID
			-- Grid to display XML tree.

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

	load_xml_string (s: READABLE_STRING_GENERAL)
		do
			grid.set_row_count_to (0)
			if s /= Void and then not s.is_empty then
				build_xml_parser
				if attached xml_parser as p then
					p.parse_from_string (s)
				else
					check xml_parser_built: False end
				end
			end
			update_columns
		end

	load_xml_file (fn: READABLE_STRING_GENERAL)
			--
		local
			f: RAW_FILE
		do
			grid.set_row_count_to (0)
			create f.make_with_name (fn)
			if f.exists and then f.is_readable then
				build_xml_parser
				if attached xml_parser as p then
					p.parse_from_path (f.path)
				else
					check xml_parser_built: False end
				end
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

feature {NONE} -- Xml parser implementation

	xml_parser: detachable XML_PARSER
			-- XML parser.

	build_xml_parser
			-- Build `xml_parser`.
		local
			p: like xml_parser
		do
			if not attached xml_parser then
				p := (create {XML_PARSER_FACTORY}).new_parser
				p.set_callbacks (Current)
				xml_parser := p
			end
		ensure
			xml_parser_built: xml_parser /= Void
		end

feature {NONE} -- xml callbacks

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
			log ("Start XML parsing")
		end

	on_finish
		local
			r: EV_GRID_ROW
			i: INTEGER
		do
			log ("XML parsing completed")
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

	on_xml_declaration (a_version: READABLE_STRING_32; an_encoding: detachable READABLE_STRING_32; a_standalone: BOOLEAN)
		local
			r: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
		do
			log ("XML declaration")
			current_depth := current_depth + 1

			r := next_row
			lab := new_info_label ("Version")
			r.set_item (1, lab)
			create lab.make_with_text (a_version)
			r.set_item (2, lab)

			if an_encoding /= Void then
				r := next_row
				lab := new_info_label ("Encoding")
				r.set_item (1, lab)
				create lab.make_with_text (an_encoding)
				r.set_item (2, lab)
			end
			if a_standalone then
				r := next_row
				lab := new_info_label ("Standalone")
				r.set_item (1, lab)
				create lab.make_with_text ("True")
				r.set_item (2, lab)
			end
			current_depth := current_depth - 1
		end

	on_error (a_message: READABLE_STRING_32)
		local
			r: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
		do
			log ({STRING_32} "XML Error: " + a_message)
			current_depth := current_depth + 1
			r := next_row
			lab := new_error_label ("Error")

			r.set_item (1, lab)
			create lab.make_with_text (a_message)
			r.set_item (2, lab)
			r.set_background_color (non_closed_color)
			current_depth := current_depth - 1
		end

	on_processing_instruction (a_name: READABLE_STRING_32; a_content: READABLE_STRING_32)
		local
			s: STRING_32
			r: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
		do
			current_depth := current_depth + 1
			r := next_row
			lab := new_info_label ("Instruction")
			r.set_item (1, lab)
			create s.make_from_string (a_name)
			s.append_string_general ("=%"")
			s.append_string_general (a_content)
			s.append_string_general ("%"")
			create lab.make_with_text (s)
			r.set_item (2, lab)

			current_depth := current_depth - 1
		end

	on_comment (a_content: READABLE_STRING_32)
		local
			r: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
		do
			current_depth := current_depth + 1
			r := next_row
			lab := new_info_label ("Comment")
			r.set_item (1, lab)
			create lab.make_with_text (a_content)
			r.set_item (2, lab)
			current_depth := current_depth - 1
		end

	on_start_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
		local
			s: STRING_32
			lab: EV_GRID_LABEL_ITEM
			r: EV_GRID_ROW
		do
			current_depth := current_depth + 1
			create s.make_empty
			if a_namespace /= Void then
				s.append_string (a_namespace)
				s.append_character (':')
			end
			s.append_string (a_local_part)
			if a_prefix /= Void then
				s.prepend_character ('-')
				s.prepend_string (a_prefix)
			end
			log ({STRING_32} "XML Tag: " + s)
			lab := new_tag_label (s)

			r := next_row
			r.set_item (1, lab)

			r.set_item (2, create {EV_GRID_ITEM})
			tags_row_index.put (grid.row_count)
		end

	on_attribute (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32; a_value: READABLE_STRING_32)
		local
			s: STRING_32
			r: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
		do
			current_depth := current_depth + 1
			create s.make_empty
			if a_namespace /= Void then
				s.append_string (a_namespace)
				s.append_character (':')
			end
			s.append_string (a_local_part)
			if a_prefix /= Void then
				s.prepend_character ('-')
				s.prepend_string (a_prefix)
			end
			log ({STRING_32} "XML Attribute: " + s)
			s.append_character ('=')
			r := next_row
			create lab.make_with_text (s)
			lab.set_foreground_color (attribute_color)
			if attached attribute_pixmap as att_pix then
				lab.set_pixmap (att_pix)
			end

			lab.align_text_right
			lab.set_right_border (3)
			r.set_item (1, lab)

			lab := new_value_label (a_value)
			r.set_item (2, lab)
			current_depth := current_depth - 1
		end

	on_start_tag_finish
			-- End of start tag.
		do
			last_content := Void
		end

	on_end_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
		local
			r: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
		do
				--| Process Content
			if attached last_content as l_last_content then
				current_depth := current_depth + 1
				r := next_row
				lab := new_content_label ("Content")
				r.set_item (1, lab)

				lab := new_value_label (l_last_content)
				r.set_item (2, lab)
				if l_last_content.index_of ('%N', 1) > 0 then
					r.set_height (value_font.string_size (l_last_content).height)
				end
				current_depth := current_depth - 1

				last_content := Void
			end
				--| Process end of tag
			current_depth := current_depth - 1
			tags_row_index.remove
		end

	last_content: detachable STRING_32

	on_content (a_content: READABLE_STRING_32)
		do
			if attached last_content as t then
				t.append_string (a_content)
			else
				create last_content.make_from_string (a_content)
			end
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

			tag_pixmap := new_pixmap ("Tag", w, h, tag_color, bg, ft)
			attribute_pixmap := new_pixmap ("A", w, h, attribute_color, bg, ft)
			content_pixmap := new_pixmap ("#", w, h, content_color, bg, ft)
			error_pixmap := new_pixmap ("E", w, h, error_color, bg, ft)
			info_pixmap := new_pixmap ("i", w, h, info_color, bg, ft)
		end

	new_pixmap (a_text: STRING; w,h: INTEGER; fg, bg: EV_COLOR; ft: EV_FONT): EV_PIXMAP
		local
			sw, tw: INTEGER
		do
			sw := ft.string_width (a_text)
			tw := (sw + 4).max (w)

			create Result.make_with_size (tw, h)
			Result.set_font (ft)
			Result.set_foreground_color (fg)
			Result.set_background_color (bg)
			Result.clear
			Result.fill_rectangle (0, 0, tw, h)
			Result.set_foreground_color (bg)

			Result.draw_text_top_left ((tw - sw) // 2, 0, a_text)
		end

	tag_pixmap: detachable EV_PIXMAP
			-- Pixmap for tag

	attribute_pixmap: detachable EV_PIXMAP
			-- Pixmap for attribute

	content_pixmap: detachable EV_PIXMAP
			-- Pixmap for attribute

	error_pixmap: detachable EV_PIXMAP
			-- Pixmap for error	

	info_pixmap: detachable EV_PIXMAP
			-- Pixmap for information

feature -- Change pixmaps

	set_tag_pixmap (p: like tag_pixmap)
			-- Set Pixmap for tag
		do
			tag_pixmap := p
		end

	set_attribute_pixmap (p: like attribute_pixmap)
			-- Set Pixmap for attribute
		do
			attribute_pixmap := p
		end

	set_content_pixmap (p: like content_pixmap)
			-- Set Pixmap for attribute
		do
			content_pixmap := p
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
				load_xml_file (files.first)
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

	new_tag_label (t: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
			--
		do
			create Result.make_with_text (t)
			Result.set_foreground_color (tag_color)
			if attached tag_pixmap as pix then
				Result.set_pixmap (pix)
			end
			Result.set_font (tag_font)
		end

	new_attribute_label (t: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
			--
		do
			create Result.make_with_text (t)
			Result.set_foreground_color (attribute_color)
			if attached attribute_pixmap as pix then
				Result.set_pixmap (pix)
			end
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

	new_content_label (t: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
			--
		do
			create Result.make_with_text (t)
			Result.set_foreground_color (content_color)
			if attached content_pixmap as pix then
				Result.set_pixmap (pix)
			end
		end

	new_value_label (t: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
			--
		do
			create Result.make_with_text (t)
			Result.set_font (value_font)
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
			if grid.row_count > 0 and then attached last_row.parent_row as p then
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
--				p := r.parent_row
--				if p /= Void then
--					p := p.parent_row
--				end
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

feature -- Colors

	init_colors
		do
			create tag_color.make_with_8_bit_rgb (0, 0, 255)
			create attribute_color.make_with_8_bit_rgb (0, 128, 0)
			create info_color.make_with_8_bit_rgb (128, 0, 0)
			create content_color.make_with_8_bit_rgb (0, 0, 0)
			create error_color.make_with_8_bit_rgb (255, 0, 0)
		end

	tag_color: EV_COLOR

	attribute_color: EV_COLOR

	info_color: EV_COLOR

	content_color: EV_COLOR

	error_color: EV_COLOR

feature -- Change color

	set_tag_color (c: like tag_color)
		do
			tag_color := c
		end

	set_attribute_color (c: like attribute_color)
		do
			attribute_color := c
		end

	set_info_color (c: like info_color)
		do
			info_color := c
		end

	set_content_color (c: like content_color)
		do
			content_color := c
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

			create tag_font
			tag_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)

			create value_font
		end

	selected_row_colors: SPECIAL [EV_COLOR]

	row_colors: SPECIAL [EV_COLOR]

	non_closed_color: EV_COLOR

	tag_font: EV_FONT

	value_font: EV_FONT

invariant

	selected_row_colors_not_void: selected_row_colors /= Void
	row_colors_not_void: row_colors /= Void
	non_closed_color_not_void: non_closed_color /= Void
	tag_font_not_void: tag_font /= Void
	value_font_not_void: value_font /= Void

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
