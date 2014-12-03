note
	description: "Summary description for {WDOCS_BOOKS_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_BOOKS_DATA

inherit
	WDOCS_HELPER

create
	make

feature {NONE} -- Initialization

	make
		do
			create book_names.make (0)
			create books.make (0)
		end

feature {WDOCS_DATA_ACCESS} -- Access

	book_names: ARRAYED_LIST [READABLE_STRING_32]

	books: ARRAYED_LIST [WIKI_BOOK]

feature {WDOCS_DATA_ACCESS} -- Query

	book (a_name: READABLE_STRING_GENERAL): detachable WIKI_BOOK
		do
			across
				books as ic
			until
				Result /= Void
			loop
				if a_name.is_case_insensitive_equal (ic.item.name) then
					Result := ic.item
				end
			end
		end

end
