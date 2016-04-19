note
	description: "[
			Persistency for WDOCS data on file system.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_FS_STORAGE

inherit
	WDOCS_STORAGE

	WDOCS_DATA_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_manager: WDOCS_MANAGER; a_wiki_db_path: like wiki_database_path; a_tmp_dir: like tmp_dir)
			-- Initialize `Current'.
		do
			manager := a_manager
			metadata_extension := "data"
			index_name := "index"
			wiki_database_path := a_wiki_db_path
			tmp_dir := a_tmp_dir
			create books_data.make
		end

feature -- Settings

	manager: WDOCS_MANAGER

	wiki_database_path: PATH

	tmp_dir: PATH

	metadata_extension: STRING

	index_name: STRING
			-- Default: "index"

feature -- Access		

	book_names: ITERABLE [READABLE_STRING_32]
			-- Available book names.
		local
			l_book_names: like internal_book_names
		do
			l_book_names := internal_book_names
			if l_book_names = Void then
				l_book_names := new_book_names
				internal_book_names := l_book_names
			end
			Result := l_book_names
		end

	books_with_root_page: ITERABLE [WIKI_BOOK]
			-- Available books filled with only the root page.	
		local
			l_books: like internal_books_with_root_page
		do
			l_books := internal_books_with_root_page
			if l_books = Void then
				l_books := new_books_with_root_page
				internal_books_with_root_page := l_books
			end
			Result := l_books
		end

	book (a_bookid: READABLE_STRING_GENERAL): detachable WIKI_BOOK
			-- Book named `a_bookid' if any.
		local
			p: PATH
			vis: WDOCS_WIKI_BOOK_SCANNER
		do
			if attached books_data.book (a_bookid) as b then
				Result := b
			else
				if attached stored_book (a_bookid) as l_book then
					Result := l_book
					books_data.books.force (Result)
				else
					p := wiki_database_path.extended (a_bookid)
					-- Remove support for book.index file.
	--				Result := book_from_index_file (a_bookid, p.extended ("book.index"))
					if Result = Void then
							-- Scan each folder, and sub folder(s)
						create Result.make (a_bookid.as_string_8, p) -- FIXME: truncated
						create vis.make (Result, manager)
					end
					if Result /= Void then
						Result.sort
						books_data.books.force (Result)
