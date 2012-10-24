note
	description: "Summary description for {XML_CHARACTER_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_CHARACTER_DATA

inherit
	XML_ELEMENT_NODE

create
	make,
	make_last

feature {NONE} -- Initialization

	make (a_parent: XML_ELEMENT; c: READABLE_STRING_GENERAL)
			-- Create a new character data node.
		require
			a_parent_not_void: a_parent /= Void
			c_not_void: c /= Void
		do
			parent := a_parent
			set_content (c)
		ensure
			parent_set: parent = a_parent
			content_set: has_same_content (c)
		end

	make_last (a_parent: XML_ELEMENT; c: READABLE_STRING_GENERAL)
			-- Create a new character data node,
			-- and add it to parent.
		require
			a_parent_not_void: a_parent /= Void
			c_not_void: c /= Void
		do
			set_content (c)
			a_parent.force_last (Current)
		ensure
			parent_set: parent = a_parent
			in_parent: a_parent.last = Current
			content_set: has_same_content (c)
		end

feature -- Status report

	content_is_valid_as_string_8: BOOLEAN
			-- Is content a valid string_8 value?
		do
			Result := internal_content.is_valid_as_string_8
		end

	has_same_content (a_content: like internal_content): BOOLEAN
		local
			v: like internal_content
		do
			v := internal_content
			Result := (v = a_content) or (a_content.same_string (v))
		end

feature -- Access		

	content_8, content: STRING_8
			-- Actual character data
		require
			content_is_valid_as_string_8: content_is_valid_as_string_8
		do
			Result := internal_content.as_string_8
		end

	content_32: READABLE_STRING_32
			-- Actual character data
		do
			Result := to_readable_string_32 (internal_content)
		end

	content_count: INTEGER
			-- Count of `content'.
		do
			Result := internal_content.count
		end

feature {XML_EXPORTER} -- Access

	internal_content: READABLE_STRING_GENERAL

feature -- Element change

	set_content (a_content: READABLE_STRING_GENERAL)
			-- Set content.
		require
			a_content_not_void: a_content /= Void
		do
			internal_content := a_content
		ensure
			same_string: a_content.same_string (internal_content)
		end

	append_content (other: like Current)
			-- Append the content of 'other' to
			-- the content of `Current'.
		require
			other_not_void: other /= Void
		local
			s32: STRING_32
		do
			if attached {STRING_GENERAL} internal_content as sg then
				sg.append (other.content_32)
			else
				s32 := internal_content.as_string_32
				s32.append_string_general (other.content_32)
				internal_content := s32
			end
		ensure
			appended_count: content_count = other.content_count + old (content_count)
			appended: other.has_same_content (internal_content.substring (content_count - other.content_count + 1, content_count))
		end

feature -- Visitor processing

	process (a_processor: XML_NODE_VISITOR)
			-- Process current node with `a_processor'.
		do
			a_processor.process_character_data (Current)
		end

invariant
	content_not_void: internal_content /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
