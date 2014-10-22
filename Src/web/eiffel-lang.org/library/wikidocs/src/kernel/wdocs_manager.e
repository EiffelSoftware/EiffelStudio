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

create
	make

feature {NONE} -- Initialization

	make (a_wiki_dir: PATH; a_version_id: like version_id; a_tmp_dir: PATH)
		do
			wiki_database_path := a_wiki_dir
			version_id := a_version_id
			tmp_dir := a_tmp_dir
			get_data
		end

feature -- Access

	wiki_database_path: PATH

	version_id: detachable READABLE_STRING_GENERAL

	tmp_dir: PATH

	data: WDOCS_DATA

feature -- Basic operations

	reload_data
			-- Discard memory cache for `data',
			-- and reload it from file system.
		do
			get_data
		end

	refresh_data
			-- Refresh manager data.
		do
			reset_data
			get_data
		end

feature {NONE} -- Initialization

	get_data
			-- Read data from the wikidatabase and save it on `data'.
			-- Save the data on a cache.
		local
			l_data: like data
			p: PATH
			d,l_dir: DIRECTORY
			wb: WIKI_BOOK
			wp: WIKI_PAGE
			md: detachable WDOCS_METADATA
			wb_lst: ARRAYED_LIST [WIKI_BOOK]
			utf: UTF_CONVERTER
		do
			if attached stored_data as l_stored_data then
				data := l_stored_data
			else
				create l_data.make
				data := l_data

					-- Book names
				p := wiki_database_path
				create d.make_with_path (p)
				if d.exists then
					create wb_lst.make (5)
					across
						d.entries as ic
					loop
						if
							not ic.item.is_parent_symbol and not ic.item.is_current_symbol and not ic.item.name.starts_with ("_")
						then
							create l_dir.make_with_path (p.extended_path (ic.item))
							if l_dir.exists then
										-- FIXME: unicode support in Wikitext lib?
								create wb.make (utf.escaped_utf_32_string_to_utf_8_string_8 (ic.item.name), l_dir.path.extended_path (ic.item))
								create wp.make ("index", wb.name)
								md := metadata (wp, <<"weight">>)
								if md = Void then
									create wp.make (wb.name, wb.name)
									md := metadata (wp, <<"weight">>)
								end
								if md /= Void and then attached md.item ("weight") as l_weight and then l_weight.is_integer then
									wp.set_weight (l_weight.to_integer)
								end
								wb.add_page (wp)
								wb_lst.force (wb)
							end
						end
					end
					sort_books (wb_lst)
					across
						wb_lst as ic
					loop
						l_data.book_names.force (ic.item.name)
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
				end

					-- Index images
					-- global
				index_images_for_book_info_data (Void, l_data)
					-- and for each book
				across
					l_data.book_names as ic
				loop
					index_images_for_book_info_data (ic.item, l_data)
				end

					-- Index templates
					-- global
				index_templates_for_book_info_data (Void, l_data)
					-- and for each book
				across
					l_data.book_names as ic
				loop
					index_templates_for_book_info_data (ic.item, l_data)
				end

					-- Index pages
				store_data (l_data)
			end
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
						if ext.is_case_insensitive_equal_general ("md") then
							create md.make_with_path (p.extended_path (i))
							if md.exists then
								md.get_only_items_named_as (<<"title", "filename">>)
								l_title := md.item ("title")
								l_filename := md.item ("filename")
								if l_filename = Void then
									if attached i.entry as e then
										l_filename := e.name
										l_filename.remove_tail (3) -- extension ".md"
										create f.make_with_path (d.path.extended (l_filename))
										if not f.exists then
											l_filename := Void
										end
									end
								end
							end
						elseif attached i.entry as e then
								-- Not . or ..
								-- not a *.md file
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
						if ext.is_case_insensitive_equal_general ("md") then
							create md.make_with_path (p.extended_path (i))
							if md.exists then
								md.get_only_items_named_as (<<"title", "filename">>)
								if l_title /= Void then
									if l_filename = Void then
										if attached i.entry as e then
											l_filename := e.name
											l_filename.remove_tail (3) -- extension ".md"
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
--				Result := p.parent.extended (".cache").extended_path (e).appended_with_extension ("data")
			else
				Result := p.appended_with_extension ("data")
			end
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
			p, ip: PATH
			w: WIKI_INDEX
			ut: FILE_UTILITIES
			vis: WDOCS_WIKI_BOOK_SCANNER
		do
			if attached data.book (a_bookid) as b then
				Result := b
			else
				p := wiki_database_path.extended (a_bookid)
				ip := p.extended ("book.index")
				if ut.file_path_exists (ip) then
						-- Based on book.index
					create w.make (a_bookid.as_string_8, ip)
					Result := w.book
					if Result /= Void then
						Result.sort
						data.books.force (Result)
						store_data (data)
					end
				else
						-- Scan each folder, and sub folder(s)
					create Result.make (a_bookid.as_string_8, p) -- FIXME: truncated
					create vis.make (Result)
					Result.sort
					data.books.force (Result)
					store_data (data)
				end
			end
		end

	page (a_bookid: READABLE_STRING_GENERAL; a_bookpage: detachable READABLE_STRING_GENERAL): detachable WIKI_PAGE
			-- Wiki page for book `a_bookid', and if provided title `a_bookpage', otherwise the root page of related wiki book.
		local
			n: READABLE_STRING_GENERAL
			p: PATH
			f: PLAIN_TEXT_FILE
			wi: WIKI_INDEX
			pg: detachable WIKI_PAGE
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
			if pg /= Void then
				p := wiki_database_path.extended (pg.src)
			else
				p := wiki_database_path.extended (a_bookid).extended (n)
			end
			p := p.appended_with_extension ("wiki")
			create f.make_with_path (p)
			if not f.exists then
				if pg /= Void then
					p := wiki_database_path.extended (pg.src)
				else
