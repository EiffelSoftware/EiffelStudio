note
	description: "Summary description for {IRON_NODE_FS_DATABASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_FS_DATABASE

inherit
	IRON_NODE_DATABASE

	SHARED_EXECUTION_ENVIRONMENT

create
	make_with_layout

feature {NONE} -- Initialization

	make_with_layout (a_layout: IRON_NODE_LAYOUT)
		do
			layout := a_layout
		end

	layout: IRON_NODE_LAYOUT

feature -- Operation	

	initialize
		local
			d: DIRECTORY
		do
			create d.make_with_path (layout.repo_path)
			d.recursive_create_dir

			create d.make_with_path (layout.repo_versions_path)
			d.recursive_create_dir
			create d.make_with_path (layout.repo_users_path)
			d.recursive_create_dir
		end

feature -- Status report

	is_available: BOOLEAN
		local
			d: DIRECTORY
		do
			create d.make_with_path (layout.repo_path)
			if d.exists then
				create d.make_with_path (layout.repo_versions_path)
				if d.exists then
					create d.make_with_path (layout.repo_users_path)
					Result := d.exists
				end
			end
		end

feature -- Logs

	save_log (a_log: IRON_NODE_LOG)
			-- Save log `a_log'.
		local
			f: RAW_FILE
			dt: DATE_TIME
			dt_text: STRING
			d: DIRECTORY
			p: PATH
			j: JSON_OBJECT
		do
			dt := a_log.time
			create dt_text.make_empty
			dt_text.append_integer (dt.year)
			if dt.month < 10 then
				dt_text.append_character ('0')
			end
			dt_text.append_integer (dt.month)
			if dt.day < 10 then
				dt_text.append_character ('0')
			end
			dt_text.append_integer (dt.day)

			p := layout.logs_path
			if attached a_log.type as l_log_type then
				p := p.extended (l_log_type)
			end
			p := p.extended (dt_text)

			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end

			dt_text := dt.date.ordered_compact_date.out + "-" + dt.time.compact_time.out + "-" + dt.time.nano_second.out

			p := p.extended (dt_text).appended_with_extension ("log")
			create j.make
			j.put (create {JSON_STRING}.make_from_string ((create {HTTP_DATE}.make_from_date_time (dt)).string), "date")
			j.put (create {JSON_STRING}.make_from_string_32 (a_log.title), "title")
			if attached a_log.content as l_content then
				j.put (create {JSON_STRING}.make_from_string_32 (l_content), "message")
			end
			create f.make_with_path (p)
			f.create_read_write
			f.put_string (j.representation)
			f.close
		end

feature -- User

	encrypted_password (p: detachable READABLE_STRING_GENERAL): READABLE_STRING_8
		local
			sha256: SHA256
			utf: UTF_CONVERTER
		do
			create sha256.make
			if p = Void then
				sha256.update_from_string ("")
			else
				sha256.update_from_string (utf.utf_32_string_to_utf_8_string_8 (p))
			end
			Result := sha256.digest_as_string
		end

	is_valid_credential (u: like {IRON_NODE_USER}.name; p: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			if not u.is_empty and then attached iron_info (user_path (u)) as inf then
				if p /= Void then
					if attached inf.item ("encrypted_password") as enc_pwd then
						Result := enc_pwd.same_string_general (encrypted_password (p))
					elseif attached inf.item ("password") as pwd then
						Result := encrypted_password (pwd).same_string_general (encrypted_password (p))
					end
				end
			end
		end

	user (u: like {IRON_NODE_USER}.name): detachable IRON_NODE_USER
		do
			if not u.is_empty and then attached iron_info (user_path (u)) as inf then
				if attached inf.item ("name") as l_username and then l_username.is_case_insensitive_equal (u) then
					create Result.make (u)
					if attached inf.item ("activation_code") as s and then not s.is_empty then
						-- need activation
						-- thus no roles
					elseif attached inf.item ("roles") as s_roles then
						if attached s_roles.split (',') as l_roles then
							across
								l_roles as c
							loop
								Result.add_role (create {IRON_NODE_USER_ROLE}.make (c.item))
							end
						end
					end
					if attached inf.item ("email") as s_email then
						Result.set_email (s_email)
					end
					across
						inf as c
					loop
						if
							c.key.same_string ("name")
							or c.key.same_string ("roles")
							or c.key.same_string ("email")
						then
							-- Already stored in attribute
						else
							Result.set_data_item (c.key, c.item)
						end
					end
				end
			end
		end

	user_by_email (a_email: READABLE_STRING_GENERAL): detachable IRON_NODE_USER
		local
			d: DIRECTORY
		do
			create d.make_with_path (users_path)
			if d.exists then
				across
					d.entries as c
				until
					Result /= Void
				loop
					Result := user (c.item.name)
					if
						Result /= Void and then
						attached Result.email as l_email and then
						a_email.is_case_insensitive_equal (l_email)
					then
						-- Found it.
					else
						Result := Void
					end
				end
			end
		end

	update_user (u: IRON_NODE_USER)
		local
			inf: IRON_NODE_INFO
			s: STRING
			utf: UTF_CONVERTER
			flag_is_new: BOOLEAN
			l_encpwd: detachable READABLE_STRING_8
			l_user: like user
		do
			check user_name_is_not_empty: not u.name.is_empty end
			l_user := user (u.name)
			if l_user /= Void then
					-- update
				create inf.make_with_path (user_path (u.name))
			else
				create inf.make_empty
				inf.put (u.name, "name")

				flag_is_new := True
			end

			if attached u.roles as l_user_roles and then not l_user_roles.is_empty then
				create s.make_empty
				across
					l_user_roles as c
				loop
					if not s.is_empty then
						s.append_character (',')
					end
					s.append (utf.utf_32_string_to_utf_8_string_8 (c.item.name))
				end
				inf.put (s, "roles")
			end
			if attached u.email then
				inf.put (u.email, "email")
			end

			if attached u.data as l_u_data then
				across
					l_u_data as c
				loop
					if attached {READABLE_STRING_GENERAL} c.item as l_text then
						inf.put (l_text, c.key)
					end
				end
			end
			if attached u.removed_data as l_u_data then
				across
					l_u_data as c
				loop
					inf.remove (c.item)
				end
			end

			if l_user /= Void then
				if attached u.password as p then
					l_encpwd := encrypted_password (p)
				elseif attached inf.item ("password") as pwd then
					l_encpwd := encrypted_password (pwd)
				end
			else
				l_encpwd := encrypted_password (u.password)
			end
			if l_encpwd /= Void then
				u.set_data_item ("encrypted_password", l_encpwd)
				inf.put (l_encpwd, "encrypted_password")
				inf.remove ("password")
			else
				u.remove_data_item ("encrypted_password")
			end
				-- Remove non encrypted password!
			u.set_password (Void)

			inf.save_to (user_path (u.name))
			on_user_updated (u, flag_is_new)
		end

feature -- Version

	versions: IRON_NODE_VERSION_COLLECTION
		local
			d: DIRECTORY
			u: FILE_UTILITIES
		do
			create Result.make (5)
			create d.make_with_path (versions_path)
			if d.exists and d.is_readable then
				d.open_read
				across
					d.entries as c
				loop
					if attached {PATH} c.item as p and then not (p.is_current_symbol or p.is_parent_symbol) then
						if u.directory_path_exists (d.path.extended_path (p)) then
							Result.force (create {IRON_NODE_VERSION}.make (p.utf_8_name))
						end
					end
				end
				d.close
			end
		end

	save_version (a_version: IRON_NODE_VERSION)
		local
			d: DIRECTORY
		do
			create d.make_with_path (versions_path.extended (a_version.value))
			if not d.exists then
				d.recursive_create_dir
			end
		end

feature -- Package

	package (a_id: READABLE_STRING_GENERAL): detachable IRON_NODE_PACKAGE
		local
			inf: like iron_info
			p: like package_path
			hdate: HTTP_DATE
			s: STRING_32
			l_title: detachable STRING_32
			i: INTEGER
		do
			p := package_path (a_id)
			inf := iron_info (p.extended ("package.info"))
			if inf = Void then
					-- Look for first  *.info
			end
			if inf /= Void then
				if attached inf.item ("id") as l_uuid and then a_id.same_string (l_uuid) then
						-- Ok
				else
					check same_id: False end
				end
				create Result.make (a_id.to_string_8)
				Result.set_name (inf.item ("name"))
				Result.set_title (inf.item ("title"))
				Result.set_description (inf.item ("description"))
				if attached inf.item ("owner") as s_owner then
					if attached user (s_owner) as o then
						Result.set_owner (o)
					end
				end
				if attached inf.item ("tags") as s_tags and then not s_tags.is_empty then
					across
						s_tags.split (',') as tags_ic
					loop
						Result.add_tag (tags_ic.item)
					end
				end
				if attached inf.table_item ("links") as s_links then
					across
						s_links as links_ic
					loop
						create s.make_from_string (links_ic.item)
						s.left_adjust
						s.right_adjust
						create l_title.make_from_string_general (links_ic.key)
						if not s.is_empty then
							if s.item (1) = '"' then
								i := s.index_of ('"', 2)
								if i > 0 then
									l_title := s.substring (2, i - 1)
									s := s.substring (i + 1, s.count)
									s.left_justify
								end
							end
							if s.is_valid_as_string_8 then
								Result.add_link (links_ic.key, create {IRON_NODE_LINK}.make (s.to_string_8, l_title))
							end
						end
					end
				end

				if attached inf.item ("last-modified") as dt then
					create hdate.make_from_string (dt.to_string_8)
					Result.set_last_modified (hdate.date_time)
				end

				across
					inf as c
				loop
					if
						c.key.same_string ("id")
						or c.key.same_string ("name")
						or c.key.same_string ("title")
						or c.key.same_string ("description")
						or c.key.same_string ("tags")
						or c.key.same_string ("owner")
						or c.key.same_string ("last-modified")
						or c.key.same_string ("last-archive-revision")
						or c.key.same_string ("links")
						or c.key.starts_with ("links[")
					then
							-- no way
					else
						Result.put (c.item, c.key)
					end
				end
--				z := package_archive_path (v, a_id)
--				if u.file_path_exists (z) then
--					Result.set_archive_path (z.absolute_path)
--				end
			end
		end

	packages (a_lower, a_upper: INTEGER): detachable IRON_NODE_PACKAGE_COLLECTION
		local
			p: PATH
			d,t: DIRECTORY
			i: INTEGER
			l_files: ARRAYED_LIST [PATH]
			l_path: PATH
			l_upper: INTEGER
		do
			p := packages_path
			create d.make_with_path (p)
			if d.exists and then d.is_readable then
				create l_files.make (10)
				i := 0
				across
					d.entries as c
				loop
					l_path := c.item
					if
						not l_path.is_current_symbol and then
						not l_path.is_parent_symbol
					then
						create t.make_with_path (p.extended_path (l_path))
						if t.exists then
							i := i + 1
							if a_lower <= i then
								l_files.force (l_path)
							end
						end
					end
				end
				create Result.make (l_files.count)
				i := a_lower - 1
				if a_upper <= 0 then
					l_upper := a_lower - 1 + l_files.count + a_upper
				else
					l_upper := a_lower - 1 + a_upper
				end
				across
					l_files as ic
				until
					i >= l_upper
				loop
					i := i + 1
					if i <= l_upper then
						l_path := ic.item
						if attached package (l_path.name) as l_pack then
							check attached l_path.entry as e and then e.name.same_string_general (l_pack.id) end
							Result.force (l_pack)
						end
					end
				end
			end
		end

feature -- Package: change

	force_package (a_package: IRON_NODE_PACKAGE)
		do
			patch_package (a_package, Void)
		end

	update_package (a_package: IRON_NODE_PACKAGE)
		local
			l_db_package: like package
			uuidg: UUID_GENERATOR
			l_uuid: UUID
		do
			if a_package.has_id then
				l_db_package := package (a_package.id)
			end
			if l_db_package = Void then
				create uuidg
				l_uuid := (create {UUID_GENERATOR}).generate_uuid
				a_package.update_id (l_uuid.out)
			end

			patch_package (a_package, l_db_package)
		end

	delete_package (a_package: IRON_NODE_PACKAGE)
		local
			l_path: PATH
			d1,d2: DIRECTORY
			dt: DATE_TIME
		do
			create d1.make_with_path (package_path (a_package.id))
			create dt.make_now_utc

			l_path := packages_trash_path
			create d2.make_with_path (l_path)
			if not d2.exists then
				d2.recursive_create_dir
			end

			create d2.make_with_path (l_path.extended (a_package.id).appended ("-" + dt.definite_duration (create {DATE_TIME}.make_from_epoch (0)).seconds_count.out))
			if not d2.exists then
				d1.rename_path (d2.path)
				a_package.reset_id
			end
			-- FIXME: delete associated version packages
		end

	patch_package (a_package: IRON_NODE_PACKAGE; a_prev_package: detachable IRON_NODE_PACKAGE)
		require
			a_package.has_id
		local
			p: like package_path
			d: DIRECTORY
			inf: detachable IRON_NODE_INFO
			hdate: HTTP_DATE
			flag_is_new: BOOLEAN
			s: STRING_32
		do
			flag_is_new := a_prev_package = Void

--				-- Ensure the tree dir exists
--			p := packages_tree_path (v)
--			create d.make_with_path (p)
--			if not d.exists then
--				d.recursive_create_dir
--			end

				-- Ensure the package index dir exists
			check has_id: a_package.has_id end
			p := package_path (a_package.id)
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end

				-- Update last modified
			a_package.set_last_modified_now

				-- Save information
			create inf.make_empty
			if attached a_package.items as tb then
				across
					tb as c
				loop
					inf.put (c.item, c.key)
				end
			end

			inf.put (a_package.id, "id")
			inf.put (a_package.name, "name")
			inf.put (a_package.title, "title")
			inf.put (a_package.description, "description")
			if attached a_package.last_modified as dt then
				create hdate.make_from_date_time (dt)
				inf.put (hdate.rfc1123_string, "last-modified")
			end
			create s.make_empty
			if attached a_package.tags as l_tags then
				across
					l_tags as tags_ic
				loop
					if not s.is_empty then
						s.append_character (',')
					end
					s.append (tags_ic.item)
				end
			end
			if not s.is_empty then
				inf.put (s, "tags")
			end

			if attached a_package.links as l_links then
				across
					l_links as link_ic
				loop
					create s.make_empty
					if attached link_ic.item.title as lnk_title then
						s.append_character ('%"')
						s.append (lnk_title)
						s.append_character ('%"')
						s.append_character (' ')
					end
					s.append_string_general (link_ic.item.url)
					inf.put (s, {STRING_32} "links["+ link_ic.key + {STRING_32} "]")
				end
			end


			if attached a_package.owner as o then
				inf.put (o.name, "owner")
			end
			inf.save_to (p.extended ("package.info"))
			on_package_updated (a_package, flag_is_new)
		end

feature -- Version package

	version_package (v: IRON_NODE_VERSION; a_id: READABLE_STRING_GENERAL): detachable IRON_NODE_VERSION_PACKAGE
		local
			l_package: like package
			inf: like iron_info
			p: like package_path
			rev: NATURAL
			arch: IRON_NODE_ARCHIVE
		do
			p := package_version_path (v, a_id)
			inf := iron_info (p.extended ("version.info"))
			if inf = Void then
					-- Look for first  *.info
			end
			if inf /= Void then
				if attached inf.item ("id") as l_uuid and then a_id.same_string (l_uuid) then
						-- Ok
				else
					check same_id: False end
				end
				l_package := package (a_id)
				if l_package = Void then
						-- Error !!
				else
					create Result.make (l_package, v)
					if attached inf.item ("archive_revision") as s_rev and then s_rev.is_natural then
						rev := s_rev.to_natural
					else
						rev := Result.archive_revision
					end
					across
						inf as c
					loop
						if
							c.key.same_string ("id")
							or c.key.same_string ("archive_revision")
						then
								-- no way
						else
							Result.put (c.item, c.key)
						end
					end
					Result.set_archive_revision (rev)
					create arch.make (package_version_archive_path (Result, rev).absolute_path)
					if arch.file_exists then
						if attached inf.item ("archive_hash") as s_hash and then not s_hash.is_whitespace then
							arch.set_hash (s_hash.to_string_8) -- By design it is valid string 8.
						else
							arch.reset_hash
						end
						Result.set_archive (arch)
					else
						Result.set_archive (Void)
					end
					Result.set_download_count (download_count (Result))
				end
			end
		end

	version_packages_count (v: IRON_NODE_VERSION): INTEGER
			-- Total number of package for version `v'.
		local
			p: PATH
			d,t: DIRECTORY
			i: INTEGER
			l_path: PATH
		do
			p := packages_index_path (v)
			create d.make_with_path (p)
			if d.exists and then d.is_readable then
				i := 0
				create t.make_with_path (p) -- Initialize `t'
				across
					d.entries as c
				loop
					l_path := c.item
					if
						not l_path.is_current_symbol and then
						not l_path.is_parent_symbol
					then
						t.make_with_path (p.extended_path (l_path)) -- reuse `t'
						if t.exists then
							i := i + 1
						end
					end
				end
				Result := i
			end
		end

	version_packages (v: IRON_NODE_VERSION; a_lower, a_upper: INTEGER): detachable IRON_NODE_VERSION_PACKAGE_COLLECTION
		local
			p: PATH
			d,t: DIRECTORY
			i: INTEGER
			l_files: ARRAYED_LIST [PATH]
			l_path: PATH
			l_upper: INTEGER
		do
			p := packages_index_path (v)
			create d.make_with_path (p)
			if d.exists and then d.is_readable then
				create l_files.make (10)
				i := 0
				create t.make_with_path (p) -- Initialize `t'
				across
					d.entries as c
				loop
					l_path := c.item
					if
						not l_path.is_current_symbol and then
						not l_path.is_parent_symbol
					then
						t.make_with_path (p.extended_path (l_path)) -- reuse `t'
						if t.exists then
							i := i + 1
							if a_lower <= i then
								l_files.force (l_path)
							end
						end
					end
				end
				create Result.make (l_files.count)
				i := a_lower - 1
				if a_upper <= 0 then
					l_upper := a_lower - 1 + l_files.count + a_upper
				else
					l_upper := a_lower - 1 + a_upper
				end
				across
					l_files as ic
				until
					i >= l_upper
				loop
					i := i + 1
					if i <= l_upper then
						l_path := ic.item
						if attached version_package (v, l_path.name) as l_pack then
							check attached l_path.entry as e and then e.name.same_string_general (l_pack.id) end
							Result.force (l_pack)
						end
					end
				end
