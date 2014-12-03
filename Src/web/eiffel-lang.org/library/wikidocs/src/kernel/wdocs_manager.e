note
	description: "Component implementing the wiki database, and wiki item resolving"
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_MANAGER

inherit
	WIKI_LINK_RESOLVER
		rename
			wiki_url as link_to_wiki_url
		end

	WIKI_IMAGE_RESOLVER
		rename
			wiki_url as image_to_wiki_url,
			url as image_to_url
		end

	WIKI_TEMPLATE_RESOLVER
		rename
			content as template_content
		end

	REFACTORING_HELPER

	WDOCS_DATA_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_wiki_dir: PATH; a_version_id: like version_id; a_tmp_dir: PATH)
		do
			wiki_database_path := a_wiki_dir
			version_id := a_version_id
			tmp_dir := a_tmp_dir
			initialize
		end

	initialize
			-- Initialize values.
		do
			metadata_extension := "data"
			index_name := "index"

			get_all_data
		end

feature -- Access

	wiki_database_path: PATH

	version_id: detachable READABLE_STRING_GENERAL

	tmp_dir: PATH

	data: WDOCS_DATA

	books_data: WDOCS_BOOKS_DATA

feature -- Data access

	image_path (a_title: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL): detachable PATH
		local
			l_common_book_name: STRING
		do
			l_common_book_name := {WDOCS_DATA}.common_book_name
			if a_book_name /= Void then
				if a_book_name.same_string (l_common_book_name) then
					if attached data.images_path_by_title_and_book.item (l_common_book_name) as ht then
						Result := ht.item (a_title)
					end
				else
					if attached data.images_path_by_title_and_book.item (a_book_name) as ht then
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

feature -- Settings

	metadata_extension: STRING
			-- Default: "data"

	index_name: STRING
			-- Default: "index"

