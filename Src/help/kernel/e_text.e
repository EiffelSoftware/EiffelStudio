indexing
	description: "One paragraph of marked-up text"
	author: "Vincent Brendel"

class
	E_TEXT

creation
	make_from_xml_tree

feature -- Initialization

	make_from_xml_tree(node:XML_ELEMENT) is
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
			not_void: node /= Void and cur_part /= Void
		local
			node_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			c_item: XML_TEXT
			item: XML_ELEMENT
			tag, s: STRING
			temp, cr:E_TEXT_PART
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
						if tag.is_equal("B") then
							create temp.make_from_other(cur_part)
							temp.set_bold(true)
							create_list(item, temp)
						elseif tag.is_equal("I") then
							create temp.make_from_other(cur_part)
							temp.set_italic(true)
							create_list(item, temp)
						elseif tag.is_equal("B") then
							create temp.make_from_other(cur_part)
							temp.set_bold(true)
							create_list(item, temp)
						elseif tag.is_equal("UL") then
							cr := get_line_break(cur_part.list_depth)
							text_parts.extend(cr)
							create temp.make_from_other(cur_part)
							temp.set_list_depth(temp.list_depth+1)
							create_list(item, temp)
							text_parts.extend(cr)
							text_parts.extend(cr)
						elseif tag.is_equal("LI") then
							cr := get_line_break(cur_part.list_depth)
							cr.set_bullet(true)
							text_parts.extend(cr)
							create_list(item, cur_part)
						elseif tag.is_equal("BR") then
							cr := get_line_break(cur_part.list_depth)
							text_parts.extend(cr)
							create_list(item, cur_part)
						elseif tag.is_equal("A") then
							create temp.make_from_other(cur_part)
							if item.attributes.has("TOPIC_ID") then
								temp.set_font_color_by_string("link")
								temp.set_hyperlink(item.attributes.item("TOPIC_ID").value)
							end
							create_list(item, temp)
						elseif tag.is_equal("FONT") then
							create temp.make_from_other(cur_part)
							if item.attributes.has("NAME") then
								temp.set_font_name(item.attributes.item("NAME").value)
							end
							if item.attributes.has("COLOR") then
								temp.set_font_color_by_string(item.attributes.item("COLOR").value)
							end
							if item.attributes.has("SIZE") then
								temp.set_font_size(item.attributes.item("SIZE").value.to_integer)
							end
							create_list(item, temp)
						elseif tag.is_equal("IMP") then
							create temp.make_from_other(cur_part)
							temp.set_important(true)
							create_list(item, temp)
						end
					end
				end
				node_cursor.forth
			end
		end

	get_line_break(depth:INTEGER):E_TEXT_PART is
		do
			create Result.make_empty
			Result.set_list_depth(depth)
			Result.set_line_break(true)
			Result.set_text("")
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

end -- class E_TEXT
