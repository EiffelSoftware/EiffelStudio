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
			empty:LINKED_LIST[E_ATTRIBUTE]
		do
			create empty.make
			text_parts := create_list(node, empty)
		end

	create_list(node:XML_ELEMENT; cur_attribs:LINKED_LIST[E_ATTRIBUTE]):LINKED_LIST[E_TEXT_PART] is
			-- Recursively build the list.
		local
			node_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			c_item: XML_TEXT
			item: XML_ELEMENT
			new_part:E_TEXT_PART
			new_attrib:E_ATTRIBUTE
			nr_items:INTEGER
		do
			create Result.make
			from
				node_cursor := node.new_cursor
				node_cursor.start
			until
				node_cursor.after
			loop
				c_item ?= node_cursor.item
				if c_item /= Void then

					-- Current node is character data.
					-- use the current attributes to make a new
					-- text-part and add it to the end of the list.

					create new_part.make(c_item.out, cur_attribs)
					Result.extend(new_part)
				else
					item ?= node_cursor.item
					if item /= Void then

						-- It is a tag.
						-- Add the tag to the attribute-list,
						-- process the data under it,
						-- and remove it again.

						create new_attrib.make(item.name, item.attributes)
						nr_items := cur_attribs.count
						cur_attribs.put_front(new_attrib)
						Result.append(create_list(item, cur_attribs))
						cur_attribs.start
						cur_attribs.remove
						check
							nr_items = cur_attribs.count
						end
					end
				end
				node_cursor.forth
			end
		end

	display(area: E_TOPIC_DISPLAY) is
			-- Output un-marked-up text on 'area'.
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
		-- The paragraph divided in parts with the same
		-- attributes.

invariant
	text_exists: text_parts /= Void

end -- class E_TEXT