--				Result.sort
			end
		end

	package_by_path (v: IRON_NODE_VERSION; a_path: READABLE_STRING_GENERAL): detachable IRON_NODE_VERSION_PACKAGE
		local
			p: PATH
			err: BOOLEAN
			u: FILE_UTILITIES
		do
			p := packages_tree_path (v)
			across
				a_path.split ('/') as c
			until
				Result /= Void or err
			loop
				if not c.item.is_empty then
					p := p.extended (c.item)
					if u.file_path_exists (p) then
						if
							attached id_from_file (p) as l_uuid and then
							not l_uuid.is_empty and then attached version_package (v, l_uuid) as l_package
						then
							Result := l_package
						else
							err := True
						end
					elseif u.directory_path_exists (p) then
						-- skip
					else
						err := True
					end
				end
			end
			if err then
				Result := Void
			end
		end

	path_associated_with_package (a_package: IRON_NODE_VERSION_PACKAGE): ARRAYED_LIST [READABLE_STRING_32]
		do
			Result := path_association_map (a_package.version).paths (a_package.id)
		end

	path_browse_index (v: IRON_NODE_VERSION; a_path: READABLE_STRING_GENERAL): detachable ARRAYED_LIST [READABLE_STRING_32]
		local
			d: detachable DIRECTORY
			p: PATH
			err: BOOLEAN
			u: FILE_UTILITIES
		do
			p := packages_tree_path (v)
			if a_path.is_empty then
				if u.directory_path_exists (p) then
					-- skip
				elseif u.file_path_exists (p) then
					create d.make_with_path (p)
				else
					err := True
				end
			else
				across
					a_path.split ('/') as c
				until
					d /= Void or err
				loop
					if not c.item.is_empty then
						p := p.extended (c.item)
						if u.directory_path_exists (p) then
							-- skip
						elseif u.file_path_exists (p) then
							create d.make_with_path (p)
						else
							err := True
						end
					end
				end
			end
			if d /= Void then
				-- skip
			elseif err then
				d := Void
			elseif p /= Void then
				create d.make_with_path (p)
			end
			if d /= Void and then d.exists then
				create Result.make (5)
				across
					d.entries as e
				loop
					if e.item.is_current_symbol or e.item.is_parent_symbol then
					else
						Result.force (e.item.name)
					end
				end
			end
		end

	download_count (a_package: IRON_NODE_VERSION_PACKAGE): INTEGER
		local
			p: PATH
			f: RAW_FILE
			s: READABLE_STRING_8
		do
			p := package_version_counter_path (a_package)
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				f.read_line_thread_aware
				s := f.last_string
				if s.is_integer then
					Result := a_package.download_count.max (s.to_integer)
				end
				f.close
			end
			Result := a_package.download_count.max (Result)
		end

	increment_download_counter (a_package: IRON_NODE_VERSION_PACKAGE)
		local
			f: RAW_FILE
			nb: INTEGER
		do
			nb := download_count (a_package)
			a_package.download_count := nb + 1
			create f.make_with_path (package_version_counter_path (a_package))
			if not f.exists or else f.is_access_writable then
				f.open_write
				f.put_string (a_package.download_count.out)
				f.put_new_line
				f.close
			end
			on_version_package_downloaded (a_package)
		end

