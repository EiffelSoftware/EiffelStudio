note
	description: "Summary description for {WDOCS_XHTML_EXPORT_RESOLVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_XHTML_EXPORT_RESOLVER

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

create
	make

feature {NONE} -- Initialization

	make (mng: WDOCS_MANAGER)
		do
			manager := mng
		end

	manager: WDOCS_MANAGER

feature -- Access

	link_to_wiki_url (a_link: WIKI_LINK; a_page: detachable WIKI_PAGE): detachable STRING
			-- URL accessing the wiki link `a_link' in the context of `a_page'.
		local
			db,p,pp,lnk: detachable PATH
			f: RAW_FILE
			wi: WIKI_INDEX
			l_book_name: like book_name
			pg: detachable WIKI_BOOK_PAGE
		do
			if a_page /= Void then
				l_book_name := book_name (a_page)
			end
			pg := manager.page_by_title (a_link.name, l_book_name)
			if pg = Void then
				pg := manager.page_by_link_title (a_link.name, l_book_name)
			end
			if Result = Void then
					-- Try to find a book.index if any.
				db := manager.wiki_database_path
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
					pg := wi.page (a_link.name)
				end
			end
			if pg /= Void then
				Result := pg.page_id + ".html"
			end
		end

	image_to_wiki_url (a_image: WIKI_IMAGE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
			-- URL accessing the wiki image `a_image' in the context of `a_page'.
		do
			Result := image_to_url (a_image, a_page)
		end

	image_to_url (a_link: WIKI_IMAGE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
			-- URL accessing the file associated with the wiki image `a_image', in the context of `a_page'.
		local
			l_book_name: detachable READABLE_STRING_32
			db,p,pp,img: detachable PATH
			d: DIRECTORY
			f: RAW_FILE
			s0,s2: STRING_32
			l_image_path,tp: detachable PATH
			bak: INTEGER
		do
			if not a_link.name.has ('/') then
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
						if l_book_name /= Void then
							create tp.make_from_string (s0)
							if attached tp.entry as e and then e.name.same_string_general (l_book_name) then
								p := e.extended_path (p)
							end
						end
						p := (create {PATH}.make_from_string ("..")).extended_path (p)
						Result := p.utf_8_name
					end
				end
			end
		end

	template_content (a_template: WIKI_TEMPLATE; a_page: detachable WIKI_PAGE): detachable STRING
			-- Template content for `a_template' in the context of `a_page' if any.
		do
			Result := manager.template_content (a_template, a_page)
		end

	file_to_url (a_file: WIKI_FILE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
			-- URL accessing the file `a_file' in the context of `a_page'.
		do
			Result := manager.file_to_url (a_file, a_page)
		end

feature {NONE} -- Implementation

feature -- Data access

	storage: WDOCS_STORAGE
		do
			Result := manager.storage
		end

	file_path (a_filename: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL): detachable PATH
		do
			Result := storage.file_path (a_filename, a_book_name)
		end

	image_path (a_title: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL): detachable PATH
		do
			Result := storage.image_path (a_title, a_book_name)
		end

	wiki_database_path: PATH
		do
			Result := manager.wiki_database_path
		end

	book_name (a_page: WIKI_PAGE): detachable READABLE_STRING_32
		local
			db, p: detachable PATH
			pp: detachable PATH
		do
			p := a_page.path
			if p /= Void then
				p := p.absolute_path.canonical_path
				db := manager.wiki_database_path.absolute_path.canonical_path
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
				not across manager.book_names as ic some ic.item.same_string (Result) end
			then
					-- Found book name is unknown
				Result := Void
			end
		end

end
