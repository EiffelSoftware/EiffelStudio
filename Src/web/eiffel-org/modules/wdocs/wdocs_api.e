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

	REFACTORING_HELPER

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_cfg: WDOCS_CONFIG)
		do
			configuration := a_cfg
			make_with_cms_api (a_api)
		end

	initialize
			-- Initialize Current api.
		local
			cfg: detachable WDOCS_CONFIG
		do
			Precursor

			cfg := configuration
			temp_dir := cfg.temp_dir
			documentation_dir := cfg.documentation_dir
			default_version_id := cfg.documentation_default_version
		end

	configuration: WDOCS_CONFIG

	name: STRING = "wdocs"

feature -- Access

	documentation_dir: PATH

	default_version_id: READABLE_STRING_GENERAL

feature -- Query

	manager (a_version_id: detachable READABLE_STRING_GENERAL): WDOCS_MANAGER
		do
			if a_version_id = Void then
				create Result.make (documentation_wiki_dir (default_version_id), a_version_id, temp_dir)
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

	wiki_page (a_wiki_id: detachable READABLE_STRING_GENERAL; a_bookid, a_version_id: detachable READABLE_STRING_GENERAL): detachable like manager.new_wiki_page
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

	wiki_page_by_uuid (a_wiki_uuid: READABLE_STRING_GENERAL; a_bookid, a_version_id: detachable READABLE_STRING_GENERAL): detachable like manager.new_wiki_page
		local
			mnger: WDOCS_MANAGER
		do
			mnger := manager (a_version_id)
			Result := mnger.page_by_uuid (a_wiki_uuid, a_bookid)
		end

feature -- Factory

	new_wiki_page (a_title: READABLE_STRING_GENERAL; a_parent_key: READABLE_STRING_8): WIKI_BOOK_PAGE
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
		do
			create f.make_with_path (a_path)
			if f.exists and then f.is_access_readable then
				backup_file (f)
			end
			if not f.exists or else f.is_access_writable then
				f.open_write
				f.put_string (a_content)
				f.close
				remove_backuped_file (f)
			else
				error_handler.add_custom_error (0, "Impossible to save wiki page", "Impossible to save wiki page")
			end
		end


end