--						store_books_data (books_data)
						store_book (a_bookid, Result)
					end
				end
			end
		end

	page (a_bookpage: READABLE_STRING_GENERAL; a_bookid: READABLE_STRING_GENERAL): detachable like new_page
			-- Wiki page for book `a_bookid', and if provided title `a_bookpage', otherwise the root page of related wiki book.
		do
			Result := manager.page (a_bookpage, a_bookid)
		end

	page_book_and_title_for_path (a_path: PATH): detachable TUPLE [bookid: READABLE_STRING_GENERAL; title: READABLE_STRING_GENERAL]
			-- <Precursor>.
		local
			l_bookid: detachable READABLE_STRING_GENERAL
			l_title: detachable READABLE_STRING_GENERAL
		do
			across
				pages_data.pages_path_by_title_and_book as b_ic
			until
				l_title /= Void
			loop
				across
					b_ic.item as p_ic
				until
					l_title /= Void
				loop
					if p_ic.item.same_as (a_path) then
						l_bookid := b_ic.key
						l_title := p_ic.key
					end
				end
			end
			if l_bookid /= Void and l_title /= Void then
				Result := [l_bookid, l_title]
			end
		end

	page_by_title (a_page_title: READABLE_STRING_GENERAL; a_bookid: detachable READABLE_STRING_GENERAL): detachable like new_page
			-- Wiki page with title `a_page_title', and in book related to `a_bookid' if provided.
		do
			if a_bookid /= Void then
				if attached book (a_bookid) as wb then
					Result := wb.page (a_page_title)
				end
			elseif attached pages_data.book_names_with_page_title (a_page_title) as lst and then not lst.is_empty then
				across
					lst as ic
				until
					Result /= Void
				loop
					Result := page_by_title (a_page_title, ic.item)
				end
			end
		end

	page_by_metadata (a_metadata_name, a_metadata_value: READABLE_STRING_GENERAL; a_bookid: detachable READABLE_STRING_GENERAL; is_caseless: BOOLEAN): detachable like new_page
			-- Wiki page with metadata named `a_metadata_name' and value `a_metadata_value' (compare caseless or not depending on `is_caseless',
			-- and in book related to `a_bookid' if provided.
		do
			if a_bookid /= Void then
				if attached book (a_bookid) as wb then
					Result := wb.page_by_metadata (a_metadata_name, a_metadata_value, is_caseless)
				end
			else
				across
					book_names as ic
				until
					Result /= Void
				loop
					Result := page_by_metadata (a_metadata_name, a_metadata_value, ic.item, is_caseless)
				end
			end
		end

	page_by_uuid (a_page_uuid: READABLE_STRING_GENERAL; a_bookid: detachable READABLE_STRING_GENERAL): detachable like new_page
			-- Wiki page associated to UUID `a_page_uuid'.
		do
			Result := page_by_metadata ("uuid", a_page_uuid, a_bookid, True)
		end

	metadata (a_source: PATH; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL]): detachable WDOCS_METADATA
			-- Metadata for page `pg',
			-- if `a_restricted_names' is set, include only those metadata names after `a_restricted_names' items.
		local
			mdf: WDOCS_METADATA_FILE
			mdw: WDOCS_METADATA_WIKI_FILE
			p: PATH
			n: STRING_32
		do
			if attached a_source.extension as ext and then ext.is_case_insensitive_equal_general ("wiki") then
				create mdw.make_with_path (a_source)
				if mdw.exists then
					if a_restricted_names /= Void then
						mdw.get_only_items_named_as (a_restricted_names)
					end
					if mdw.has_metadata then
						Result := mdw
					end
				end
			end
			if Result = Void then
				create mdf.make_with_path (a_source.appended_with_extension (metadata_extension))
				if
					not mdf.exists and then
					attached a_source.extension as ext
				then
					n := a_source.name
					n.remove_tail (1 + ext.count) -- remove .wiki or similar
					create p.make_from_string (n)
					create mdf.make_with_path (p.appended_with_extension (metadata_extension))
				end
				if mdf.exists then
					if a_restricted_names /= Void then
						mdf.get_only_items_named_as (a_restricted_names)
					end
					Result := mdf
				end
			end
		end

	page_metadata (pg: WIKI_PAGE; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL]): detachable WDOCS_METADATA
			-- Metadata for page `pg',
			-- if `a_restricted_names' is set, include only those metadata names after `a_restricted_names' items.
		do
			if attached pg.path as l_path then
					-- Try from WIKI_PAGE.path if any
				Result := metadata (l_path, a_restricted_names)
			end
			if Result = Void and attached {WIKI_BOOK_PAGE} pg as l_book_pg then
					-- Try from src + .wiki or related metadata file.
				Result := metadata (wiki_database_path.extended (l_book_pg.src).appended_with_extension ("wiki"), a_restricted_names)
				if Result = Void then
						-- Try from src and altered index.wiki or related metadata file.
					Result := metadata (wiki_database_path.extended (l_book_pg.parent_key).extended (index_name).appended_with_extension ("wiki"), a_restricted_names)
				end
			end
		end

	file_path (a_filename: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL): detachable PATH
		local
			l_common_book_name: STRING
			p: PATH
			ut: FILE_UTILITIES
		do
			l_common_book_name := {WDOCS_PAGES_DATA}.common_book_name
			if a_book_name /= Void then
				if a_book_name.same_string (l_common_book_name) then
					p := wiki_database_path.extended ("_files").extended (a_filename)
					if ut.file_path_exists (p) then
						Result := p
					end
				else
					p := wiki_database_path.extended (a_book_name).extended ("_files").extended (a_filename)
					if ut.file_path_exists (p) then
						Result := p
					end
					if Result = Void then
							-- Try with common resource
						Result := file_path (a_filename, l_common_book_name)
					end
				end
			elseif attached file_path (a_filename, l_common_book_name) as l_path then
					-- Try with common book resources.
				Result := l_path
			else
					-- Try with others books resources.
				across
					book_names as ic
				until
					Result /= Void
				loop
					if attached file_path (a_filename, ic.item) as l_path then
						Result := l_path
					end
				end
			end
		end

	image_path (a_title: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL): detachable PATH
		local
			l_common_book_name: STRING
		do
			l_common_book_name := {WDOCS_PAGES_DATA}.common_book_name
			if a_book_name /= Void then
				if a_book_name.same_string (l_common_book_name) then
					if attached images_data.images_path_by_title_and_book.item (l_common_book_name) as ht then
						Result := ht.item (a_title)
					end
				else
					if attached images_data.images_path_by_title_and_book.item (a_book_name) as ht then
						Result := ht.item (a_title)
					end
					if Result = Void then
							-- Try with common resource
						Result := image_path (a_title, l_common_book_name)
					end
				end
			elseif attached image_path (a_title, l_common_book_name) as l_path then
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

	images_path_by_title_and_book: STRING_TABLE [STRING_TABLE [PATH]]
			-- Wiki image path indexed by title for each book.
		do
			Result := images_data.images_path_by_title_and_book
		end

	templates_path_by_title_and_book: STRING_TABLE [STRING_TABLE [PATH]]
			-- Wiki template path indexed by title for each book.
		do
			Result := pages_data.templates_path_by_title_and_book
		end

	template_content (a_template: WIKI_TEMPLATE; a_page: detachable WIKI_PAGE): detachable STRING
			-- Text content for template `a_template' in the context of `a_page' if precised.
		local
			db,p: detachable PATH
			d: detachable DIRECTORY
			f: RAW_FILE
			l_template_path: detachable PATH
			l_book_name: detachable READABLE_STRING_GENERAL
		do
			if a_page /= Void then
				l_book_name := manager.book_name (a_page)
			end
			l_template_path := template_path (a_template.name, l_book_name)
			if l_template_path = Void then
				if a_page /= Void then
					p := a_page.path
				end
				db := wiki_database_path
				if p = Void then
					d := directory_within ("_templates", db, db)
				else
					d := directory_within ("_templates", p.parent, db)
				end
				if d /= Void and then d.exists then
					if attached d.path.parent.entry as l_book_entry then
						l_book_name := l_book_entry.name
					else
						check has_book_name: False end
						l_book_name := "_"
					end
					l_template_path := template_path (a_template.name, l_book_name)
					if l_template_path = Void then
						p := d.path.extended (a_template.name).appended_with_extension ("tpl")
						create f.make_with_path (p)
						if f.exists then
							pages_data.record_template_path (p, a_template.name, l_book_name)
							save_pages
							l_template_path := p
						end
					end
				end
			end

			if
				l_template_path /= Void and then
				attached wiki_text_from_file (l_template_path) as l_text
			then
				Result := l_text
			end
		end

	wiki_text (p: WIKI_PAGE): detachable READABLE_STRING_8
		do
			if attached p.path as l_path then
				Result := wiki_text_from_file (l_path)
			elseif attached {WIKI_CONTENT_TEXT} p.text as l_text then
				Result := l_text.content
			end
		end

