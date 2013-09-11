note
	description: "Summary description for {MD_NAMED_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_NAMED_NODE

inherit
	MD_NODE

feature -- Access

	name: IMMUTABLE_STRING_32
			-- Itemprop name

feature -- Change

	set_name (a_name: READABLE_STRING_GENERAL)
			-- Update name
		do
			create name.make_from_string_general (a_name)
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
