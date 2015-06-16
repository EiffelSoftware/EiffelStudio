note
	description: "HTML Content format editable with WYSIWYG editor."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_EDITOR_CONTENT_FORMAT

inherit
	CONTENT_FORMAT
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create filters.make (0)
		end

feature -- Access

	name: STRING = "cms_editor"

	title: STRING_8 = "CMS HTML content"

	filters: ARRAYED_LIST [CONTENT_FILTER]

end
