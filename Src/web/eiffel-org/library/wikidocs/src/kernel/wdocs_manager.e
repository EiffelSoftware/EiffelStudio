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

	WIKI_FILE_RESOLVER

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
			create {WDOCS_FS_STORAGE} storage.make (Current, wiki_database_path, tmp_dir)
		end

feature -- Access

	wiki_database_path: PATH

	version_id: detachable READABLE_STRING_GENERAL

	tmp_dir: PATH

	is_version_id (v: like version_id): BOOLEAN
		do
			if v = Void then
				Result := version_id = Void
			elseif not attached version_id as l_version_id then
				Result := v = Void
			else
				Result := l_version_id.is_case_insensitive_equal (v)
			end
		end

feature -- Persistency

	storage: WDOCS_STORAGE

	data: like storage
			-- Same as `storage'.
			--| Kept for backward compatibility
		do
			Result := storage
		end

feature -- Data access

	image_path (a_title: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL): detachable PATH
		do
			Result := storage.image_path (a_title, a_book_name)
		end

feature -- Basic operations

	reload_data
			-- Discard memory cache for `data',
			-- and reload it from file system.
		do
			storage.reload
		end

	refresh_data
			-- Refresh manager data.
		do
			storage.refresh
		end

feature -- Access

	book_names: ITERABLE [READABLE_STRING_32]
			-- Available book names.
		do
			Result := storage.book_names
		end

	books_with_root_page: ITERABLE [WIKI_BOOK]
			-- Available books filled with only the root page.
		do
			Result := storage.books_with_root_page
		end

	book (a_bookid: READABLE_STRING_GENERAL): detachable WIKI_BOOK
			-- Book named `a_bookid' if any.
		do
			Result := storage.book (a_bookid)
		end

	index_page: detachable like new_wiki_page
			-- Main documentation index page.
		local
			p: PATH
			ut: FILE_UTILITIES
		do
			p := wiki_database_path.extended ("index.wiki")
			if ut.file_path_exists (p) then
				Result := new_wiki_page ("Documentation", "")
				Result.set_path (p)
			end
		end

	page (a_bookpage: detachable READABLE_STRING_GENERAL; a_bookid: READABLE_STRING_GENERAL): detachable like new_wiki_page
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

	page_by_title (a_page_title: READABLE_STRING_GENERAL; a_bookid: detachable READABLE_STRING_GENERAL): detachable like new_wiki_page
			-- Wiki page with title `a_page_title', and in book related to `a_bookid' if provided.
		do
			Result := storage.page_by_title (a_page_title, a_bookid)
		end

	page_by_link_title (a_page_link_title: READABLE_STRING_GENERAL; a_bookid: detachable READABLE_STRING_GENERAL): detachable like new_wiki_page
			-- Wiki page with link_title `a_page_link_title', and in book related to `a_bookid' if provided.
		do
			Result := page_by_metadata ("link_title", a_page_link_title, a_bookid, True)
		end

	page_by_metadata (a_metadataname, a_metadata_value: READABLE_STRING_GENERAL; a_bookid: detachable READABLE_STRING_GENERAL; is_caseless: BOOLEAN): detachable like new_wiki_page
		do
			Result := storage.page_by_metadata (a_metadataname, a_metadata_value, a_bookid, is_caseless)
		end

	page_by_uuid (a_page_uuid: READABLE_STRING_GENERAL; a_bookid: detachable READABLE_STRING_GENERAL): detachable like new_wiki_page
			-- Wiki page associated to UUID `a_page_uuid'.
		do
			Result := storage.page_by_uuid (a_page_uuid, a_bookid)
		end

	wiki_text (p: WIKI_PAGE): detachable READABLE_STRING_8
		do
			Result := storage.wiki_text (p)
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
			if Result = Void and then attached page_by_link_title (a_link.name, l_book_name) as pg then
					-- Try to find using the `link_title' prop
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
			if l_title /= Void and then not l_title.is_whitespace then
				Result := utf.escaped_utf_32_string_to_utf_8_string_8 (l_title)
			else
				Result := wiki_page_title (pg)
			end
		end

	page_metadata (pg: WIKI_PAGE; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL]): detachable WDOCS_METADATA
			-- Metadata for page `pg',
			-- if `a_restricted_names' is set, include only those metadata names after `a_restricted_names' items.
		do
			Result := storage.page_metadata (pg, a_restricted_names)
		ensure
			result_attached_implies_exists: Result /= Void implies not attached {WDOCS_METADATA_FILE} Result as mdf or else mdf.exists
		end

	metadata (a_source: PATH; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL]): detachable WDOCS_METADATA
			-- Metadata for page `pg',
			-- if `a_restricted_names' is set, include only those metadata names after `a_restricted_names' items.
		do
			Result := storage.metadata (a_source, a_restricted_names)
		ensure
			result_attached_implies_exists: Result /= Void implies (
						(not attached {WDOCS_METADATA_FILE} Result as en_mdf or else en_mdf.exists)
					or
						(not attached {WDOCS_METADATA_WIKI} Result as en_mdw or else en_mdw.exists)
					)
		end

feature -- Access: File

	file_to_url (a_file: WIKI_FILE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
			-- URL accessing the file `a_file'.
		do
			if a_page /= Void and then attached book_name (a_page) as l_book_name then
				Result := "/book/" + l_book_name
			else
				Result := ""
			end
			Result.append ("/file/" + a_file.name)
			if Result /= Void then
				if attached version_id as vid then
					Result.prepend ("/version/" + percent_encoder.percent_encoded_string (vid))
				end
			end
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
						l_book_name := {WDOCS_PAGES_DATA}.common_book_name
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
						l_book_name := {WDOCS_PAGES_DATA}.common_book_name
					end
					l_image_path := image_path (a_link.name, l_book_name)
					if l_image_path = Void then
						p := d.path.extended (a_link.name).appended_with_extension ("png")
						create f.make_with_path (p)
						if f.exists then
							storage.save_image_path (p, a_link.name, l_book_name)
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
		do
			Result := storage.template_content (a_template, a_page)
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




feature -- Factory

	new_wiki_page (a_title: READABLE_STRING_8; a_parent_key: READABLE_STRING_8): WIKI_BOOK_PAGE
			-- Instantiate a new wiki page with title `a_title' and a parent key `a_parent_key'.
		do
			Result := storage.new_page (a_title, a_parent_key)
		end

feature {NONE} -- Implementation

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

	percent_encoder: PERCENT_ENCODER
			-- Shared Percent encoding engine.
		once
			create Result
		end


end
