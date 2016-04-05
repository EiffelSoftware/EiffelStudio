note
	description: "Summary description for {WDOCS_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_API

inherit
	CMS_MODULE_API
		rename
			make as make_with_cms_api
		redefine
			initialize
		end

	WDOCS_HELPER

	REFACTORING_HELPER

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (a_default_version_id: READABLE_STRING_GENERAL; a_api: CMS_API; a_setup: WDOCS_SETUP)
		require
			a_default_version_id_valid: not a_default_version_id.is_whitespace
		do
			default_version_id := a_default_version_id
			temp_dir := a_setup.temp_dir
			documentation_dir := a_setup.documentation_dir
			settings := a_setup
			make_with_cms_api (a_api)
		end

	initialize
			-- <Precursor>
		local
			ct: CMS_WDOCS_CONTENT_TYPE
		do
			Precursor
			create ct
			cms_api.add_content_type (ct)
		end

feature -- Access				

	settings: WDOCS_SETUP
			-- Associated configuration.

	documentation_dir: PATH

	default_version_id: READABLE_STRING_GENERAL

feature -- Query

	manager (a_version_id: detachable READABLE_STRING_GENERAL): WDOCS_MANAGER
			-- Wikidocs manager for version `a_version_id'.
		local
			v: READABLE_STRING_GENERAL
		do
			if a_version_id /= Void then
				v := a_version_id
			else
				v := default_version_id
			end
			if
				attached internal_managers as tb and then
				attached tb.item (v) as mng
			then
				Result := mng
			else
				if a_version_id = Void or else a_version_id.same_string (default_version_id) then
					create Result.make_default (documentation_wiki_dir (default_version_id), default_version_id, temp_dir)
				else
					create Result.make (documentation_wiki_dir (a_version_id), a_version_id, temp_dir)
				end
				remember_manager (Result)
			end
		end

	documentation_wiki_dir (a_version_id: READABLE_STRING_GENERAL): PATH
		require
			a_version_id_not_blank: not a_version_id.is_whitespace
		do
			Result := documentation_dir.extended (a_version_id)
		end

feature {NONE} -- Query: cache		

	remember_manager (mng: like manager)
			-- Cache in memory wdocs manager `mng'.
		local
			tb: like internal_managers
		do
			tb := internal_managers
			if tb = Void then
				create tb.make (1)
				internal_managers := tb
			end
			tb.force (mng, mng.version_id)
		end

	internal_managers: detachable STRING_TABLE [WDOCS_MANAGER]
			-- wdocs manager cache.

feature -- Access: cache system

	cache_for_wiki_page_xhtml (a_version_id: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL; a_wiki_page: WIKI_BOOK_PAGE): WDOCS_FILE_STRING_8_CACHE
		local
			p: PATH
			d: DIRECTORY
		do
			p := temp_dir.extended ("cache").extended (a_version_id)
			if a_book_name /= Void then
				if a_book_name.is_empty then
					p := p.extended ("_none_")
				else
					p := p.extended (a_book_name)
				end
			end
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end
			p := p.extended (normalized_fs_text (a_wiki_page.title)).appended_with_extension ("xhtml")
			create Result.make (p)
		end

	cache_for_book_cms_menu (a_version_id: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL): WDOCS_CACHE [CMS_MENU]
			-- Cache for cms menu related to `a_version_id'/`a_book_name' or "all".
		local
			d: DIRECTORY
			p: PATH
		do
			p := temp_dir.extended ("cache")
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end

			p := p.extended ("cms_menu__book__")
			p := p.appended (a_version_id)
			p := p.appended ("_")
			if a_book_name /= Void then
				if a_book_name.is_empty then
					p := p.appended ("_none_")
				else
					p := p.appended (a_book_name)
				end
			else
				p := p.appended ("all")
			end
			p := p.appended_with_extension ("cache")
			create {WDOCS_FILE_OBJECT_CACHE [CMS_MENU]} Result.make (p)
		end

	reset_cms_menu_cache_for (a_version_id: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL)
			-- Reset cache for cms menu related to `a_version_id'/`a_book_name' or "all".
		do
			cache_for_book_cms_menu (a_version_id, a_book_name).delete
		end

