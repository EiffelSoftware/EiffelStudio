note
	description: "Summary description for {MD_DEBUG_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_DEBUG_ITERATOR

inherit
	MD_ITERATOR
		redefine
			visit_item,
			visit_property
		end

create
	make

feature {NONE} -- Initialization

	make (buf: like buffer)
		do
			buffer := buf
			create offset.make_empty
		end

feature -- Access

	buffer: STRING_32

	offset: STRING_32

feature -- Visit

	visit_item (v: MD_ITEM)
		do
			buffer.append (offset)
			buffer.append (v.debug_output)
			buffer.append_character ('%N')
			offset.extend (' ')
			Precursor (v)
			offset.remove_tail (1)
		end

	visit_property (v: MD_PROPERTY)
		do
			buffer.append (offset)
			buffer.append (v.debug_output)
			buffer.append_character ('%N')
			offset.extend (' ')
			Precursor (v)
			offset.remove_tail (1)
		end



note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
