indexing
	description: "The class that represents the help-topic structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel"

class
	E_DOCUMENT

inherit
	FACILITIES

feature -- Initialization

	initialized: BOOLEAN
			-- Have the properties of this class been initialized?
			-- This is to have invariants in this class.

	make_from_xml_tree (node :XML_ELEMENT; path: FILE_NAME) is
			-- Create the the document tree structure from XML-tree.
		require
			node_not_void: node /= Void
		local
			sub: XML_ELEMENT
			node_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			found: BOOLEAN
		do
			if node.name.is_equal(eiffel_document_tag) then
				from
					node_cursor := node.new_cursor
					node_cursor.start
				until
					found or else node_cursor.after
				loop
					sub ?= node_cursor.item
					if sub /= Void and then sub.name.is_equal(topic_tag) then
						create topic.make_from_xml_tree(sub, path)
						found := true
					end
					node_cursor.forth
				end
				if not found then
					warning("XML", "No " + topic_tag + " found", main_window)
				end
			else
				warning("XML", eiffel_document_tag+" missing", main_window)
			end
			initialize_sorted_list
			initialize_hash_table
			initialize_in_order_list
			initialized := True
		end

	make_from_file_name (file_name: FILE_NAME) is
			-- Create this topic from a file.
		require
			file_name_not_void: file_name /= Void
		local
			node: XML_ELEMENT
		do
			node := parse_xml_file (file_name)
			if node /= Void then
				make_from_xml_tree(node, file_name)
			end
		end

	initialize_sorted_list is
			-- Puts all topics in a sorted list.
		do
			create all_topics.make
			topic.add_to_list(all_topics)
			all_topics.sort
		end

	initialize_in_order_list is
			-- Puts all text-topics in a list.
		do
			create topics_in_order.make
			topic.add_to_in_order_list(topics_in_order)
		end

	initialize_hash_table is
			-- Puts all topics in a hashtable with ID as key.
		do
			create topic_lookup.make(0)
			topic.add_to_hash_table(topic_lookup)
		end

feature -- Miscellaneous

	create_tree(tree:EV_TREE) is
			-- Fills the tree with the document structure.
		require
			initialized
		do
			topic.create_tree_item(tree)
		end

	show_first_topic(list:EV_LIST; start_with:STRING) is
			-- Highlight the first topic that starts with the string in the text-field.
		require
			initialized
		local
			found:BOOLEAN
			front:STRING
			li: TOPIC_LIST_ITEM
		do
			start_with.to_upper
			from
				all_topics.start
			until
				found or else all_topics.after
			loop
				front := all_topics.item.id.substring(1,start_with.count)
				front.to_upper
				if front.is_equal(start_with) then
					found := true
				else
					all_topics.forth
				end
			end
			if found then
				li ?= list.find_item_by_data(all_topics.item)
				if li /= Void then
					li.set_selected(true)
					--li.set_selected(false)
				end
			end
		end

	get_topic_by_id(id:STRING):E_TOPIC is
			-- Use lookup table to get the topic by id.
		require
			id_valid: id /= Void and then not id.empty
		do
			if topic_lookup.has(id) then
				Result := topic_lookup.item(id)
			end
		end

	find_next_topic(top:E_TOPIC):E_TOPIC is
			-- Return the next topic with text in-order.
		require
			has_next_in_order(top)
		do
			from
				topics_in_order.start
			until
				Result /= Void or else topics_in_order.after
			loop
				if topics_in_order.item = top then
					topics_in_order.forth
					Result := topics_in_order.item
				else
					topics_in_order.forth
				end
			end
		end

	find_previous_topic(top:E_TOPIC):E_TOPIC is
			-- Return the previous topic with text in-order.
		require
			has_previous_in_order(top)
		local
			save:E_TOPIC
		do
			from
				topics_in_order.start
			until
				Result /= Void or else topics_in_order.after
			loop
				if topics_in_order.item = top then
					Result := save
				end
				save := topics_in_order.item
				topics_in_order.forth
			end
		end

	has_previous_in_order(top:E_TOPIC):BOOLEAN is
			-- Returns whether it is possible to go up in-order.
			-- If top does not contain text it is not possible to go up.
		do
			if top /= Void and then top.contains_text then
				Result := top /= topics_in_order.first
			end
		end

	has_next_in_order(top:E_TOPIC):BOOLEAN is
			-- Returns whether it is possible to go down in-order.
			-- If top does not contain text it is not possible to go down.
		do
			if top /= Void and then top.contains_text then
				Result := top /= topics_in_order.last
			end
		end

feature -- Currently not used.

	create_sorted_indexes(list: EV_LIST) is
			-- This is to put all topics in the list.
		local
			li: TOPIC_LIST_ITEM
		do
			from
				all_topics.start
			until
				all_topics.after
			loop
				create li.make_item(list, all_topics.item)
				all_topics.forth
			end
		end

feature -- Access

	topic: E_TOPIC
			-- The root topic of this document.

	all_topics: SORTED_TWO_WAY_LIST [E_TOPIC]
			-- A sorted list with all topics in it.

	topics_in_order: LINKED_LIST [E_TOPIC]
			-- A list with all text-topics in order.

	topic_lookup: HASH_TABLE [E_TOPIC, STRING]
			-- An easy way to find a topic by its 'id'.

invariant
	must_contain_topic: initialized implies topic /= Void
	sorted_list_exists: initialized implies all_topics /= Void

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
end -- class E_DOCUMENT
