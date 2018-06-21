note
	description: "Summary description for {WDOCS_BOOK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_BOOK

inherit
	WIKI_BOOK
		rename
			make as make_wiki_book
		redefine
			add_page, page --, page_by_normalized_title
		end

create
	make

feature {NONE} -- Initialization

	make (n: READABLE_STRING_8; p: like path; a_title_normalizer: WIKI_PAGE_TITLE_NORMALIZER)
		do
			page_title_normalizer := a_title_normalizer
			make_wiki_book (n, p)
			create pages_map.make (pages.capacity)
		end

feature -- Access

	page_title_normalizer: WIKI_PAGE_TITLE_NORMALIZER

	pages_map: STRING_TABLE [WIKI_BOOK_PAGE]

	page (a_title: READABLE_STRING_GENERAL): detachable WIKI_BOOK_PAGE
			-- Page with title `a_title'.
		local
			n: READABLE_STRING_GENERAL
		do
			n := page_title_normalizer.normalized_title (a_title)
			Result := page_by_normalized_title (n)
			if Result = Void and not a_title.same_string (n) then
				Result := Precursor (a_title)
			end
		end

	page_by_normalized_title (a_normalized_title: READABLE_STRING_GENERAL): like page
		do
			Result := pages_map.item (a_normalized_title)
		end

feature -- Element change

	add_page (a_page: WIKI_BOOK_PAGE)
			-- Add page `a_page' to current book.
		do
			Precursor (a_page)
			pages_map.force (a_page, page_title_normalizer.normalized_title (a_page.title))
		end

invariant

	same_count: pages_map.count = pages.count

end
