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
			delete_log,
			archive_log
		end

create
	make

feature {NONE} -- Initialization

	make (a_uuid: UUID; a_repo: like repository)
		do
			Precursor (a_uuid, a_repo)
		end

feature {NONE} -- Factory

	log_from_revision (r: SVN_REVISION_INFO): REPOSITORY_LOG
		local
			l_id: STRING
		do
			l_id := id_of (r)
			if
				attached logs as l_logs and then
				l_logs.has_key (l_id) and then
				attached l_logs.found_item as f
			then
				Result := f
			else
				create {REPOSITORY_SVN_LOG} Result.make (r, Current)
			end
		end

feature -- Access

	logs: detachable HASH_TABLE [like log_from_revision, STRING]

	last_known_revision: INTEGER

	info: detachable SVN_REPOSITORY_INFO

feature -- Access: Diff

	fetch_diff (a_log: REPOSITORY_SVN_LOG)
		require else
			not has_pending_diff
		local
			s: detachable STRING
		do
			s := repository.revision_diff (a_log.svn_revision)
			if s /= Void then
				s.prune_all ('%R')
			end
			internal_last_diff := s
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

	load_logs
		local
			l_last_known_rev: INTEGER
			l_logs: like logs
			d: DIRECTORY
			r: INTEGER
			l_id: STRING
		do
			load_unread_logs
			l_logs := logs
			if l_logs = Void then
				create l_logs.make (100)
				logs := l_logs
			end
			create d.make (data_folder_name)
			if d.exists then
				d.open_read
				from
					d.start
					d.readentry
				until
					d.lastentry = Void
				loop
					if attached d.lastentry as s and then s.is_integer then
						r := s.to_integer
						l_id := r.out
						l_last_known_rev := l_last_known_rev.max (r)
						if not l_logs.has (l_id) and attached loaded_log (l_id) as e then
							l_logs.put (e, l_id)
						end
					end
					d.readentry
				end
				d.close
			end
			last_known_revision := l_last_known_rev
		ensure then
			logs_attached: logs /= Void
		end

	fetch_logs
		do
			load_logs
			internal_fetch_logs (repository, last_known_revision)
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
					internal_fetch_logs (ia_repo, ia_last_known_rev)
					ia_mut.unlock
				end (l_fetch_mutex, create {like repository}.make_from_repository (repository), last_known_revision))
			th.launch
		end

	has_fetched_data: BOOLEAN

	import_fetched_logs
		local
			l_log: like log_from_revision
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
				if l_logs = Void then
					create l_logs.make (100)
					logs := l_logs
				end
				from
					l_fetched_logs.start
				until
					l_fetched_logs.after
				loop
					if attached l_fetched_logs.item as e then
						r := e.revision
						l_log := log_from_revision (e)
						l_id := l_log.id
						if l_logs.has (l_id) then
							l_logs.force (l_log, l_id)
						else
							l_logs.put (l_log, l_id)
							mark_log_unread (l_id)
						end
						store_log (e)
						check loaded_log (l_id) ~ l_log end
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

	internal_fetch_logs (a_repo: like repository; a_last_fetched_rev: INTEGER)
		do
			if attached a_repo.info as repo_info then
				fetched_info := repo_info
				if a_last_fetched_rev > 0 then
					fetched_logs := a_repo.logs (True, a_last_fetched_rev, repo_info.last_changed_rev, 0)
				else
					fetched_logs := a_repo.logs (True, 0, 0, 100)
				end
				has_fetched_data := True --fetched_logs /= Void
			end
		end

