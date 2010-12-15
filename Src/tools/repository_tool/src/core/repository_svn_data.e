note
	description: "Summary description for {REPOSITORY_SVN_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_SVN_DATA

inherit
	REPOSITORY_DATA
		redefine
			make,
			repository,
			fetch_diff,
			logs,
			log,
			storage
		end

create
	make

feature {NONE} -- Initialization

	make (a_uuid: UUID; a_repo: like repository)
		do
			Precursor (a_uuid, a_repo)
		end

feature -- Storage

	storage: REPOSITORY_SVN_FILE_STORAGE

	create_storage
			-- Create Storage
		do
			create storage.make
			storage.set_data (Current)
		end

feature -- Access

	logs: HASH_TABLE [attached like log, like log.id]

	revision_last_known: INTEGER

	revision_first_known: INTEGER

	info: detachable SVN_REPOSITORY_INFO

	log (a_id: like log.id): detachable REPOSITORY_SVN_LOG
		do
			Result := logs.item (a_id)
		end

	previous_log (a_log: attached like log): like log
		require
			a_log_attached: a_log /= Void
		local
			l_rev_info: SVN_REVISION_INFO
		do
			create l_rev_info.make (a_log.svn_revision.revision - 1)
			Result := log (id_of (l_rev_info))
			if Result = Void then
				create Result.make (l_rev_info, Current)
			end
		end

feature -- Direct SVN access

	repository_diff (a_log: REPOSITORY_SVN_LOG; a_path: detachable STRING): detachable STRING
		require
			a_log_attached: a_log /= Void
		local
			s: detachable STRING
		do
			s := repository.revision_diff (a_log.svn_revision)
			if s /= Void then
				s.prune_all ('%R')
			end
			Result := s
		end

	repository_path_content (a_log: REPOSITORY_SVN_LOG; a_path: STRING): detachable STRING
		require
			a_log_attached: a_log /= Void
			a_path_attached: a_path /= Void
		local
			s: detachable STRING
		do
			s := repository.revision_path_content (a_path, a_log.svn_revision)
			if s /= Void then
				s.prune_all ('%R')
			end
			Result := s
		end

feature -- Access: delayed diff

	fetch_diff (a_log: REPOSITORY_SVN_LOG)
		require else
			no_pending_diff: not has_pending_diff
		do
			internal_last_diff := repository_diff (a_log, Void)
		end

	get_diff (a_log: REPOSITORY_SVN_LOG)
		local
			d: like last_diff
		do
			d := last_diff
			if d /= Void then
				store_log_diff (a_log, d)
			end
		end

	has_pending_diff: BOOLEAN
		do
			Result := internal_last_diff /= Void
		end

	last_diff: like internal_last_diff
		do
			Result := internal_last_diff
			internal_last_diff := Void
		end

	internal_last_diff: detachable STRING

feature -- Access

	reload_logs
		do
			logs.wipe_out
			load_logs
		end

	load_logs
		do
			storage.load_logs (Current)
			revision_last_known := storage.revision_last_known
			revision_first_known := storage.revision_first_known
		ensure then
			logs_attached: logs /= Void
		end

	import_archive_logs
		do
			save_unread_logs
			storage.import_archive_logs (Current)
		ensure then
			logs_attached: logs /= Void
		end

	fetch_logs
		do
			save_unread_logs
			load_logs
			internal_fetch_logs (repository, revision_last_known, 0)
			import_fetched_logs
		end

	fetch_range_of_logs (a_from, a_to: INTEGER)
		do
			save_unread_logs
			load_logs
			internal_fetch_logs (repository, a_from, a_to)
			import_fetched_logs
		end

	is_asynchronious_fetching: BOOLEAN

	asynchronious_fetch_logs
		require
			is_not_fetching: not is_asynchronious_fetching
		local
