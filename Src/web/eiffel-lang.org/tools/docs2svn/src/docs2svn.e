note
	description: "[
			Enter class description here!
		]"

class
	DOCS2SVN

inherit
	SHARED_EXECUTION_ENVIRONMENT
		rename
			print as ascii_print
		end

	LOCALIZED_PRINTER
		rename
			print as ascii_print,
			localized_print as print
		end

	WDOCS_HELPER
		rename
			print as ascii_print
		end

	WDOCS_DATA_ACCESS
		rename
			print as ascii_print
		end


create
	make

feature {NONE} -- Initialization

	make
			-- Instantiate Current object.
		local
			args: ARGUMENTS_32
			l_source_dir, l_temp_dir, l_target_dir: detachable PATH
			d: PATH
			i,n: INTEGER
		do
			d := execution_environment.current_working_path.extended ("..").extended ("..").canonical_path
			source_dir := d.extended ("data").extended ("documentation").extended ("backup").canonical_path
			tmpdir := d.extended ("data").extended ("tmp").extended ("docs2svn").extended ("backup").canonical_path
--			target_dir := d.extended ("data").extended ("replay").extended ("docs").canonical_path
			target_dir := (create {PATH}.make_from_string ("C:\_dev\temp")).extended ("replay").extended ("docs").canonical_path

			from
				i := 1
				create args
				n := args.argument_count
			until
				i > n
			loop
				if args.argument (i).same_string_general ("--target") and then i < n then
					i := i + 1
					create l_target_dir.make_from_string (args.argument (i))
				elseif args.argument (i).same_string_general ("--source") and then i < n then
					i := i + 1
					create l_source_dir.make_from_string (args.argument (i))
				elseif args.argument (i).same_string_general ("--tmp") and then i < n then
					i := i + 1
					create l_temp_dir.make_from_string (args.argument (i))
				elseif args.argument (i).same_string_general ("--reset") then
					reset_requested := True
				end
				i := i + 1
			end
			if l_source_dir /= Void then
				source_dir := l_source_dir.canonical_path
			end

			if l_temp_dir /= Void then
				tmpdir := l_temp_dir.canonical_path
			end

			if l_target_dir /= Void then
				target_dir := l_target_dir.canonical_path
			end

			execute
		end

feature -- Access

	source_dir: PATH

	tmpdir: PATH

	target_dir: PATH

	wdocs: DOCS2SVN_WDOCS_MANAGER

feature -- Settings

	reset_requested: BOOLEAN

