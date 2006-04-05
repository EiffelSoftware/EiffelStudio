indexing
	description: "One paragraph of marked-up text"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel"

class
	E_TEXT

inherit
	FACILITIES

create
	make_from_xml_tree

feature -- Initialization

	make_from_xml_tree (node: XML_ELEMENT) is
			-- Initialize
		require
			not_void: node /= Void
		local
			empty:E_TEXT_PART
		do
			create empty.make_empty
			create text_parts.make
			create_list(node, empty)
		end

	create_list(node:XML_ELEMENT; cur_part:E_TEXT_PART) is
			-- Recursively build the list.
		require
			node_exists: node /= Void
			cur_part_exists: cur_part /= Void
		local
			node_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			c_item: XML_TEXT
			item: XML_ELEMENT
			tag, s: STRING
			temp, cr: E_TEXT_PART
		do
			from
				node_cursor := node.new_cursor
				node_cursor.start
			until
				node_cursor.after
			loop
				c_item ?= node_cursor.item
				if c_item /= Void then
					create temp.make_from_other(cur_part)
					s := clone(c_item.string)
					s.prune_all('%N')
					if not s.empty then
						temp.set_text(s)
						text_parts.extend(temp)
					end
				else
					item ?= node_cursor.item
					if item /= Void then
						tag := item.name
						if tag.is_equal(bold_tag) then
							create temp.make_from_other(cur_part)
							temp.set_bold(true)
							create_list(item, temp)
						elseif tag.is_equal(italics_tag) then
							create temp.make_from_other(cur_part)
							temp.set_italic(true)
							create_list(item, temp)
						elseif tag.is_equal(underlined_tag) then
							create temp.make_from_other(cur_part)
							temp.set_underline(true)
							create_list(item, temp)
						elseif tag.is_equal(list_tag) then
							cr := get_line_break_indent(cur_part.list_depth)
							create temp.make_from_other(cur_part)
							temp.set_list_depth(temp.list_depth+1)
							create_list(item, temp)
							text_parts.extend (cr)
						elseif tag.is_equal(list_item_tag) then
							cr := get_line_break_indent(cur_part.list_depth)
							cr.set_bullet(true)
							text_parts.extend(cr)
							create_list(item, cur_part)
						elseif tag.is_equal(line_break_tag) then
							cr := get_line_break_indent(cur_part.list_depth)
							text_parts.extend(cr)
							create_list(item, cur_part)
						elseif tag.is_equal(anchor_tag) then
							create temp.make_from_other(cur_part)
							if item.attributes.has(anchor_topic_id_attr) then
								temp.set_font_color_by_string("link")
								temp.set_hyperlink(item.attributes.item(anchor_topic_id_attr).value)
							end
							create_list(item, temp)
						elseif tag.is_equal(font_tag) then
							create temp.make_from_other(cur_part)
							if item.attributes.has(font_name_attr) then
								temp.set_font_name(item.attributes.item(font_name_attr).value)
							end
							if item.attributes.has(font_color_attr) then
								temp.set_font_color_by_string(item.attributes.item(font_color_attr).value)
							end
							if item.attributes.has(font_size_attr) then
								temp.set_font_size(item.attributes.item(font_size_attr).value.to_integer)
							end
							create_list(item, temp)
						elseif tag.is_equal(keyword_tag) then
							create temp.make_from_other(cur_part)
							temp.set_important(true)
							create_list(item, temp)
						end
					end
				end
				node_cursor.forth
			end
		end

	get_line_break_indent (depth: INTEGER): E_TEXT_PART is
		do
			create Result.make_empty
			Result.set_list_depth (depth)
			Result.set_line_break (True)
			Result.set_text ("")
		end

feature -- Display

	display(area: E_TOPIC_DISPLAY) is
			-- Output un-marked-up text on 'area'.
		require
			not_void: area /= Void
		do
			from
				text_parts.start
			until
				text_parts.after
			loop
				text_parts.item.display(area)
				text_parts.forth
			end
		end

feature -- Access

	text_parts: LINKED_LIST[E_TEXT_PART]
		-- The paragraph divided in parts with the same attributes.

invariant
	text_exists: text_parts /= Void

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
end -- class E_TEXT