feature -- Factory

	new_page (a_title: READABLE_STRING_8; a_parent_key: READABLE_STRING_8): WIKI_BOOK_PAGE
			-- Instantiate a new wiki page with title `a_title' and a parent key `a_parent_key'.
		do
			create Result.make (a_title, a_parent_key)
		end

feature -- Access

	existing_pages_data: detachable WDOCS_PAGES_DATA
		do
			Result := internal_pages_data
			if Result = Void then
				if attached stored_pages_data as l_stored_data then
					Result := l_stored_data
				end
				internal_pages_data := Result
			end
		end

	pages_data: WDOCS_PAGES_DATA
		local
			l_data: like internal_pages_data
		do
			l_data := existing_pages_data
			if l_data = Void then
				l_data := new_pages_data
				store_pages_data (l_data)
				internal_pages_data := l_data
			end
			Result := l_data
		end

	images_data: WDOCS_IMAGES_DATA
		local
			l_data: like internal_images_data
		do
			l_data := internal_images_data
			if l_data = Void then
				if attached stored_images_data as l_stored_data then
					l_data := l_stored_data
				else
					l_data := new_images_data (book_names)
					store_images_data (l_data)
				end
				internal_images_data := l_data
			end
			Result := l_data
		end

	books_data: WDOCS_BOOKS_DATA

