indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIKI_WITH_CHILD

feature -- Access

	pages: ARRAYED_LIST [WIKIPAGE]

feature -- Status report

	is_valid_page (p: WIKIPAGE): BOOLEAN
		do
			Result := p /= Void
		end

feature -- Element change

	add_page (p: WIKIPAGE)
		require
			is_valid_page: is_valid_page (p)
		do
			if pages = Void then
				create pages.make (10)
			end
			pages.extend (p)
		end



end
