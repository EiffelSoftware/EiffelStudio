note
	description: "Node qualified by `id' and indicates that descendants of this element contain information about it and be referenced by `itemref' from MD_ITEM."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ID_NODE

inherit
	MD_COMPOSITE

create
	make

feature {NONE} -- Initialization

	make (a_id: READABLE_STRING_GENERAL)
		do
			initialize
			create id.make_from_string_general (a_id)
		end

feature -- Access

	id: IMMUTABLE_STRING_32
			-- unique html identifier.

feature -- Status report

	debug_output: STRING_32
			-- <Precursor>
		do
			create Result.make_empty
			Result.append_character ('%"')
			Result.append_string_general (id)
			Result.append_character ('%"')
			if count > 0 then
				Result.append_string_general (" : ")
				Result.append_integer (count)
				Result.append_string_general (" props")
			else
				Result.append_string_general (" : No property!")
			end
		end

feature -- Visitor

	accept (vis: MD_VISITOR)
		do
			vis.visit_id_node (Current)
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
