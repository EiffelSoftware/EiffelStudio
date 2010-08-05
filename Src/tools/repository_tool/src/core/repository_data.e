note
	description: "Summary description for {REPOSITORY_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPOSITORY_DATA

inherit
	REPOSITORY_SHARED

	HASHABLE

feature {NONE} -- Initialization

	make (a_uuid: UUID; a_repo: like repository)
		local
			sep: STRING
		do
			sep := operating_environment.directory_separator.out
			uuid := a_uuid
			repository := a_repo
			create unread_logs.make (100)
			unread_logs.compare_objects

			data_folder_name := Common_data_folder + sep + a_uuid.out + "_logs"
			diff_data_folder_name := data_folder_name + sep + "_diff"
			review_data_folder_name := data_folder_name + sep + "_review"

			archive_data_folder_name := Common_data_folder + sep + a_uuid.out + "_logs" + sep + "_archive"
			archive_diff_data_folder_name := archive_data_folder_name + sep + "_diff"
			archive_review_data_folder_name := archive_data_folder_name + sep + "_review"
		end

feature -- Access

	unread_logs: HASH_TABLE [BOOLEAN, like {REPOSITORY_LOG}.id]

	logs: detachable HASH_TABLE [REPOSITORY_LOG, STRING]

feature -- Status report

	is_unread_log (a_log: REPOSITORY_LOG): BOOLEAN
		do
			Result := unread_logs.has (a_log.id)
		end

	unread_log_count: INTEGER
		do
			Result := unread_logs.count
		end

	unread_log_count_for (a_filter: detachable REPOSITORY_LOG_FILTER): INTEGER
		do
			Result := unread_log_count
			if
				Result > 0 and a_filter /= Void and then
				attached logs as l_logs
			then
				Result := 0
				across
					unread_logs as c
				loop
					if
						attached l_logs.item (c.key) as l_log and then
						a_filter.matched (l_log)
					then
						Result := Result + 1
					end
				end
			end
		ensure
			Result_valid: Result <= unread_log_count
		end

	review_enabled: BOOLEAN
		do
			Result := repository.review_enabled
		end

	tokens: detachable HASH_TABLE [TUPLE [url_pattern: STRING_8; key: STRING_8], STRING_8]
		do
			Result := repository.tokens
		end

	tokens_keys: detachable ARRAY [STRING]
		do
			Result := repository.tokens_keys
		end

	token_url (a_name: STRING; v: STRING): detachable STRING
		do
			Result := repository.token_url (a_name, v)
		end

feature -- Access

	review_username: detachable STRING
		do
			Result := repository.review_username
		end

feature -- Element change

	mark_all_logs_read
		do
			unread_logs.wipe_out
		end

	mark_log_unread (a_id: STRING)
		do
			unread_logs.force (True, a_id)
		end

	mark_log_read (a_id: STRING)
		do
			unread_logs.remove (a_id)
		end

	archive_log (a_log: REPOSITORY_LOG)
		local
			f: RAW_FILE
			l_id: STRING
		do
			ensure_folder_exists (archive_data_folder_name)
			l_id := a_log.id
			if unread_logs.has (l_id) then
				unread_logs.remove (l_id)
			end
			create f.make (log_diff_data_filename (a_log))
			if f.exists then
				ensure_folder_exists (archive_diff_data_folder_name)
				move_file (f, archive_log_diff_data_filename (a_log))
			end
			create f.make (log_review_data_filename (a_log))
			if f.exists then
				ensure_folder_exists (archive_review_data_folder_name)
				move_file (f, archive_log_review_data_filename (a_log))
			end
		end

	delete_log (a_log: REPOSITORY_LOG)
		local
			f: RAW_FILE
			l_id: STRING
		do
			l_id := a_log.id
			if unread_logs.has (l_id) then
				unread_logs.remove (l_id)
			end
			create f.make (log_diff_data_filename (a_log))
			if f.exists then
				f.delete
			end
			create f.make (log_review_data_filename (a_log))
			if f.exists then
				f.delete
			end
		end

feature -- Query

	has_pending_diff: BOOLEAN
		deferred
		end

	fetch_diff (a_log: REPOSITORY_LOG)
		deferred
		end

	get_diff (a_log: REPOSITORY_LOG)
		require
			has_pending_diff
		deferred
		end

	fetch_logs
			-- fetch logs from repository
		deferred
		end

	load_logs
			-- Get logs from storage
		deferred
		end

	repository_location: like repository.location
		do
			Result := repository.location
		end

