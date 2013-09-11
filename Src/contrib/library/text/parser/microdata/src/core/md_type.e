note
	description: "A valid URL of a vocabulary that describes the item and its properties context."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TYPE

create
	make_from_url

feature {NONE} -- Initialization

	make_from_url (a_type_url: READABLE_STRING_GENERAL)
		do
			create url.make_from_string_general (a_type_url)
		end

feature -- Access

	url: IMMUTABLE_STRING_32

feature -- Change	

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
