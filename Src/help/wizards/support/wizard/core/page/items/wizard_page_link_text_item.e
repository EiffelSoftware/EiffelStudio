note
	description: "Wizard linked text item"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PAGE_LINK_TEXT_ITEM

inherit
	WIZARD_PAGE_TEXT_ITEM
		rename
			make as make_text
		end

create
	make

feature {NONE} -- Initialization

	make (a_text: READABLE_STRING_GENERAL; a_uri: READABLE_STRING_8)
		do
			make_text (a_text)
			set_uri (a_uri)
		end

feature -- Access

	uri: IMMUTABLE_STRING_8

feature -- Element change

	set_uri (a_uri: READABLE_STRING_8)
		do
			create uri.make_from_string (a_uri)
		end

end
