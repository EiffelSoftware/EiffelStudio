note
	description: "Summary description for {CMS_EXTERNAL_MENU}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_EXTERNAL_LINK

inherit
	CMS_LINK

create
	make

feature {NONE} -- Initialization

	make (a_title: like title; a_location: like location)
		do
			title := a_title
			location := a_location
		end

feature -- Status report

	is_active: BOOLEAN = False

	is_expanded: BOOLEAN = False

	is_collapsed: BOOLEAN = False

	is_expandable: BOOLEAN = False

	has_children: BOOLEAN = False

	children: detachable LIST [CMS_LINK]
		do
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
