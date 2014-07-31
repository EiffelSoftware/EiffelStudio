note
	description: "Summary description for {WDOCS_MANAGER}."
	author: ""
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

	SHARED_WSF_PERCENT_ENCODER

create
	make

feature {NONE} -- Initialization

	make (a_root_dir: PATH)
		do
			root_dir := a_root_dir
			database_path := a_root_dir.extended ("_db")
			wiki_database_path := database_path.extended ("wiki")
			get_data
		end

feature -- Access

	root_dir: PATH

	database_path: PATH

	wiki_database_path: PATH

	data: WDOCS_DATA

feature {NONE} -- Initialization

	get_data
		local
			l_data: like data
			p: PATH
			d,l_dir: DIRECTORY
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
					across
						d.entries as ic
					loop
						if not ic.item.is_parent_symbol and not ic.item.is_current_symbol then
							create l_dir.make_with_path (p.extended_path (ic.item))
							if l_dir.exists then
								l_data.book_names.force (ic.item.name)
							end
						end
					end
				end

					-- Index images
				across
					l_data.book_names as ic
				loop
					index_images_for_book_info_data (ic.item, l_data)
				end

					-- Index templates
				across
					l_data.book_names as ic
				loop
					index_templates_for_book_info_data (ic.item, l_data)
				end

					-- Index pages
				store_data (l_data)
			end
		end

	index_images_for_book_info_data (a_book_name: READABLE_STRING_GENERAL; a_data: WDOCS_DATA)
		local
			ht: STRING_TABLE [PATH]
			i, p: PATH
			d: DIRECTORY
			f: RAW_FILE
			l_line: READABLE_STRING_8
			l_title: detachable STRING_8
			l_filename: detachable STRING_32
		do
			create ht.make_caseless (0)
			p := wiki_database_path.extended (a_book_name).extended ("_images")
			create d.make_with_path (p)
			if d.exists and then d.is_readable then
				across
					d.entries as ic
				loop
					i := ic.item
					if i.is_current_symbol or i.is_parent_symbol then
							-- Ignore
					elseif attached i.extension as ext and then ext.is_case_insensitive_equal_general ("md") then
						create f.make_with_path (p.extended_path (i))
						if f.exists and then f.is_access_readable then
							f.open_read
							from
								l_title := Void
								l_filename := Void
							until
								f.exhausted or f.end_of_file
							loop
								f.read_line_thread_aware
								l_line := f.last_string
								if l_line.starts_with_general ("title=") then
									l_title := l_line.substring (1 + ("title=").count, l_line.count)
									l_title.left_adjust
									l_title.right_adjust
								elseif l_line.starts_with_general ("filename=") then
									l_filename := l_line.substring (1 + ("filename=").count, l_line.count)
									l_filename.left_adjust
									l_filename.right_adjust
								end
							end
							f.close
							if l_title /= Void then
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
								if l_filename /= Void then
									ht.force (d.path.extended (l_filename), l_title)
								end
							end
						end
					end
				end
			end
			a_data.images_path_by_title_and_book.force (ht, a_book_name)
		end

	index_templates_for_book_info_data (a_book_name: READABLE_STRING_GENERAL; a_data: WDOCS_DATA)
		local
			ht: STRING_TABLE [PATH]
			i, p: PATH
			d: DIRECTORY
			f: RAW_FILE
			l_line: READABLE_STRING_8
			l_title: detachable STRING_8
			l_filename: detachable STRING_32
		do
			create ht.make_caseless (0)
			p := wiki_database_path.extended (a_book_name).extended ("_templates")
			create d.make_with_path (p)
			if d.exists and then d.is_readable then
				across
					d.entries as ic
				loop
					i := ic.item
					if i.is_current_symbol or i.is_parent_symbol then
							-- Ignore
					elseif attached i.extension as ext and then ext.is_case_insensitive_equal_general ("md") then
						create f.make_with_path (p.extended_path (i))
						if f.exists and then f.is_access_readable then
							f.open_read
							from
								l_title := Void
								l_filename := Void
							until
								f.exhausted or f.end_of_file
							loop
								f.read_line_thread_aware
								l_line := f.last_string
								if l_line.starts_with_general ("title=") then
									l_title := l_line.substring (1 + ("title=").count, l_line.count)
									l_title.left_adjust
									l_title.right_adjust
								elseif l_line.starts_with_general ("filename=") then
									l_filename := l_line.substring (1 + ("filename=").count, l_line.count)
									l_filename.left_adjust
									l_filename.right_adjust
								end
							end
							f.close
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
								if l_filename /= Void then
									ht.force (d.path.extended (l_filename), l_title)
								end
							end
						end
					end
				end
			end
			a_data.templates_path_by_title_and_book.force (ht, a_book_name)
		end

	stored_data: detachable WDOCS_DATA
		local
			f: RAW_FILE
		do
			create f.make_with_path (database_path.appended_with_extension ("data"))
			if f.exists and then f.is_access_readable then
				f.open_read
				if attached {WDOCS_DATA} f.retrieved as d then
					Result := d
				end
				f.close
			end
		end

	store_data (d: WDOCS_DATA)
		local
			f: RAW_FILE
		do
			create f.make_with_path (database_path.appended_with_extension ("data"))
			if not f.exists or else f.is_access_writable then
				f.open_write
				f.basic_store (d)
				f.close
			end
		end

