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
		end

	REFACTORING_HELPER

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (a_default_version_id: READABLE_STRING_GENERAL; a_api: CMS_API; a_cfg: WDOCS_CONFIG)
		require
			a_default_version_id_valid: not a_default_version_id.is_whitespace
		do
			default_version_id := a_default_version_id
			temp_dir := a_cfg.temp_dir
			documentation_dir := a_cfg.documentation_dir
--			configuration := a_cfg
			make_with_cms_api (a_api)
		end

--	configuration: WDOCS_CONFIG

	name: STRING = "wdocs"

feature -- Access

	documentation_dir: PATH

	default_version_id: READABLE_STRING_GENERAL

feature -- Query

	manager (a_version_id: detachable READABLE_STRING_GENERAL): WDOCS_MANAGER
		do
			if a_version_id = Void or else a_version_id.same_string (default_version_id) then
				create Result.make_default (documentation_wiki_dir (default_version_id), default_version_id, temp_dir)
			else
				create Result.make (documentation_wiki_dir (a_version_id), a_version_id, temp_dir)
			end
		end

	documentation_wiki_dir (a_version_id: READABLE_STRING_GENERAL): PATH
		require
			a_version_id_not_blank: not a_version_id.is_whitespace
		do
			Result := documentation_dir.extended (a_version_id)
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

feature -- Recent changes	

	recent_changes_before (params: CMS_DATA_QUERY_PARAMETERS; a_date: DATE_TIME; a_version_id: detachable READABLE_STRING_GENERAL): LIST [TUPLE [time: DATE_TIME; author: READABLE_STRING_32; bookid: READABLE_STRING_GENERAL; page: like new_wiki_page; log: READABLE_STRING_8]]
			-- List of recent changes, before `a_date', according to `params' settings.
		local
			svn: SVN
			opts: detachable SVN_OPTIONS
			l_info: SVN_REVISION_INFO
			loc: PATH
			l_base_url: detachable STRING_8
			s: STRING_32
			utf: UTF_CONVERTER
			wp: detachable WIKI_BOOK_PAGE
			wbookid: detachable READABLE_STRING_GENERAL
			mnger: like manager
			dt: DATE_TIME
		do
			create {ARRAYED_LIST [like recent_changes_before.item]} Result.make (params.size.as_integer_32)

--			create opts

			create {SVN_ENGINE} svn
			if attached cms_api.setup.text_item ("tools.subversion.location") as l_svn_loc then
				create {SVN_ENGINE} svn.make_with_executable_path (l_svn_loc)
			elseif {PLATFORM}.is_unix then
				create {SVN_ENGINE} svn.make_with_executable_path ("/usr/bin/svn")
			else
				create {SVN_ENGINE} svn
			end
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
			if attached svn.logs (loc.name, True, a_date, 1, params.size.to_integer_32, opts) as l_logs then
				across
					l_logs as ic
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
						wp := Void
						wbookid := Void
						mnger := manager (a_version_id)
						if attached mnger.book_and_page_by_path (loc.extended (s)) as l_wb_and_wp then
							wp := l_wb_and_wp.page
							wbookid := l_wb_and_wp.bookid
						end
--						if wp = Void then
--							wp := new_wiki_page (s, "recent_changes")
--							wp.set_path (loc.extended (s))
--						end
						if wbookid /= Void and wp /= Void then
							wp.update_from_metadata
							wp.set_src (mnger.wiki_page_uri_path (wp, wbookid, a_version_id))
							wp.set_src (wp.src.substring (2, wp.src.count))
							Result.force ([dt, l_info.author, wbookid, wp, utf.utf_32_string_to_utf_8_string_8 (p_ic.item.action + {STRING_32} "%N -- " + l_info.log_message)])
						else
								-- FIXME: Either not a doc item, or issue. To handle.
						end
					end
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

	save_wiki_page (a_page: like new_wiki_page; a_source: detachable READABLE_STRING_8; a_path: detachable PATH; a_manager: WDOCS_MANAGER)
			-- Save page `a_page' with source `a_source' into file `a_path' or inside folder `a_path' if `a_path' is a folder.
		local
			p: detachable PATH
			txt: detachable STRING
			s: STRING
			i,j: INTEGER
			utf: UTF_CONVERTER
			wut: WSF_FILE_UTILITIES [RAW_FILE]
			fn: STRING
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
					a_page.update_metadata
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

					save_content_to_file (txt, p)
					if not has_error then
						a_manager.refresh_page_data (a_page)
					end
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


end
