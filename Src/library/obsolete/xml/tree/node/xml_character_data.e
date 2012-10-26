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

	make (a_parent: XML_ELEMENT; c: like content)
			-- Create a new character data node.
		require
			a_parent_not_void: a_parent /= Void
			c_not_void: c /= Void
		do
			parent := a_parent
			content := c
		ensure
			parent_set: parent = a_parent
			content_set: content = c
		end

	make_last (a_parent: XML_ELEMENT; c: like content)
			-- Create a new character data node,
			-- and add it to parent.
		require
			a_parent_not_void: a_parent /= Void
			c_not_void: c /= Void
		do
			content := c
			a_parent.force_last (Current)
		ensure
			parent_set: parent = a_parent
			in_parent: a_parent.last = Current
			content_set: content = c
		end

feature -- Access

	content: STRING
			-- Actual character data

feature -- Element change

	set_content (a_content: STRING)
			-- Set content.
		require
			a_content_not_void: a_content /= Void
		do
			content := a_content
		ensure
			set: content = a_content
			same_string: content ~ a_content
		end

	append_content (other: like Current)
			-- Append the content of 'other' to
			-- the content of `Current'.
		require
			other_not_void: other /= Void
		do
			content.append_string (other.content)
		ensure
			appended_count: content.count = other.content.count + old (content.count)
			appended: other.content ~
					content.substring (content.count - other.content.count + 1, content.count)
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
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
