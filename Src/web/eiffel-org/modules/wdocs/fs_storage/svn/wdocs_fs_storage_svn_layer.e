note
	description: "FS Storage layer for wdocs data, with subversion support."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_FS_STORAGE_SVN_LAYER

inherit
	WDOCS_FS_STORAGE_LAYER
		redefine
			make,
			commit, update,
			recent_changes_before,
			create_directory,
			delete_file,
			move_file,
			new_file, overwrite_file
		end

create {WDOCS_FS_STORAGE_LAYER_FACTORY}
	make

feature {NONE} -- Initialization

	make (a_api: like wdocs_api)
		do
			Precursor (a_api)
			changelist := new_changelist
		end

feature -- Access

	changelist: SVN_CHANGELIST

feature -- Execution

	commit (a_context: detachable WDOCS_CHANGE_CONTEXT; a_message: detachable READABLE_STRING_32)
		do
			if a_context /= Void then
				svn_commit (changelist, a_context.username, a_context.log)
			else
				svn_commit (changelist, Void, a_message)
			end
		end

	update (p: PATH)
		do
			svn_update (p)
		end

feature -- Basic operations

	add_file_path (p: PATH)
		do
			svn_add (p)
		end

	create_directory (dir: DIRECTORY)
		do
			Precursor (dir)
			changelist.extend_path (dir.path)
			svn_add (dir.path)
		end

	delete_file (p: PATH)
		do
			changelist.extend_path (p)
			svn_delete (p)
		end

	move_file (a_from, a_target: PATH)
		do
			svn_move (a_from, a_target)
			changelist.extend_path (a_from)
			changelist.extend_path (a_target)
		end

	new_file (a_content: detachable READABLE_STRING_8; a_path: PATH)
		do
			changelist.extend_path (a_path)
			Precursor (a_content, a_path)
			add_file_path (a_path)
		end

	overwrite_file (a_content: detachable READABLE_STRING_8; a_path: PATH)
		do
			changelist.extend_path (a_path)
			Precursor (a_content, a_path)
		end

feature -- Recent changes

	recent_changes_before (params: CMS_DATA_QUERY_PARAMETERS; a_date: DATE_TIME; a_version_id: detachable READABLE_STRING_GENERAL): LIST [TUPLE [time: DATE_TIME; author: READABLE_STRING_32; bookid: READABLE_STRING_GENERAL; page: like wdocs_api.new_wiki_page; log: READABLE_STRING_8]]
			-- List of recent changes, before `a_date', according to `params' settings.
		local
			svn: SVN
			opts: detachable SVN_OPTIONS
			l_info: SVN_REVISION_INFO
			l_log: READABLE_STRING_8
			loc: PATH
			i: INTEGER
			l_base_url, l_version_base_url: detachable STRING_8
			s: STRING_32
			utf: UTF_CONVERTER
			wp: detachable WIKI_BOOK_PAGE
			wbookid: detachable READABLE_STRING_GENERAL
			mnger: WDOCS_MANAGER
			dt: DATE_TIME
			l_prev: detachable like recent_changes_before.item
			l_logs: detachable LIST [SVN_REVISION_INFO]
			l_result_count: INTEGER
			nb: INTEGER
			done: BOOLEAN
		do
			Result := Precursor (params, a_date, a_version_id)

--			create opts

			mnger := wdocs_api.manager (a_version_id)

			svn := new_svn
			if a_version_id = Void then
				loc := wdocs_api.documentation_dir.extended (wdocs_api.default_version_id)
			else
				loc := wdocs_api.documentation_dir.extended (a_version_id)
			end
			if attached svn.repository_info (loc.name, opts) as l_repo_info then
				if
					attached l_repo_info.url as l_repo_url and
					attached l_repo_info.repository_root as l_repo_root
				then
					create l_version_base_url.make_from_string (l_repo_url)
					l_version_base_url.remove_head (l_repo_root.count)

						-- Remove the version segment.
					create l_base_url.make_from_string (l_version_base_url)
					i := l_base_url.last_index_of ('/', l_base_url.count)
					if i > 0 then
						l_base_url.keep_head (i - 1)
					end
				end
			end
--			loc := wdocs_api.documentation_dir -- Remove the version part			

			if l_version_base_url = Void then
				create l_version_base_url.make_empty
			end
			if l_base_url = Void then
				l_base_url := l_version_base_url
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
					done := l_result_count >= nb
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
							if s.starts_with (l_version_base_url) then
								s.remove_head (l_version_base_url.count + 1)
							elseif s.starts_with (l_base_url) then
								s.remove_head (l_base_url.count + 1)
								i := s.index_of ('/', 2)
								if i > 0 then
									s.remove_head (i)
								end
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

feature -- Subversion helpers

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

	new_changelist: SVN_CHANGELIST
		do
			create Result.make
		end

	add_path_to_changelist (p: PATH; a_changelist: like new_changelist)
		do
			a_changelist.extend_path (p)
		end

	svn_update (p: PATH)
		local
			svn: SVN
			opts: detachable SVN_OPTIONS
		do
			reset_error
			svn := new_svn
			if attached svn.update (p, Void, opts) as res then
				if res.failed then
					add_custom_error (1, "svn update failed", res.message)
				end
			end
		end

	svn_delete (p: PATH)
			-- Svn delete node at `p'.
		local
			svn: SVN
			opts: detachable SVN_OPTIONS
		do
			reset_error
			svn := new_svn
			create opts
			opts.set_parameters ("--force")
			if attached svn.delete (p, opts) as res then
				if res.failed then
					add_custom_error (1, "svn delete failed", res.message)
				end
			end
		end

	svn_add (p: PATH)
		local
			svn: SVN
			opts: detachable SVN_OPTIONS
		do
			reset_error
			svn := new_svn
			create opts
			opts.set_parameters ("--parents")
			if attached svn.add (p, opts) as res then
				if res.failed then
					add_custom_error (1, "svn add failed", res.message)
				end
			end
		end

	svn_move (p, a_new_location: PATH)
			-- Svn move node at `p' to new location `a_new_location'.
		local
			svn: SVN
			opts: detachable SVN_OPTIONS
		do
			reset_error
			svn := new_svn
			create opts
			opts.set_parameters ("--parents")
			if attached svn.move (p.name, a_new_location.name, opts) as res then
				if res.failed then
					add_custom_error (1, "svn add failed", res.message)
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
			reset_error
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
					add_custom_error (1, "svn commit failed", res.message)
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