feature -- Basic operations

	reload
		do
			books_data.reset
			internal_pages_data := Void
			internal_images_data := Void
		end

	refresh
		do
			reset_book_names
			reset_books_data
			reset_images_data
			reset_pages_data
		end

	refresh_page_data (bn: READABLE_STRING_GENERAL; pg: WIKI_PAGE)
		do
			-- TODO: implement smart page refresh!
			refresh
		end

feature -- Persistency

	save_pages
		do
			store_pages_data (pages_data)
		end

	save_images
		do
			store_images_data (images_data)
		end

	save_image_path (a_path: PATH; a_image_name: READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL)
		do
			images_data.record_image_path (a_path, a_image_name, a_book_name)
			save_images
		end


feature {NONE} -- Implementation

	internal_pages_data: detachable like pages_data

	internal_images_data: detachable like images_data

	internal_book_names: detachable like book_names

	internal_books_with_root_page: detachable like books_with_root_page

feature {NONE} -- Implamentation: books

	new_books_with_root_page: ARRAYED_LIST [WIKI_BOOK]
		local
			p: PATH
			d,l_dir: DIRECTORY
			wb: WIKI_BOOK
			wp: like new_page
			md: detachable WDOCS_METADATA
			wb_lst: ARRAYED_LIST [WIKI_BOOK]
			utf: UTF_CONVERTER
			l_name: READABLE_STRING_32
		do
				-- Book names
			p := wiki_database_path
			create d.make_with_path (p)
			create wb_lst.make (5)
			if d.exists then
				across
					d.entries as ic
				loop
					l_name := ic.item.name
					if
						not ic.item.is_parent_symbol and
						not ic.item.is_current_symbol and
						not l_name.starts_with ("_") and
						not l_name.starts_with (".")
					then
						create l_dir.make_with_path (p.extended (l_name))
						if l_dir.exists then
									-- FIXME: unicode support in Wikitext lib?
							create wb.make (utf.escaped_utf_32_string_to_utf_8_string_8 (l_name), l_dir.path.extended (l_name))

							wp := new_page ("index", wb.name)
							md := page_metadata (wp, Void)
							if md = Void then
								wp := new_page (wb.name, wb.name)
								md := page_metadata (wp, Void)
							end
							if md /= Void then
								if attached md.item ("weight") as l_weight and then l_weight.is_integer then
									wp.set_weight (l_weight.to_integer)
								end
								if attached md.item ("title") as l_title and then not l_title.is_whitespace then
									wp.set_title (l_title)
								end
								across
									md as md_ic
								loop
									wp.set_metadata (md_ic.item, md_ic.key)
								end
								if wp.metadata ("link_title") = Void then
									wp.set_metadata (wp.title, "link_title") -- Avoid multiple queries.
								end
							end
							wb.add_page (wp)
							wb_lst.force (wb)
						end
					end
				end
			end

				-- Sort by name and weight
			sort_books (wb_lst)

			Result := wb_lst
		end

	new_book_names: ARRAYED_LIST [READABLE_STRING_32]
		local
			wb_lst: ITERABLE [WIKI_BOOK]
		do
			wb_lst := books_with_root_page

				-- Records book names.
			create Result.make (3)
			across
				wb_lst as ic
			loop
				Result.force (ic.item.name)
			end
		end

	book_from_index_file (a_book_id: READABLE_STRING_GENERAL; p: PATH): detachable WIKI_BOOK
			-- Book built with index file `p'
			-- usually "book.index".
--		local
--			w: WIKI_INDEX
--			ut: FILE_UTILITIES
		do
--			if ut.file_path_exists (p) then
--					-- Based on book.index
--				create w.make (a_book_id.as_string_8, p)
--				Result := w.book
--			end
		end

feature {NONE} -- Storage: books		

	book_cache (a_book_id: READABLE_STRING_GENERAL): WDOCS_FILE_OBJECT_CACHE [WIKI_BOOK]
		local
			p: PATH
		do
			p := wiki_database_path
			if attached p.entry as e then
				p := tmp_dir.extended ("cache").extended_path (e).extended ("book__").appended (a_book_id).appended_with_extension ("data")
			else
				p := p.appended ("book__").appended (a_book_id).appended_with_extension ("data")
			end
			create Result.make (p)
		end

	stored_book (a_book_id: READABLE_STRING_GENERAL): detachable WIKI_BOOK
		do
			Result := book_cache (a_book_id).item
		end

	store_book (a_book_id: READABLE_STRING_GENERAL; a_book: WIKI_BOOK)
		do
			book_cache (a_book_id).put (a_book)
		end

	reset_book (a_book_id: READABLE_STRING_GENERAL)
			-- Reset book in cache, if any
		do
			book_cache (a_book_id).delete
		end

	reset_book_names
			-- Reset `book_names'.
		do
			internal_book_names := Void
		end

	reset_books_data
			-- Reset books data in cache, if any
		do
			books_data.reset
			across
				book_names as ic
			loop
				reset_book (ic.item)
			end
		end

