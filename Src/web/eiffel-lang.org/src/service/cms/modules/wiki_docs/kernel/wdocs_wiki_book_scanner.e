note
	description: "Summary description for {WDOCS_WIKI_BOOK_SCANNER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_WIKI_BOOK_SCANNER

inherit
	DIRECTORY_ITERATOR
		redefine
			process_directory,
			process_file,
			file_excluded
		end

create
	make

feature {NONE} -- Initialization

	make (wb: WIKI_BOOK)
		do
			wiki_book := wb
			create local_pages.make (0)
			process_directory (wb.path)
		end

feature -- Access

	wiki_book: WIKI_BOOK

feature -- Visiting

	process_directory (dn: PATH)
		local
			p: PATH
			ut: FILE_UTILITIES
			l_parent, l_index_page: detachable WIKI_PAGE
			l_name: STRING_32
		do
			if not local_pages.is_empty then
					-- Process previous pages for parent_page
				l_parent := parent_page
				if l_parent /= Void then
					across
						local_pages as ic
					loop
						l_parent.add_page (ic.item)
					end
					local_pages.wipe_out
				end
			end
			if attached dn.entry as e then
				l_name := e.name
			else
				l_name := dn.name
			end

			check local_pages.is_empty end
			local_pages.wipe_out

			if l_parent /= Void then
				l_index_page := l_parent.page (l_name)
			end
			if l_index_page = Void then
				p := dn.extended ("index.wiki")
				if ut.file_path_exists (p) then
					process_file (p)
				end
				l_index_page := local_pages.item (l_name)
				local_pages.wipe_out
			end
			if l_index_page = Void then
				create l_index_page.make (l_name, l_name)
				wiki_book.add_page (l_index_page)
			end

			l_parent := parent_page
			if l_parent /= Void then
				l_parent.add_page (l_index_page)
				l_index_page.set_parent (l_parent)
			end
			parent_page := l_index_page

			Precursor (dn)

			across
				local_pages as ic
			loop
				l_index_page.add_page (ic.item)
			end
			local_pages.wipe_out
			if l_parent /= Void then
				parent_page := wiki_book.page (l_parent.key)
			else
				parent_page := Void
			end
		ensure then
			local_pages.is_empty
		end

	process_file (fn: PATH)
		local
			pn: PATH
			wp: WIKI_PAGE
			l_name: STRING_32
			pk: detachable STRING
		do
			Precursor (fn)
			if attached fn.entry as e then
				l_name := e.name
			else
				l_name := fn.name
			end
			l_name.remove_tail (5) -- (".wiki").count

			if local_pages.has (l_name) then
					-- already processed
				check is_index: l_name.is_case_insensitive_equal_general ("index") end
			else
				if attached parent_page as pp then
					pk := pp.key
				else
					if l_name.is_case_insensitive_equal_general ("index") then
						pn := fn.parent -- Directory
							-- FIXME: truncation or UTF_8
						if attached pn.entry as e then
							pk := e.utf_8_name
						else
							pk := pn.utf_8_name
						end
					else
						pk := l_name
					end
				end

				create wp.make (l_name, pk)
				wp.set_path (fn)
				wiki_book.add_page (wp)
				local_pages.force (wp, l_name) -- TODO: check {WIKI_PAGE}.key ...
			end
		end

feature -- Status report

	file_excluded (fn: PATH): BOOLEAN
			-- Is file `fn' excluded?
		do
			if attached fn.extension as ext and then ext.is_case_insensitive_equal ("wiki") then
					-- Wiki file.
			else
				Result := True
			end
		end

feature {NONE} -- Implementation

	local_pages: STRING_TABLE [WIKI_PAGE]

	parent_page: detachable WIKI_PAGE

end