feature -- Execution			

	execute
		local
			k: READABLE_STRING_GENERAL
			wd: DOCS2SVN_WDOCS_MANAGER
			d: PATH
			wikidir: PATH
			wp: WIKI_PAGE
			timeline: WDOCS_TIMELINE
			evt: WDOCS_TIMELINE_EVENT
			l_reset: BOOLEAN
		do
			l_reset := reset_requested
			wikidir := source_dir

			create timeline.make (1_000)
			if not l_reset then
				timeline.load (tmpdir, "timeline")
			end
			if not timeline.items.is_empty then
				create wd.make (wikidir, "backup", tmpdir)
				wdocs := wd
			else

				create wd.make_clear (wikidir, "backup", tmpdir)
				wdocs := wd

				if l_reset then
					wd.reload_data
				end

				prepare_documentation (wd)

				across
					wd.book_names as ic
				loop
					if attached wd.book (ic.item) as l_book then
						across
							l_book.pages as p_ic
						loop
							wp := p_ic.item
							print ("[")
							print (wp.title)
							print ("] ")
							if attached wp.path as l_wp_path then
								print (l_wp_path.name)
							end
							print ("%N")
							if attached wp.path as l_wp_path and then attached page_revisions (wp) as l_revisions then
								across
									l_revisions as  rev_ic
								loop
									print ("%T #" + rev_ic.item.id.out + " ")
									if attached rev_ic.item.data as md then
										if attached revision_date_time (md.item ("revision")) as l_changed then
											print (l_changed.out)

											create {WDOCS_TIMELINE_PAGE_EVENT} evt.make (wikidir, l_wp_path, wp, rev_ic.item, l_changed)
											timeline.put (evt)
										else
											report_error ({STRING_32} "Missing time information!%N" + rev_ic.item.location.name + "%N")
										end
									end
									print ("%N")
								end
							end
						end
					end
				end

				if attached wd.storage.templates_path_by_title_and_book as tpl_table then
					across
						tpl_table as tb_ic
					loop
						across
							tb_ic.item as ic
						loop
							print ("{{")
							print (ic.key)
							print ("}} ")
							print (ic.item.name)
							print ("%N")
							if attached revisions (ic.item) as l_revisions then
								across
									l_revisions as  rev_ic
								loop
									print ("%T #" + rev_ic.item.id.out + " ")
									if attached rev_ic.item.data as md then
										if attached revision_date_time (md.item ("revision")) as l_changed then
											print (l_changed.out)

											create {WDOCS_TIMELINE_TEMPLATE_EVENT} evt.make (wikidir, ic.key, ic.item, tb_ic.key, rev_ic.item, l_changed)
											timeline.put (evt)
										else
											report_error ({STRING_32} "Missing time information!%N" + rev_ic.item.location.name + "%N")
										end
									end
									print ("%N")
								end
							end
						end
					end
				end

				if attached wd.storage.images_path_by_title_and_book as img_table then
					across
						img_table as tb_ic
					loop
						across
							tb_ic.item as ic
						loop
							print ("[Image:")
							print (ic.key)
							print ("] ")
							print (ic.item.name)
							print ("%N")
							if attached revisions (ic.item) as l_revisions then
								across
									l_revisions as  rev_ic
								loop
									print ("%T #" + rev_ic.item.id.out + " ")
									if attached rev_ic.item.data as md then
										if attached revision_date_time (md.item ("revision")) as l_changed then
											print (l_changed.out)

											create {WDOCS_TIMELINE_IMAGE_EVENT} evt.make (wikidir, ic.key, ic.item, tb_ic.key, rev_ic.item, l_changed)
											timeline.put (evt)
										else
											report_error ({STRING_32} "Missing time information!%N" + rev_ic.item.location.name + "%N")
										end
									end
									print ("%N")
								end
							end
						end
					end
				end

				timeline.sort
				timeline.save (tmpdir, "timeline")
			end

--			across
--				timeline.authors as ic
--			loop
--				print (ic.item)
--				print ("%N")
--			end
--			replay_timeline (timeline, target_dir, create {DATE_TIME}.make (2011, 01, 01, 12, 0, 0))
			replay_timeline (timeline, target_dir, Void)
		end

	report_error (m: READABLE_STRING_32)
		do
			localized_print_error (m)
			localized_print_error ("%N");

			(create {EXCEPTIONS}).die (-1)
		end

	page_revisions (a_page: WIKI_PAGE): detachable ARRAYED_LIST [WDOCS_REVISION_INFO]
		require
			page_has_path: a_page.path /= Void
		do
			if attached a_page.path as p then
				Result := revisions (p)
			end
		end

	revisions (p: PATH): detachable ARRAYED_LIST [WDOCS_REVISION_INFO]
		local
			ut: FILE_UTILITIES
			l_revs_path: PATH
			n: STRING_32
			dir: DIRECTORY
			ext: detachable READABLE_STRING_32
			l_rev: WDOCS_REVISION_INFO
			l_sorter: QUICK_SORTER [WDOCS_REVISION_INFO]
		do
			if ut.file_path_exists (p) then
				ext := p.extension
				l_revs_path := p.appended_with_extension ("revs")

				create Result.make (1)
				if ut.directory_path_exists (l_revs_path) then
					create dir.make_with_path (l_revs_path)
					across
						dir.entries as ic
					loop
						if
							ext = Void or else
							attached ic.item.extension as i_ext and then
							i_ext.same_string (ext)
						then
							create l_rev.make (l_revs_path.extended_path (ic.item))
							l_rev.set_data (wdocs.metadata (l_rev.location, Void))
							Result.force (l_rev)
						end
					end

					create l_sorter.make (create {COMPARABLE_COMPARATOR [WDOCS_REVISION_INFO]})
					l_sorter.sort (Result)