feature {REPOSITORY_SVN_LOG} -- Implementation

	repository: REPOSITORY_SVN

	last_stored_rev: INTEGER
		local
			d: DIRECTORY
		do
			create d.make (data_folder_name)
			if d.exists then
				d.open_read
				from
					d.start
					d.readentry
				until
					d.lastentry = Void
				loop
					if attached d.lastentry as s and then s.is_integer then
						Result := Result.max (s.to_integer)
					end
					d.readentry
				end
				d.close
			end
		end

	loaded_log (a_id: STRING): detachable like log_from_revision
		local
			f: RAW_FILE
			l_line: STRING
			l_message: detachable STRING
			e: detachable SVN_REVISION_INFO
			r: INTEGER
		do
			create f.make (svn_log_data_filename (a_id))
			if f.exists and then f.is_readable then
				f.open_read
				from
					f.start
					check id_is_integer: a_id.is_integer end
					r := a_id.to_integer
					create e.make (r)
				until
					f.exhausted or e = Void
				loop
					f.read_line
					l_line := f.last_string
					if l_message /= Void then
						l_message.extend ('%N')
						l_message.append_string (l_line)
					elseif l_line.starts_with ("revision=") then
						l_line.remove_head (9)
						if l_line.is_integer and then l_line.to_integer /= r then
							e := Void
						end
					elseif l_line.starts_with ("date=") then
						l_line.remove_head (5)
						e.set_date (l_line.string)
					elseif l_line.starts_with ("author=") then
						l_line.remove_head (7)
						e.set_author (l_line.string)
					elseif l_line.starts_with ("parent=") then
--						l_line.remove_head (7)
					elseif l_line.starts_with ("path[]=") then
						l_line.remove_head (7)
						e.add_path (l_line.string, "", "")
					elseif l_line.starts_with ("message=") then
						l_line.remove_head (8)
						l_message := l_line.string
						e.set_log_message (l_message)
					end
				end
				f.close
				if e /= Void then
					Result := log_from_revision (e)
				end
			end
		end

	store_log (r: SVN_REVISION_INFO)
		local
			f: RAW_FILE
		do
			ensure_data_folder_exists
			create f.make (svn_log_data_filename (id_of (r)))
			if not f.exists then
				f.create_read_write
				f.put_string ("revision=" + r.revision.out + "%N")
				f.put_string ("date=" + r.date + "%N")
				f.put_string ("author=" + r.author + "%N")
				f.put_string ("parent=" + r.common_parent_path + "%N")
				if attached r.paths as l_paths and then not l_paths.is_empty then
					from
						l_paths.start
					until
						l_paths.after
					loop
						f.put_string ("path[]=" + l_paths.item.path + "%N")
						l_paths.forth
					end
				end
				f.put_string ("message=" + r.log_message + "%N")
				f.close
				debug ("scm")
					print ("Log for rev#" + r.revision.out + " stored%N")
				end
			else
				debug ("scm")
					print ("Log for rev#" + r.revision.out + " already fetched%N")
				end
			end
		end

feature -- Persistence

	archive_log (a_log: REPOSITORY_LOG)
		local
			f: RAW_FILE
			l_id: STRING
		do
			Precursor (a_log)
			l_id := a_log.id
			if attached logs as l_logs then
				if l_logs.has_key (l_id) then
					l_logs.remove (l_id)
				end
			end
			create f.make (log_data_filename (a_log))
			if f.exists then
				ensure_folder_exists (archive_data_folder_name)
				move_file (f, archive_log_data_filename (a_log))
			end
		end

	delete_log (a_log: REPOSITORY_LOG)
		local
			f: RAW_FILE
			l_id: STRING
		do
			Precursor (a_log)
			l_id := a_log.id
			if attached logs as l_logs then
				if l_logs.has_key (l_id) then
					l_logs.remove (l_id)
				end
			end
			create f.make (log_data_filename (a_log))
			if f.exists then
				f.delete
			end
		end


feature {NONE} -- Implementation

	logs_data_folder_name: like data_folder_name
		do
			Result := data_folder_name
		end

	archive_logs_data_folder_name: like archive_data_folder_name
		do
			Result := archive_data_folder_name
		end

	archive_svn_log_data_filename (r: STRING): STRING
		local
			fn: FILE_NAME
		do
			create fn.make_from_string (archive_logs_data_folder_name)
			fn.set_file_name (r)
			Result := fn.string
		end

	svn_log_data_filename (r: STRING): STRING
		local
			fn: FILE_NAME
		do
			create fn.make_from_string (logs_data_folder_name)
			fn.set_file_name (r)
			Result := fn.string
		end

	archive_log_data_filename (a_log: REPOSITORY_LOG): STRING
		do
			Result := archive_svn_log_data_filename (a_log.id)
		end

	log_data_filename (a_log: REPOSITORY_LOG): STRING
		do
			Result := svn_log_data_filename (a_log.id)
		end


end
