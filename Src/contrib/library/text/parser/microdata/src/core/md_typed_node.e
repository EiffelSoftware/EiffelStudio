note
	description: "Summary description for {MD_TYPED_NODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=HTML Microdata Itemtype", "protocol=URI", "src=http://www.w3.org/TR/microdata/#attr-itemtype"	

deferred class
	MD_TYPED_NODE

inherit
	MD_NODE

feature -- Access

	type: detachable MD_TYPE
			-- associated itemtype

	type_url: detachable READABLE_STRING_32
			-- valid URL of a vocabulary that describes the item and its properties context.
		do
			if attached type as l_type then
				Result := l_type.url
			end
		end

feature -- Change

	set_type_url (a_type_url: detachable READABLE_STRING_GENERAL)
		do
			if a_type_url = Void then
				type := Void
			else
				create type.make_from_url (a_type_url)
			end
		end

	set_type (a_type: like type)
		do
			type := a_type
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