feature -- Version Package: change

	force_version_package (a_package: IRON_NODE_VERSION_PACKAGE)
		do
			patch_version_package (a_package, Void)
		end

	update_version_package (a_package: IRON_NODE_VERSION_PACKAGE)
		local
			l_db_vpackage: like version_package
			v: IRON_NODE_VERSION
		do
			v := a_package.version

			if a_package.has_id then
				l_db_vpackage := version_package (v, a_package.id)
			end
			patch_version_package (a_package, l_db_vpackage)
		end

	patch_version_package (a_package: IRON_NODE_VERSION_PACKAGE; a_prev_package: detachable IRON_NODE_VERSION_PACKAGE)
		require
			a_package.has_id
		local
			vp: like package_version_path
			d: DIRECTORY
			inf: detachable IRON_NODE_INFO
			flag_is_new: BOOLEAN
			v: IRON_NODE_VERSION
		do
			v := a_package.version

			flag_is_new := a_prev_package = Void

				-- Ensure the tree dir exists
			vp := packages_tree_path (v)
			create d.make_with_path (vp)
			if not d.exists then
				d.recursive_create_dir
			end

				-- Ensure the package index dir exists
			check has_id: a_package.has_id end
			vp := package_version_path (v, a_package.id)
			create d.make_with_path (vp)
			if not d.exists then
				d.recursive_create_dir
			end

				-- Update last modified
			a_package.package.set_last_modified_now

				-- Save information
			create inf.make_empty
			if attached a_package.version_items as tb then
				across
					tb as c
				loop
					inf.put (c.item, c.key)
				end
			end

			inf.put (a_package.id, "id")
			inf.put (a_package.name, "name")
			inf.put (a_package.archive_revision.out, "archive_revision")
			if attached a_package.archive as l_archive then
				inf.put (l_archive.hash, "archive_hash")
			else
				inf.remove ("archive_hash")
			end

			inf.save_to (vp.extended ("version.info"))
			on_version_package_updated (a_package, flag_is_new)

			if a_prev_package = Void then
				patch_package (a_package.package, Void)
			else
				patch_package (a_package.package, a_prev_package.package)
			end
		end

	delete_version_package (a_package: IRON_NODE_VERSION_PACKAGE)
		local
			l_path: PATH
			d1,d2: DIRECTORY
			dt: DATE_TIME
			v: IRON_NODE_VERSION
		do
			v := a_package.version
			create d1.make_with_path (package_version_path (v, a_package.id))
			create dt.make_now_utc

			l_path := packages_version_trash_path (v)
			create d2.make_with_path (l_path)
			if not d2.exists then
				d2.recursive_create_dir
			end

			create d2.make_with_path (l_path.extended (a_package.id).appended ("-" + dt.definite_duration (create {DATE_TIME}.make_from_epoch (0)).seconds_count.out))
			if not d2.exists then
				d1.rename_path (d2.path)
			end
			reset_path_association_map (a_package.version)
		end

