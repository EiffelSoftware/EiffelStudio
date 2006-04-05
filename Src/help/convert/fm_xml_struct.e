indexing
	description: "Objects that convert the XML structure used by framemaker%
		%into a big XML-help-document-string."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel"
	date: "$Date$"
	revision: "$Revision$"

class
	FM_XML_STRUCT

inherit
	E_XML_TAGS

create
	make

feature -- Initialization

	make (tree: XML_ELEMENT; source: STRING) is
			-- Take FM tree and convert it to help-tree
		require
			tree_is_root: tree /= Void and then tree.is_root
		local
			tree_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			time: TIME
		do
			source_file := source
			if tree.name.is_equal("XML") then
				create links_list.make (100)
				generate_links_list (tree)
				create time.make_now
				base_id := time.seconds
				xml_string := get_start_tag (eiffel_document_tag, "")
				cur_level := 0
				process_tree(tree)
				change_level(1)
				xml_string.append(get_end_tag (eiffel_document_tag))
			end
		end

	generate_links_list (tree: XML_ELEMENT) is
		local
			tree_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			tree_elem: XML_ELEMENT
			tmp: STRING
		do
			--! FIXME We cannot have links to outside because it is too complicated.
			--! Will require huge repository or something.
			--! Maybe FrameMaker provides something I don't know of...
			from
				tree_cursor := tree.new_cursor
				tree_cursor.start
			until
				tree_cursor.after
			loop
				tree_elem ?= tree_cursor.item
				if tree_elem /= Void then
					if tree_elem.name.is_equal ("A") then
						if tree_elem.attributes.has ("ID") then
							tmp := tree_elem.attributes.item ("ID").value
							if tmp.substring(1,5).is_equal("pgfId") then
								--! Do not assign it like that! FIXME
								last_link := clone(tmp)
							else
								if last_link /= Void then
									links_list.force (last_link, tmp)
								end
							end
						end
					end
					generate_links_list (tree_elem)
				end
				tree_cursor.forth		
			end
		end

	process_tree(tree:XML_ELEMENT) is
		local
			tree_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			tree_elem: XML_ELEMENT
		do
			from
				tree_cursor := tree.new_cursor
				tree_cursor.start
			until
				tree_cursor.after
			loop
				tree_elem ?= tree_cursor.item
				if tree_elem /= Void then
					last_tag := get_fm_tag (tree_elem.name)

					-- We need to do this first:
					if merge_list_item and then not is_list_item (last_tag) then
						-- End of list
						xml_string.append (get_end_tag (list_tag))
						xml_string.append (get_end_tag (text_tag) + "%N")
						merge_list_item := false
					end

					if is_header (last_tag) then
						change_level (get_header_level (last_tag))
						process_header (tree_elem)
					elseif is_body (last_tag) then
						-- if the next header turns out to be one level higher insert the topic tag.
						if insert_position = 0 then
							insert_position := xml_string.count
						end
						xml_string.append (get_start_tag (text_tag, ""))
						process_body (tree_elem)
					--	xml_string.append ("Save time, skip a paragraph.")
						xml_string.append (get_end_tag (text_tag) + "%N")

					elseif is_list_item (last_tag) then
						if insert_position = 0 then
							insert_position := xml_string.count
						end
						if not merge_list_item then
							-- Start of list.
							xml_string.append (get_start_tag (text_tag, ""))
							xml_string.append (get_start_tag (list_tag, ""))
						end
						xml_string.append (get_start_tag (list_item_tag, ""))
						process_body (tree_elem)
						xml_string.append (get_end_tag (list_item_tag) + "%N")

						merge_list_item := true
					elseif last_tag.is_equal ("TABLE") then
						if insert_position = 0 then
							insert_position := xml_string.count
						end
						now_doing_a_table := True
						xml_string.append (get_start_tag (text_tag, "") + get_start_tag (list_tag, ""))
						process_body (tree_elem)
						xml_string.append (get_end_tag (list_tag) + get_end_tag (text_tag) + "%N")
						now_doing_a_table := False
					else
					--	io.put_string (tree_elem.name+"%N")
						process_tree(tree_elem)
					end
				end
				tree_cursor.forth		
			end
		end

	change_level(new_level:INTEGER) is
		do
		--	io.putstring(last_tag+": ")
		--	io.putstring(cur_level.out +" -> "+ new_level.out+"%N")
			if new_level > cur_level then
				if insert_position > 0 then
					xml_string.insert(leading_tabs+
						get_start_tag(topic_tag, get_attr(topic_id_attr, generate_unique_id))+
						get_start_tag(head_tag, "")+
						"(convert)"+
						get_end_tag(head_tag),insert_position)
					xml_string.append(leading_tabs+get_end_tag(topic_tag)+"%N")
				end
				cur_level := new_level
			else
				from
					xml_string.append(leading_tabs+get_end_tag(topic_tag)+"%N")
				until
					new_level = cur_level
				loop
					xml_string.append(leading_tabs+get_end_tag(topic_tag)+"%N")
					cur_level := cur_level - 1
				end
			end
			insert_position := 0
		end

	process_header(tree: XML_ELEMENT) is
		local
			tree_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			text_tree: XML_TEXT
			tree_elem: XML_ELEMENT
			id, head, tmp: STRING
		do
			from
				tree_cursor := tree.new_cursor
				tree_cursor.start
			until
				tree_cursor.after
			loop
				text_tree ?= tree_cursor.item
				if text_tree /= Void then
					tmp := text_tree.string
					remove_excess_whitespace (tmp)
					if tmp.count > 1 then
						format_for_xml (tmp)
						head := tmp
					end
				else
					tree_elem ?= tree_cursor.item
					if tree_elem /= Void and then tree_elem.name.is_equal("A") then
						tmp := tree_elem.attributes.item("ID").value
						if tmp.substring(1,5).is_equal("pgfId") then
							id := tmp
						else
							--io.put_string (tmp + "%N")
						end
					end
				end
				tree_cursor.forth		
			end
			if id = Void then
				io.putstring ("Warning: No id found. However, we'll generate one for you!%N")
				id := generate_unique_id
			end
			xml_string.append (leading_tabs + get_start_tag (topic_tag, get_attr (topic_id_attr, id)) + "%N")
			if head = Void then
				io.putstring ("Warning: No head found for topic " + id + ". Let's use 'Untitled'! (Original isn't it?)")
				head := "Untitled"
			end
			xml_string.append (leading_tabs + "  " + get_start_tag (head_tag, "") + head + get_end_tag (head_tag) + "%N")
		end

	process_body (tree: XML_ELEMENT) is
		local
			tree_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			text_tree: XML_TEXT
			tree_elem: XML_ELEMENT
			xml_help_tag, temp_str: STRING
		do
			from
				tree_cursor := tree.new_cursor
				tree_cursor.start
			until
				tree_cursor.after
			loop
				text_tree ?= tree_cursor.item
				if text_tree /= Void then
					temp_str := text_tree.string
					temp_str.prune_all ('%N')
					format_for_xml (temp_str)
					remove_excess_whitespace (temp_str)
					xml_string.append (temp_str)
				else
					tree_elem ?= tree_cursor.item
					if tree_elem /= Void then
						append_help_start_tag (get_fm_tag (tree_elem.name))
						if last_help_tag /= Void then
							xml_help_tag := clone (last_help_tag)
							process_body (tree_elem)
							xml_string.append (get_end_tag (xml_help_tag))
							if now_doing_a_table then
								xml_string.append (get_line_break)
							end
						else
							-- Could be a link?
							if tree_elem.name.is_equal ("A") then
								if tree_elem.attributes.has("href") then
									-- We actually have something!
									-- (do something with it!) FIXME
									temp_str := tree_elem.attributes.item("href").value
									temp_str := temp_str.substring (temp_str.count - 5, temp_str.count - 1)
									if links_list.has (temp_str) then
							--			io.put_string ("Resolved "+temp_str+" to "+links_list.item (temp_str)+"%N")
									end
							--		io.put_string (temp_str + "%N")
									xml_string.append (get_start_tag (anchor_tag, get_attr (anchor_topic_id_attr, temp_str)))
									process_body (tree_elem)
									xml_string.append (get_end_tag (anchor_tag))	
								end
							else
								process_body (tree_elem)
							end
						end
					end
				end
				tree_cursor.forth		
			end
		end

	process_string (s: STRING): STRING is
		do
			Result := clone (s)
			remove_excess_whitespace (Result)
			format_for_xml (Result)
		end

	append_help_start_tag (tag: STRING) is
			-- appends the help-equiv. to FM `tag' and sets last_help_tag.
		do
			if tag.is_equal ("bold") then
				last_help_tag := bold_tag
				xml_string.append (get_start_tag (last_help_tag, ""))
			elseif tag.is_equal ("italics") then
				last_help_tag := italics_tag
				xml_string.append (get_start_tag (last_help_tag, ""))
			elseif tag.is_equal ("note") then
				last_help_tag := underlined_tag
				xml_string.append (get_start_tag (last_help_tag, ""))
			elseif  tag.is_equal ("syntax") then
				last_help_tag := font_tag
				xml_string.append (get_start_tag (last_help_tag, get_attr (font_color_attr, "green")))
			elseif tag.is_equal ("text") or else tag.is_equal ("dot") or else tag.is_equal ("comment") then
				last_help_tag := font_tag
				xml_string.append (get_start_tag (last_help_tag, get_attr (font_color_attr, "blue")))
			elseif tag.is_equal ("crossref") then
				last_help_tag := font_tag
				xml_string.append (get_start_tag (last_help_tag, get_attr (font_color_attr, "red")))
				-- This is of course a link, so underline as well, but this is all done by the anchor tag.
				--| This means FIXME.
			elseif tag.is_equal ("symbol") or else tag.is_equal ("nsymbol") then
				last_help_tag := font_tag
				xml_string.append (get_start_tag (last_help_tag, get_attr (font_color_attr, "magenta")))
			elseif tag.is_equal ("reserved") then
				last_help_tag := font_tag
				xml_string.append (get_start_tag (last_help_tag, get_attr (font_color_attr, "cyan")))
			elseif tag.is_equal ("keyword") then
				last_help_tag := keyword_tag
				xml_string.append (get_start_tag (last_help_tag, ""))
				-- Make blue, too.
				-- And bold as well!
			else
				last_help_tag := Void
			end
		end

	get_header_level (header: STRING): INTEGER is
		do
			if header.is_equal("chapter") then
				Result := 1
			elseif header.is_equal("sec2") then
				Result := 2
			elseif header.is_equal("sec3") then
				Result := 3
			end
		end

	get_fm_tag (tag: STRING): STRING is
			-- Returns a string without the first three characters.
		require
			tag /= Void
		do
			if tag.count >= 4 and then tag.item(3).is_equal('-') then
				create Result.make (tag.count - 3)
				Result := tag.substring (4, tag.count)
			else
				Result := tag
			end
		end

	is_header (tag_name: STRING): BOOLEAN is
		require
			tag_name_not_void: tag_name /= Void
		do
			Result := tag_name.is_equal("chapter") or else
				tag_name.is_equal("sec2") or else
				tag_name.is_equal("sec3")
		end

	is_body (tag_name: STRING): BOOLEAN is
		require
			tag_name_not_void: tag_name /= Void
		do
			Result := tag_name.is_equal("first") or else
				tag_name.is_equal("normal") or else
				tag_name.is_equal("small")
		end

	is_list_item (tag_name: STRING): BOOLEAN is
			-- Determines whether `tag_name' is a list-item-tag.
		require
			tag_name_not_void: tag_name /= Void
		do
			Result := tag_name.is_equal ("bull") or else
				tag_name.is_equal ("bullnum")
				--or else tag_name.is_equal ("TABLE")
		end

	leading_tabs: STRING is
		do
			create Result.make(cur_level*2)
			Result.fill_character(' ')	
		end

	generate_unique_id: STRING is
		do
			Result := source_file + "-" + base_id.out
			base_id := base_id + 1
		end

	now_doing_a_table: BOOLEAN
			-- Are we busy with a table? Than don't ignore %N's for a minute. @#$%^FrameMaker!

	source_file: STRING
			-- The name of the FM XML file.

	last_link: STRING
			-- Used by generate_links_list.

	insert_position: INTEGER
			-- The position the current body text started on.

	last_tag: STRING
			-- The last processed FM XML tag.

	last_help_tag: STRING
			-- The last processed help XML tag.

	cur_level: INTEGER
			-- Current topic level.

	xml_string: STRING
			-- The XML-string in which the help-file is built.

	merge_list_item: BOOLEAN
			-- Merge the next list item in the same list as the current one.

	base_id: INTEGER
			-- Number used to generate the next unique ID.

	links_list: HASH_TABLE [STRING, STRING];
			-- The resp. topic link to a link inside a paragraph. [topic, paragraph]

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
end -- class FM_XML_STRUCT
