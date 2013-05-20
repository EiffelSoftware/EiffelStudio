note
	description: "Summary description for {WSF_ROUTER_MAPPING_DOCUMENTATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_ROUTER_MAPPING_DOCUMENTATION

create
	make

feature {NONE} -- Initialization

	make (m: like mapping)
		do
			mapping := m
			create descriptions.make (0)
		end

feature -- Status report

	is_hidden: BOOLEAN
			-- Hide this mapping from any self documentation?		
			-- Default=False

	is_empty: BOOLEAN
			-- Is Current empty?
			-- i.e: does not carry any information.
		do
			Result := descriptions.is_empty
		end

feature -- Access

	mapping: WSF_ROUTER_MAPPING
			-- Associated mapping

	descriptions: ARRAYED_LIST [READABLE_STRING_GENERAL]

	description: STRING_32
		do
			create Result.make_empty
			across
				descriptions as c
			loop
				Result.append_string_general (c.item)
				Result.append ("%N")
			end
		end

feature -- Change

	set_is_hidden (b: BOOLEAN)
		do
			is_hidden := b
		end

	add_description (d: READABLE_STRING_GENERAL)
		do
			descriptions.force (d)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
