class
	MEMBER_FILTER

inherit
	XM_CALLBACKS_FILTER
		redefine
			on_start_tag,
			on_attribute,
			on_end_tag
		end

creation
	make

feature -- Initialization

	make is
			-- Initialization.
		do
			create Xml_members.make (10000)
			create current_xml_member.make
			create current_tag.make (10)
		ensure then
			non_void_xml_members: xml_members /= Void
			non_void_current_xml_member: current_xml_member /= Void
			non_void_current_tag: current_tag /= Void
		end

feature -- Access

	xml_members: HASH_TABLE [XML_MEMBER, STRING]
			-- Hash table of all xml types, classified per name.

feature {NONE} -- Access

	current_xml_member: XML_MEMBER
			-- Representation of a member in xml.
	
	current_tag: ARRAYED_STACK [STRING]
			-- List of opened XML tags.

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Add tag to list of tags.
			-- If <member> then set position of tag.
		local
			l_position: XM_DEFAULT_POSITION
		do
			current_tag.extend (a_local_part)
			if a_local_part.is_equal ("member") then
				l_position ?= parser.position
				check
					non_void_position: l_position /= Void
				end
				current_xml_member.set_pos_in_file (l_position.byte_index - l_position.column)
			end
			Precursor {XM_CALLBACKS_FILTER} (a_namespace, a_prefix, a_local_part)
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
			-- if `current_tag' is <member> then retrieve name of member.
		local
			l_name: STRING
		do
			if current_tag.item.is_equal ("member") then
				check
					name_attribute: a_local_part.is_equal ("name")
				end
				create l_name.make_from_string (a_value)
				l_name.keep_tail (l_name.count - 2)
				current_xml_member.set_name (l_name)
			end
			Precursor {XM_CALLBACKS_FILTER} (a_namespace, a_prefix, a_local_part, a_value)
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- If </member> then retrieve size of in bytes of tag.
			-- Add `current_xml_member' to `xml_members'.
		local
			l_number_of_char: INTEGER
			l_position: XM_DEFAULT_POSITION
		do
			if a_local_part.is_equal ("member") then
				if current_xml_member.pos_in_file > 0  then
					l_position ?= parser.position
					check
						non_void_position: l_position /= Void
					end
					l_number_of_char := l_position.byte_index - current_xml_member.pos_in_file --+ ("/member>").count
					current_xml_member.set_number_of_char (l_number_of_char)
					xml_members.put (deep_clone (current_xml_member), clone (current_xml_member.name))
				end
			end
			current_tag.remove
			Precursor {XM_CALLBACKS_FILTER} (a_namespace, a_prefix, a_local_part)
		end

feature -- Stautus Setting

	parser: XM_EIFFEL_PARSER
			-- Eiffel parser.

	set_parser (a_parser: like parser) is
			-- Set `parser' with `a_parser'.
		require
			non_void_parser: a_parser /= Void
		do
			parser := a_parser
		ensure
			parser_set: parser = a_parser implies parser /= Void
		end

invariant
	non_void_xml_members: xml_members /= Void
	non_void_current_xml_member: current_xml_member /= Void
	non_void_current_tag: current_tag /= Void

end -- class MEMBER_FILTER