feature -- Query: wiki

	wiki_text (pg: like new_wiki_page): detachable READABLE_STRING_8
		local
			f: RAW_FILE
			s: STRING
		do
			if attached pg.text.content as l_content then
				Result := l_content
			elseif attached pg.path as fn then
				create f.make_with_path (fn)
				if f.exists and then f.is_access_readable then
					create s.make (f.count)
					f.open_read
					from
					until
						f.exhausted or f.end_of_file
					loop
						f.read_stream (1024)
						s.append (f.last_string)
					end
					f.close
					Result := s
				end
			end
		end

	wiki_page (a_wiki_id: detachable READABLE_STRING_GENERAL; a_bookid, a_version_id: detachable READABLE_STRING_GENERAL): detachable like new_wiki_page
		local
			mnger: WDOCS_MANAGER
		do
			mnger := manager (a_version_id)
			if a_bookid /= Void then
				Result := mnger.page (a_wiki_id, a_bookid)
				if Result = Void and a_wiki_id /= Void then
					if a_wiki_id.is_case_insensitive_equal ("index") then
						Result := mnger.page (a_bookid, a_bookid)
					elseif a_wiki_id.is_case_insensitive_equal (a_bookid) then
						Result := mnger.page ("index", a_bookid)
					end
					if Result = Void then
						Result := mnger.page_by_title (a_wiki_id, a_bookid)
					end
					if Result = Void then
						Result := mnger.page_by_metadata ("link_title", a_wiki_id , a_bookid, True)
					end
					if Result = Void then
						Result := mnger.page_by_uuid (a_wiki_id, a_bookid)
					end
				end
			end
			if
				Result /= Void
			then
				Result.update_from_metadata
			end
		end

	wiki_page_by_uuid (a_wiki_uuid: READABLE_STRING_GENERAL; a_bookid, a_version_id: detachable READABLE_STRING_GENERAL): detachable like new_wiki_page
		local
			mnger: WDOCS_MANAGER
		do
			mnger := manager (a_version_id)
			Result := mnger.page_by_uuid (a_wiki_uuid, a_bookid)
		end

	wiki_page_uuid (a_wp: WIKI_PAGE; a_version_id: detachable READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		local
			mnger: WDOCS_MANAGER
		do
			mnger := manager (a_version_id)
			if attached mnger.page_metadata (a_wp, <<"uuid">>) as md then
				Result := md.item ("uuid")
			end
		end

feature -- Recent changes	

	recent_changes_before (params: CMS_DATA_QUERY_PARAMETERS; a_date: DATE_TIME; a_version_id: detachable READABLE_STRING_GENERAL): LIST [TUPLE [time: DATE_TIME; author: READABLE_STRING_32; bookid: READABLE_STRING_GENERAL; page: like new_wiki_page; log: READABLE_STRING_8]]
			-- List of recent changes, before `a_date', according to `params' settings.
		local
			svn: SVN
			opts: detachable SVN_OPTIONS
			l_info: SVN_REVISION_INFO
			l_log: READABLE_STRING_8
			loc: PATH
			l_base_url: detachable STRING_8
			s: STRING_32
			utf: UTF_CONVERTER
			wp: detachable WIKI_BOOK_PAGE
			wbookid: detachable READABLE_STRING_GENERAL
			mnger: like manager
			dt: DATE_TIME
			l_prev: detachable like recent_changes_before.item
			l_logs: detachable LIST [SVN_REVISION_INFO]
			l_result_count: INTEGER
			nb: INTEGER
			done: BOOLEAN
		do
			create {ARRAYED_LIST [like recent_changes_before.item]} Result.make (params.size.as_integer_32)

--			create opts

			mnger := manager (a_version_id)

			svn := new_svn
			if a_version_id = Void then
				loc := documentation_dir.extended (default_version_id)
			else
				loc := documentation_dir.extended (a_version_id)
			end

			if attached svn.repository_info (loc.name, opts) as l_repo_info then
				if
					attached l_repo_info.url as l_repo_url and
					attached l_repo_info.repository_root as l_repo_root
				then
					create l_base_url.make_from_string (l_repo_url)
					l_base_url.remove_head (l_repo_root.count)
				end
			end
			if l_base_url = Void then
				create l_base_url.make_empty
			end
			from
				nb := params.size.to_integer_32
				done := False
				dt := a_date
			until
				Result.count >= nb or done
			loop
				l_result_count := Result.count
				l_logs := svn.logs (loc.name, True, dt, 1, nb - l_result_count, opts)
				if l_logs = Void or else l_logs.count = 0 then
					done := True
				else
					done := l_logs.count < nb - l_result_count
					across
						l_logs as ic
					until
						done
					loop
						l_info := ic.item
						dt := svn_log_date_to_date_time (l_info.date)
						across
							l_info.paths as p_ic
						loop
							s := p_ic.item.path
							if s.starts_with (l_base_url) then
								s.remove_head (l_base_url.count + 1)
							end
							if not s.is_empty and then s.item (1) = '/' then
								s.remove_head (1)
							end
							if not s.is_empty then
								wp := Void
								wbookid := Void
								if attached mnger.book_and_page_by_path (loc.extended (s)) as l_wb_and_wp then
									wp := l_wb_and_wp.page
									wbookid := l_wb_and_wp.bookid
								end
								if wbookid /= Void and wp /= Void then
									wp.update_from_metadata
									wp.set_src (mnger.wiki_page_uri_path (wp, wbookid, a_version_id))
									wp.set_src (wp.src.substring (2, wp.src.count))
									l_log := utf.utf_32_string_to_utf_8_string_8 (p_ic.item.action + {STRING_32} "%N -- " + l_info.log_message)
									if
										l_prev /= Void and then
										wbookid.same_string (l_prev.bookid) and then
										l_prev.page ~ wp
									then
											-- Update previous data
										l_prev.time := dt
										l_prev.author := l_info.author
										l_prev.bookid := wbookid
										if not l_prev.log.same_string (l_log) then
											l_prev.log := l_prev.log + l_log
										end
									else
										l_prev := [dt, l_info.author, wbookid, wp, l_log]
										Result.force (l_prev)
									end
								else
										-- FIXME: Either not a doc item, or issue. To handle.
								end
							end
						end
						done := done or Result.count >= nb
					end
						-- Stop if no new change were added (prevent very long processing) that may occurs with "svn copy ...".
					done := done or Result.count = l_result_count
				end
			end
		end

	svn_log_date_to_date_time (a_date_string: READABLE_STRING_32): DATE_TIME
			-- "2015-08-14T10:34:13.493740Z"
		local
			i,j: INTEGER
			s: READABLE_STRING_GENERAL
			y,m,d,h,min: INTEGER
			sec: REAL_64
		do
			i := a_date_string.index_of ('-', 1)
			if i > 0 then
				s := a_date_string.substring (1, i - 1)
				y := s.to_integer_32 -- Year
				j := i + 1
				i := a_date_string.index_of ('-', j)
				if i > 0 then
					s := a_date_string.substring (j, i - 1)
					m := s.to_integer_32 -- Month
					j := i + 1
					i := a_date_string.index_of ('T', j)
					if i = 0 then
						i := a_date_string.index_of (' ', j)
					end
					if i = 0 then
						i := a_date_string.count + 1
					end
					if i > 0 then
						s := a_date_string.substring (j, i - 1)
						if s.is_integer then
							d := s.to_integer_32 -- Day							
							j := i + 1
							i := a_date_string.index_of (':', j)
							if i > 0 then
								s := a_date_string.substring (j, i - 1)
								h := s.to_integer
								j := i + 1
								i := a_date_string.index_of (':', j)
								if i > 0 then
									s := a_date_string.substring (j, i - 1)
									min := s.to_integer
									j := i + 1
									i := a_date_string.index_of ('Z', j)
									if i = 0 then
										i := a_date_string.count + 1
									end
									s := a_date_string.substring (j, i - 1)
									sec := s.to_double
								end
							end
						end
					end
				end
			end
			create Result.make (y,m,d,h,m,0)
			Result.fine_second_add (sec)
		end

feature -- Factory

	new_wiki_page (a_title: READABLE_STRING_GENERAL; a_parent_key: READABLE_STRING_8): like manager.new_wiki_page
		local
			utf: UTF_CONVERTER
		do
			Result := manager (Void).new_wiki_page (utf.utf_32_string_to_utf_8_string_8 (a_title), a_parent_key)
		end

	delete_wiki_page (a_page: like new_wiki_page; a_path: detachable PATH; a_book_id: READABLE_STRING_GENERAL; a_manager: WDOCS_MANAGER; a_context: detachable WDOCS_CHANGE_CONTEXT)
			-- Delete page `a_page' located at `a_path' or inside folder `a_path' if `a_path' is a folder.
		local
			p,p_data: detachable PATH
			fn: STRING
			wut: WSF_FILE_UTILITIES [RAW_FILE]
			l_changelist: SVN_CHANGELIST
		do
			reset_error
			p := a_path
			if p = Void then
				p := a_page.path
			else
				if attached p.extension as ext and then ext.is_case_insensitive_equal_general ("wiki") then
						-- Wiki file location.
				else
						-- A folder location.
					create wut
					fn := wut.safe_filename (a_page.title)
					p := p.extended (fn).appended_with_extension ("wiki")
				end
			end
			if p /= Void then
				if (create {FILE_UTILITIES}).file_path_exists (p) then
					create l_changelist.make_with_path (p)
					svn_delete (p)
					if not has_error then
						p_data := p.appended_with_extension ("data")
						if (create {FILE_UTILITIES}).file_path_exists (p_data) then
							l_changelist.extend_path (p_data)
							svn_delete (p_data)
						end
					end

				end
				if not has_error and l_changelist /= Void then
					if a_context /= Void then
						svn_commit (l_changelist, a_context.username, a_context.log)
					else
						svn_commit (l_changelist, Void, "Delete wiki page %"" + a_page.title + "%".")
					end
					if not has_error then
						svn_update (documentation_dir.extended (a_manager.version_id))
						cache_for_wiki_page_xhtml (a_manager.version_id, a_book_id, a_page).delete
						cache_for_book_cms_menu (a_manager.version_id, a_book_id).delete
						if
							attached a_manager.book (a_book_id) as wb and then
							attached wb.page_by_key (a_page.parent_key) as l_parent_page
						then
							cache_for_wiki_page_xhtml (a_manager.version_id, a_book_id, l_parent_page).delete
						end
					end
				end
			end
		end

	save_wiki_page (a_page: like new_wiki_page; a_parent_page: detachable like new_wiki_page; a_source: detachable READABLE_STRING_8; a_path: detachable PATH; a_book_id: READABLE_STRING_GENERAL; a_manager: WDOCS_MANAGER; a_context: detachable WDOCS_CHANGE_CONTEXT)
			-- Save page `a_page' with source `a_source' into file `a_path' or inside folder `a_path' if `a_path' is a folder.
		local
			p: detachable PATH
			txt: detachable STRING
			s: STRING
			i,j: INTEGER
			utf: UTF_CONVERTER
			wut: WSF_FILE_UTILITIES [RAW_FILE]
			fn: STRING
			l_changelist: SVN_CHANGELIST
			md_text: WDOCS_METADATA_WIKI_TEXT
			l_prev_md: detachable STRING_TABLE [READABLE_STRING_32]
		do
			reset_error

			p := a_path
			if p = Void then
				p := a_page.path
			else
				if attached p.extension as ext and then ext.is_case_insensitive_equal_general ("wiki") then
						-- Wiki file location.
				else
						-- A folder location.
					create wut
					fn := wut.safe_filename (a_page.title)
					p := p.extended (fn).appended_with_extension ("wiki")
				end
			end
			if p /= Void then
				if a_source /= Void then
					create txt.make_from_string (a_source)
				end
				if txt = Void then
					if attached wiki_text (a_page) as wtxt then
						create txt.make_from_string (wtxt)
					end
				else
					a_page.set_text (create {WIKI_CONTENT_TEXT}.make_from_string (txt))
				end
				if txt /= Void then
					if attached a_page.metadata_table as md_tb then
						create l_prev_md.make (md_tb.count)
						across
							md_tb as ic
						loop
							l_prev_md.force (ic.item, ic.key)
						end
					end
					a_page.update_metadata
					create md_text.make_with_text (txt)
					if l_prev_md /= Void then
						across
							l_prev_md as ic
						loop
							md_text.force (ic.item, ic.key)
						end
					end
					across
						md_text as ic
					loop
						a_page.set_metadata (ic.item, ic.key)
					end

					if not a_page.has_metadata ("uuid") then
						a_page.set_metadata ((create {UUID_GENERATOR}).generate_uuid.out, "uuid")
					end
					if attached a_page.metadata_table as tb then
						across
							tb as ic
						loop
							s := "[[Property:" + utf.utf_32_string_to_utf_8_string_8 (ic.key) + "|"
							i := txt.substring_index (s, 1)
							j := 0
							if i > 0 then
								j := txt.substring_index ("]]", i + 3)
								if j > i then
									txt.replace_substring (s + utf.utf_32_string_to_utf_8_string_8 (ic.item) + "]]", i, j + 1)
								end
							end
							if j = 0 then
								txt.prepend (s + utf.utf_32_string_to_utf_8_string_8 (ic.item) + "]]%N")
							end
						end
					end
					if (create {FILE_UTILITIES}).file_path_exists (p) then
						save_content_to_file (txt, p)
						create l_changelist.make_with_path (p)
					else
						create l_changelist.make_with_path (p)
						prepare_wiki_parent_directory (p.parent, a_parent_page, l_changelist)
						save_content_to_file (txt, p)
						svn_add (p)
					end
					if a_context /= Void then
						svn_commit (l_changelist, a_context.username, a_context.log)
					else
						svn_commit (l_changelist, Void, Void)
					end
					a_page.set_text (create {WIKI_CONTENT_TEXT}.make_from_string (txt))
					if not has_error then
						a_manager.refresh_page_data (a_book_id, a_page)
						svn_update (documentation_dir.extended (a_manager.version_id))
						cache_for_wiki_page_xhtml (a_manager.version_id, a_book_id, a_page).delete
						cache_for_book_cms_menu (a_manager.version_id, a_book_id).delete
						if
							attached a_manager.book (a_book_id) as wb and then
							attached wb.page_by_key (a_page.parent_key) as l_parent_page
						then
							cache_for_wiki_page_xhtml (a_manager.version_id, a_book_id, l_parent_page).delete
						end
					end
				end
			end
		end

	prepare_wiki_parent_directory (p: PATH; a_parent_page: detachable like new_wiki_page; a_changelist: SVN_CHANGELIST)
			-- Prepare parent directory for a new sub wiki page.
		local
			dir: DIRECTORY
			l_index_path: detachable PATH
			fut: FILE_UTILITIES
			f: PLAIN_TEXT_FILE
		do
			create dir.make_with_path (p)
			if not dir.exists then
				a_changelist.extend_path (p)
				dir.recursive_create_dir
				svn_add (p)
				if a_parent_page /= Void then
					if
						attached a_parent_page.path as pp and then
						fut.file_path_exists (pp)
					then
						l_index_path := pp
					else
						l_index_path := p.parent.extended (a_parent_page.parent_key).appended_with_extension ("wiki")
					end
				end
				if
					l_index_path /= Void and then
					fut.file_path_exists (l_index_path)
				then
					svn_move (l_index_path, p.extended ("index.wiki"))
					a_changelist.extend_path (l_index_path)
				else
					l_index_path := p.extended ("index.wiki")
					create f.make_with_path (l_index_path)
					f.create_read_write
					f.put_new_line
					f.close
					svn_add (l_index_path)
				end
			end
		end

feature -- Access: docs

	temp_dir: PATH

feature {NONE} -- Implementation

	backup_file (f: RAW_FILE)
		require
			f.is_closed
		local
			bak: RAW_FILE
		do
			if f.exists and then f.is_access_readable then
				create bak.make_with_path (f.path.appended_with_extension ("bak"))
				if not bak.exists or else bak.is_access_writable then
					bak.create_read_write
					f.open_read
					f.copy_to (bak)
					f.close
					bak.close
				end
			end
		end

	restore_backuped_file (f: RAW_FILE)
		local
			bak: RAW_FILE
		do
			if f.exists and then f.is_access_writable then
				create bak.make_with_path (f.path.appended_with_extension ("bak"))
				if bak.exists and then bak.is_access_writable then
					bak.open_read
					f.open_write
					bak.copy_to (f)
					f.close
					bak.close
					bak.delete
				end
			end
		end

	remove_backuped_file (f: FILE)
		local
			bak: RAW_FILE
		do
			create bak.make_with_path (f.path.appended_with_extension ("bak"))
			if bak.exists and then bak.is_access_writable then
				bak.delete
			end
		end

	save_content_to_file (a_content: READABLE_STRING_8; a_path: PATH)
		local
			f: RAW_FILE
			d: DIRECTORY
		do
			create f.make_with_path (a_path)
			if f.exists and then f.is_access_readable then
				backup_file (f)
			end
			if not f.exists or else f.is_access_writable then
				create d.make_with_path (a_path.parent)
				if not d.exists then
					d.recursive_create_dir
				end
				f.open_write
				f.put_string (a_content)
				f.close
				remove_backuped_file (f)
			else
				error_handler.add_custom_error (0, "Impossible to save wiki page", "Impossible to save wiki page")
			end
		end

feature -- Subversion helpers	

	svn_update (p: PATH)
		local
			svn: SVN
			opts: detachable SVN_OPTIONS
		do
			error_handler.reset
			svn := new_svn
			if attached svn.update (p, Void, opts) as res then
				if res.failed then
					error_handler.add_custom_error (1, "svn update failed", res.message)
				end
			end
		end

	svn_delete (p: PATH)
			-- Svn delete node at `p'.
		local
			svn: SVN
			opts: detachable SVN_OPTIONS
		do
			error_handler.reset
			svn := new_svn
			create opts
			opts.set_parameters ("--force")
			if attached svn.delete (p, opts) as res then
				if res.failed then
					error_handler.add_custom_error (1, "svn delete failed", res.message)
				end
			end
		end

	svn_add (p: PATH)
		local
			svn: SVN
			opts: detachable SVN_OPTIONS
		do
			error_handler.reset
			svn := new_svn
			create opts
			opts.set_parameters ("--parents")
			if attached svn.add (p, opts) as res then
				if res.failed then
					error_handler.add_custom_error (1, "svn add failed", res.message)
				end
			end
		end

	svn_move (p, a_new_location: PATH)
			-- Svn move node at `p' to new location `a_new_location'.
		local
			svn: SVN
			opts: detachable SVN_OPTIONS
		do
			error_handler.reset
			svn := new_svn
			create opts
			opts.set_parameters ("--parents")
			if attached svn.move (p.name, a_new_location.name, opts) as res then
				if res.failed then
					error_handler.add_custom_error (1, "svn add failed", res.message)
				end
			end
		end

	svn_commit (a_changelist: SVN_CHANGELIST; a_username: detachable READABLE_STRING_32; a_log: detachable READABLE_STRING_32)
		local
			svn: SVN
			opts: detachable SVN_OPTIONS
			s: STRING
			utf: UTF_CONVERTER
		do
			error_handler.reset
			svn := new_svn
			if
				attached cms_api.setup.text_item ("tools.subversion.username") as l_svn_username and
				attached cms_api.setup.text_item ("tools.subversion.password") as l_svn_password
			then
				create opts
				opts.set_username (l_svn_username)
				opts.set_password (l_svn_password)
			end
			if a_log /= Void then
				s := utf.utf_32_string_to_utf_8_string_8 (a_log)
			else
				s := "Updated wikidocs."
			end
			if a_username /= Void then
				s.append_character ('%T')
				s.append ("(Signed-off-by:")
				s.append (utf.utf_32_string_to_utf_8_string_8 (a_username))
				s.append (").")
			end
			if attached svn.commit (a_changelist, s, opts) as res then
				if res.failed then
					error_handler.add_custom_error (1, "svn commit failed", res.message)
				end
			end
		end

	new_svn: SVN
		do
			if attached cms_api.setup.text_item ("tools.subversion.location") as l_svn_loc then
				create {SVN_ENGINE} Result.make_with_executable_path (l_svn_loc)
			elseif {PLATFORM}.is_unix then
				create {SVN_ENGINE} Result.make_with_executable_path ("/usr/bin/svn")
			else
				create {SVN_ENGINE} Result
			end
		end

end

