indexing
	description: "Help topic class"
	author: "Vincent Brendel"

class
	E_TOPIC

inherit
	COMPARABLE

	FACILITIES
		undefine
			is_equal		
		end

creation
	make,
	make_from_xml_tree

feature

	make(new_id, new_head:STRING; new_location:FILE_NAME) is
			-- Not used.
		require
			id_not_empty: (new_id /= Void) and then (not new_id.empty)
			location_not_empty: (new_location /= Void) and then (not new_location.empty)
			head_not_empty: (new_head /= Void) and then (not new_head.empty)
		do
			id := new_id
			head := new_head
			location := new_location
		ensure
			id = new_id
			head = new_head
			location = new_location
		end

	make_from_xml_tree(node:XML_ELEMENT; path:FILE_NAME) is
			-- Create this topic from XML-tree.
		require
			node_not_void: node /= Void and path /= Void
		local
			sub: XML_ELEMENT
			c_item: XML_TEXT
			node_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			new_topic: E_TOPIC
			new_text: E_TEXT
		do
			location := path

			if node.attributes.has("LOCATION") then
				-- Topic is reference, so come back later.
				create location.make_from_string(node.attributes.item("LOCATION").value)
				id := "unknown" -- Unknown yet.
				make_from_file_name(location)
			else
				-- Get the ID
				if node.attributes.has("ID") then
					id := node.attributes.item("ID").value
				end

				-- Get the HEAD and either the subtopics or the text.
				from
					node_cursor := node.new_cursor
					node_cursor.start
				until
					node_cursor.after
				loop
					sub ?= node_cursor.item
					if sub /= Void then
						if sub.name.is_equal("HEAD") then
							c_item ?= sub.first
							head := c_item.string
						elseif sub.name.is_equal("TOPIC") then
							-- This is a topic with subtopics. There should be
							-- no TEXT tags...
							if contains_text then
								io.putstring("No subtopics in TEXT-topic")
							else
								if not contains_subtopics then
									create subtopics.make
								end
								create new_topic.make_from_xml_tree(sub,path)
								add_topic(new_topic)
							end
						elseif sub.name.is_equal("TEXT") then
							-- This is a topic with text. There should be
							-- no TOPIC tags...
							if contains_subtopics then
								io.putstring("No text in subtopic-topic")
							else
								if not contains_text then
									create paragraphs.make
								end
								create new_text.make_from_xml_tree(sub)
								add_paragraph(new_text)
							end
						end
					end
					node_cursor.forth
				end
			end
		end

	make_from_file_name(file_name:FILE_NAME) is
			-- Opens the XML file and calls 'make_from_xml_tree'.
		require
			file_name_not_void: file_name /= Void
		local
			file: RAW_FILE
			s: STRING
			parser: XML_TREE_PARSER
			node_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			doc: XML_ELEMENT
			err: BOOLEAN
		do
			if not err then
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
	
					-- Now find the first TOPIC-tag...
					if parser.root_element.name.is_equal("EIFFEL_DOCUMENT") then
						doc := find_first_node_with_tag("TOPIC", parser.root_element)
						if doc /= Void then
							make_from_xml_tree(doc, file_name)
						else
							head := "No TOPIC-tag found in: "+file_name
						end
					else
						head := "No EIFFEL_DOCUMENT-tag found in: "+file_name
					end
				else
					s:="The file " + file_name
					warning("File not found",s,main_window)
				end
			else
				s:="The file " + file_name
				warning("File not accesible",s,main_window)
			end
		rescue
			err := TRUE
			retry
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'? (comparable)
		local
			s,os: STRING
		do
			s := deep_clone(id)
			s.to_upper
			os := deep_clone(other.id)
			os.to_upper
			Result := s < os
		end

	find_first_node_with_tag(tag_name:STRING; node:XML_ELEMENT):XML_ELEMENT is
			-- Search this node for a node with tag_name.
		require
			not_void: tag_name /= Void and node /= VOid
		local
			node_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			found: BOOLEAN
			sub: XML_ELEMENT
		do
			from
				node_cursor := node.new_cursor
				node_cursor.start
			until
				found or else node_cursor.after
			loop
				sub ?= node_cursor.item
				if sub /= Void then
					if sub.name.is_equal(tag_name) then
						Result := sub
						found := true
					end
				end
				node_cursor.forth
			end
		end

	add_topic(new_topic:E_TOPIC) is
			-- Add a subtopic to the end of the subtopics list.
		require
			topic_not_void: new_topic /= Void
			is_subtopic_topic: contains_subtopics
		do
			subtopics.extend(new_topic)
		end

	add_paragraph(new_par:E_TEXT) is
			-- Add a paragraph to the end of the paragraph list.
		require
			new_par_not_void: new_par /= Void
			is_text_topic: contains_text
		do
			paragraphs.extend(new_par)
		end

	contains_text:BOOLEAN is
			-- Is this a topic with text?
		do
			Result := paragraphs /= Void
		end

	contains_subtopics:BOOLEAN is
			-- Is this a topic with subtopics?
		do
			Result := subtopics /= Void
		end

	create_tree_item(parent:EV_TREE_ITEM_HOLDER) is
			-- Make a TOPIC_TREE_ITEM.
		local
			item: TOPIC_TREE_ITEM
		do
			create item.make_item(parent, Current)
			if contains_subtopics then
				from
					subtopics.start
				until
					subtopics.after
				loop
					subtopics.item.create_tree_item(item)
					subtopics.forth
				end
			end
		end

	add_to_list(list: SORTED_TWO_WAY_LIST[E_TOPIC]) is
			-- Make sorted list.
		require
			not_void: list /= Void
		do
			list.extend(Current)
			if contains_subtopics then
				from
					subtopics.start
				until
					subtopics.after
				loop
					subtopics.item.add_to_list(list)
					subtopics.forth
				end
			end
		end

	add_to_in_order_list(list: LINKED_LIST[E_TOPIC]) is
			-- Make in-order list of text-topics.
		require
			not_void: list /= VOid
		do
			if contains_text then
				list.extend(Current)
			end
			if contains_subtopics then
				from
					subtopics.start
				until
					subtopics.after
				loop
					subtopics.item.add_to_in_order_list(list)
					subtopics.forth
				end
			end
		end

	add_to_hash_table(ht: HASH_TABLE[E_TOPIC,STRING]) is
			-- Make hashtable.
		require
			ht /= Void
		do
			ht.force(Current, Current.id)
			if contains_subtopics then
				from
					subtopics.start
				until
					subtopics.after
				loop
					subtopics.item.add_to_hash_table(ht)
					subtopics.forth
				end
			end
		end