feature -- Basic operations

	reload_data
			-- Discard memory cache for `data',
			-- and reload it from file system.
		do
			get_all_data
		end

	refresh_data
			-- Refresh manager data.
		do
			reset_books_data
			reset_data
			get_all_data
		end

feature -- Access

	book_names: ITERABLE [READABLE_STRING_32]
			-- Available book names.
		do
			Result := data.book_names
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
				p := wiki_database_path.extended (a_bookid)
				-- Remove support for book.index file.
--				Result := book_from_index_file (a_bookid, p.extended ("book.index"))
				if Result = Void then
						-- Scan each folder, and sub folder(s)
					create Result.make (a_bookid.as_string_8, p) -- FIXME: truncated
					create vis.make (Result, Current)
				end
				if Result /= Void then
					Result.sort
					books_data.books.force (Result)
					store_books_data (books_data)
				end
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

	page (a_bookid: READABLE_STRING_GENERAL; a_bookpage: detachable READABLE_STRING_GENERAL): detachable like new_wiki_page
			-- Wiki page for book `a_bookid', and if provided title `a_bookpage', otherwise the root page of related wiki book.
		local
			n: READABLE_STRING_GENERAL
			p: PATH
			f: PLAIN_TEXT_FILE
			wi: WIKI_INDEX
			pg: detachable like new_wiki_page
			ut: FILE_UTILITIES
		do
			if a_bookpage = Void then
				n := "index"
			else
				n := a_bookpage
			end

			p := wiki_database_path.extended (a_bookid).extended ("book.index")
			if ut.file_path_exists (p) then
				create wi.make (a_bookid.as_string_8, wiki_database_path.extended (a_bookid).extended ("book.index"))
				pg := wi.page_by_id (n)
			elseif attached book (a_bookid) as wb then
				pg := wb.page (n)
				if pg = Void then
					pg := wb.page_by_key (n)
				end
			end
			if attached {WIKI_BOOK_PAGE} pg as l_book_page then
				p := wiki_database_path.extended (l_book_page.src)
			else
				p := wiki_database_path.extended (a_bookid).extended (n)
			end
			p := p.appended_with_extension ("wiki")
			create f.make_with_path (p)
			if not f.exists then
				if attached {WIKI_BOOK_PAGE} pg as l_book_pg then
					p := wiki_database_path.extended (l_book_pg.src)
				else
					p := wiki_database_path.extended (a_bookid).extended (n)
				end
				p := p.extended ("index.wiki")
				create f.make_with_path (p)
			end
			if f.exists then
				if pg /= Void then
					Result := pg
				else
					Result := new_wiki_page (n.as_string_8, n.as_string_8)
				end
				Result.get_structure (p)
			end
		end

	page_by_title (a_page_title: READABLE_STRING_GENERAL; a_bookid: detachable READABLE_STRING_GENERAL): detachable WIKI_PAGE
			-- Wiki page with title `a_page_title', and in book related to `a_bookid' if provided.
		do
			if a_bookid /= Void then
				Result := page (a_bookid, a_page_title)
			elseif attached data.book_names_with_page_title (a_page_title) as lst and then not lst.is_empty then
				across
					lst as ic
				until
					Result /= Void
				loop
					Result := page (ic.item, a_page_title)
				end
			end
		end

	page_by_uuid (a_page_uuid: READABLE_STRING_GENERAL): detachable WIKI_PAGE
			-- Wiki page associated to UUID `a_page_uuid'.
		local
		do
			-- TODO: implement this
		end

	wiki_text (p: WIKI_PAGE): detachable READABLE_STRING_8
		require
			path_set: p.path /= Void
		do
			if attached p.path as l_path then
				Result := wiki_text_from_file (l_path)
			end
		end

feature -- Access: link

	link_to_wiki_url (a_link: WIKI_LINK; a_page: detachable WIKI_PAGE): detachable STRING
		local
			db,p,pp,lnk: detachable PATH
			f: RAW_FILE
			wi: WIKI_INDEX
			l_book_name: like book_name
		do
			if a_page /= Void then
				l_book_name := book_name (a_page)
			end
			if attached page_by_title (a_link.name, l_book_name) as pg then
				Result := wiki_page_uri_path (pg)
			end

			if Result = Void then
					-- Try to find a book.index if any.
				db := wiki_database_path
				if p = Void then
					p := db
				else
					p := p.parent
				end
				from
					pp := p
					lnk := pp.extended ("book.index")
					create f.make_with_path (lnk)
				until
					f.exists or pp.same_as (db) or pp.is_current_symbol
				loop
					pp := pp.parent
					lnk := pp.extended ("book.index")
					create f.make_with_path (lnk)
				end
				if f.exists then
					create wi.make ("book", f.path)
					if attached wi.page (a_link.name) as pg then
						Result := wiki_page_uri_path (pg)
					end
				end

			end

			if Result /= Void then
				if attached version_id as vid then
					Result.prepend ("/version/" + percent_encoder.percent_encoded_string (vid))
				end
			end
		end

	wiki_page_uri_path (pg: WIKI_PAGE): STRING
		local
			utf: UTF_CONVERTER
			l_path: detachable READABLE_STRING_32
		do
			if attached page_metadata (pg, <<"path">>) as md then
				l_path := md.item ("path")
			end
			if l_path /= Void then
				Result := "/" + utf.string_32_to_utf_8_string_8 (l_path)
			elseif attached book_name (pg) as bn then
				Result := "/book/" + bn + "/" + pg.title
			elseif attached {WIKI_BOOK_PAGE} pg as l_book_pg then
				Result := "/book/" + l_book_pg.src
			else
				Result := "/book/" -- FIXME
			end
		end

	wiki_page_title (pg: WIKI_PAGE): STRING
		local
			utf: UTF_CONVERTER
		do
			if pg.metadata_count > 0 then
				Result := pg.title -- metadata already associated, so `title' should have expected value.
			else
				if
					attached page_metadata (pg, <<"title">>) as md and then
					attached md.item ("title") as l_title and then
					not l_title.is_whitespace
				then
					Result := utf.escaped_utf_32_string_to_utf_8_string_8 (l_title)
				else
					Result := pg.title
				end
			end
		end

	wiki_page_link_title (pg: WIKI_PAGE): STRING
		local
			utf: UTF_CONVERTER
			l_title: detachable READABLE_STRING_32
		do
			l_title := pg.metadata ("link_title")
			if l_title = Void or else l_title.is_whitespace then
				if attached page_metadata (pg, <<"link_title">>) as md then
					l_title := md.item ("link_title")
				end
			end
			if l_title /= Void then
				Result := utf.escaped_utf_32_string_to_utf_8_string_8 (l_title)
			else
				Result := wiki_page_title (pg)
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
		ensure
			result_attached_implies_exists: Result /= Void implies not attached {WDOCS_METADATA_FILE} Result as mdf or else mdf.exists
		end

	metadata (a_source: PATH; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL]): detachable WDOCS_METADATA
			-- Metadata for page `pg',
			-- if `a_restricted_names' is set, include only those metadata names after `a_restricted_names' items.
		local
			mdf: WDOCS_METADATA_FILE
			mdw: WDOCS_METADATA_WIKI
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
		ensure
			result_attached_implies_exists: Result /= Void implies (
						(not attached {WDOCS_METADATA_FILE} Result as en_mdf or else en_mdf.exists)
					or
						(not attached {WDOCS_METADATA_WIKI} Result as en_mdw or else en_mdw.exists)
					)
		end

