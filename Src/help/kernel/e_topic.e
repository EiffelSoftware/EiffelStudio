indexing
	description: "Help topic class. A topic can either contain text or subtopics."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

feature -- Initialization

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

	make_from_xml_tree (node: XML_ELEMENT; path: FILE_NAME) is
			-- Create this topic from XML-tree.
		require
			node_exists: node /= Void
			path_exists: path /= Void
		local
			sub: XML_ELEMENT
			c_item: XML_TEXT
			node_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			new_topic: E_TOPIC
			new_text: E_TEXT
			resolved, error: BOOLEAN
			new_loc: STRING
			new_node: XML_ELEMENT
		do
			from
				location := path
				sub := node
			until
				sub = Void or else not sub.attributes.has (topic_location_attr)
			loop
				if sub.attributes.has (topic_location_attr) then
					new_loc := clone(sub.attributes.item (topic_location_attr).value)
					transform_relative_path (path, new_loc)
					sub := get_topic_node_from_file (new_loc)
					if sub /= Void then
						create location.make_from_string (new_loc)
					end
				end
			end
			if sub /= Void then
				if sub.attributes.has("ID") then
					id := sub.attributes.item("ID").value
					-- There are no checks here yet.
					-- Checks are performed at the end of this routine.
				end

				from
					node_cursor := sub.new_cursor
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
			else
				warning ("XML", "Unable to solve location of external topic.", main_window)
				create location.make_from_string("<error>")
				--! FIXME Exit application?
			end
			if id = Void then
				warning ("XML", "A topic must always have an ID.", main_window)
				id := "Missing ID"
			end
			if head = Void then
				warning ("XML", "A topic must always have a head.", main_window)
				head := "Missing HEAD"
			end
			if not contains_text and then not contains_subtopics then
				warning ("XML", "Encountered an empty topic.", main_window)
			end
		end

	get_topic_node_from_file (fn: STRING): XML_ELEMENT is
			-- Open file `fn' and return the first topic in it.
		local
			file_name: FILE_NAME
			sub: XML_ELEMENT
		do
			create file_name.make_from_string (fn)
			sub := parse_xml_file (file_name)
			if sub /= Void then
				Result := find_first_node_with_tag (topic_tag, sub)
			end
		end

feature -- Basic operations

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'? (comparable)
			-- We use the id in uppercase to compare.
		local
			s, os: STRING
		do
			s := deep_clone (id)
			s.to_upper
			os := deep_clone (other.id)
			os.to_upper
			Result := s < os
		end

feature -- Miscellaneous

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

feature -- State setting

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

feature -- Status report

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

feature -- Implementation

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

	display (area: E_TOPIC_DISPLAY) is
			-- Show this topic in a quick, buffered way.
		require
			area_exists: area /= Void
		do
			area.display_topic (Current)
		end

	display_old(area: E_TOPIC_DISPLAY) is
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
					area.line_break(0)
					paragraphs.forth
				end
			elseif contains_subtopics then
				create temp.make_empty
				temp.set_bullet(true)
				temp.set_font_color_by_string("link")
				from
					subtopics.start
				until
					subtopics.after
				loop
					area.line_break(1)
					temp.set_text(subtopics.item.head)
					temp.set_hyperlink(subtopics.item.id)
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

	paragraphs: LINKED_LIST [E_TEXT]
			-- A list of all paragraphs in this topic.

	subtopics: LINKED_LIST [E_TOPIC]
			-- All the subtopics of this topic.

invariant
	must_have_id: (id /= Void) and then (not id.empty)
	must_have_location: (location /= Void) and then (not location.empty)
	must_have_head: (head /= Void) and then (not head.empty)
	not_topics_and_text: not (contains_text and contains_subtopics)

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
end -- class E_TOPIC