--					if n.is_case_insensitive_equal (a_bookid) or n.is_case_insensitive_equal ("index") then
--						p := wiki_database_path.extended (a_bookid)
--					else
						p := wiki_database_path.extended (a_bookid).extended (n)
--					end
				end
				p := p.extended ("index.wiki")
				create f.make_with_path (p)
			end
			if f.exists then
				if pg /= Void then
					Result := pg
				else
					create Result.make (n.as_string_8, n.as_string_8)
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
				Result := wiki_page_path (pg)
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
						Result := wiki_page_path (pg)
					end
				end

			end

			if Result /= Void then
				if attached version_id as vid then
					Result.prepend ("/version/" + percent_encoder.percent_encoded_string (vid))
				end
			end
		end

	wiki_page_path (pg: WIKI_PAGE): STRING
		local
			utf: UTF_CONVERTER
			l_path: detachable READABLE_STRING_32
		do
			if attached metadata (pg, <<"path">>) as md then
				l_path := md.item ("path")
			end
			if l_path /= Void then
--				Result := "../../" + utf.string_32_to_utf_8_string_8 (l_path)
				Result := "/" + utf.string_32_to_utf_8_string_8 (l_path)
			elseif attached book_name (pg) as bn then
				Result := "/book/" + bn + "/" + pg.title
			else
				Result := "/book/" + pg.src
			end
		end

	metadata (pg: WIKI_PAGE; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL]): detachable WDOCS_METADATA
			-- Metadata for page `pg',
			-- if `a_restricted_names' is set, include only those metadata names after `a_restricted_names' items.
		local
			md: WDOCS_METADATA_FILE
		do
			create md.make_with_path (wiki_database_path.extended (pg.src).appended_with_extension ("md"))
			if not md.exists then
				create md.make_with_path (wiki_database_path.extended (pg.parent_key).extended ("index").appended_with_extension ("md"))
			end
			if md.exists then
				if a_restricted_names /= Void then
					md.get_only_items_named_as (a_restricted_names)
				end
				Result := md
			end
		ensure
			result_attached_implies_exists: Result /= Void implies not attached {WDOCS_METADATA_FILE} Result as mdf or else mdf.exists
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
			l_image_path := data.image_path (a_link.name, l_book_name)
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
					l_image_path := data.image_path (a_link.name, l_book_name)
	--				l_image_path := images (d.path).item (a_link.name)
					if l_image_path = Void then
						p := d.path.extended (a_link.name).appended_with_extension ("png")
						create f.make_with_path (p)
						if f.exists then
	--						images (d.path).force (p, a_link.name)
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

			if l_template_path /= Void then
				create f.make_with_path (l_template_path)
				if f.exists then
					create Result.make (f.count)
					f.open_read
					from
					until
						f.exhausted or f.end_of_file
					loop
						f.read_stream_thread_aware (1_024)
						Result.append (f.last_string)
					end
					f.close
				end
			end
		end

feature -- Helpers

	book_name (a_page: WIKI_PAGE): detachable READABLE_STRING_32
		local
			db, p: detachable PATH
			pp: PATH
		do
			p := a_page.path
			if p /= Void then
				db := wiki_database_path
				from
					pp := p
				until
					pp.same_as (db) or pp.is_current_symbol
				loop
					p := pp
					pp := p.parent
				end
				if p.same_as (db) then
					Result := Void
				elseif attached p.entry as e then
					Result := e.name
				end
			end
			if Result /= Void and then not across book_names as ic some ic.item.same_string (Result) end then
				Result := Void
			end
		end

feature {NONE} -- Implementation

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
