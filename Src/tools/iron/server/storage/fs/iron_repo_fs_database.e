note
	description: "Summary description for {IRON_REPO_FS_DATABASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPO_FS_DATABASE

inherit
	IRON_REPO_DATABASE

create
	make_with_path

feature {NONE} -- Initialization

	make_with_path (d: PATH)
		do
			path := d
		end

	path: PATH

feature -- Operation	

	initialize
		local
			d: DIRECTORY
		do
			create d.make_with_path (path)
			d.recursive_create_dir
			create d.make_with_path (path.extended ("versions"))
			d.recursive_create_dir
			create d.make_with_path (users_path)
			d.recursive_create_dir
		end

feature -- Status report

	is_available: BOOLEAN
		local
			d: DIRECTORY
		do
			create d.make_with_path (path)
			if d.exists then
				create d.make_with_path (path.extended ("versions"))
				if d.exists then
					create d.make_with_path (users_path)
					Result := d.exists
				end
			end
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

	is_valid_credential (u: like {IRON_REPO_USER}.name; p: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached iron_info (user_path (u)) as inf then
				if p /= Void then
					if attached inf.item ("encrypted_password") as enc_pwd then
						Result := enc_pwd.same_string (encrypted_password (p))
					elseif attached inf.item ("password") as pwd then
						Result := encrypted_password (pwd).same_string (encrypted_password (p))
					end
				end
			end
		end

	user (u: like {IRON_REPO_USER}.name): detachable IRON_REPO_USER
		do
			if attached iron_info (user_path (u)) as inf then
				if attached inf.item ("name") as l_username and then u.is_case_insensitive_equal (u) then
					create Result.make (u)
					if attached inf.item ("activation_code") as s and then not s.is_empty then
						-- need activation
						-- thus no roles
					elseif attached inf.item ("roles") as s_roles then
						if attached s_roles.split (',') as l_roles then
							across
								l_roles as c
							loop
								Result.add_role (create {IRON_REPO_USER_ROLE}.make (c.item))
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

	user_by_email (a_email: READABLE_STRING_GENERAL): detachable IRON_REPO_USER
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

	update_user (u: IRON_REPO_USER)
		local
			inf: IRON_REPO_INFO
			s: STRING
			utf: UTF_CONVERTER
			flag_is_new: BOOLEAN
			l_encpwd: detachable READABLE_STRING_8
			l_user: like user
		do
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
		end

feature -- Version

	versions: ITERABLE [IRON_REPO_VERSION]
		local
			d: DIRECTORY
			u: FILE_UTILITIES
			lst: ARRAYED_LIST [IRON_REPO_VERSION]
		do
			create lst.make (5)
			create d.make_with_path (versions_path)
			if d.exists and d.is_readable then
				d.open_read
				across
					d.entries as c
				loop
					if attached {PATH} c.item as p and then not (p.is_current_symbol or p.is_parent_symbol) then
						if u.directory_path_exists (d.path.extended_path (p)) then
							lst.force (create {IRON_REPO_VERSION}.make (p.utf_8_name))
						end
					end
				end
				d.close
			end
			Result := lst
		end

feature -- Package

	update_package (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE)
		local
			l_package: like package
			p: like package_path
			d: DIRECTORY
			inf: detachable IRON_REPO_INFO
			uuidg: UUID_GENERATOR
			l_uuid: UUID
			hdate: HTTP_DATE
			flag_is_new: BOOLEAN
		do
			if a_package.has_id then
				l_package := package (v, a_package.id)
			else
				flag_is_new := True
			end
			if l_package = Void then
				create uuidg
				l_uuid := (create {UUID_GENERATOR}).generate_uuid
				a_package.update_id (l_uuid.out)
			end
			l_package := a_package

				-- Ensure the tree dir exists
			p := packages_tree_path (v)
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end

				-- Ensure the package index dir exists
			check has_id: l_package.has_id end
			p := package_path (v, l_package.id)
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end

				-- Update last modified
			l_package.set_last_modified_now

				-- Save information
			create inf.make_empty
			if attached l_package.items as tb then
				across
					tb as c
				loop
					inf.put (c.item, c.key)
				end
			end

			inf.put (l_package.id, "id")
			inf.put (a_package.name, "name")
			inf.put (a_package.description, "description")
			if attached l_package.last_modified as dt then
				create hdate.make_from_date_time (dt)
				inf.put (hdate.rfc1123_string, "last-modified")
			end

			if attached a_package.owner as o then
				inf.put (o.name, "owner")
			end
			inf.save_to (p.extended ("package.info"))
		end

	save_uploaded_package_archive (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE; a_file: WSF_UPLOADED_FILE)
		local
			p: PATH
			b: BOOLEAN
		do
			p := package_path (v, a_package.id).extended ("archive")
			b := a_file.move_to (p.name.to_string_8)
			if b then
				a_package.set_archive_path (p)
			end
		end

	save_package_archive (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE; a_file: PATH; a_keep_source_file: BOOLEAN)
		local
			p: PATH
			src,tgt: RAW_FILE
		do
			p := package_path (v, a_package.id).extended ("archive")
			create src.make_with_path (a_file)
			if src.exists then
				if a_keep_source_file then
					create tgt.make_with_path (p)
					tgt.open_write
					src.open_read
					src.copy_to (tgt)
					src.close
					tgt.close
				else
					src.rename_path (p)
				end
				a_package.set_archive_path (p)
			end
		end

	delete_package_archive (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE)
		local
			p: PATH
			f: RAW_FILE
		do
			p := package_path (v, a_package.id).extended ("archive")
			create f.make_with_path (p)
			if f.exists then
				f.delete
				a_package.set_archive_path (Void)

				update_package (v, a_package)
			end
		end

	delete_package (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE)
		local
			l_path: PATH
			d1,d2: DIRECTORY
			dt: DATE_TIME
		do
			create d1.make_with_path (package_path (v, a_package.id))
			create dt.make_now_utc

			l_path := packages_trash_path (v)
			create d2.make_with_path (l_path)
			if not d2.exists then
				d2.recursive_create_dir
			end

			create d2.make_with_path (l_path.extended (a_package.id).appended ("-" + dt.definite_duration (create {DATE_TIME}.make_from_epoch (0)).seconds_count.out))
			if not d2.exists then
				d1.rename_path (d2.path)
				a_package.reset_id
			end
		end

	package (v: IRON_REPO_VERSION; a_id: READABLE_STRING_GENERAL): detachable IRON_REPO_PACKAGE
		local
			inf: like iron_info
			z,p: like package_path
			u: FILE_UTILITIES
			hdate: HTTP_DATE
		do
			p := package_path (v, a_id)
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
				Result.set_description (inf.item ("description"))
				if attached inf.item ("owner") as s_owner then
					if attached user (s_owner) as o then
						Result.set_owner (o)
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
						or c.key.same_string ("description")
					then
							-- no way
					else
						Result.put (c.item, c.key)
					end
				end
				z := p.extended ("package")
					--| Should we have a specific ext
				if u.file_path_exists (z) then
					Result.set_archive_path (z.absolute_path)
				else
					z := p.extended ("archive")
					if u.file_path_exists (z) then
						Result.set_archive_path (z.absolute_path)
					else
						z := p.extended (a_id.to_string_32)
						if u.file_path_exists (z) then
							Result.set_archive_path (z.absolute_path)
						end
					end
				end
			end
		end

	package_by_path (v: IRON_REPO_VERSION; a_path: READABLE_STRING_GENERAL): detachable IRON_REPO_PACKAGE
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
							not l_uuid.is_empty and then attached package (v, l_uuid) as l_package
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

	path_associated_with_package (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE): ARRAYED_LIST [READABLE_STRING_32]
		local
			it: IRON_REPO_FS_PATH_ITERATOR
			l_paths: ARRAYED_LIST [PATH]
			p: PATH
			s,t: STRING_32
			d: DIRECTORY
		do
			create Result.make (1)
			create it.make
			p := packages_tree_path (v)
			create l_paths.make (1)
			it.file_actions.extend (agent (ia_path: PATH; ia_id: READABLE_STRING_GENERAL; res: LIST [PATH])
					do
						if
							attached id_from_file (ia_path) as l_id and then
							ia_id.is_case_insensitive_equal (l_id)
						then
							res.force (ia_path.canonical_path)
						end
					end(?, a_package.id, l_paths)
				)
			p := p.canonical_path
			create d.make_with_path (p)
			if d.exists then
				it.process_directory (p)
				s := p.name
				across
					l_paths as c
				loop
					t := c.item.name
					if t.starts_with (s) then
						t.remove_head (s.count)
						t.replace_substring_all ("\", "/")
						Result.force (t)
					else
						check False end
					end
				end
			end
		end

	associate_package_with_path (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE; a_path: READABLE_STRING_GENERAL)
		local
			p: PATH
			f: PLAIN_TEXT_FILE
			d: DIRECTORY
		do
			if attached package_by_path (v, a_path) as curr then
				check precondition: False end
			else
				p := packages_tree_path (v).extended (a_path)
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
				end
			end
		end

	unassociate_package_with_path (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE; a_path: READABLE_STRING_GENERAL)
		local
			p: PATH
			f: PLAIN_TEXT_FILE
		do
			if attached package_by_path (v, a_path) as curr then
				if curr ~ a_package then
					p := packages_tree_path (v).extended (a_path)
					create f.make_with_path (p)
					if f.exists then
						f.delete
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

	packages (v: IRON_REPO_VERSION; a_lower, a_upper: INTEGER): detachable LIST [IRON_REPO_PACKAGE]
		local
			p: PATH
			d,t: DIRECTORY
		do
			p := packages_index_path (v)
			create d.make_with_path (p)
			if d.exists and then d.is_readable then
				create {ARRAYED_LIST [IRON_REPO_PACKAGE]} Result.make (10)
				across
					d.entries as c
				loop
					if
						attached {PATH} c.item as l_path and then
						not l_path.is_current_symbol and then
						not l_path.is_parent_symbol
					then
						create t.make_with_path (p.extended_path (l_path))
						if t.exists and then attached package (v, l_path.utf_8_name) as l_pack then
							check attached t.path.entry as e and then e.name.same_string_general (l_pack.id) end
							Result.force (l_pack)
						end
					end
				end
			end
		end

	path_browse_index (v: IRON_REPO_VERSION; a_path: READABLE_STRING_GENERAL): detachable ARRAYED_LIST [READABLE_STRING_32]
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

	iron_info (p: PATH): detachable IRON_REPO_INFO
		do
			create Result.make_with_path (p)
			if not Result.is_valid then
				Result := Void
			end
		end

	users_path: PATH
		once
			Result := path.extended ("users")
		end

	user_path (u: READABLE_STRING_GENERAL): PATH
		do
			Result := users_path.extended (u)
		end

	versions_path: PATH
		once
			Result := path.extended ("versions")
		end

	package_path (v: IRON_REPO_VERSION; a_id: READABLE_STRING_GENERAL): PATH
		require
			valid_id: not a_id.is_empty
		do
			Result := packages_index_path (v).extended (a_id)
		end

	packages_index_path (v: IRON_REPO_VERSION): PATH
		do
			Result := versions_path.extended (v.value).extended ("items")
		end

	packages_tree_path (v: IRON_REPO_VERSION): PATH
		do
			Result := versions_path.extended (v.value).extended ("index")
		end

	packages_trash_path (v: IRON_REPO_VERSION): PATH
		do
			Result := packages_index_path (v).extended ("trash")
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