feature -- Access

	book_names: ITERABLE [READABLE_STRING_32]
		do
			Result := data.book_names
		end
--		local
--			lst: ARRAYED_LIST [READABLE_STRING_32]
--			p: PATH
--			d,l_dir: DIRECTORY
--		do
--			create lst.make (0)
--			p := wiki_database_path
--			create d.make_with_path (p)
--			if d.exists then
--				across
--					d.entries as ic
--				loop
--					if not ic.item.is_parent_symbol and not ic.item.is_current_symbol then
--						create l_dir.make_with_path (p.extended_path (ic.item))
--						if l_dir.exists then
--							lst.force (ic.item.name)
--						end
--					end
--				end
--			end
--			Result := lst
--		end

	book (a_bookid: READABLE_STRING_GENERAL): detachable WIKI_BOOK
		local
			p: PATH
			w: WIKI_INDEX
		do
			if attached data.book (a_bookid) as b then
				Result := b
			else
				p := wiki_database_path.extended (a_bookid)
				p := p.extended ("book.index")
				create w.make (a_bookid.as_string_8, p)
				Result := w.book
				if Result /= Void then
					data.books.force (Result)
					store_data (data)
				end
			end
		end

	page (a_bookid: READABLE_STRING_GENERAL; a_bookpage: detachable READABLE_STRING_GENERAL): detachable WIKI_PAGE
		local
			n: READABLE_STRING_GENERAL
			p: PATH
			f: PLAIN_TEXT_FILE
			wi: WIKI_INDEX
			pg: detachable WIKI_PAGE
		do
			if a_bookpage = Void then
				n := "index"
			else
				n := a_bookpage
			end

			create wi.make (a_bookid.as_string_8, wiki_database_path.extended (a_bookid).extended ("book.index"))
			pg := wi.page_by_id (n)
			if pg /= Void then
				p := wiki_database_path.extended (pg.src)
			else
				p := wiki_database_path.extended (a_bookid).extended (n)
			end

			p := p.appended_with_extension ("wiki")
			create f.make_with_path (p)
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
		local
		do
			-- TODO: implement this
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
		do
			if a_page /= Void then
				p := a_page.path
			end
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
				f.exists or pp.same_as (db)
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

	wiki_page_path (pg: WIKI_PAGE): STRING
		local
			f: RAW_FILE
		do
			create f.make_with_path (wiki_database_path.extended (pg.src).appended_with_extension ("md"))
			if attached md_item (f, "path") as l_path then
				Result := "../../" + l_path
			else
				Result := "/" + pg.src
			end
		end

	md_item (f: FILE; k: READABLE_STRING_8): detachable STRING_8
		do
			if f.exists and then f.is_access_readable then
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					f.read_line_thread_aware
					if f.last_string.starts_with_general (k + "=") then
						create Result.make_from_string (f.last_string)
						Result.remove_head (k.count + 1)
						Result.left_adjust
						Result.right_adjust
					end
				end
				f.close
			end
		end

