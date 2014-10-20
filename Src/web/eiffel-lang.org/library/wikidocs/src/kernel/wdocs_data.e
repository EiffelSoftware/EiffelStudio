note
	description: "Summary description for {WDOCS_DATA}."
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

	common_book_name: STRING = ""
			-- Book name representing resource common to all books.

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

	image_path (a_title: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL): detachable PATH
		do
			if a_book_name /= Void then
				if a_book_name.same_string (common_book_name) then
					if attached images_path_by_title_and_book.item (common_book_name) as ht then
						Result := ht.item (a_title)
					end
				else
					if attached images_path_by_title_and_book.item (a_book_name) as ht then
						Result := ht.item (a_title)
					end
					if Result = Void then
							-- Try with common resource
						Result := image_path (a_title, common_book_name)
					end
				end
			elseif attached image_path (a_title, common_book_name) as l_path then
					-- Try with common book resources.
				Result := l_path
			else
					-- Try with others books resources.
				across
					book_names as ic
				until
					Result /= Void
				loop
					if attached image_path (a_title, ic.item) as l_path then
						Result := l_path
					end
				end
			end
		end

	template_path (a_title: READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL): detachable PATH
		do
			if a_book_name /= Void then
				if a_book_name.same_string (common_book_name) then
					if attached templates_path_by_title_and_book.item (common_book_name) as ht then
						Result := ht.item (a_title)
					end
				else
					if attached templates_path_by_title_and_book.item (a_book_name) as ht then
						Result := ht.item (a_title)
					end
					if Result = Void then
							-- Try with common resource
						Result := template_path (a_title, common_book_name)
					end
				end
			elseif attached template_path (a_title, common_book_name) as l_path then
					-- Try with common book resources.
				Result := l_path
			else
					-- Try with others books resources.
				across
					book_names as ic
				until
					Result /= Void
				loop
					if attached template_path (a_title, ic.item) as l_path then
						Result := l_path
					end
				end
			end
		end

	page (a_title: READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL): detachable WIKI_PAGE
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
