note
	description : "[
				CMS Storage implemented using SED
			]"
	date        : "$Date$"
	revision    : "$Revision$"

class
	CMS_SED_STORAGE

inherit
	CMS_STORAGE

create
	make

feature {NONE} -- Initialization

	make (dn: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			create directory_name.make_from_string (dn)
			ensure_directory_exists (directory_name)
			create sed
			initialize
		end

	directory_name: PATH

	sed: SED_STORABLE_FACILITIES

	sed_file_retrieved (f: FILE): detachable ANY
		local
			r: SED_MEDIUM_READER_WRITER
		do
			create r.make (f)
			r.set_for_reading
			Result := sed.retrieved (r, True)
		end

	sed_file_store (obj: ANY; f: FILE)
		local
			w: SED_MEDIUM_READER_WRITER
		do
			create w.make (f)
			w.set_for_writing
			sed.store (obj, w)
		end

	save_object_with_id (obj: ANY; a_id: INTEGER; a_type: STRING)
		local
			fn: PATH
			f: RAW_FILE
		do
			fn := directory_name.extended (a_type)
			ensure_directory_exists (fn)
			fn := fn.extended (a_id.out)
--			.appended_with_extension ("txt")
			create f.make_with_path (fn)
--			check not f.exists end
			f.create_read_write
			sed_file_store (obj, f)
			f.close
		end

	object_with_id (a_id: INTEGER; a_type: STRING): detachable ANY
		local
			fn: PATH
			f: RAW_FILE
		do
			fn := directory_name.extended (a_type)
			ensure_directory_exists (fn)
			fn := fn.extended (a_id.out)
--			.append_with_extension ("txt")
			create f.make_with_path (fn)
			if f.exists and f.is_readable then
				f.open_read
				Result := sed_file_retrieved (f)
				f.close
			end
		end

feature -- Access: user

	has_user: BOOLEAN
			-- Has any user?
		do
			Result := users_count > 0
		end

	users_count: INTEGER
		do
			Result := last_sequence ("user")
		end

	fill_user_profile (a_user: CMS_USER)
		do
			if a_user.profile = Void then
				if attached user_profile (a_user) as p then
					a_user.set_profile (p)
				end
			end
		end

	all_users: LIST [CMS_USER]
		local
			res: ARRAYED_LIST [like all_users.item]
			i, n: like last_sequence
		do
			n := last_sequence ("user")
			create res.make (n)
			from
				i := 1
			until
				i > n
			loop
				if attached user_by_id (i) as u then
					res.force (u)
				end
				i := i + 1
			end
			Result := res
		end

	user_by_id (a_id: like {CMS_USER}.id): detachable CMS_USER
		do
			if attached {like user_by_id} object_with_id (a_id, "user") as u then
				Result := u
			end
		end

	user_by_name (a_name: like {CMS_USER}.name): detachable CMS_USER
		local
			uid: INTEGER
		do
			if attached users_index as t then
				uid := t.by_name.item (a_name)
				if uid > 0 then
					Result := user_by_id (uid)
				end
			end
		end

	user_by_email (a_email: like {CMS_USER}.email): detachable CMS_USER
		local
			uid: INTEGER
		do
			if attached users_index as t then
				uid := t.by_email.item (a_email)
				if uid > 0 then
					Result := user_by_id (uid)
				end
			end
		end

	is_valid_credential (u, p: READABLE_STRING_32): BOOLEAN
		do
			if attached user_by_name (u) as l_user then
				Result := attached l_user.encoded_password as l_pass and then l_pass.same_string (encoded_password (p))
			end
		end

	encoded_password (a_raw_password: STRING_32): attached like {CMS_USER}.encoded_password
		do
			Result := a_raw_password.as_string_8 + "!123!"
		end

feature -- Change: user

	save_user (a_user: CMS_USER)
		local
			uid: INTEGER
			prof: like {CMS_USER}.profile
			l_has_new_name: BOOLEAN
			l_has_new_email: BOOLEAN
			l_stored_user: like user_by_id
		do
			if a_user.has_id then
				uid := a_user.id
				l_stored_user := user_by_id (uid)
				if l_stored_user /= Void then
					l_has_new_name := not l_stored_user.name.same_string (a_user.name)
					l_has_new_email := not (l_stored_user.email ~ a_user.email)
				end
			else
				l_has_new_name := True
				l_has_new_email := True
				uid := next_sequence ("user")
				a_user.set_id (uid)
			end
			if attached a_user.password as p then
				a_user.set_encoded_password (encoded_password (p))
				a_user.set_password (Void)
			end

			prof := a_user.profile
			a_user.set_profile (Void)
			if prof /= Void then
				save_user_profile (a_user, prof)
			end
			save_object_with_id (a_user, uid, "user")
			if l_has_new_name or l_has_new_email then
				if attached users_index as l_index then
					l_index.by_name.force (uid, a_user.name)
					l_index.by_email.force (uid, a_user.email)
					store_users_index (l_index)
				end
			end
			a_user.set_profile (prof)
		end

feature -- Access: user_role

	user_role_by_id (a_id: INTEGER): detachable CMS_USER_ROLE
		do
			if attached {like user_role_by_id} object_with_id (a_id, "user_roles") as ur then
				Result := ur
			end
		end

	user_roles: LIST [CMS_USER_ROLE]
		local
			i: INTEGER
			n: like last_sequence
		do
			n := last_sequence ("user_roles")
			create {ARRAYED_LIST [CMS_USER_ROLE]} Result.make (n)
			if n > 0 then
				from
					i := 1
				until
					i > n
				loop
					if attached user_role_by_id (i) as ur then
						Result.force (ur)
					end
					i := i + 1
				end
			end
		end

feature -- Change: user_role		

	save_user_role (a_role: CMS_USER_ROLE)
		do
			if not a_role.has_id then
				a_role.set_id (next_sequence ("user_roles"))
			end
			save_object_with_id (a_role, a_role.id, "user_roles")
		end

feature -- Email		

	save_email (a_email: NOTIFICATION_EMAIL)
		local
			dn: PATH
			fn: PATH
			f: RAW_FILE
			ts: INTEGER_64
			i: INTEGER
		do
			dn := directory_name.extended ("emails")
			ensure_directory_exists (dn)
			ts := (create {HTTP_DATE_TIME_UTILITIES}).unix_time_stamp (a_email.date)
			from
				fn := dn.extended (ts.out).appended_with_extension ("txt")
				create f.make_with_path (fn)
			until
				not f.exists
			loop
				i := i + 1
				fn := dn.extended (ts.out + "-" + i.out).appended_with_extension ("txt")
				f.make_with_path (fn)
			end
			f.create_read_write
			f.put_string (a_email.message)
			f.close
		end

feature -- Log

	log (a_id: like {CMS_LOG}.id): detachable CMS_LOG
		do
			if attached {CMS_LOG} object_with_id (a_id, "log") as l then
				Result := l
			end
		end

	recent_logs (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_LOG]
		local
			n: Like last_sequence
			i, p1, nb: INTEGER
		do
			n := last_sequence ("log")
			p1 := n - a_lower + 1

			if p1 > 0 then
				create {ARRAYED_LIST [CMS_LOG]} Result.make (a_count)
				from
					i := p1
				until
					i < 1 or nb = a_count
				loop
					if attached log (i) as obj then
						Result.force (obj)
						nb := nb + 1
					end
					i := i - 1
				end
			else
				create {ARRAYED_LIST [CMS_LOG]} Result.make (0)
			end
		end


	save_log (a_log: CMS_LOG)
		do
			if not a_log.has_id then
				a_log.set_id (next_sequence ("log"))
			end
			save_object_with_id (a_log, a_log.id, "log")
		end

feature -- Node

	recent_nodes (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
		local
			n: Like last_sequence
			i, p1, nb: INTEGER
		do
			n := last_sequence ("node")
			p1 := n - a_lower + 1

			if p1 > 0 then
				create {ARRAYED_LIST [CMS_NODE]} Result.make (a_count)
				from
					i := p1
				until
					i < 1 or nb = a_count
				loop
					if attached node (i) as l_node then
						Result.force (l_node)
						nb := nb + 1
					end
					i := i - 1
				end
			else
				create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
			end
		end

	node (a_id: INTEGER): detachable CMS_NODE
		do
			if attached {like node} object_with_id (a_id, "node") as obj then
				Result := obj
			end
		end

	save_node (a_node: CMS_NODE)
		local
			nid: INTEGER
		do
			if a_node.has_id then
				nid := a_node.id
			else
				nid := next_sequence ("node")
				a_node.set_id (nid)
			end

			save_object_with_id (a_node, nid, "node")
		end

feature {NONE} -- Implementation

	last_sequence (a_type: STRING): INTEGER
		local
			fn: PATH
			f: RAW_FILE
		do
			fn := directory_name.extended (a_type).appended_with_extension ("last_id")
			create f.make_with_path (fn)
			if f.exists and then f.is_readable then
				f.open_read
				f.read_line
				if f.last_string.is_integer then
					Result := f.last_string.to_integer
				else
					check is_integer: False end
				end
				f.close
			end
		end

	next_sequence (a_type: STRING): INTEGER
		local
			fn: PATH
			f: RAW_FILE
		do
			fn := directory_name.extended (a_type).appended_with_extension ("last_id")
			create f.make_with_path (fn)
			if f.exists and then f.is_readable then
				f.open_read
				f.read_line
				if f.last_string.is_integer then
					Result := f.last_string.to_integer
				else
					check is_integer: False end
				end
				f.close
			end
			Result := Result + 1
			f.open_write
			f.put_string (Result.out)
			f.put_new_line
			f.close
		end

	users_index: TUPLE [
					by_name: HASH_TABLE [like {CMS_USER}.id, like {CMS_USER}.name];
					by_email: HASH_TABLE [like {CMS_USER}.id, like {CMS_USER}.email]
				]
		local
			f: RAW_FILE
			fn: PATH
			res: detachable like users_index
			retried: INTEGER
		do
			fn := directory_name.extended ("users.db")
			create f.make_with_path (fn)
			if retried = 0 then
				if f.exists and then f.is_readable then
					f.open_read
					if attached {like users_index} sed_file_retrieved (f) as r then
						res := r
					end
					f.close
				else
				end
			end
			if res = Void then
				res := [	create {HASH_TABLE [like {CMS_USER}.id, like {CMS_USER}.name]}.make (1),
							create {HASH_TABLE [like {CMS_USER}.id, like {CMS_USER}.email]}.make (1) ]
			end
			Result := res
		rescue
			retried := retried + 1
			retry
		end

	store_users_index (a_users_index: like users_index)
		local
			f: RAW_FILE
			fn: PATH
		do
			fn := directory_name.extended ("users.db")
			create f.make_with_path (fn)
			if not f.exists or else f.is_writable then
				f.open_write
				sed_file_store (a_users_index, f)
				f.close
			end
		end

	user_profile (a_user: CMS_USER): detachable CMS_USER_PROFILE
		do
			if attached {like user_profile} object_with_id (a_user.id, "user_profile") as obj then
				Result := obj
			end
		end

	save_user_profile (a_user: CMS_USER; a_prof: CMS_USER_PROFILE)
		local
			l_id: INTEGER
		do
			if a_user.has_id then
				l_id := a_user.id
			end

			save_object_with_id (a_prof, l_id, "user_profile")
		end

feature -- Misc

	custom_type (a_type: READABLE_STRING_8): STRING
		do
			Result := "custom__" + a_type
		end

	custom_value_id (a_name: READABLE_STRING_8; a_type: READABLE_STRING_8): INTEGER
			-- Storage `id' for custom value named `a_name' if any.
			-- If no such data exists, return 0
		local
			i,
			l_id, l_last_id: INTEGER
			t: STRING
		do
			t := custom_type (a_type)
			l_last_id := last_sequence (t)
			from
				i := 1
			until
				i > l_last_id or l_id > 0
			loop
				if
					attached {TUPLE [name: READABLE_STRING_8; value: attached like custom_value]} object_with_id (i, t) as obj and then
					obj.name.same_string (a_name)
				then
					l_id := i
				end
				i := i + 1
			end
		end

	set_custom_value (a_name: READABLE_STRING_8; a_value: attached like custom_value ; a_type: READABLE_STRING_8)
			-- Save data `a_name:a_value' for type `a_type'
		local
			t: STRING
			l_id: INTEGER
		do
			t := custom_type (a_type)
			l_id := custom_value_id (a_name, a_type)
			if l_id = 0 then
				l_id := next_sequence (t)
			end
			save_object_with_id ([a_name, a_value], l_id, t)
		end

	custom_value (a_name: READABLE_STRING_8; a_type: READABLE_STRING_8): detachable TABLE_ITERABLE [READABLE_STRING_8, STRING_8]
			-- Data for name `a_name' and type `a_type'.
		local
			i,
			l_id, l_last_id: INTEGER
			t: STRING
		do
			t := custom_type (a_type)
			l_last_id := last_sequence (t)
			from
				i := 1
			until
				i > l_last_id or l_id > 0
			loop
				if
					attached {TUPLE [name: READABLE_STRING_8; value: attached like custom_value]} object_with_id (i, t) as obj and then
					obj.name.same_string (a_name)
				then
					l_id := i
					Result := obj.value
				end
				i := i + 1
			end
		end

	custom_value_names_where (a_where_key, a_where_value: READABLE_STRING_8; a_type: READABLE_STRING_8): detachable LIST [READABLE_STRING_8]
			-- Name where custom value has item `a_where_key' same as `a_where_value' for  type `a_type'.
		local
			i, l_last_id: INTEGER
			t: STRING
			l_key_found: BOOLEAN
			res: ARRAYED_LIST [READABLE_STRING_8]
		do
			create res.make (0)
			t := custom_type (a_type)
			l_last_id := last_sequence (t)
			from
				i := 1
			until
				i > l_last_id
			loop
				if
					attached {TUPLE [name: READABLE_STRING_8; value: attached like custom_value]} object_with_id (i, t) as d
				then
					l_key_found := False
					across
						d.value as c
					until
						l_key_found or Result /= Void
					loop
						if c.key.same_string (a_where_key) then
							l_key_found := True
							if c.item.same_string (a_where_value) then
								res.force (d.name)
							end
						end
					end
				end
				i := i + 1
			end
			if not res.is_empty then
				Result := res
			end
		end

feature {NONE} -- Implementation		

	ensure_directory_exists (dn: PATH)
		local
			d: DIRECTORY
		do
			d := tmp_dir
			d.make_with_path (dn)
			if not d.exists then
				d.recursive_create_dir
			end
		end

feature {NONE} -- Implementation

	tmp_dir: DIRECTORY
		once
			create Result.make_with_path (directory_name)
		end

invariant

end