feature {VIEWER_WINDOW} -- Display

	display(area: E_TOPIC_DISPLAY) is
			-- Output the text (if any) on 'area'.
		require
			not_void: area /= Void
		local
			temp: E_TEXT_PART
		do
			area.clear
			area.set_head_format
			area.set_text(head)
			area.line_break(0)
			if contains_text then
				from
					paragraphs.start
				until
					paragraphs.after
				loop
					area.line_break(0)
					paragraphs.item.display(area)
					paragraphs.forth
				end
			elseif contains_subtopics then
				create temp.make_empty
				temp.set_text("Make your choice:")
				temp.set_line_break(true)
				temp.display(area)
				from
					subtopics.start
				until
					subtopics.after
				loop
					create temp.make_empty
					area.line_break(1)
					temp.set_text(subtopics.item.id+" ("+subtopics.item.head+")")
					temp.set_hyperlink(subtopics.item.id)
					temp.set_bullet(true)
					temp.set_font_color_rgb(255,0,0)
					temp.display(area)
					subtopics.forth
				end
			end				
		end

feature -- Access

	id: STRING
			-- Topic identification string.

	head: STRING
			-- The title of this topic.

	location: FILE_NAME
			-- The file this topic is from.

	paragraphs: LINKED_LIST[E_TEXT]
			-- A list of all paragraphs in this topic.

	subtopics: LINKED_LIST[E_TOPIC]
			-- All the subtopics of this topic.

invariant
	must_have_id: (id /= Void) and then (not id.empty)
	must_have_location: (location /= Void) and then (not location.empty)
	must_have_head: (head /= Void) and then (not head.empty)
	topics_or_text: not (contains_text and contains_subtopics)

end -- class E_TOPIC
