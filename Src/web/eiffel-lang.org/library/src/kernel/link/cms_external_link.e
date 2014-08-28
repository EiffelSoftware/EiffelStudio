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

	is_expandable: BOOLEAN = False

	has_children: BOOLEAN = False

	children: detachable LIST [CMS_LINK]
		do
		end

end