feature -- Version package / archive: change

	last_archive_revision (a_package: IRON_NODE_PACKAGE): NATURAL
		local
			p: PATH
			f: RAW_FILE
			s: READABLE_STRING_8
		do
			p := package_archive_revision_counter_path (a_package)
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				f.read_line_thread_aware
				s := f.last_string
				if s.is_integer then
					Result := s.to_natural
				end
				f.close
			end
			Result := Result
		end

	incremented_last_archive_revision (a_package: IRON_NODE_PACKAGE; a_min_rev: NATURAL): NATURAL
		local
			p: PATH
			f: RAW_FILE
			s: READABLE_STRING_8
		do
			p := package_archive_revision_counter_path (a_package)
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				f.read_line_thread_aware
				s := f.last_string
				if s.is_integer then
					Result := s.to_natural
				end
				f.close
			end
			Result := a_min_rev.max (Result) + {NATURAL} 1
			if not f.exists or else f.is_access_writable then
				f.open_write
				f.put_string (Result.out)
				f.put_new_line
				f.close
			end
		end

	get_new_archive_revision (a_package: IRON_NODE_VERSION_PACKAGE)
		do
			a_package.set_archive_revision (incremented_last_archive_revision (a_package.package, a_package.archive_revision))
		end

	save_uploaded_package_archive (a_package: IRON_NODE_VERSION_PACKAGE; a_file: WSF_UPLOADED_FILE)
		local
			b: BOOLEAN
			tgt: RAW_FILE
			rev: NATURAL
			arch: IRON_NODE_ARCHIVE
		do
			rev := a_package.archive_revision
			create arch.make (package_version_archive_path (a_package, rev))
			create tgt.make_with_path (arch.path)
			from
			until
				not tgt.exists
			loop
				get_new_archive_revision (a_package) -- New archive, keep previous for backup!
				rev := a_package.archive_revision
				create arch.make (package_version_archive_path (a_package, rev))
				create tgt.make_with_path (arch.path)
				check not tgt.exists end
			end
			b := a_file.move_to (tgt.path.name)
			if b then
				arch.update_info
				a_package.set_archive (arch)
				update_version_package (a_package)
			end
		end

	save_package_archive (a_package: IRON_NODE_VERSION_PACKAGE; a_file: PATH; a_keep_source_file: BOOLEAN)
		local
			src,tgt: RAW_FILE
			retried: BOOLEAN
			rev: NATURAL
			arch: IRON_NODE_ARCHIVE
		do
			if not retried then
				create src.make_with_path (a_file)
				if src.exists then
					rev := a_package.archive_revision
					create arch.make (package_version_archive_path (a_package, rev))
					create tgt.make_with_path (arch.path)
					from
					until
						not tgt.exists
					loop
						get_new_archive_revision (a_package) -- New archive, keep previous for backup!
						rev := a_package.archive_revision
						create arch.make (package_version_archive_path (a_package, rev))
						create tgt.make_with_path (arch.path)
						check not tgt.exists end
					end
					if a_keep_source_file then
						tgt.open_write
						src.open_read
						src.copy_to (tgt)
						src.close
						tgt.close
					else
						src.rename_path (tgt.path)
					end
					debug ("ssd_file_delay")
						execution_environment.sleep (1_000_000_000)
					end

					check tgt.exists end
					print ("tgt.size=" + tgt.count.out + "%N")
					arch.update_info
					a_package.set_archive (arch)
					arch.compute_hash

					update_version_package (a_package)
				end
			else
					-- FIXME: report issue !
				a_package.set_archive (Void)
				update_version_package (a_package)
			end
		rescue
			retried := True
			retry
		end

	delete_package_archive (a_package: IRON_NODE_VERSION_PACKAGE)
		local
			p: PATH
			f: RAW_FILE
		do
			p := package_version_archive_path (a_package, a_package.archive_revision)
			create f.make_with_path (p)
			if f.exists then
				f.delete
				get_new_archive_revision (a_package)
				a_package.set_archive (Void)
				update_version_package (a_package)
			end
		end

	associate_package_with_path (a_package: IRON_NODE_VERSION_PACKAGE; a_path: READABLE_STRING_GENERAL)
		local
			p: PATH
			f: PLAIN_TEXT_FILE
			d: DIRECTORY
			v: IRON_NODE_VERSION
		do
			v := a_package.version
			if attached package_by_path (v, a_path) as curr then
				check precondition: False end
			else
				if a_path.starts_with ("/") then
					p := packages_tree_path (v).extended (a_path.substring (2, a_path.count))
				else
					p := packages_tree_path (v).extended (a_path)
				end
				create d.make_with_path (p.parent)
				if not d.exists then
					d.recursive_create_dir
				end
				create f.make_with_path (p)
				if not f.exists or else f.is_access_writable then
					f.open_write
					f.put_string (a_package.id)
					f.put_new_line
					f.close
					reset_path_association_map (a_package.version)
					on_version_package_updated (a_package, False)
				end
			end
		end

	unassociate_package_with_path (a_package: IRON_NODE_VERSION_PACKAGE; a_path: READABLE_STRING_GENERAL)
		local
			p: PATH
			f: PLAIN_TEXT_FILE
			v: IRON_NODE_VERSION
		do
			v := a_package.version
			if attached package_by_path (v, a_path) as curr then
				if curr ~ a_package then
					if a_path.starts_with ("/") then
						p := packages_tree_path (v).extended (a_path.substring (2, a_path.count))
					else
						p := packages_tree_path (v).extended (a_path)
					end

					create f.make_with_path (p)
					if f.exists then
						f.delete
						reset_path_association_map (a_package.version)
						on_version_package_updated (a_package, False)
					end
				else
						-- path is mapped to another package !!!
					check precondition: False end
				end
			else
					-- path not mapped to a package !
				check precondition: False end
			end
		end