--				else
--					create l_rev.make (p)
--					l_rev.set_data (wdocs.metadata (l_rev.location, Void))
--					Result.force (l_rev)
				end
				create l_rev.make (p)
				l_rev.set_data (wdocs.metadata (l_rev.location, Void))
				Result.force (l_rev)
			end
		end

	revision_date_time (a_revision_string: detachable READABLE_STRING_32): detachable DATE_TIME
		local
			hd: HTTP_DATE
			i: INTEGER
			s: READABLE_STRING_32
		do
			if a_revision_string /= Void then
				i := a_revision_string.index_of ('"', 1)
				if i > 0 then
					s := a_revision_string.head (i - 1)
					if s.is_integer_64 then
						create hd.make_from_timestamp (s.to_integer_64)
						Result := hd.date_time
					end
				end
			end
		end

feature -- Operation

	prepare_documentation (wd: DOCS2SVN_WDOCS_MANAGER)
		do
			reuse_documentation_items (wd, "templates", wd.storage.templates_path_by_title_and_book)
			reuse_documentation_items (wd, "images", wd.storage.images_path_by_title_and_book)
		end

	reuse_documentation_items (wd: DOCS2SVN_WDOCS_MANAGER; a_id: READABLE_STRING_8; a_table: STRING_TABLE [STRING_TABLE [PATH]])
		local
			l_book_name: READABLE_STRING_GENERAL
			l_paths: STRING_TABLE [PATH]
			l_common_table: detachable STRING_TABLE [PATH]
			l_item_name: READABLE_STRING_GENERAL
			l_item_path: PATH
			to_remove: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			across
				a_table as tb_ic
			loop
				l_book_name := tb_ic.key
				if l_book_name.is_case_insensitive_equal ({WDOCS_PAGES_DATA}.common_book_name) then
					l_common_table := tb_ic.item
				end
			end
			if l_common_table = Void then
				create l_common_table.make (0)
				a_table.force (l_common_table, {WDOCS_PAGES_DATA}.common_book_name)
			end

			across
				a_table as tb_ic
			loop
				l_book_name := tb_ic.key
