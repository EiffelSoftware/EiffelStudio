indexing
	description: "The class that represents the help-topic structure"
	author: "Vincent Brendel"

class
	E_DOCUMENT

creation
	make

feature

	make is
			-- No initialization.
		do
		end

	make_from_xml_tree(node:XML_ELEMENT; path:FILE_NAME) is
			-- Create the the document tree structure from XML-tree.
		require
			node_not_void: node /= Void
		local
			sub: XML_ELEMENT
			node_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			found: BOOLEAN
		do
			if node.name.is_equal("EIFFEL_DOCUMENT") then
				from
					node_cursor := node.new_cursor
					node_cursor.start
				until
					found or else node_cursor.after
				loop
					sub ?= node_cursor.item
					if sub /= Void and then sub.name.is_equal("TOPIC") then
						create topic.make_from_xml_tree(sub, path)
						found := true
					end
					node_cursor.forth
				end
				if not found then
					io.putstring("No TOPIC found")
				end
			else
				io.putstring("EIFFEL_DOCUMENT missing")
			end
			initialize_sorted_list
			initialize_hash_table
			initialize_in_order_list
		end

	make_from_file_name(file_name:FILE_NAME) is
			-- Create this topic from a file.
		require
			file_name_not_void: file_name /= Void
		local
			file: RAW_FILE
			s: STRING
			parser: XML_TREE_PARSER
		do
			create parser.make 
			create file.make (file_name)
			if file.exists then
				file.open_read
				file.read_stream (file.count)
				create s.make(file.count)
				s.append (file.last_string)
				parser.parse_string(s)
				parser.set_end_of_file
				file.close
				make_from_xml_tree(parser.root_element, file_name)
			end
		end

	create_tree(tree:EV_TREE) is
			-- Fills the tree with the document structure.
		do
			topic.create_tree_item(tree)
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

	create_sorted_indexes(list: EV_LIST) is
			-- This is to put all topics in the list. Not used.
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

	show_first_topics(list:EV_LIST; nr:INTEGER; start_with:STRING) is
			-- Show the first 'nr' topics starting with the one that starts with something.
		local
			n:INTEGER
			found:BOOLEAN
			front:STRING
			li: TOPIC_LIST_ITEM
		do
			list.clear_items
			start_with.to_upper
			from
				n := 0
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
				from
					n := 0
				until
					n >= nr or else all_topics.after
				loop
					create li.make_item(list, all_topics.item)
					n := n + 1
					all_topics.forth
				end
			end
		end

	get_topic_by_id(id:STRING):E_TOPIC is
			-- use lookup table to get the topic by id.
		do
			if topic_lookup.has(id) then
				Result := topic_lookup.item(id)
			end
		end

	find_next_topic(top:E_TOPIC):E_TOPIC is
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
		do
			if top /= Void and then top.contains_text then
				Result := top /= topics_in_order.first
			end
		end

	has_next_in_order(top:E_TOPIC):BOOLEAN is
		do
			if top /= Void and then top.contains_text then
				Result := top /= topics_in_order.last
			end
		end

feature -- Access

	topic: E_TOPIC
			-- The root topic of this document.

	all_topics: SORTED_TWO_WAY_LIST[E_TOPIC]
			-- A sorted list with all topics in it.

	topics_in_order: LINKED_LIST[E_TOPIC]
			-- A list with all text-topics in order.

	topic_lookup: HASH_TABLE[E_TOPIC, STRING]
			-- An easy way to find a topic by its 'id'.

invariant
	--must_contain_topic: topic /= Void
	--sorted_list_exists: all_topics /= Void

end -- class E_DOCUMENT
