note
	description: "Summary description for {WDOCS_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_DATA

inherit
	WDOCS_HELPER

	WDOCS_IMAGES_DATA
		rename
			make as make_images_data
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create book_names.make (0)
			create pages_path_by_title_and_book.make_caseless (0)
			make_images_data
			create templates_path_by_title_and_book.make_caseless (0)
		end

feature {WDOCS_DATA_ACCESS} -- Access

	book_names: ARRAYED_LIST [READABLE_STRING_32]

	pages_path_by_title_and_book: STRING_TABLE [STRING_TABLE [PATH]]
			-- Wiki page path indexed by page title for each book.

	templates_path_by_title_and_book: STRING_TABLE [STRING_TABLE [PATH]]
			-- Wiki template path indexed by title for each book.	

	common_book_name: STRING = ""
			-- Book name representing resource common to all books.

feature {WDOCS_DATA_ACCESS} -- Query

	template_path (a_title: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL): detachable PATH
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

	book_names_with_page_title (a_title: READABLE_STRING_GENERAL): ARRAYED_LIST [READABLE_STRING_32]
		local
			l_normalized_title: like normalized_fs_text
		do
			create Result.make (0)
			l_normalized_title := normalized_fs_text (a_title)
			across
				book_names as ic
			loop
				if attached normalized_page_path (l_normalized_title, normalized_fs_text (ic.item)) as p then
					Result.force (ic.item)
				end
			end
		end

	page_path (a_title: READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL): detachable PATH
		do
			Result := normalized_page_path (normalized_fs_text (a_title), normalized_fs_text (a_book_name))
		end

feature {NONE} -- Normalized calls		

	normalized_page_path (a_normalized_title: READABLE_STRING_GENERAL; a_normalized_book_name: READABLE_STRING_GENERAL): detachable PATH
		do
			if attached pages_path_by_title_and_book.item (a_normalized_book_name) as ht then
				Result := ht.item (a_normalized_title)
			end
		end

feature {WDOCS_DATA_ACCESS} -- Element change

	record_page_path (a_path: PATH; a_page_name: READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL)
		local
			ht: detachable STRING_TABLE [PATH]
		do
			ht := pages_path_by_title_and_book.item (a_book_name)
			if ht = Void then
				create ht.make (1)
				pages_path_by_title_and_book.force (ht, a_book_name)
			end
			ht.force (a_path, a_page_name)
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