--				if l_book_name.is_case_insensitive_equal ({WDOCS_DATA}.common_book_name) then
--						-- Skip
--				else
						-- not global common book
					create to_remove.make (0)
					across
						tb_ic.item as ic
					loop
						l_item_name := ic.key
						l_item_path := ic.item

						across
							a_table as itb_ic
						loop
							if
								itb_ic.key.is_case_insensitive_equal ({WDOCS_PAGES_DATA}.common_book_name)
								or itb_ic.key = l_book_name
							then
									-- Skip
							else
								if
									attached itb_ic.item.item (l_item_name) as p2 and then
									same_file (l_item_path, p2)
								then
									print (a_id + " [")
									print (l_book_name)
									print ("] %"")
									print (l_item_name)
									print ("%" duplicated in book [")
									print (itb_ic.key)
									print ("]%N")
									if attached l_common_table.item (l_item_name) as l_common_item then
											-- Already item associated with that name.
										if same_file (l_item_path, l_common_item) then
											to_remove.force (l_item_name)
											itb_ic.item.remove (l_item_name)
											print (" => item already in common.%N")
										else
											print (" => name already associated with an item, keep as it.%N")
										end
									else
										to_remove.force (l_item_name)
										itb_ic.item.remove (l_item_name)
										print (" => Move to common.%N")
										l_common_table.force (l_item_path, l_item_name)
									end
								end
							end
						end
					end
					across
						to_remove as del_ic
					loop
						tb_ic.item.remove (del_ic.item)
					end
					to_remove.wipe_out

--				end
			end
		end

	same_file (p1, p2: PATH): BOOLEAN
		local
			f1, f2: RAW_FILE
		do
			if
				attached p1.entry as e1	and then
				attached p2.entry as e2 and then
				e1.name.same_string (e2.name)
			then
				create f1.make_with_path (p1)
				create f2.make_with_path (p2)

				if f1.exists and f2.exists then
					Result := f1.count = f2.count
				end
			end
		end

	replay_timeline (a_timeline: WDOCS_TIMELINE; a_target_dir: PATH; a_date: detachable DATE_TIME)
		local
			rev: WDOCS_REVISION_INFO
			p: PATH
--			log: STRING
			l_md_path: PATH
--			l_iso8601: STRING
			l_added_paths: HASH_TABLE [PATH, PATH]
			lst: ARRAYED_LIST [PATH]
			i: INTEGER
			pending_date_upper_ranger: detachable DATE_TIME
			commit_delay_in_minutes: INTEGER
			l_commit: detachable DOCS2SVN_SVN_COMMIT_PARAMETERS
		do
			commit_delay_in_minutes := 8 * 60 -- 8 hours

			execution_environment.change_working_path (a_target_dir)
			create l_added_paths.make (300)
			create lst.make (2)
			across
				a_timeline as ic
			loop
				if a_date = Void or else ic.item.date <= a_date then
					if attached {WDOCS_TIMELINE_PATH_EVENT} ic.item as p_event then
						lst.wipe_out
						i := i + 1
						print ("%N--<" + i.out + ">--%N")
						rev := p_event.revision
						p := a_target_dir.extended (normalized_fs_text (p_event.relative_path))

							-- Copy wiki or image or template file
						copy_to (rev.location, p)
						if is_wiki_filename (p) then
							rev.save_new_metadata_to_wiki (p)
--							update_wiki_file_with_revision_metadata (p, rev)
						else
							l_md_path := metadata_filename (p)

							rev.save_new_metadata_to (l_md_path)
							if not l_added_paths.has (l_md_path) then
								lst.force (l_md_path)
								l_added_paths.put (l_md_path, l_md_path)
							end
						end

							-- Subversion: add new files.

						if not l_added_paths.has (p) then
							lst.force (p)
							l_added_paths.put (p, p)
						end

						if not lst.is_empty then
							svn_add (lst)
						end

							-- Process previous commit, if
							--		last commit occurred more than `commit_delay_in_minutes' minutes ago
							--	or	different author
							--	or	has a revision commit log
						if
								-- Has pending commit
							l_commit /= Void and then
							(
									-- different author
								not rev.is_author (l_commit.author)
									-- next revision has log
								or (attached rev.log as revlog and then not revlog.is_whitespace)
									-- last commit occurred more than `commit_delay_in_minutes' minutes ago
								or (attached pending_date_upper_ranger as l_prev_date and then ic.item.date > l_prev_date)
							)
						then
								-- Perform pending commit
							commit (l_commit)
							pending_date_upper_ranger := Void
							l_commit := Void
						end

						create l_commit.make (ic.item.date, rev.author, rev.log)
						if
								-- current revision has a significant log.
							attached rev.log as revlog and then not revlog.is_whitespace
						then
								-- Commit change right away
							commit (l_commit)
							l_commit := Void
						else
							if pending_date_upper_ranger = Void then
								pending_date_upper_ranger := l_commit.date.deep_twin
								pending_date_upper_ranger.minute_add (commit_delay_in_minutes)
							end
						end
					end
				end
			end
			if l_commit /= Void then
				commit (l_commit)
			end
		end

	copy_to (src: PATH; tgt: PATH)
		local
			ut: FILE_UTILITIES
			src_data, tgt_data: detachable PATH
			n: STRING_32
		do
			copy_file_from_to (src, tgt)


			debug ("docs2svn")
					-- Metadata...
				src_data := src.appended_with_extension (wdocs.metadata_extension)
				if ut.file_path_exists (src_data) then
					tgt_data := tgt.appended_with_extension (wdocs.metadata_extension)
				else
					if attached src.extension as ext then
						n := src.name
						n.remove_tail (ext.count + 1)
						create src_data.make_from_string (n)
						src_data := src_data.appended_with_extension (wdocs.metadata_extension)
						if ut.file_path_exists (src_data) then
							if attached tgt.extension as ext2 then
								n := tgt.name
								n.remove_tail (ext2.count + 1)
								create tgt_data.make_from_string (n)
								tgt_data := tgt_data.appended_with_extension (wdocs.metadata_extension)
							end
						else
							src_data := Void
						end
					end
				end

				if src_data /= Void and tgt_data /= Void then
					tgt_data := tgt_data.appended_with_extension ("debug")
					copy_file_from_to (src_data, tgt_data)
				end
			end
		end

	is_wiki_filename (p: PATH): BOOLEAN
			-- Is `p' representing a wiki filename?
		do
			Result := attached p.extension as ext and then ext.is_case_insensitive_equal_general ("wiki")
		end

	metadata_filename (p: PATH): PATH
		local
			n: STRING_32
		do
			if
				attached p.extension as ext and then
				ext.is_case_insensitive_equal_general ("wiki")
			then
				n := p.name
				n.remove_tail (ext.count + 1)
				create Result.make_from_string (n)
			else
				Result := p
			end
			Result := Result.appended_with_extension (wdocs.metadata_extension)
		end

	copy_file_from_to (src: PATH; tgt: PATH)
		local
			f_src: RAW_FILE
			f_target: RAW_FILE
			d: DIRECTORY
			ut: FILE_UTILITIES
			l_is_text: BOOLEAN
		do
			print ("Copy ")
			print (src.name)
			print (" to ")
			print (tgt.name)
			print ("%N")

			l_is_text := attached src.extension as ext and then
					(
						ext.is_case_insensitive_equal_general ("wiki")
						or ext.is_case_insensitive_equal_general (wdocs.metadata_extension)
						or ext.is_case_insensitive_equal_general ("md")
					)

			create f_src.make_with_path (src)
			if f_src.exists and then f_src.is_access_readable then
				f_src.open_read

				create f_target.make_with_path (tgt)
				if not f_target.exists or else f_target.is_access_writable then
					create d.make_with_path (tgt.parent)
					if not d.exists then
						d.recursive_create_dir
					end
					f_target.open_write
					if l_is_text then
						copy_text_file_from_to (f_src, f_target)
					else
						f_src.copy_to (f_target)
					end
					f_target.close
				end
				f_src.close
			end
		end

	copy_text_file_from_to (f_src, f_target: RAW_FILE)
		local
			done: BOOLEAN
			s: STRING
		do
			from
			until
				done
			loop
				f_src.read_line_thread_aware
				s := f_src.last_string
				if s[s.count] = '%R' then
					s.remove_tail (1)
				end
				f_target.put_string (s)
				f_target.put_new_line
				done := f_src.exhausted or f_src.end_of_file
			end
		end

feature -- Subversion

	commit (a_commit: DOCS2SVN_SVN_COMMIT_PARAMETERS)
		do
			svn_commit (a_commit.commit_log)
			svn_propset_date (a_commit.iso_date_string)
			if attached a_commit.author as l_author then
				svn_propset_author (l_author)
			end
		end

	svn_authors: STRING_TABLE [READABLE_STRING_8]
		once
			create Result.make (10)
			Result.force ("jfiat", "admin")
			Result.force ("halw", "halw")
			Result.force ("paulb", "paulb")
			Result.force ("jfiat", "jfiat")
			Result.force ("manus", "manus")
			Result.force ("alexk", "alexk")
			Result.force ("bmeyer", "bmeyer")
			Result.force ("tedf", "tedf")
			Result.force ("king", "king")
			Result.force ("arnof", "arnofiva")

			Result.force ("pgummer", "Peter Gummer")
			Result.force ("roman", "Roman")
			Result.force ("vwheeler", "vwheeler")
			Result.force ("paolanto", "paolanto")
			Result.force ("conaclos", "Conaclos")
		end

	svn_author (a: READABLE_STRING_8): READABLE_STRING_8
		do
			if attached svn_authors.item (a) as s then
				Result := s
			else
				Result := "contributors"
			end
		end

	is_current_working_path_same_as (p: PATH): BOOLEAN
		do
			Result := execution_environment.current_working_path.same_as (p)
		end

	new_svn_command (op: READABLE_STRING_GENERAL): STRING_32
		do
			create Result.make_from_string_general ("svn ")
			Result.append_string_general (op)
		end

	svn_add (lst: ITERABLE [PATH])
		require
			is_current_working_path_same_as (target_dir)
		local
			cmd: STRING_32
		do
			cmd := new_svn_command ("add")
			cmd.append (" --parents")
			across
				lst as ic
			loop
				cmd.append_character (' ')
				cmd.append_character ('"')
				cmd.append_string (ic.item.name)
				cmd.append_character ('"')
			end
			execution_environment.system (cmd)
			check_execution_error (cmd, True)
		end

	svn_commit (log: READABLE_STRING_8)
		require
			is_current_working_path_same_as (target_dir)
		local
			cmd: STRING_32
			f: RAW_FILE
			p: PATH
		do
			p := tmpdir.extended ("tmp-commit-log")
			create f.make_with_path (p)
			f.create_read_write
			f.put_string (log)
			f.close
			cmd := new_svn_command ("commit")
			cmd.append (" --file ")
			cmd.append_character ('"')
			cmd.append (p.name)
			cmd.append_character ('"')
			execution_environment.system (cmd)
			check_execution_error (cmd, False)
		end

	svn_propset_date (l_iso8601: READABLE_STRING_8)
		require
			is_current_working_path_same_as (target_dir)
		local
			cmd: STRING_32
		do
			cmd := new_svn_command ("propset")
			cmd.append (" svn:date ")
			cmd.append_character ('"')
			cmd.append (l_iso8601)
			cmd.append_character ('"')
			cmd.append (" --revprop ")
			cmd.append (" -r HEAD ")
			execution_environment.system (cmd)
			check_execution_error (cmd, True)
		end

	svn_propset_author (author: READABLE_STRING_8)
		require
			is_current_working_path_same_as (target_dir)
		local
			cmd: STRING_32
		do
			cmd := new_svn_command ("propset")
			cmd.append (" svn:author ")
			cmd.append_character ('"')
			cmd.append (svn_author (author))
			cmd.append_character ('"')
			cmd.append (" --revprop ")
			cmd.append (" -r HEAD ")
			execution_environment.system (cmd)
			check_execution_error (cmd, True)
		end

	check_execution_error (cmd: READABLE_STRING_32; a_accept_error: BOOLEAN)
		do
			if execution_environment.return_code /= 0 then
				print ("Error command=[")
				print (cmd)
				print ("] ... return_code=" + execution_environment.return_code.out + " .%N")
				if not a_accept_error then
					print ("Press ENTER.")
					io.read_line;
					(create {EXCEPTIONS}).die (-1)
				end
			end
		end

	svn_date (d: DATE_TIME): STRING
		do
			create Result.make_empty
			Result.append_integer (d.year)
			Result.append_character ('-')
			Result.append_string (two_digit (d.month))
			Result.append_character ('-')
			Result.append_string (two_digit (d.day))
			Result.append_character ('T')
			Result.append_string (two_digit (d.hour))
			Result.append_character (':')
			Result.append_string (two_digit (d.minute))
			Result.append_character (':')
			Result.append_string (two_digit (d.second))
			Result.append_string (".000000Z")
		end

	two_digit (n: INTEGER): STRING
		do
			create Result.make (2)
			if n <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (n)
		end

end
