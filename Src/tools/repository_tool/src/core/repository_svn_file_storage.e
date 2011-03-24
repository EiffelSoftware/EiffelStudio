note
	description: "Summary description for {REPOSITORY_SVN_STORAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_SVN_FILE_STORAGE

inherit
	REPOSITORY_FILE_STORAGE
		redefine
			make,
			archive_log,
			delete_log
		end

	REPOSITORY_SVN_STORAGE

create
	make

feature {NONE} -- Initialization

	make
		do
			Precursor
		end

feature -- Load

	archive_loaded_log (a_id: STRING; a_data: REPOSITORY_SVN_DATA): like loaded_log
		do
			Result := log_from_file (a_id, archive_svn_log_data_filename (a_id), a_data)
		end

	loaded_log (a_id: STRING; a_data: REPOSITORY_SVN_DATA): detachable REPOSITORY_SVN_LOG
		do
			Result := log_from_file (a_id, svn_log_data_filename (a_id), a_data)
		end


	load_logs (a_data: REPOSITORY_SVN_DATA)
		local
			l_last_known_rev: INTEGER
			l_first_known_rev: INTEGER
			d: DIRECTORY
			r: INTEGER
			l_id: STRING
		do
			load_unread_logs (a_data)
			if attached a_data.logs as l_logs then
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
							if l_first_known_rev = 0 then
								l_first_known_rev := r
							else
								l_first_known_rev := l_first_known_rev.min (r)
							end
							if not l_logs.has (l_id) and attached loaded_log (l_id, a_data) as e then
								l_logs.put (e, l_id)
							end
						end
						d.readentry
					end
					d.close
				end
				revision_last_known := l_last_known_rev
				revision_first_known := l_first_known_rev
			end
		end

	import_archive_logs (a_data: REPOSITORY_SVN_DATA)
		local
			l_last_known_rev: INTEGER
			l_first_known_rev: INTEGER
			d: DIRECTORY
			r: INTEGER
			l_id: STRING
		do
--			store_unread_logs (a_data)
			load_logs (a_data)
			if attached a_data.logs as l_logs then
				create d.make (archive_data_folder_name)
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
							if l_first_known_rev = 0 then
								l_first_known_rev := r
							else
								l_first_known_rev := l_first_known_rev.min (r)
							end
							if not l_logs.has (l_id) and attached archive_loaded_log (l_id, a_data) as e then
								l_logs.put (e, l_id)
							end
						end
						d.readentry
					end
					d.close
				end
			end
		end

feature -- Status

	revision_first_known: INTEGER
	revision_last_known: INTEGER

feature -- Subversion specific

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

	log_from_revision (r: SVN_REVISION_INFO; a_data: REPOSITORY_SVN_DATA): attached like loaded_log
		local
			l_id: STRING
		do
			l_id := id_of_svn_revision_info (r)
			if
				attached a_data.logs as l_logs and then
				l_logs.has_key (l_id) and then
				attached l_logs.found_item as f
			then
				Result := f
			else
				create {REPOSITORY_SVN_LOG} Result.make (r, a_data)
			end
		end

	store_svn_revision_info (r: SVN_REVISION_INFO; a_data: REPOSITORY_SVN_DATA)
		local
			f: RAW_FILE
		do
			ensure_data_folder_exists (a_data)
			create f.make (svn_log_data_filename (id_of_svn_revision_info (r)))
			if not f.exists or else f.is_writable then
				debug ("scm")
					if f.exists then
						print ("Log for rev#" + r.revision.out + " already fetched%N")
					end
				end
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
						f.put_string ("path[],")
						inspect
							l_paths.item.kind
						when {SVN_CONSTANTS}.kind_dir then
							f.put_string ("D,")
						when {SVN_CONSTANTS}.kind_file then
							f.put_string ("F,")
						else
						end
						f.put_string (l_paths.item.action)
						f.put_character ('=')
						f.put_string (l_paths.item.path + "%N")
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

feature -- Store

	archive_log (a_log: REPOSITORY_LOG)
		local
			f: RAW_FILE
		do
			Precursor (a_log)
			create f.make (log_data_filename (a_log))
			if f.exists then
				ensure_folder_exists (archive_data_folder_name)
				move_file (f, archive_log_data_filename (a_log))
			end
		end

	delete_log (a_log: REPOSITORY_LOG)
		local
			f: RAW_FILE
		do
			Precursor (a_log)
			create f.make (log_data_filename (a_log))
			if f.exists then
				f.delete
			end
		end

feature -- Filename

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

feature {NONE} -- Implementation: subversion

	id_of_svn_revision_info (r: SVN_REVISION_INFO): STRING
		do
			Result := r.revision.out
		end

feature {NONE} -- Implementation

	log_from_file (a_id: STRING; a_filename: STRING; a_data: REPOSITORY_SVN_DATA): like loaded_log
		local
			f: RAW_FILE
			l_line,s: STRING
			n,p: INTEGER
			l_message: detachable STRING
			e: detachable SVN_REVISION_INFO
			r: INTEGER
		do
			create f.make (a_filename)
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
					elseif l_line.starts_with ("path[]") then
						p := l_line.index_of ('=', 1)
						if p > 0 then
							s := l_line.substring (6, p - 1)
							n := s.occurrences (',')
							if n = 1 then
								-- path[],A=
								e.add_path (l_line.substring (p + 1, l_line.count), "", s.substring (2, s.count))
							elseif n = 2 then
								-- path[],K,A=
								inspect s.item (2)
								when 'D', 'd' then
									e.add_dir_path (l_line.substring (p + 1, l_line.count), s.substring (5, s.count))
								when 'F', 'f' then
									e.add_file_path (l_line.substring (p + 1, l_line.count), s.substring (5, s.count))
								else
									e.add_path (l_line.substring (p + 1, l_line.count), s.substring (2,2), s.substring (5, s.count))
								end
							else
								e.add_path (l_line.substring (p + 1, l_line.count), "", "")
							end
						else
							check invalid_line: False end
							print ("Invalid log line: " + l_line + "%N")
						end
					elseif l_line.starts_with ("message=") then
						l_line.remove_head (8)
						l_message := l_line.string
						e.set_log_message (l_message)
					end
				end
				f.close
				if e /= Void then
					Result := log_from_revision (e, a_data)
				end
			end
		end

end
