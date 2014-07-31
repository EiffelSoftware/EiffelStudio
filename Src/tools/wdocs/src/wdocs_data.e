note
	description: "Summary description for {WDOCS_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_DATA

create
	make

feature {NONE} -- Initialization

	make
		do
			create books.make (0)
			create book_names.make (0)
			create pages_path_by_title_and_book.make_caseless (0)
			create images_path_by_title_and_book.make_caseless (0)
			create templates_path_by_title_and_book.make_caseless (0)
		end

feature -- Access

	books: ARRAYED_LIST [WIKI_BOOK]

	book_names: ARRAYED_LIST [READABLE_STRING_32]

	pages_path_by_title_and_book: STRING_TABLE [STRING_TABLE [PATH]]
			-- Wiki page path indexed by page title for each book.

	images_path_by_title_and_book: STRING_TABLE [STRING_TABLE [PATH]]
			-- Wiki image path indexed by title for each book.			

	templates_path_by_title_and_book: STRING_TABLE [STRING_TABLE [PATH]]
			-- Wiki template path indexed by title for each book.			

feature -- Query

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

	image_path (a_title: READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL): detachable PATH
		do
			if attached images_path_by_title_and_book.item (a_book_name) as ht then
				Result := ht.item (a_title)
			end
		end

	template_path (a_title: READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL): detachable PATH
		do
			if attached templates_path_by_title_and_book.item (a_book_name) as ht then
				Result := ht.item (a_title)
			end
		end

	page (a_title: READABLE_STRING_GENERAL): detachable WIKI_PAGE
		do

		end

feature -- Element change

	record_image_path (a_path: PATH; a_image_name: READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL)
		local
			ht: detachable STRING_TABLE [PATH]
		do
			ht := images_path_by_title_and_book.item (a_book_name)
			if ht = Void then
				create ht.make (1)
				images_path_by_title_and_book.force (ht, a_book_name)
			end
			ht.force (a_path, a_image_name)
		end

	record_template_path (a_path: PATH; a_template_name: READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL)
		local
			ht: detachable STRING_TABLE [PATH]
		do
			ht := templates_path_by_title_and_book.item (a_book_name)
			if ht = Void then
				create ht.make (1)
				templates_path_by_title_and_book.force (ht, a_book_name)
			end
			ht.force (a_path, a_template_name)
		end

end