feature {NONE} -- Implementation: pages

	template_path (a_title: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL): detachable PATH
		local
			l_data: like pages_data
			l_common_book_name: READABLE_STRING_GENERAL
		do
			l_data := pages_data
			l_common_book_name := l_data.common_book_name
			if a_book_name /= Void then
				if a_book_name.same_string (l_common_book_name) then
					if attached l_data.templates_path_by_title_and_book.item (l_common_book_name) as ht then
						Result := ht.item (a_title)
					end
				else
					if attached l_data.templates_path_by_title_and_book.item (a_book_name) as ht then
						Result := ht.item (a_title)
					end
					if Result = Void then
							-- Try with common resource
						Result := template_path (a_title, l_common_book_name)
					end
				end
			elseif attached template_path (a_title, l_common_book_name) as l_path then
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

	new_pages_data: like pages_data
			-- Read data from the wikidatabase and save it on `data'.
			-- Save the data on a cache.
		do
			create Result.make

			across
				book_names as ic
			loop
				Result.book_names.force (ic.item)
			end

				-- Record association between wiki page title, and wiki files		
			across
				book_names as ic
			loop
				if attached book (ic.item) as l_wikibook then
					across
						l_wikibook.pages as p_ic
					loop
						if attached p_ic.item.path as l_page_path then
							Result.record_page_path (l_page_path, p_ic.item.title, l_wikibook.name)
						else
							check has_path: False end
						end
					end
				end
			end

				-- Index templates
			get_templates_data (Result)
		end

	get_templates_data (a_data: like pages_data)
		do
				-- Index images
				-- global
			index_templates_for_book_info_data (Void, a_data)
				-- and for each book
			across
				book_names as ic
			loop
				index_templates_for_book_info_data (ic.item, a_data)
			end
		end

	index_templates_for_book_info_data (a_book_name: detachable READABLE_STRING_GENERAL; a_data: WDOCS_PAGES_DATA)
			-- Index wiki templates for book `a_book_name' (or for all books if `a_book_name' is Void), and save it into `a_data'.
		local
			ht: STRING_TABLE [PATH]
			i, p: PATH
			d: DIRECTORY
			f: RAW_FILE
			l_title: detachable STRING_8
			l_filename: detachable STRING_32
			md: WDOCS_METADATA_FILE
		do
			create ht.make_caseless (0)
			if a_book_name /= Void then
				p := wiki_database_path.extended (a_book_name).extended ("_templates")
			else
				p := wiki_database_path.extended ("_templates")
			end
			create d.make_with_path (p)
			if d.exists and then d.is_readable then
				across
					d.entries as ic
				loop
					i := ic.item
					l_title := Void
					l_filename := Void
					if i.is_current_symbol or i.is_parent_symbol then
							-- Ignore
					elseif attached i.extension as ext then
						if ext.is_case_insensitive_equal_general (metadata_extension) then
							create md.make_with_path (p.extended_path (i))
							if md.exists then
								md.get_only_items_named_as (<<"title", "filename">>)
								if l_title /= Void then
									if l_filename = Void then
										if attached i.entry as e then
											l_filename := e.name
											l_filename.remove_tail (1 + metadata_extension.count) -- extension ".data"
											create f.make_with_path (d.path.extended (l_filename))
											if not f.exists then
												l_filename.append (".tpl") -- use PATH.appended_with_extension !
												create f.make_with_path (d.path.extended (l_filename))
												if not f.exists then
													l_filename := Void
												end
											end
										end
									end
								end
							end
						elseif ext.is_case_insensitive_equal_general ("tpl") then
								-- Not . or ..
								-- Not *.md
								-- Could be a template *.tpl or others ...
							if attached i.entry as e then
								l_filename := e.name
								l_title := l_filename.head (l_filename.count - 1 - ext.count)
							end
						end
						if l_title /= Void and l_filename /= Void then
							ht.force (d.path.extended (l_filename), l_title)
						end
					end
				end
			end
			if a_book_name /= Void then
				a_data.templates_path_by_title_and_book.force (ht, a_book_name)
			else
				a_data.templates_path_by_title_and_book.force (ht, a_data.common_book_name)
			end
		end

	update_wiki_page (wb: WIKI_BOOK; wp: WIKI_BOOK_PAGE; a_wp_path: PATH; a_parent: detachable WIKI_BOOK_PAGE)
		require
			a_wp_path_set: a_wp_path /= Void
		local
			n1,n2: STRING_32
			p: PATH
			s: STRING_32
			k: STRING_32
		do
			wp.set_path (a_wp_path)
			if attached page_metadata (wp, Void) as md then
				if attached md.item ("weight") as l_weight and then l_weight.is_integer then
					wp.set_weight (l_weight.to_integer)
				end
				if attached md.item ("title") as l_title and then not l_title.is_whitespace then
					wp.set_title (l_title)
				end
				across
					md as md_ic
				loop
					wp.set_metadata (md_ic.item, md_ic.key)
				end
				if wp.metadata ("link_title") = Void then
					wp.set_metadata (wp.title, "link_title") -- Avoid multiple queries.
				end
			end

			n1 := wb.path.absolute_path.canonical_path.name
			n2 := a_wp_path.absolute_path.canonical_path.name
			if n2.ends_with_general (".wiki") then
				n2.remove_tail (5)
			end
			if n2.starts_with (n1) then
				create p.make_from_string (n2.substring (n1.count + 1 + 1, n2.count)) -- remove first directory separator
				create s.make (p.name.count + 10)
				s.append (wb.name.as_string_8) -- FIXME: (#unicode) truncated to string8 !!!
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
		ensure
			path_set: wp.path /= Void
		end

feature {NONE} -- Storage: pages

	pages_cache: WDOCS_FILE_OBJECT_CACHE [WDOCS_PAGES_DATA]
		local
			p: PATH
		do
			p := wiki_database_path
			if attached p.entry as e then
				p := tmp_dir.extended ("cache").extended_path (e).extended ("pages").appended_with_extension ("data")
			else
				p := p.appended ("pages").appended_with_extension ("data")
			end
			create Result.make (p)
		end

	stored_pages_data: detachable WDOCS_PAGES_DATA
			-- Retrieve data from cache, if any.
		do
			Result := pages_cache.item
		end

	store_pages_data (d: WDOCS_PAGES_DATA)
			-- Store data on cahce.
		do
			pages_cache.put (d)
		end

	reset_pages_data
			-- Reset data in cache, if any
		do
			pages_cache.delete
			internal_pages_data := Void
		end

feature {NONE} -- Implementation: images

	new_images_data (a_book_names: ITERABLE [READABLE_STRING_GENERAL]): like images_data
		do
			create Result.make
			get_images_data (Result, a_book_names)
		end

	get_images_data (a_data: like images_data; a_book_names: ITERABLE [READABLE_STRING_GENERAL])
		do
				-- Index images
				-- global
			index_images_for_book_info_data (Void, a_data)
				-- and for each book
			across
				a_book_names as ic
			loop
				index_images_for_book_info_data (ic.item, a_data)
			end
		end

	index_images_for_book_info_data (a_book_name: detachable READABLE_STRING_GENERAL; a_data: WDOCS_IMAGES_DATA)
			-- Index wiki images for book `a_book_name' (or for all books if `a_book_name' is Void), and save it into `a_data'.
		local
			ht: STRING_TABLE [PATH]
			i, p: PATH
			d: DIRECTORY
			f: RAW_FILE
			l_title: detachable STRING_32
			l_filename: detachable STRING_32
			md: WDOCS_METADATA_FILE
		do
			create ht.make_caseless (0)
			if a_book_name /= Void then
				p := wiki_database_path.extended (a_book_name).extended ("_images")
			else
					-- Common Images for all books
				p := wiki_database_path.extended ("_images")
			end
			create d.make_with_path (p)
			if d.exists and then d.is_readable then
				across
					d.entries as ic
				loop
					i := ic.item
					l_title := Void
					l_filename := Void
					if i.is_current_symbol or i.is_parent_symbol then
							-- Ignore
					elseif attached i.extension as ext then
						if ext.is_case_insensitive_equal_general (metadata_extension) then
							create md.make_with_path (p.extended_path (i))
							if md.exists then
								md.get_only_items_named_as (<<"title", "filename">>)
								l_title := md.item ("title")
								l_filename := md.item ("filename")
								if l_filename = Void then
									if attached i.entry as e then
										l_filename := e.name
										l_filename.remove_tail (1 + metadata_extension.count) -- extension ".data"
										create f.make_with_path (d.path.extended (l_filename))
										if not f.exists then
											l_filename := Void
										end
									end
								end
							end
						elseif attached i.entry as e then
								-- Not . or ..
								-- not a *.data file
								-- hopefully .. an image file
							l_filename := e.name
							l_title := l_filename.head (l_filename.count - 1 - ext.count) -- removing "." + ext
						end
						if l_title /= Void and l_filename /= Void then
							ht.force (d.path.extended (l_filename), l_title)
						end
					end
				end
			end
			if a_book_name /= Void then
				a_data.images_path_by_title_and_book.force (ht, a_book_name)
			else
				a_data.images_path_by_title_and_book.force (ht, a_data.common_book_name)
			end
		end


feature {NONE} -- Storage: images					

	images_cache: WDOCS_FILE_OBJECT_CACHE [WDOCS_IMAGES_DATA]
		local
			p: PATH
		do
			p := wiki_database_path
			if attached p.entry as e then
				p := tmp_dir.extended ("cache").extended_path (e).appended_with_extension ("images")
			else
				p := p.appended_with_extension ("images")
			end
			create Result.make (p)
		end

	stored_images_data: detachable WDOCS_IMAGES_DATA
			-- Retrieve data from cache, if any.
		do
			Result := images_cache.item
		end

	store_images_data (d: WDOCS_IMAGES_DATA)
			-- Store data on cahce.
		do
			images_cache.put (d)
		end

	reset_images_data
			-- Reset data in cache, if any
		do
			images_cache.delete
			internal_images_data := Void
		end

feature {NONE} -- Helpers

	directory_within (a_name: READABLE_STRING_GENERAL; a_path: PATH; a_root: detachable PATH): detachable DIRECTORY
			-- Directory named `a_name' in a_path, or if `a_root' is set, search in parents until `a_root' is reached.
		local
			p: PATH
			l_root: PATH
			l_root_name: READABLE_STRING_32
			l_path_name: READABLE_STRING_32
			done: BOOLEAN
		do
			p := a_path.extended (a_name)
			create Result.make_with_path (p)
			if not Result.exists then
				Result := Void
					-- Search in parent until a_root is found.
				if a_root /= Void then
					l_root := a_root.absolute_path.canonical_path
					l_root_name := l_root.name
					l_path_name := a_path.absolute_path.canonical_path.name
					if l_path_name.starts_with (l_root_name) then
						from
							done := False
						until
							done
						loop
							p := p.parent
							create Result.make_with_path (p.extended (a_name))
							done := Result.exists or else p.same_as (l_root) or p.is_current_symbol
						end
						if Result /= Void and then not Result.exists then
							Result := Void
						end
					end
				end
			end
		ensure
			Result /= Void implies Result.exists
		end

	wiki_text_from_file (fn: PATH): detachable STRING
		local
			f: RAW_FILE
			l_done: BOOLEAN
		do
			create f.make_with_path (fn)
			if f.exists and then f.is_access_readable then
				create Result.make (f.count)
				f.open_read
				from
					l_done := f.exhausted or f.end_of_file
				until
					l_done
				loop
					f.read_stream_thread_aware (2_048)
					Result.append (f.last_string)
					l_done := f.exhausted or f.end_of_file or f.last_string.count < 2_048
				end
				f.close
				Result.prune_all ('%R')
			end
		end

	sort_books (lst: LIST [WIKI_BOOK])
			-- Sort `pages' and sub pages.
		local
			l_sorter: QUICK_SORTER [WIKI_BOOK]
		do
			create l_sorter.make (create {COMPARABLE_COMPARATOR [WIKI_BOOK]})
			l_sorter.sort (lst)
		end

invariant


end
