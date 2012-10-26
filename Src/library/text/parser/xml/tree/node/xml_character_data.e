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

	make (a_parent: XML_ELEMENT; c: READABLE_STRING_32)
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

	make_last (a_parent: XML_ELEMENT; c: READABLE_STRING_32)
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

	has_same_content (a_content: like content): BOOLEAN
		local
			v: like content
		do
			v := content
			Result := (v = a_content) or (a_content.same_string (v))
		end

feature -- Access		

	content: READABLE_STRING_32
			-- Actual character data

	content_count: INTEGER
			-- Count of `content'.
		do
			Result := content.count
		end

feature -- Element change

	set_content (a_content: READABLE_STRING_32)
			-- Set content.
		require
			a_content_not_void: a_content /= Void
		do
			content := a_content
		ensure
			same_string: a_content.same_string (content)
		end

	append_content (other: like Current)
			-- Append the content of 'other' to
			-- the content of `Current'.
		require
			other_not_void: other /= Void
		local
			s32: STRING_32
		do
			if attached {STRING_32} content as s then
				s.append (other.content)
			else
				s32 := content.to_string_32
				s32.append_string (other.content)
				content := s32
			end
		ensure
			appended_count: content_count = other.content_count + old (content_count)
			appended: other.has_same_content (content.substring (content_count - other.content_count + 1, content_count))
		end

feature -- Visitor processing

	process (a_processor: XML_NODE_VISITOR)
			-- Process current node with `a_processor'.
		do
			a_processor.process_character_data (Current)
		end

invariant
	content_not_void: content /= Void

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
