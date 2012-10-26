note
	description: "Summary description for {XML_HAS_UNICODE_NODE_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_HAS_UNICODE_NODE_VISITOR

inherit
	XML_NODE_ITERATOR
		redefine
			process_element,
			process_character_data,
			process_comment,
			process_attribute
		end

feature -- Visitor

	has_unicode: BOOLEAN

	reset
		do
			has_unicode := False
		end

	string_has_unicode (s: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := not s.is_valid_as_string_8
		end

feature -- Visitor

	process_element (e: XML_ELEMENT)
			-- Process character data `e'.
		do
			has_unicode := has_unicode or string_has_unicode (e.name)
			if not has_unicode then
				Precursor (e)
			end
		end

	process_character_data (c: XML_CHARACTER_DATA)
			-- Process character data `c'.
		do
			has_unicode := has_unicode or string_has_unicode (c.content)
		end

	process_comment (com: XML_COMMENT)
			-- Process comment `com'.
		do
			has_unicode := has_unicode or string_has_unicode (com.data)
		end

	process_attribute (att: XML_ATTRIBUTE)
			-- Process attribute `att'.
		do
			has_unicode := has_unicode or string_has_unicode (att.name) or string_has_unicode (att.value)
		end



end
