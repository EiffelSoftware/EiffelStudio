indexing
	description: "The class that represents the help-topic structure"
	author: "Vincent Brendel"

class
	E_DOCUMENT

creation
	make_from_xml_tree,
	make_from_file_name

feature

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
		end

	make_from_file_name(file_name:FILE_NAME) is
			-- Create this topic from a file
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

	create_tree(tree:EV_TREE; com:E_TOPIC_SELECT_COMMAND) is
			-- Fills the tree with the document structure.
		do
			topic.create_tree_item(tree, com)
		end

	initialize_sorted_list is
			-- Puts all topics in a sorted list.
		do
			create all_topics.make
			topic.add_to_list(all_topics)
			all_topics.sort
		end

	initialize_hash_table is
			-- Puts all topics in a hashtable with ID as key.
		do
			create topic_lookup.make(0)
			topic.add_to_hash_table(topic_lookup)
		end

	create_sorted_indexes(list: EV_LIST; com: E_TOPIC_SELECT_COMMAND) is
		local
			li: EV_LIST_ITEM
			arg: EV_ARGUMENT1[E_TOPIC]
		do
			from
				all_topics.start
			until
				all_topics.after
			loop
				create li.make_with_text(list, all_topics.item.id)
				create arg.make(all_topics.item)
				li.add_select_command(com, arg)
				all_topics.forth
			end
		end

feature -- Access

	topic: E_TOPIC

	all_topics: SORTED_TWO_WAY_LIST[E_TOPIC]

	topic_lookup: HASH_TABLE[E_TOPIC, STRING]

invariant
	must_contain_topic: topic /= Void
	sorted_list_exists: all_topics /= Void

end -- class E_DOCUMENT