feature -- Access: Image

	image_to_wiki_url (a_link: WIKI_IMAGE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
		do
			Result := "/images/" + a_link.name
		end

	image_to_url (a_link: WIKI_IMAGE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
		local
			l_book_name: READABLE_STRING_GENERAL
			db,p,pp,img: detachable PATH
			d: DIRECTORY
			f: RAW_FILE
			s0,s1,s2: STRING_32
			l_image_path: detachable PATH
			bak: INTEGER
		do
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
				img := pp.extended ("_images")
				create d.make_with_path (img)
			until
				d.exists or pp.same_as (db)
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
					l_book_name := "_"
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
				if l_image_path /= Void then
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
						create Result.make (p.name.count)
						from
						until
							bak <= 1
						loop
							if not Result.is_empty then
								Result.append_character ('/')
							end
							Result.append ("..")
							bak := bak - 1
						end
						across
							p.components as ic
						loop
							if not Result.is_empty then
								Result.append_character ('/')
							end
							Result.append (percent_encoder.percent_encoded_string (ic.item.name))
						end
					end
				end
			end
		end

--	images (a_path: PATH): STRING_TABLE [PATH]
--		local
--			d: DIRECTORY
--			p: PATH
--			f,img: RAW_FILE
--			l_line: READABLE_STRING_8
--			l_title: detachable STRING_8
--			l_filename: detachable STRING_32
--		do
--			if attached images_table.item (a_path) as res then
--				Result := res
--			else
--				create Result.make (10)
--				images_table.force (Result, a_path)

--				create d.make_with_path (a_path)
--				across
--					d.entries as ic
--				loop
--					p := ic.item
--					if p.is_current_symbol or p.is_parent_symbol then
--							-- Ignore
--					elseif attached p.extension as ext and then ext.is_case_insensitive_equal_general ("md") then
--						create f.make_with_path (a_path.extended_path (p))
--						if f.exists and then f.is_access_readable then
--							f.open_read
--							from
--								l_title := Void
--								l_filename := Void
--							until
--								f.exhausted or f.end_of_file
--							loop
--								f.read_line_thread_aware
--								l_line := f.last_string
--								if l_line.starts_with_general ("title=") then
--									l_title := l_line.substring (1 + ("title=").count, l_line.count)
--									l_title.left_adjust
--									l_title.right_adjust
--								elseif l_line.starts_with_general ("filename=") then
--									l_filename := l_line.substring (1 + ("filename=").count, l_line.count)
--									l_filename.left_adjust
--									l_filename.right_adjust
--								end
--							end
--							f.close
--							if l_title /= Void then
--								if l_filename = Void then
--									if attached p.entry as e then
--										l_filename := e.name
--										l_filename.remove_tail (3) -- extension ".md"
--										create img.make_with_path (d.path.extended (l_filename))
--										if not img.exists then
--											l_filename := Void
--										end
--									end
--								end
--								if l_filename /= Void then
--									Result.force (d.path.extended (l_filename), l_title)
--								end
--							end
--						end
--					end
--				end
--			end
--		end

--	images_table: HASH_TABLE [STRING_TABLE [PATH], PATH]
--		once
--			create Result.make (0)
--		end

feature -- Access: Template

	template_content (a_template: WIKI_TEMPLATE; a_page: detachable WIKI_PAGE): detachable STRING
		local
			db,p,pp,l_tpl_path: detachable PATH
			d: DIRECTORY
			f: RAW_FILE
			s0,s1: STRING_32
			l_template_path: detachable PATH
			bak: INTEGER
			l_book_name: READABLE_STRING_GENERAL
		do
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
				d.exists or pp.same_as (db)
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
--				l_template_path := templates (d.path).item (a_template.name)
				if l_template_path = Void then
					p := d.path.extended (a_template.name).appended_with_extension ("tpl")
					create f.make_with_path (p)
					if f.exists then
						data.record_template_path (p, a_template.name, l_book_name)
						store_data (data)
--						templates (d.path).force (p, a_template.name)
						l_template_path := p
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
		end

--	templates (a_path: PATH): STRING_TABLE [PATH]
--		local
--			d: DIRECTORY
--			p: PATH
--			f: RAW_FILE
--			l_line: READABLE_STRING_8
--			l_title: detachable STRING_8
--			l_filename: detachable STRING_32
--		do
--			if attached templates_table.item (a_path) as res then
--				Result := res
--			else
--				create Result.make (10)
--				templates_table.force (Result, a_path)

--				create d.make_with_path (a_path)
--				across
--					d.entries as ic
--				loop
--					p := ic.item
--					if p.is_current_symbol or p.is_parent_symbol then
--							-- Ignore
--					elseif attached p.extension as ext and then ext.is_case_insensitive_equal_general ("md") then
--						create f.make_with_path (a_path.extended_path (p))
--						if f.exists and then f.is_access_readable then
--							f.open_read
--							from
--								l_title := Void
--								l_filename := Void
--							until
--								f.exhausted or f.end_of_file
--							loop
--								f.read_line_thread_aware
--								l_line := f.last_string
--								if l_line.starts_with_general ("title=") then
--									l_title := l_line.substring (1 + ("title=").count, l_line.count)
--									l_title.left_adjust
--									l_title.right_adjust
--								elseif l_line.starts_with_general ("filename=") then
--									l_filename := l_line.substring (1 + ("filename=").count, l_line.count)
--									l_filename.left_adjust
--									l_filename.right_adjust
--								end
--							end
--							f.close
--							if l_title /= Void then
--								if l_filename = Void then
--									if attached p.entry as e then
--										l_filename := e.name
--										l_filename.remove_tail (3) -- extension ".md"
--										create f.make_with_path (d.path.extended (l_filename))
--										if not f.exists then
--											l_filename.append (".tpl") -- use PATH.appended_with_extension !
--											create f.make_with_path (d.path.extended (l_filename))
--											if not f.exists then
--												l_filename := Void
--											end
--										end
--									end
--								end
--								if l_filename /= Void then
--									Result.force (d.path.extended (l_filename), l_title)
--								end
--							end
--						end
--					end
--				end
--			end
--		end

--	templates_table: HASH_TABLE [STRING_TABLE [PATH], PATH]
--		once
--			create Result.make (0)
--		end

end
