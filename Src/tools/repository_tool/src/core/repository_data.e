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
		do
			uuid := a_uuid
			repository := a_repo
			create unread_logs.make (100)
			unread_logs.compare_objects
			create logs.make (100)
			logs.compare_objects

			create_storage
		end

feature -- Access

	unread_logs: HASH_TABLE [BOOLEAN, like log.id]

	logs: HASH_TABLE [attached like log, like log.id]
			-- Log indexed by `id'

	log (a_id: like log.id): detachable REPOSITORY_LOG
		do
			Result := logs.item (a_id)
		end

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

feature -- Storage

	storage: REPOSITORY_STORAGE

	create_storage
			-- Create Storage
		deferred
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
		ensure
			removed: not unread_logs.has (a_id)
		end

	archive_log (a_log: REPOSITORY_LOG)
		local
			l_id: STRING
		do
			l_id := a_log.id
			if unread_logs.has (l_id) then
				unread_logs.remove (l_id)
			end
			if attached logs as l_logs then
				if l_logs.has_key (l_id) then
					l_logs.remove (l_id)
				end
			end
			storage.archive_log (a_log)
			delete_log (a_log)
		end

	delete_log (a_log: REPOSITORY_LOG)
		local
			l_id: STRING
		do
			l_id := a_log.id
			if unread_logs.has (l_id) then
				unread_logs.remove (l_id)
			end
			if attached logs as l_logs and then l_logs.has_key (l_id) then
				l_logs.remove (l_id)
			end
			storage.delete_log (a_log)
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

	fetch_range_of_logs (a_from, a_to: INTEGER)
			-- fetch logs from repository
			-- from `a_from' to `a_to'
		deferred
		end

	fetch_logs
			-- fetch logs from repository
		deferred
		end

	reload_logs
			-- Clear logs, and get logs from storage
		deferred
		end

	load_logs
			-- Get logs from storage
		deferred
		end

	import_archive_logs
			-- Get logs from storage
		deferred
		end

	repository_location: like repository.location
		do
			Result := repository.location
		end

	repository_option (a_name: STRING): detachable STRING
		do
			Result := repository.free_configuration_value (a_name)
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
		do
			Result := storage.review_exists (a_log)
		end

	review (a_log: REPOSITORY_LOG): detachable REPOSITORY_LOG_REVIEW
		require
			review_exists: review_exists (a_log)
		do
			Result := storage.review (a_log)
		end

feature -- Diff

	diff_exists (a_log: REPOSITORY_LOG): BOOLEAN
		do
			Result := storage.diff_exists (a_log)
		end

	diff (a_log: REPOSITORY_LOG): detachable STRING
		do
			Result := storage.diff (a_log)
		end

feature -- Persistence

	export_to_sqlite
		local
			db: detachable SQLITE_DATABASE
			f: RAW_FILE
			l_modify: SQLITE_MODIFY_STATEMENT
			l_insert: SQLITE_INSERT_STATEMENT
--			l_query: SQLITE_QUERY_STATEMENT
			using_transaction: BOOLEAN
			fn: FILE_NAME
			retried: BOOLEAN
		do
			using_transaction := True

			if not retried then
				debug ("CTR")
					print ("export_to_sqlite: " + uuid.out + "%N")
				end
				create fn.make_from_string (common_data_folder)
				fn.extend ("db")
				fn.set_file_name (uuid.out)
				fn.add_extension ("sqlite")
				create f.make (fn.string)
				if f.exists then
					create db.make_open_read_write (f.name)
				else
					create db.make_create_read_write (f.name)
				end

					-- Remove any existing table
				create l_modify.make ("DROP TABLE IF EXISTS logs;", db)
				l_modify.execute

					-- Create a new table
				create l_modify.make ("CREATE TABLE logs (Id TEXT PRIMARY KEY, Author TEXT, Message TEXT, Date TEXT);", db)
				l_modify.execute

				if using_transaction then
					db.begin_transaction (False) --| FIXME: Crash when using "False"
				end

				create l_insert.make ("INSERT INTO logs (Id,Author,Message,Date) VALUES (?1, ?2, ?3, ?4);", db)
				check l_insert_is_compiled: l_insert.is_compiled end

				if attached logs as l_logs then
					from
						l_logs.start
					until
						l_logs.after
					loop
						if attached l_logs.item_for_iteration as l_log then
							l_insert.execute_with_arguments ([
									l_log.id,
									l_log.author,
									l_log.message,
									l_log.date
								])
						end
						l_logs.forth
					end
				end

				if using_transaction then
					db.commit
				end
				db.close
			else
				if attached db as l_db and then not db.is_closed then
					if using_transaction then
						db.rollback
					end
					db.close
				end
			end
		rescue
			debug ("CTR")
				print ("ERROR during export_to_sqlite%N")
			end
			retried := True
			retry
		end

	save_unread_logs
		do
			storage.store_unread_logs (Current)
		end

	load_unread_logs
		do
			storage.load_unread_logs (Current)
		end


	store_log_diff (r: REPOSITORY_LOG; a_diff: STRING)
		do
			storage.store_diff (r, a_diff)
		end

	store_log_review (a_log: REPOSITORY_LOG; a_review: REPOSITORY_LOG_REVIEW)
		do
			storage.store_review (a_log, a_review)
		end

feature -- Status report

	hash_code: INTEGER
			-- Hash code value
		do
			Result := uuid.hash_code
		end

feature {REPOSITORY_STORAGE} -- Implementation

	uuid: UUID

	repository: REPOSITORY

end
