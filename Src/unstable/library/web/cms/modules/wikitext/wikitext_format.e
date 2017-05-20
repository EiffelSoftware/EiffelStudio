note
	description: "Summary description for {WIKITEXT_FORMAT}."
	date: "$Date$"
	revision: "$Revision$"

class
	WIKITEXT_FORMAT

inherit
	CONTENT_FORMAT
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create filters.make (1)
			filters.force (create {WIKITEXT_FILTER})
		end

feature -- Access

	name: STRING = "wikitext"

	title: STRING_8 = "Wikitext"

	filters: ARRAYED_LIST [CONTENT_FILTER]

end