feature {NONE} -- Implementation: maps		

	internal_path_association_maps: detachable HASH_TABLE [IRON_NODE_PATH_MAP, IRON_NODE_VERSION]
			-- Internal cache for `path_association_map'.

	reset_path_association_map (v: IRON_NODE_VERSION)
			-- Reset information from `path_association_map' related to version `v'.
		do
			if attached internal_path_association_maps as ht then
				ht.remove (v)
			end
			delete_path_association_map (v)
		end

	path_association_map (v: IRON_NODE_VERSION): IRON_NODE_PATH_MAP
			-- Path association map for version `v'.
		local
			l_maps: detachable like path_association_map
			it: IRON_NODE_FS_PATH_ITERATOR
			p: PATH
			d: DIRECTORY
			ht: like internal_path_association_maps
		do
			ht:= internal_path_association_maps
			if ht = Void then
				create ht.make (1)
				internal_path_association_maps := ht
			else
				l_maps := ht.item (v)
			end
			if l_maps /= Void then
				Result := l_maps
			else
				l_maps := loaded_path_association_map (v)
				if l_maps /= Void then
					Result := l_maps
					ht.force (Result, v)
				else
					create Result.make (v)
					p := packages_tree_path (v).canonical_path
					create d.make_with_path (p)
					if d.exists then
						create it.make
						it.file_actions.extend (agent (ia_path: PATH; a_base_path: READABLE_STRING_32; ia_map: like path_association_map)
								local
									s: STRING_32
								do
									if attached id_from_file (ia_path) as l_id then
										create s.make_from_string (ia_path.canonical_path.name)
										if s.starts_with (a_base_path) then
											s.remove_head (a_base_path.count)
											s.replace_substring_all ("\", "/")
											ia_map.register_path (l_id, s)
										else
											check False end
										end
									end
								end(?, p.name, Result)
							)
						it.process_directory (p)
					end
						--| keep map
					ht.force (Result, v)
					store_path_association_map (Result)
				end

			end
		end

	store_path_association_map (m: IRON_NODE_PATH_MAP)
		local
			f: RAW_FILE
			utf: UTF_CONVERTER
			l_id: READABLE_STRING_32
		do
			create f.make_with_path (packages_version_index_map_path (m.version))
			f.create_read_write
			across
				m.maps as ic
			loop
				l_id := ic.key -- By design, it is valid STRING_8
				f.put_string (utf.utf_32_string_to_utf_8_string_8 (l_id))
				f.put_new_line
				across
					ic.item as ic_path
				loop
					f.put_character ('%T')
					f.put_string (utf.escaped_utf_32_string_to_utf_8_string_8 (ic_path.item))
					f.put_new_line
				end
			end
			f.close
		end

	delete_path_association_map (v: IRON_NODE_VERSION)
		local
			f: RAW_FILE
		do
			create f.make_with_path (packages_version_index_map_path (v))
			if f.exists then
				f.delete
			end
		end

	loaded_path_association_map (v: IRON_NODE_VERSION): detachable IRON_NODE_PATH_MAP
		local
			f: RAW_FILE
			utf: UTF_CONVERTER
			s: STRING_8
			l_id: detachable IMMUTABLE_STRING_8
		do
			create f.make_with_path (packages_version_index_map_path (v))
			if f.exists and f.is_access_readable then
				f.open_read
				create Result.make (v)
				if f.file_readable then
					from
						f.read_line_thread_aware
					until
						f.exhausted
					loop
						s := f.last_string
						if s.is_empty then
						elseif s.item (1).is_space then
							if l_id /= Void then
								s.left_adjust
								s.right_adjust
								Result.register_path (l_id, utf.utf_8_string_8_to_escaped_string_32 (s))
							end
						else
							s.right_adjust
							create l_id.make_from_string (s)
						end
						f.read_line_thread_aware
					end
				end
				f.close
			end
		end

feature {NONE} -- Initialization

	id_from_file (p: PATH): detachable READABLE_STRING_8
		local
			f: PLAIN_TEXT_FILE
			s: STRING_8
		do
			create f.make_with_path (p)
			if f.exists and f.is_access_readable then
				f.open_read
				f.read_line_thread_aware
				s := f.last_string
				s.left_adjust
				s.right_adjust
				f.close
				if not s.is_empty then
					Result := s
				end
			end
		end

	iron_info (p: PATH): detachable IRON_NODE_INFO
		do
			create Result.make_with_path (p)
			if not Result.is_valid then
				Result := Void
			end
		end

	users_path: PATH
		once
			Result := layout.repo_users_path
		end

	user_path (u: READABLE_STRING_GENERAL): PATH
		require
			u_is_not_empty: not u.is_empty
		do
			Result := users_path.extended (u)
		end

	packages_path: PATH
		once
			Result := layout.repo_packages_path
		end

	package_path (a_id: READABLE_STRING_GENERAL): PATH
		require
			valid_id: not a_id.is_empty
		do
			Result := packages_path.extended (a_id)
		end

	package_archive_revision_counter_path (a_package: IRON_NODE_PACKAGE): PATH
		require
			package_with_id: a_package.has_id
		do
			Result := package_path (a_package.id).extended ("archive_revision")
		end

	packages_trash_path: PATH
		do
			Result := layout.repo_trash
		end

	versions_path: PATH
		once
			Result := layout.repo_versions_path
		end

	package_version_path (v: IRON_NODE_VERSION; a_id: READABLE_STRING_GENERAL): PATH
		require
			valid_id: not a_id.is_empty
		do
			Result := packages_index_path (v).extended (a_id)
		end

	package_version_counter_path (a_package: IRON_NODE_VERSION_PACKAGE): PATH
		require
			package_with_id: a_package.has_id
		do
			Result := packages_index_path (a_package.version).extended (a_package.id).extended ("downloads")
		end

	package_version_archive_path (a_package: IRON_NODE_VERSION_PACKAGE; a_archive_revision: NATURAL): PATH
		require
			has_id: a_package.has_id
		do
			Result := package_archive_path (a_package.version, a_archive_revision, a_package.id)
		end

	package_archive_path (v: IRON_NODE_VERSION; a_rev: NATURAL; a_id: READABLE_STRING_GENERAL): PATH
		require
			valid_id: not a_id.is_empty
		do
			Result := packages_index_path (v).extended (a_id).extended ("archive")
			if a_rev > 0 then
				Result := Result.appended_with_extension (a_rev.out)
			end
		end

	packages_index_path (v: IRON_NODE_VERSION): PATH
		do
			Result := layout.repo_version_items (v)
		end

	packages_tree_path (v: IRON_NODE_VERSION): PATH
		do
			Result := layout.repo_version_index (v)
		end

	packages_version_trash_path (v: IRON_NODE_VERSION): PATH
		do
			Result := layout.repo_version_trash (v)
		end

	packages_version_index_map_path (v: IRON_NODE_VERSION): PATH
		do
			Result := layout.repo_version_index_map (v)
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
