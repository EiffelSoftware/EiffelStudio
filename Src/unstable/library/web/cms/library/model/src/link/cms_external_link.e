note
	description: "[
			Abstraction to represent a link outside current CMS system.
			For instance, a web url.
		]"
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
			-- Create current external link with optional title `a_title' and location `a_location'.
		do
			title := a_title
			location := a_location
		end

feature -- Status report

	is_active: BOOLEAN = False
			-- <Precursor>

	is_expanded: BOOLEAN = False
			-- <Precursor>

	is_collapsed: BOOLEAN = False
			-- <Precursor>

	is_expandable: BOOLEAN = False
			-- <Precursor>

	has_children: BOOLEAN = False
			-- <Precursor>

feature -- Security		

	is_forbidden: BOOLEAN = False
			-- <Precursor>			

feature -- Access			

	children: detachable LIST [CMS_LINK]
			-- <Precursor>

invariant
note
	copyright: "2011-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