--			e: EXECUTION_ENVIRONMENT
--			n: INTEGER
			th: WORKER_THREAD
			l_fetch_mutex: like fetch_mutex
		do
			save_unread_logs
			load_logs
			is_asynchronious_fetching := True
			l_fetch_mutex := fetch_mutex
			if l_fetch_mutex = Void then
				create l_fetch_mutex.make
				fetch_mutex := l_fetch_mutex
			end
			create th.make (agent (ia_mut: MUTEX; ia_repo: like repository; ia_last_known_rev: INTEGER_32)
				do
					ia_mut.lock
					internal_fetch_logs (ia_repo, ia_last_known_rev, 0)
					ia_mut.unlock
				end (l_fetch_mutex, create {like repository}.make_from_repository (repository), revision_last_known))
			th.launch
		end

	has_fetched_data: BOOLEAN

	import_fetched_logs
		local
			l_log: like loaded_log
			l_logs: like logs
			l_fetched_logs: like fetched_logs
			l_fetched_info: like fetched_info
			r: INTEGER
			l_id: STRING
		do
			if has_fetched_data then
				if attached fetch_mutex as fmutex then
					fmutex.lock
					l_fetched_logs := fetched_logs
					l_fetched_info := fetched_info
					fetched_logs := Void
					fetched_info := Void
					has_fetched_data := False
					fmutex.unlock
					fetch_mutex := Void
					is_asynchronious_fetching := False
				else
					l_fetched_logs := fetched_logs
					l_fetched_info := fetched_info
					fetched_logs := Void
					has_fetched_data := False
				end
			end
			if l_fetched_info /= Void then
				info := l_fetched_info
			end
			if l_fetched_logs /= Void and then not l_fetched_logs.is_empty then
				l_logs := logs
				from
					l_fetched_logs.start
				until
					l_fetched_logs.after
				loop
					if attached l_fetched_logs.item as e then
						r := e.revision
						l_log := storage.log_from_revision (e, Current)
						l_id := l_log.id
						if l_logs.has (l_id) then
							l_logs.force (l_log, l_id)
						else
							l_logs.put (l_log, l_id)
							mark_log_unread (l_id)
						end
						storage.store_svn_revision_info (e, Current)
						check storage.loaded_log (l_id, Current) ~ l_log end
					end
					l_fetched_logs.forth
				end
			end
			save_unread_logs
		ensure
			not_has_fetched_data: has_fetched_data = False
			fetched_logs = Void
		end

feature {NONE} -- Implementation

	id_of (r: SVN_REVISION_INFO): STRING
		do
			Result := r.revision.out
		end

	fetch_mutex: detachable MUTEX

	fetched_logs: like repository.logs

	fetched_info: like repository.info

	internal_fetch_logs (a_repo: like repository; a_from_rev, a_to_rev: INTEGER)
		do
			if attached a_repo.info as repo_info then
				fetched_info := repo_info
				if a_from_rev > 0 then
					if a_to_rev > a_from_rev then
						fetched_logs := a_repo.logs (True, a_from_rev, a_to_rev, 0)
					else
						fetched_logs := a_repo.logs (True, a_from_rev, repo_info.last_changed_rev, 0)
					end
				else
					fetched_logs := a_repo.logs (True, 0, 0, 100)
				end
				has_fetched_data := True --fetched_logs /= Void
			end
		end

feature {REPOSITORY_SVN_LOG} -- Implementation

	repository: REPOSITORY_SVN

	last_stored_rev: INTEGER
		do
			Result := storage.last_stored_rev
		end

	archive_loaded_log (a_id: STRING): like loaded_log
		do
			Result := storage.archive_loaded_log (a_id, Current)
		end

	loaded_log (a_id: STRING): detachable REPOSITORY_SVN_LOG
		do
			Result := storage.loaded_log (a_id, Current)
		end

	store_log (r: SVN_REVISION_INFO)
		do
			storage.store_svn_revision_info (r, Current)
		end


end
