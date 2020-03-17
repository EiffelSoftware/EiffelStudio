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

	default_editing_version_id: READABLE_STRING_GENERAL
		do
--			if attached available_versions (False) as lst and then not lst.is_empty then
--				Result := lst.first
--			else
				Result := default_version_id
--			end
		end

feature -- Query

	label_of_version (a_version_id: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- optional label for `a_version_id`.
		do
			Result := available_versions (False).item (a_version_id)
			if
				Result = Void and then
				a_version_id.is_case_insensitive_equal (default_version_id)
			then
				Result := "current"
			end
		end

	available_versions (a_check_existence: BOOLEAN): STRING_TABLE [detachable READABLE_STRING_32]
			-- Available versions.
		local
			f: PLAIN_TEXT_FILE
			utf: UTF_CONVERTER
			ut: FILE_UTILITIES
			i: INTEGER
			p: PATH
			d: DIRECTORY
			s,lab,v: detachable STRING_32
		do
			if a_check_existence and then attached internal_available_existing_versions as l_existing_versions then
				Result := l_existing_versions
			elseif not a_check_existence and then attached internal_available_versions as l_versions then
				Result := l_versions
			else
				create Result.make_equal_caseless (3)
				if a_check_existence then
					internal_available_existing_versions := Result
				else
					internal_available_versions := Result
				end

				create f.make_with_path (settings.documentation_dir.extended ("versions"))
				if f.exists and then f.is_access_readable then
					f.open_read
					from
					until
						f.end_of_file or f.exhausted
					loop
						f.read_line_thread_aware
						s := utf.utf_8_string_8_to_string_32 (f.last_string)
						i := s.index_of (':', 1)
						if i > 0 then
							lab := s.substring (i + 1, s.count)
							v := s
							v.keep_head (i - 1)
							lab.left_adjust
							lab.right_adjust
						else
							v := s
							lab := Void
						end
						v.left_adjust
						v.right_adjust
						if
							not v.is_whitespace and then
							(not a_check_existence or else ut.directory_path_exists (settings.documentation_dir.extended (v)))
						then
							Result.force (lab, v)
						end
					end
					f.close
				else
					create d.make_with_path (settings.documentation_dir)
					if d.exists then
						across
							d.entries as ic
						loop
							p := ic.item
							if p.is_current_symbol or p.is_parent_symbol then
							elseif not p.name.starts_with_general (".") then
								Result.force (Void, p.name)
							end
						end
					end
				end
				if Result.is_empty then
					Result.force ("current", default_version_id.as_string_32)
				end
			end
		end

feature {NONE} -- Query

	internal_available_versions: detachable like available_versions
			-- cached version of `available_versions (False)`.

	internal_available_existing_versions: detachable like available_versions
			-- cached version of `available_versions (True)`.


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

	clear_all_caches
			-- Clear all existing wdocs related caches.
		local
			retried: BOOLEAN
--			p: PATH
--			d: DIRECTORY
		do
			if not retried then
				internal_available_versions := Void
				internal_available_existing_versions := Void
				across
					available_versions (False) as ic
				loop
					clear_all_cache_for_version (ic.key)
				end
--					-- FIXME: clear remaining cache data, in case it was not cleared yet.
--				p := temp_dir.extended ("cache")
--				create d.make_with_path (p)
--				if d.exists then
--					d.recursive_delete
--				end
			else
				error_handler.add_custom_error (-1, "Clearing cache failed!", Void)
			end
		rescue
			retried := True
			retry
		end

	clear_all_cache_for_version (a_version_id: READABLE_STRING_GENERAL)
			-- Clear all existing wdocs related caches.
			-- if `a_version_id` is set, clear only cache related to that version
			-- else clear all known version caches.
		local
			retried: BOOLEAN
			p: PATH
			d: DIRECTORY
		do
			if not retried then
				if attached manager (a_version_id) as mng then
						-- Clear wiki catalog
					mng.refresh_data
						-- Clear cms menu
					across
						mng.book_names as ic
					loop
						reset_cms_menu_cache_for (mng.version_id, ic.item)
					end
				end
					-- FIXME: clear remaining cache data, in case it was not cleared yet.
				p := temp_dir.extended ("cache").extended (a_version_id).extended ("xhtml")
				create d.make_with_path (p)
				if d.exists then
					d.recursive_delete
				end
			else
				error_handler.add_custom_error (-1, "Clearing cache failed!", {STRING_32} "Failed to clear cache for version %""+ a_version_id.as_string_32 +"%"!")
			end
		rescue
			retried := True
			retry
		end

	cache_for_wiki_page_xhtml (a_version_id: READABLE_STRING_GENERAL; a_book_name: detachable READABLE_STRING_GENERAL; a_wiki_page: WIKI_BOOK_PAGE): WDOCS_FILE_STRING_8_CACHE
		local
			p: PATH
			d: DIRECTORY
		do
			p := temp_dir.extended ("cache").extended (a_version_id).extended ("xhtml")
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
			p := p.extended (normalized_fs_text (a_wiki_page.key)).appended_with_extension ("xhtml")
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

	append_available_versions_menu_to_xhtml (pg: detachable like new_wiki_page; a_version_id: detachable READABLE_STRING_GENERAL; a_response: CMS_RESPONSE; a_output: STRING_8)
		local
			s, loc, uri: detachable STRING
			l_link_title, lab: detachable READABLE_STRING_GENERAL
			l_curr_version: READABLE_STRING_GENERAL
			l_version_id: READABLE_STRING_GENERAL
			i: INTEGER
		do
			if attached available_versions (False) as l_versions and then not l_versions.is_empty then
				loc := a_response.location
				if loc.starts_with_general ("doc/") then
					if loc.starts_with_general ("doc/version/") then
						i := loc.index_of ('/', 13)
						if i > 0 then
							l_curr_version := loc.substring (13, i - 1)
							s := loc.substring (i, loc.count)
						else
							l_curr_version := loc.substring (13, loc.count)
							s := ""
						end
					else
						s := loc.substring (4, loc.count)
					end
				elseif loc.same_string_general ("documentation") or loc.same_string_general ("documentation/") then
					s := ""
				end
				if s /= Void then
					a_output.append ("<div class=%"wdocs-versions%">")
					a_output.append (cms_api.translation ("Version", Void))
					a_output.append ("<ul>")
					a_output.append ("<li class=%"active%">")
					if a_version_id = Void then
						l_version_id := default_version_id
					else
						l_version_id := a_version_id
					end
					lab := l_versions.item (l_version_id)
					if l_version_id.is_case_insensitive_equal (default_version_id) then
						if lab = Void then
							lab := "current"
						end
						uri := "doc" + s
					else
						uri := "doc/version/" + l_version_id.out + s
					end
					if lab /= Void then
						l_link_title := l_version_id + " (" + lab + ")"
					else
						l_link_title := l_version_id
					end
					a_response.append_link_to_html (l_link_title + " ...", uri, Void, a_output)

					a_output.append ("<ul class=%"popup-menu%">")
					across
						l_versions as ic
					loop
						lab := ic.item
						if l_version_id.is_case_insensitive_equal (ic.key) then
							a_output.append ("<li class=%"active%">")
						else
							a_output.append ("<li>")
						end
						if default_version_id.is_case_insensitive_equal (ic.key) then
							if lab = Void then
								lab := "current"
							end
							uri := "doc" + s
						else
							uri := "doc/version/" + ic.key.out + s
						end
						if lab /= Void then
							l_link_title := ic.key.to_string_32 + " (" + lab + ")"
						else
							l_link_title := ic.key
						end
						a_response.append_link_to_html (l_link_title, uri, Void, a_output)

						a_output.append ("</li>")
					end
					a_output.append ("</ul></li>")
					a_output.append ("</ul></div>%N")
				end
			end
		end

	append_versions_to_xhtml (a_version_ids: ITERABLE [READABLE_STRING_GENERAL]; a_response: CMS_RESPONSE; a_show_url: BOOLEAN; a_output: STRING_8; a_css_class: detachable READABLE_STRING_8)
		local
			s, loc, uri: detachable STRING
			l_link_title, lab: detachable READABLE_STRING_GENERAL
			l_curr_version: READABLE_STRING_GENERAL
			i: INTEGER
		do
			if attached available_versions (False) as l_versions and then not l_versions.is_empty then
				loc := a_response.location
				if loc.starts_with_general ("doc/") then
					if loc.starts_with_general ("doc/version/") then
						i := loc.index_of ('/', 13)
						if i > 0 then
							l_curr_version := loc.substring (13, i - 1)
							s := loc.substring (i, loc.count)
						else
							l_curr_version := loc.substring (13, loc.count)
							s := ""
						end
					else
						s := loc.substring (4, loc.count)
					end
				elseif loc.same_string_general ("documentation") or loc.same_string_general ("documentation/") then
					s := ""
				end
				if s /= Void then
					if a_css_class /= Void then
						a_output.append ("<ul class=%"" + a_css_class + "%">")
					else
						a_output.append ("<ul>")
					end
					across
						l_versions as ic
					loop
						lab := ic.item
						if across a_version_ids as vic some vic.item.is_case_insensitive_equal (ic.key) end then
								-- Excluded
							a_output.append ("<li>")
							if default_version_id.is_case_insensitive_equal (ic.key) then
								if lab = Void then
									lab := "current"
								end
								uri := "doc" + s
							else
								uri := "doc/version/" + ic.key.out + s
							end
							if lab /= Void then
								l_link_title := ic.key.to_string_32 + " (" + lab + ")"
							else
								l_link_title := ic.key
							end
							if a_show_url then
								l_link_title := l_link_title + ": " + uri
							end

							a_response.append_link_to_html (l_link_title, uri, Void, a_output)

							a_output.append ("</li>")
						end
					end
					a_output.append ("</ul>%N")
				end
			end
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
			elseif a_wiki_id /= Void and then a_wiki_id.same_string ("Documentation") then
				Result := mnger.index_page
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

	page_references (a_wp: WIKI_PAGE; a_book_id, a_version_id: detachable READABLE_STRING_GENERAL): LIST [like new_wiki_page]
			-- Page referencing `a_wp' if any.
			-- TODO: to implement!
		do
			create {ARRAYED_LIST [like new_wiki_page]} Result.make (0)
		end

feature -- Recent changes	

	recent_changes_before (params: CMS_DATA_QUERY_PARAMETERS; a_date: DATE_TIME; a_version_id: detachable READABLE_STRING_GENERAL): LIST [TUPLE [time: DATE_TIME; author: READABLE_STRING_32; bookid: READABLE_STRING_GENERAL; page: like new_wiki_page; log: READABLE_STRING_8]]
			-- List of recent changes, before `a_date', according to `params' settings.
		local
			l_storage_layer: like new_storage_layer
		do
			l_storage_layer := new_storage_layer
			Result := l_storage_layer.recent_changes_before (params, a_date, a_version_id)
		end

feature -- Page management

	update
		local
			l_storage_layer: like new_storage_layer
		do
			l_storage_layer := new_storage_layer
			l_storage_layer.update (documentation_dir)
		end

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
			l_storage_layer: detachable like new_storage_layer
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
				l_storage_layer := new_storage_layer
				if (create {FILE_UTILITIES}).file_path_exists (p) then
					l_storage_layer.delete_file (p)
					if not has_error then
						p_data := p.appended_with_extension ("data")
						if (create {FILE_UTILITIES}).file_path_exists (p_data) then
							l_storage_layer.delete_file (p_data)
						end
					end

				end
				if not has_error and l_storage_layer /= Void then
					l_storage_layer.commit (a_context, "Delete wiki page %"" + a_page.title + "%".")
					if not has_error then
						l_storage_layer.update (documentation_dir.extended (a_manager.version_id))
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

	save_wiki_page (a_page: like new_wiki_page; a_parent_page: detachable like new_wiki_page; a_source: detachable READABLE_STRING_8;
			a_path: detachable PATH; a_book_id: READABLE_STRING_GENERAL; a_manager: WDOCS_MANAGER; a_context: detachable WDOCS_CHANGE_CONTEXT)
			-- Save page `a_page' with source `a_source' into file `a_path' or inside folder `a_path' if `a_path' is a folder.
		local
			p: detachable PATH
			txt: detachable STRING
			s: STRING
			i,j: INTEGER
			utf: UTF_CONVERTER
			wut: WSF_FILE_UTILITIES [RAW_FILE]
			fn: STRING
			l_storage_layer: like new_storage_layer
			md_text: WDOCS_METADATA_WIKI_TEXT
			l_prev_md: detachable STRING_TABLE [READABLE_STRING_32]
			l_save_succeed, l_commit_succeed: BOOLEAN
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
					if not a_page.has_metadata ("publication_date") then
						a_page.set_metadata (cms_api.date_time_to_string (create {DATE_TIME}.make_now_utc), "publication_date")
					end
					a_page.set_metadata (cms_api.date_time_to_string (create {DATE_TIME}.make_now_utc), "modification_date")

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

					l_storage_layer := new_storage_layer
						-- Save wiki file
					if (create {FILE_UTILITIES}).file_path_exists (p) then
						l_storage_layer.overwrite_file (txt, p)
					else
						prepare_wiki_parent_directory (p.parent, a_parent_page, l_storage_layer)
						l_storage_layer.new_file (txt, p)
					end
					l_save_succeed := not has_error
					l_storage_layer.commit (a_context, Void)
					l_commit_succeed := not has_error
					a_page.set_text (create {WIKI_CONTENT_TEXT}.make_from_string (txt))
					if l_save_succeed then
						a_manager.refresh_page_data (a_book_id, a_page)
						l_storage_layer.update (documentation_dir.extended (a_manager.version_id))
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

	prepare_wiki_parent_directory (p: PATH; a_parent_page: detachable like new_wiki_page; a_storage_layer: like new_storage_layer)
			-- Prepare parent directory for a new sub wiki page.
		local
			dir: DIRECTORY
			l_index_path: detachable PATH
			fut: FILE_UTILITIES
		do
			create dir.make_with_path (p)
			if not dir.exists then
				a_storage_layer.create_directory (dir)
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
					a_storage_layer.move_file (l_index_path, p.extended ("index.wiki"))
				else
					a_storage_layer.new_file (Void, p.extended ("index.wiki"))
				end
			end
		end

feature -- Event

	new_storage_layer: WDOCS_FS_STORAGE_LAYER
		do
			Result := storage_layer_factory.new_layer (Current)
		end

feature {NONE} -- Implementation

	temp_dir: PATH

	storage_layer_factory: WDOCS_FS_STORAGE_LAYER_FACTORY
		once
			create Result
		end

end

