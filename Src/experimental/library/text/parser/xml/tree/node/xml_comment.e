note
	description: "Summary description for {XML_COMMENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_COMMENT

inherit
	XML_DOCUMENT_NODE

	XML_ELEMENT_NODE

create
	make,
	make_last,
	make_last_in_document

feature {NONE} -- Initialization

	make (a_parent: like parent; a_data: READABLE_STRING_32)
			-- Create a new comment node.
		require
			a_parent_not_void: a_parent /= Void
			a_data_not_void: a_data /= Void
		do
			parent := a_parent
			set_data (a_data)
		ensure
			parent_set: parent = a_parent
			data_set: a_data.same_string (data)
		end

	make_last (a_parent: XML_ELEMENT; a_data: READABLE_STRING_32)
			-- Create a new comment node.
			-- and add it to parent.
		require
			a_parent_not_void: a_parent /= Void
			a_data_not_void: a_data /= Void
		do
			set_data (a_data)
			a_parent.force_last (Current)
		ensure
			parent_set: parent = a_parent
			in_parent: a_parent.last = Current
			data_set: a_data.same_string (data)
		end

	make_last_in_document (a_parent: XML_DOCUMENT; a_data: READABLE_STRING_32)
			-- Create a new comment node,
			-- and add it to parent.
		require
			a_parent_not_void: a_parent /= Void
			a_data_not_void: a_data /= Void
		do
			set_data (a_data)
			a_parent.force_last (Current)
		ensure
			parent_set: parent = a_parent
			in_parent: a_parent.last = Current
			data_set: a_data.same_string (data)
		end

feature -- Access		

	data: READABLE_STRING_32
			-- Comment's character data	

feature -- Setting

	set_data (a_data: READABLE_STRING_32)
			-- Set comment's data.
		require
			a_data_not_void: a_data /= Void
		do
			data := a_data
		ensure
			set: a_data.same_string (data)
		end

feature -- Visitor processing

	process (a_processor: XML_NODE_VISITOR)
			-- Process current node with `a_processor'.
		do
			a_processor.process_comment (Current)
		end

invariant
	data_not_void: data /= Void

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