feature -- Access: Image

	image_to_wiki_url (a_link: WIKI_IMAGE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
		do
			Result := "/images/" + a_link.name

			if Result /= Void then
				if attached version_id as vid then
					Result.prepend ("/version/" + percent_encoder.percent_encoded_string (vid))
				end
			end
		end

	image_to_url (a_link: WIKI_IMAGE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
		local
			l_book_name: detachable READABLE_STRING_32
			db,p,pp,img: detachable PATH
			d: DIRECTORY
			f: RAW_FILE
			s0,s2: STRING_32
			l_image_path: detachable PATH
			bak: INTEGER
		do
			if a_page /= Void then
				l_book_name := book_name (a_page)
			end
				-- `l_book_name' could be Void
			l_image_path := image_path (a_link.name, l_book_name)
			if l_image_path /= Void then
				s0 := l_image_path.parent.parent.name
				if l_book_name = Void then
					if attached l_image_path.parent.parent.entry as l_book_entry then
						l_book_name := l_book_entry.name
					else
						check has_book_name: False end
						l_book_name := data.common_book_name
					end
				end
			else
				db := wiki_database_path
				if a_page /= Void then
					p := a_page.path
				end
				if p = Void then
					p := db
				else
					p := p.parent
				end
				from
					pp := p
					img := pp.extended ("_images")
					create d.make_with_path (img)
				until
					d.exists or pp.same_as (db) or pp.is_current_symbol
				loop
					bak := bak + 1
					pp := pp.parent
					img := pp.extended ("_images")
					create d.make_with_path (img)
				end
				s0 := pp.name
				if d.exists then
					if attached d.path.parent.entry as l_book_entry then
						l_book_name := l_book_entry.name
					else
						check has_book_name: False end
						l_book_name := data.common_book_name
					end
					l_image_path := image_path (a_link.name, l_book_name)
					if l_image_path = Void then
						p := d.path.extended (a_link.name).appended_with_extension ("png")
						create f.make_with_path (p)
						if f.exists then
							data.record_image_path (p, a_link.name, l_book_name)
							store_data (data)
							l_image_path := p
						end
					end
				end
			end

			if l_image_path /= Void and l_book_name /= Void then
				create f.make_with_path (l_image_path)
				if f.exists then
					s2 := l_image_path.name
					if s2.starts_with (s0) then
						s2 := s2.substring (s0.count + 1 + 1, s2.count)
						create p.make_from_string (s2)
					else
						p := f.path
						bak := 0
					end
					create Result.make_empty
					if a_page /= Void then
						Result.append ("/book/")
						Result.append (percent_encoder.percent_encoded_string (l_book_name))
						across
							p.components as ic
						loop
							if not Result.is_empty then
								Result.append_character ('/')
							end
							Result.append (percent_encoder.percent_encoded_string (ic.item.name))
						end
					else
						Result.append ("/images/" + a_link.name)
--	This commented code was used to try to compute relative path, give another try later.
--						create Result.make (p.name.count)
--						from
--						until
--							bak <= 1
--						loop
--							if not Result.is_empty then
--								Result.append_character ('/')
--							end
--							Result.append ("..")
--							bak := bak - 1
--						end
--						across
--							p.components as ic
--						loop
--							if not Result.is_empty then
--								Result.append_character ('/')
--							end
--							Result.append (percent_encoder.percent_encoded_string (ic.item.name))
--						end							
					end
				end
			end
			if Result /= Void then
				if attached version_id as vid then
					Result.prepend ("/version/" + percent_encoder.percent_encoded_string (vid))
				end
			end
		end

feature -- Access: Template

	template_content (a_template: WIKI_TEMPLATE; a_page: detachable WIKI_PAGE): detachable STRING
			-- Text content for template `a_template' in the context of `a_page' if precised.
		local
			db,p,pp,l_tpl_path: detachable PATH
			d: DIRECTORY
			f: RAW_FILE
			s0,s1: STRING_32
			l_template_path: detachable PATH
			bak: INTEGER
			l_book_name: detachable READABLE_STRING_GENERAL
		do
			if a_page /= Void then
				l_book_name := book_name (a_page)
			end
			l_template_path := data.template_path (a_template.name, l_book_name)
			if l_template_path = Void then
				if a_page /= Void then
					p := a_page.path
				end
				db := wiki_database_path
				if p = Void then
					p := db
				else
					p := p.parent
				end
				s1 := p.name
				from
					pp := p
					l_tpl_path := pp.extended ("_templates")
					create d.make_with_path (l_tpl_path)
				until
					d.exists or pp.same_as (db) or pp.is_current_symbol
				loop
					bak := bak + 1
					pp := pp.parent
					l_tpl_path := pp.extended ("_templates")
					create d.make_with_path (l_tpl_path)
				end
				s0 := pp.name
				if d.exists then
					if attached d.path.parent.entry as l_book_entry then
						l_book_name := l_book_entry.name
					else
						check has_book_name: False end
						l_book_name := "_"
					end
					l_template_path := data.template_path (a_template.name, l_book_name)
					if l_template_path = Void then
						p := d.path.extended (a_template.name).appended_with_extension ("tpl")
						create f.make_with_path (p)
						if f.exists then
							data.record_template_path (p, a_template.name, l_book_name)
							store_data (data)
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

feature -- Helpers

	book_name (a_page: WIKI_PAGE): detachable READABLE_STRING_32
		local
			db, p: detachable PATH
			pp: detachable PATH
		do
			p := a_page.path
			if p /= Void then
				p := p.absolute_path.canonical_path
				db := wiki_database_path.absolute_path.canonical_path
				if p.name.starts_with (db.name) then
						-- Search book folder, which has `db' as parent.
					from
						pp := p
					until
						pp = Void or else (pp.same_as (db) or pp.is_current_symbol)
					loop
						p := pp
						pp := p.parent
						if p.same_as (pp) then
							pp := Void
						end
					end
					if p.same_as (db) then
						Result := Void
					elseif attached p.entry as e then
						Result := e.name
					end
				else
				end
			end
			if
				Result /= Void and then
				not across book_names as ic some ic.item.same_string (Result) end
			then
					-- Found book name is unknown
				Result := Void
			end
		end

feature {NONE} -- Implementation: data

	get_all_data
			-- Read data from the wikidatabase and save it on `data'.
			-- Save the data on a cache.
		local
			l_data: like data
			l_books_data: like books_data
			p: PATH
			d,l_dir: DIRECTORY
			wb: WIKI_BOOK
			wp: like new_wiki_page
			md: detachable WDOCS_METADATA
			wb_lst: ARRAYED_LIST [WIKI_BOOK]
			utf: UTF_CONVERTER
			l_name: READABLE_STRING_32
		do
			if attached stored_books_data as l_stored_books_data then
				l_books_data := l_stored_books_data
				books_data := l_books_data
			else
				reset_data -- Reset WDOCS_DATA mainly because it depends on books_data
				create l_books_data.make
				books_data := l_books_data

					-- Book names
				p := wiki_database_path
				create d.make_with_path (p)
				if d.exists then
					create wb_lst.make (5)
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

								wp := new_wiki_page ("index", wb.name)
								md := page_metadata (wp, Void)
								if md = Void then
									wp := new_wiki_page (wb.name, wb.name)
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
						-- Sort by name and weight
					sort_books (wb_lst)

						-- Records book names.
					across
						wb_lst as ic
					loop
						l_books_data.book_names.force (ic.item.name)
					end
				end
				store_books_data (books_data)
			end

			if attached stored_data as l_stored_data then
				data := l_stored_data
			else
				create l_data.make
				data := l_data

				across
					l_books_data.book_names as ic
				loop
					l_data.book_names.force (ic.item)
				end

					-- Record association between wiki page title, and wiki files
				across
					l_data.book_names as ic
				loop
					if attached book (ic.item) as l_wikibook then
						across
							l_wikibook.pages as p_ic
						loop
							if attached p_ic.item.path as l_page_path then
								l_data.record_page_path (l_page_path, p_ic.item.title, l_wikibook.name)
							else
								check has_path: False end
							end
						end
					end
				end

					-- Index images
				get_images_data

					-- Index templates
				get_templates_data

					-- Store result
				store_data (l_data)
			end
		end

	get_images_data
		local
			l_data: like data
		do
			l_data := data

				-- Index images
				-- global
			index_images_for_book_info_data (Void, l_data)
				-- and for each book
			across
				l_data.book_names as ic
			loop
				index_images_for_book_info_data (ic.item, l_data)
			end
		end

	get_templates_data
		local
			l_data: like data
		do
			l_data := data

				-- Index images
				-- global
			index_templates_for_book_info_data (Void, l_data)
				-- and for each book
			across
				l_data.book_names as ic
			loop
				index_templates_for_book_info_data (ic.item, l_data)
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

	index_images_for_book_info_data (a_book_name: detachable READABLE_STRING_GENERAL; a_data: WDOCS_DATA)
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

	index_templates_for_book_info_data (a_book_name: detachable READABLE_STRING_GENERAL; a_data: WDOCS_DATA)
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

	stored_data: detachable WDOCS_DATA
			-- Retrieve data from cache, if any.
		local
			c: WDOCS_FILE_OBJECT_CACHE [WDOCS_DATA]
		do
			create c.make (data_filename)
			Result := c.item
		end

	store_data (d: WDOCS_DATA)
			-- Store data on cahce.
		local
			c: WDOCS_FILE_OBJECT_CACHE [WDOCS_DATA]
		do
			create c.make (data_filename)
			c.put (d)
		end

	reset_data
			-- Reset data in cache, if any
		local
			c: WDOCS_FILE_OBJECT_CACHE [WDOCS_DATA]
		do
			create c.make (data_filename)
			c.delete
		end

	data_filename: PATH
		local
			p: PATH
		do
			p := wiki_database_path
			if attached p.entry as e then
				Result := tmp_dir.extended ("cache").extended_path (e).appended_with_extension ("data")
			else
				Result := p.appended_with_extension ("data")
			end
		end

	stored_books_data: detachable WDOCS_BOOKS_DATA
			-- Retrieve books data from cache, if any.
		local
			c: WDOCS_FILE_OBJECT_CACHE [WDOCS_BOOKS_DATA]
		do
			create c.make (books_data_filename)
			Result := c.item
		end

	store_books_data (d: WDOCS_BOOKS_DATA)
			-- Store books data on cahce.
		local
			c: WDOCS_FILE_OBJECT_CACHE [WDOCS_BOOKS_DATA]
		do
			create c.make (books_data_filename)
			c.put (d)
		end

	reset_books_data
			-- Reset books data in cache, if any
		local
			c: WDOCS_FILE_OBJECT_CACHE [WDOCS_BOOKS_DATA]
		do
			create c.make (books_data_filename)
			c.delete
		end

	books_data_filename: PATH
		local
			p: PATH
		do
			p := wiki_database_path
			if attached p.entry as e then
				Result := tmp_dir.extended ("cache").extended_path (e).appended ("-books").appended_with_extension ("data")
			else
				Result := p.appended ("-books").appended_with_extension ("data")
			end
		end

feature -- Factory

	new_wiki_page (a_title: READABLE_STRING_8; a_parent_key: READABLE_STRING_8): WIKI_BOOK_PAGE
			-- Instantiate a new wiki page with title `a_title' and a parent key `a_parent_key'.
		do
			create Result.make (a_title, a_parent_key)
		end

feature {NONE} -- Implementation

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

	backup_file (a_file: FILE)
		require
			a_file.is_closed
		local
			bak: RAW_FILE
		do
			if a_file.exists and then a_file.is_access_readable then
				create bak.make_with_path (a_file.path.appended_with_extension ("bak"))
				if not bak.exists or else bak.is_access_writable then
					bak.create_read_write
					a_file.open_read
					a_file.copy_to (bak)
					a_file.close
					bak.close
				end
			end
		end

	save_content_to_file (a_content: READABLE_STRING_8; a_path: PATH)
		local
			f: RAW_FILE
		do
			create f.make_with_path (a_path)
			if not f.exists or else f.is_access_writable then
				f.open_write
				f.put_string (a_content)
				f.close
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

	percent_encoder: PERCENT_ENCODER
			-- Shared Percent encoding engine.
		once
			create Result
		end


end