--class
--	MEMBER_FILTER
--
--inherit
--	XM_CALLBACKS_FILTER
--		redefine
--			on_comment,
--			on_processing_instruction,
--			on_start_tag,
--			on_attribute,
--			on_start_tag_finish,
--			on_end_tag,
--			on_content
--		end
--
--creation
--	make
--
--feature -- Initialization
--
--	make is
--			-- Initialization.
--		do
--			create Xml_members.make (10000)
--			create current_xml_member.make
--			create current_tag.make (10)
--		ensure then
--			non_void_xml_members: xml_members /= Void
--			non_void_current_xml_member: current_xml_member /= Void
--			non_void_current_tag: current_tag /= Void
--		end
--
--feature -- Access
--
--	xml_members: HASH_TABLE [XML_MEMBER, STRING]
--			-- Hash table of all xml types, classified per name.
--
--feature {NONE} -- Access
--
--	current_xml_member: XML_MEMBER
--			-- Representation of a member in xml.
--	
--	current_tag: ARRAYED_STACK [STRING]
--			-- XML tag opened.
--
--	start_tag_byte_position: CELL[INTEGER] is
--			-- Start tag byte position.
--		once
--			create Result.put (0)
--		end
--
--feature -- Meta
--
--	on_processing_instruction (a_name: STRING; a_content: STRING) is
--			-- Print processing instruction.
--		do
--			Precursor {XM_CALLBACKS_FILTER} (a_name, a_content)
--		end
--
--	on_comment (a_content: STRING) is
--			-- Print comment.
--		do
--			Precursor {XM_CALLBACKS_FILTER} (a_content)
--		end
--
--feature -- Tag
--
--	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
--			-- Print start of start tag.
--		local
--			l_name: STRING
--			l_position: XM_DEFAULT_POSITION
--			
--			titi, toto: INTEGER
--		do
--			current_tag.extend (a_local_part)
--			if a_local_part.is_equal ("member") then
--				l_position ?= parser.position
--				check
--					non_void_position: l_position /= Void
--				end
--				titi := l_position.byte_index
--				toto := parser.byte_position
--
--				current_xml_member.set_pos_in_file (parser.byte_position - parser.column)
--			end
--			Precursor {XM_CALLBACKS_FILTER} (a_namespace, a_prefix, a_local_part)
--		end
--
--	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
--			-- Print attribute.
--		local
--			l_name: STRING
--			l_number_of_char: INTEGER
--		do
--			if
--				current_tag.item.is_equal ("member")
--			then
--				check
--					name_attribute: a_local_part.is_equal ("name")
--				end
--				create l_name.make_from_string (a_value)
--				l_name.keep_tail (l_name.count - 2)
--				current_xml_member.set_name (l_name)
--			end
--			Precursor {XM_CALLBACKS_FILTER} (a_namespace, a_prefix, a_local_part, a_value)
--		end
--
--	on_start_tag_finish is
--			-- Print end of start tag.
--		do
--			Precursor {XM_CALLBACKS_FILTER}
--		end
--
--	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
--			-- Print end tag.
--		local
--			l_number_of_char: INTEGER
--			
--			l_position: XM_DEFAULT_POSITION
--			toto, titi: INTEGER
--		do
--			if a_local_part.is_equal ("member") then
--				if current_xml_member.pos_in_file > 0  then
--
--					l_position ?= parser.position
--					check
--						non_void_position: l_position /= Void
--					end
--					titi := l_position.byte_index
--					toto := parser.byte_position
--
--					l_number_of_char := parser.byte_position - current_xml_member.pos_in_file
--					current_xml_member.set_number_of_char (l_number_of_char)
--					xml_members.put (deep_clone (current_xml_member), clone (current_xml_member.name))
--				end
--			end
--			current_tag.remove
--			Precursor {XM_CALLBACKS_FILTER} (a_namespace, a_prefix, a_local_part)
--		end
--
--feature -- Content
--
--	on_content (a_content: STRING) is
--			-- Text content.
--			-- NOT atomic: successive content may be different.
--			-- Default: forward event to 'next'.
--		do
--			Precursor {XM_CALLBACKS_FILTER} (a_content)
--		end
--
--feature -- Stautus Setting
--
--	parser: XM_EIFFEL_PARSER
--			-- Eiffel parser.
--
--	set_parser (a_parser: like parser) is
--			-- Set `parser' with `a_parser'.
--		require
--			non_void_parser: a_parser /= Void
--		do
--			parser := a_parser
--		ensure
--			parser_set: parser = a_parser implies parser /= Void
--		end
--
--invariant
--	non_void_xml_members: xml_members /= Void
--	non_void_current_xml_member: current_xml_member /= Void
--	non_void_current_tag: current_tag /= Void
--
--end -- class MEMBER_FILTER