feature {NONE} -- Implementation: Review

	internal_review_client: detachable like review_client
			-- Internal attribut for `review_client'

feature -- Review

	review_client: CTR_LOG_REVIEW_CLIENT_PROXY
		require
			review_enabled: review_enabled
		do
			if attached internal_review_client as rc then
				Result := rc
			else
				create Result.make (repository)
				internal_review_client := Result
			end
		end

	review_exists (a_log: REPOSITORY_LOG): BOOLEAN
		local
			f: RAW_FILE
		do
			create f.make (log_review_data_filename (a_log))
			Result := f.exists and then f.is_readable
		end

	review (a_log: REPOSITORY_LOG): detachable REPOSITORY_LOG_REVIEW
		require
			review_exists: review_exists (a_log)
		local
			f: RAW_FILE
			l_line: STRING
			p,m: INTEGER
			s: STRING
			l_remote: BOOLEAN
			t: like {REPOSITORY_LOG_REVIEW}.user_review
			l_reviews: like {REPOSITORY_LOG_REVIEW}.reviews
		do
			create f.make (log_review_data_filename (a_log))
			if f.exists and then f.is_readable then
				f.open_read
				from
					create Result.make
					l_reviews := Result.reviews
					f.start
				until
					f.exhausted
				loop
					f.read_line
					l_line := f.last_string
					l_line.left_adjust
					if l_line.is_empty or else l_line.item (1) = '#' then
						-- Ignore
					else
						p := l_line.index_of (':', 1)
						if p > 0 then
							s := l_line.substring (1, p - 1) --| User
							m := p + 1
							l_remote := l_line.item (m) = '@'
							if l_remote then
								m := m + 1
							end
							p := l_line.index_of (':', m)
							if p > 0 then
								create t.make (s, l_line.substring (m, p - 1))
								t.set_comment (l_line.substring (p + 1, l_line.count))
								t.set_is_remote (l_remote)
							else
								create t.make (s, l_line.substring (m, l_line.count))
								t.set_is_remote (l_remote)
							end
							l_reviews.extend (t)
						end
					end
				end
				f.close
			end
		end

feature -- Storage filename

	data_folder_name: STRING

	diff_data_folder_name: STRING

	review_data_folder_name: STRING

	archive_data_folder_name: STRING

	archive_diff_data_folder_name: STRING

	archive_review_data_folder_name: STRING


	log_diff_data_filename (a_log: REPOSITORY_LOG): STRING
		local
			fn: FILE_NAME
		do
			create fn.make_from_string (diff_data_folder_name)
			fn.set_file_name (a_log.id)
			fn.add_extension ("diff")
			Result := fn.string
		end

	log_review_data_filename (a_log: REPOSITORY_LOG): STRING
		local
			fn: FILE_NAME
		do
			create fn.make_from_string (review_data_folder_name)
			fn.set_file_name (a_log.id)
			fn.add_extension ("review")
			Result := fn.string
		end

	archive_log_diff_data_filename (a_log: REPOSITORY_LOG): STRING
		local
			fn: FILE_NAME
		do
			create fn.make_from_string (archive_diff_data_folder_name)
			fn.set_file_name (a_log.id)
			fn.add_extension ("diff")
			Result := fn.string
		end

	archive_log_review_data_filename (a_log: REPOSITORY_LOG): STRING
		local
			fn: FILE_NAME
		do
			create fn.make_from_string (archive_review_data_folder_name)
			fn.set_file_name (a_log.id)
			fn.add_extension ("review")
			Result := fn.string
		end

	unread_logs_data_filename: STRING
		local
			fn: FILE_NAME
		do
			create fn.make_from_string (data_folder_name)
			fn.set_file_name ("unreads")
			fn.add_extension ("db")
			Result := fn.string
		end

	info_data_filename: STRING
		local
			fn: FILE_NAME
		once
			create fn.make_from_string (data_folder_name)
			fn.set_file_name ("info.txt")
			Result := fn.string
		end

feature -- Diff

	diff_exists (a_log: REPOSITORY_LOG): BOOLEAN
		local
			f: RAW_FILE
		do
			create f.make (log_diff_data_filename (a_log))
			Result := f.exists and then f.is_readable
		end

	diff (a_log: REPOSITORY_LOG): detachable STRING
		local
			s: STRING
			f: RAW_FILE
		do
			create f.make (log_diff_data_filename (a_log))
			if f.exists and then f.is_readable then
				f.open_read
				create s.make (f.count)
				from
					f.start
				until
					f.exhausted
				loop
					f.read_stream (1024)
					s.append_string (f.last_string)
				end
				f.close
--				r.set_diff (s)
				Result := s
			end
		end

feature -- Persistence

	save_unread_logs
		local
			f: RAW_FILE
		do
			ensure_data_folder_exists
			create f.make (unread_logs_data_filename)
			if not f.exists or else f.is_writable then
				f.create_read_write
				f.put_string ("[unread logs]%N")
				if attached unread_logs as l_logs and then not l_logs.is_empty then
					across
						l_logs as c
					loop
						f.put_string (c.key.out + "%N")
					end
				end
				f.close
			end
		end

	load_unread_logs
		local
			f: RAW_FILE
			l_line: STRING
		do
			create f.make (unread_logs_data_filename)
			if f.exists and then f.is_readable then
				f.open_read
				from
					f.start
					check unread_logs.is_empty end
					mark_all_logs_read
				until
					f.exhausted
				loop
					f.read_line
					l_line := f.last_string
					l_line.left_adjust
					if l_line.is_empty then
						-- Skip
					elseif l_line.item (1) = '[' then
						-- Skip
					else
						l_line.right_adjust
						mark_log_unread (l_line.string)
					end
				end
				f.close
			end
		end

	ensure_folder_exists (a_dirname: STRING)
		local
			d: DIRECTORY
		do
			create d.make (a_dirname)
			if not d.exists then
				if d.name.has (operating_environment.directory_separator) then
					d.recursive_create_dir
				else
					d.create_dir
				end
			end
		end

	ensure_data_folder_exists
		local
			f: RAW_FILE
		do
			ensure_folder_exists (data_folder_name)
			create f.make (info_data_filename)
			if not f.exists then
				f.create_read_write
				f.put_string ("location=" + repository.location + "%N")
				f.close
			end
		end

	ensure_diff_data_folder_exists
		do
			ensure_folder_exists (diff_data_folder_name)
		end

	ensure_review_data_folder_exists
		do
			ensure_folder_exists (review_data_folder_name)
		end

	store_log_diff (r: REPOSITORY_LOG; a_diff: STRING)
		local
			f: RAW_FILE
		do
			ensure_diff_data_folder_exists
			create f.make (log_diff_data_filename (r))
			if not f.exists or f.is_writable then
				f.create_read_write
				f.put_string (a_diff)
--				f.put_string (r.diff)
				f.close
			end
		end

	store_log_review (a_log: REPOSITORY_LOG; a_review: REPOSITORY_LOG_REVIEW)
		local
			f: RAW_FILE
		do
			ensure_review_data_folder_exists
			create f.make (log_review_data_filename (a_log))
			if not f.exists or f.is_writable then
				if attached a_review.reviews as l_reviews and then not l_reviews.is_empty then
					f.create_read_write
					from
						l_reviews.start
					until
						l_reviews.after
					loop
						if attached l_reviews.item as t then
							if not t.is_none_status then
								f.put_string (l_reviews.item.user)
								f.put_character (':')
								if t.is_remote then
									f.put_character ('@')
								end
								f.put_string (l_reviews.item.status)
								if attached l_reviews.item.comment as l_comment then
									f.put_character (':')
									f.put_string (l_comment)
								end
								f.put_new_line
							end
						end
						l_reviews.forth
					end
					f.close
				end
			end
		end

feature -- Status report

	hash_code: INTEGER
			-- Hash code value
		do
			Result := uuid.hash_code
		end

feature {NONE} -- Implementation

	move_file (a_src: FILE; a_target: STRING)
		local
			f: RAW_FILE
		do
			create f.make (a_target)
			if not f.exists or else f.is_writable then
				f.create_read_write
				if not a_src.is_open_read then
					a_src.open_read
					a_src.copy_to (f)
					a_src.close
				else
					a_src.copy_to (f)
				end
				f.close
			end
		end

	uuid: UUID

	repository: REPOSITORY

end
