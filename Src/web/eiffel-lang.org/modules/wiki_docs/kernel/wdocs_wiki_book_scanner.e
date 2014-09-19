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
		local
			ut: FILE_UTILITIES
		do
			wiki_book := wb
			create parent_pages.make (0)
			create local_pages.make (0)

			if ut.directory_path_exists (wb.path) then
				process_directory (wb.path)
			end
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
			l_parent := parent_page
			if not local_pages.is_empty then
					-- Process previous pages for parent_page
				if l_parent /= Void then
					across
						local_pages as ic
					loop
						if ic.item /= l_parent then
							l_parent.add_page (ic.item)
						end
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
				l_index_page := local_pages.item ("index")
				if l_index_page = Void then
					create l_index_page.make (l_name, l_name)
					wiki_book.add_page (l_index_page)

				end
				if l_parent /= Void then
					l_parent.add_page (l_index_page)
					l_index_page.set_parent (l_parent)
				end
			else
					-- Reuse parent sub page.
			end

				-- Now the parent page is the new one.
			push_parent_page (l_index_page)

			Precursor (dn)
			local_pages.prune (l_index_page)

			across
				local_pages as ic
			loop
				l_index_page.add_page (ic.item)
			end
			local_pages.wipe_out

			pop_parent_page
--			if l_parent /= Void then
--				parent_page := wiki_book.page_by_key (l_parent.key)
--			else
--				parent_page := Void
--			end
		ensure then
			local_pages.is_empty
		end

	process_file (fn: PATH)
		local
			pn: PATH
			wp: WIKI_PAGE
			l_name: STRING_32
			wk, pk: detachable STRING
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
				wk := l_name
				if attached parent_page as pp then
					pk := pp.key
					if pk.is_case_insensitive_equal_general ("index") then
						pk := pp.title
					end
					if l_name.is_case_insensitive_equal_general ("index") then
						pn := fn.parent -- Directory
							-- FIXME: truncation or UTF_8
						if attached pn.entry as e then
							l_name := e.utf_8_name
						else
							l_name := pn.utf_8_name
						end
					end
				else
					if l_name.is_case_insensitive_equal_general ("index") then
						pn := fn.parent -- Directory
							-- FIXME: truncation or UTF_8
						if attached pn.entry as e then
							l_name := e.utf_8_name
						else
							l_name := pn.utf_8_name
						end
						wk := "index"
						pk := l_name
					else
						pk := l_name
					end
				end

				create wp.make (l_name, pk)
				update_page_source (wiki_book, wp, fn, parent_page)
--				if attached parent_page as pp then
--					wp.set_src (pp.parent_key + "/" + l_name)
--				else
--					wp.set_src (wp.parent_key + "/" + wk)
--				end
				wiki_book.add_page (wp)
				local_pages.force (wp, wk) -- TODO: check {WIKI_PAGE}.key ...
			end
		end

	update_page_source (wb: WIKI_BOOK; wp: WIKI_PAGE; a_wp_path: PATH; a_parent: detachable WIKI_PAGE)
		local
			n1,n2: STRING_32
			p: PATH
			s: STRING_32
			k: STRING_32
		do
			wp.set_path (a_wp_path)
			n1 := wb.path.absolute_path.canonical_path.name
			n2 := a_wp_path.absolute_path.canonical_path.name
			if n2.ends_with_general (".wiki") then
				n2.remove_tail (5)
			end
			if n2.starts_with (n1) then
				create p.make_from_string (n2.substring (n1.count + 1 + 1, n2.count)) -- remove first directory separator
				create s.make (p.name.count + 10)
				s.append (wb.name)
				across
					p.components as ic
				loop
					s.append_character ('/')
					s.append (ic.item.name)
				end
				wp.set_src (s)
			else
				check page_under_book_directory: False end
				if attached a_wp_path.entry as e then
					k := e.name
				else
					k := a_wp_path.name
				end
				if k.ends_with_general (".wiki") then
					k.remove_tail (5) -- remove ".wiki"
				end
				if a_parent /= Void then
					wp.set_src (a_parent.src + "/" + k)
				else
					wp.set_src (wp.parent_key + "/" + k)
				end
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
		do
			if not parent_pages.is_empty then
				Result := parent_pages.item
			end
		end

	parent_pages: ARRAYED_STACK [WIKI_PAGE]

	push_parent_page (wp: WIKI_PAGE)
		do
			parent_pages.force (wp)
		ensure
			parent_pages_not_empty: not parent_pages.is_empty
			wp_set: parent_pages.item = wp
		end

	pop_parent_page
		require
			parent_pages_not_empty: not parent_pages.is_empty
		do
			parent_pages.remove
		end

end
