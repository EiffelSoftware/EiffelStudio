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
			tag: STRING
			temp:E_TEXT_PART
			color: EV_COLOR
		do
			from
				node_cursor := node.new_cursor
				node_cursor.start
			until
				node_cursor.after
			loop
				c_item ?= node_cursor.item
				if c_item /= Void then
					-- We have character data.
					-- Make copy and set the text.
					create temp.make_from_other(cur_part)
					temp.set_text(c_item.string)
					text_parts.extend(temp)
					cur_part.set_bullet(false)
					cur_part.set_line_break(false)
				else
					item ?= node_cursor.item
					if item /= Void then
						-- We have a tag.
						-- Make copy and apply the tag.

						create temp.make_from_other(cur_part)
						tag := item.name
						if tag.is_equal("B") then
							temp.set_bold(true)
						elseif tag.is_equal("I") then
							temp.set_italic(true)
						elseif tag.is_equal("B") then
							temp.set_bold(true)
						elseif tag.is_equal("UL") then
							temp.set_list_depth(temp.list_depth+1)
						elseif tag.is_equal("LI") then
							temp.set_bullet(true)
							temp.set_line_break(true)
						elseif tag.is_equal("BR") then
							temp.set_line_break(true)
						elseif tag.is_equal("A") then
							if item.attributes.has("TOPIC_ID") then
								-- To make clear that it is a link,
								-- we use a nice color.
								create color.make_rgb(255,0,0)
								temp.set_font_color(color)
								temp.set_hyperlink(item.attributes.item("TOPIC_ID").value)
							end
						elseif tag.is_equal("FONT") then
							if item.attributes.has("NAME") then
								temp.set_font_name(item.attributes.item("NAME").value)
							end
							if item.attributes.has("COLOR") then
								-- TODO: Convert color-string to RGB values.
								create color.make_rgb(255,0,255)
								temp.set_font_color(color)
							end
							if item.attributes.has("SIZE") then
								temp.set_font_size(item.attributes.item("SIZE").value.to_integer)
							end
						elseif tag.is_equal("IMP") then
							temp.set_important(true)
						end
						if item.is_empty then
							temp.set_text("")
							text_parts.extend(temp)
						end
						create_list(item, temp)
					end
				end
				node_cursor.forth
			end
		end

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
