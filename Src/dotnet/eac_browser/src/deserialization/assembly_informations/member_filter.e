class
	MEMBER_FILTER

inherit
	XM_CALLBACKS_FILTER
		redefine
			on_start_tag,
			on_attribute,
			on_end_tag
		end

create
	make

feature -- Initialization

	make is
			-- Initialization.
		do
			create xml_members.make (10000)
			create current_tag.make (10)
		ensure then
			non_void_xml_members: xml_members /= Void
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

	tag_started: BOOLEAN
			-- Was a new tag started?

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Add tag to list of tags.
			-- If <member> then set position of tag.
		local
			l_position: XM_DEFAULT_POSITION
		do
			current_tag.extend (a_local_part)
			if a_local_part.is_equal ("member") then
				create current_xml_member.make
				tag_started := True
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
			if tag_started and current_tag.item.is_equal ("member") then
				check
					name_attribute: a_local_part.is_equal ("name")
				end
				create l_name.make_from_string (a_value)
				l_name.keep_tail (l_name.count - 2)
				current_xml_member.set_name (l_name)
				tag_started := False
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
					l_number_of_char := l_position.byte_index - current_xml_member.pos_in_file
					current_xml_member.set_number_of_char (l_number_of_char)
					xml_members.put (current_xml_member, current_xml_member.name)
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
	non_void_current_tag: current_tag /= Void

end -- class MEMBER_FILTER
