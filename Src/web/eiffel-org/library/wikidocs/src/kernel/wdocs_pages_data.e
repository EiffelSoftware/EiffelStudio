note
	description: "Summary description for {WDOCS_PAGES_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_PAGES_DATA

inherit
	WDOCS_DATA_I
	WDOCS_HELPER

create
	make

feature {NONE} -- Initialization

	make
		do
			create book_names.make (0)
			create pages_path_by_title_and_book.make_caseless (0)
			create templates_path_by_title_and_book.make_caseless (0)
		end

feature {WDOCS_DATA_ACCESS} -- Access

	book_names: ARRAYED_LIST [READABLE_STRING_32]

	pages_path_by_title_and_book: STRING_TABLE [STRING_TABLE [PATH]]
			-- Wiki page path indexed by page title for each book.

	templates_path_by_title_and_book: STRING_TABLE [STRING_TABLE [PATH]]
			-- Wiki template path indexed by title for each book.	

feature {WDOCS_DATA_ACCESS} -- Query

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
			pn, bn: like normalized_fs_text
		do
			bn := normalized_fs_text (a_book_name)
			pn := normalized_fs_text (a_page_name)

			ht := pages_path_by_title_and_book.item (bn)
			if ht = Void then
				create ht.make (1)
				pages_path_by_title_and_book.force (ht, bn)
			end
			ht.force (a_path, pn)
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
