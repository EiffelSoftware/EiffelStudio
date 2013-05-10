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
			create d.make_with_path (path.extended ("packages").extended ("_index_"))
			d.recursive_create_dir
			create d.make_with_path (path.extended ("users"))
			d.recursive_create_dir
		end

feature -- Status report

	is_available: BOOLEAN
		local
			d: DIRECTORY
		do
			create d.make_with_path (path)
			if d.exists then
				create d.make_with_path (path.extended ("packages").extended ("_index_"))
				if d.exists then
					create d.make_with_path (path.extended ("users"))
					Result := d.exists
				end
			end
		end

feature -- User

	is_valid_credential (u: like {IRON_REPO_USER}.name; p: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached iron_info (user_path (u)) as inf then
				if p /= Void and attached inf.item ("password") as pwd then
					Result := p.same_string (pwd)
				end
			end
		end

	user (u: like {IRON_REPO_USER}.name): detachable IRON_REPO_USER
		do
			if attached iron_info (user_path (u)) as inf then
				if attached inf.item ("name") as l_username and then u.is_case_insensitive_equal (u) then
					create Result.make (u)
				end
			end
		end

	update_user (u: IRON_REPO_USER)
		local
			inf: IRON_REPO_INFO
		do
			if attached user (u.name) as l_user then
					-- update
				create inf.make_with_path (user_path (u.name))
				if attached u.password as p then
					inf.put (p, "password")
				end
			else
					-- create
				create inf.make_empty
				inf.put (u.name, "name")
				inf.put (u.password, "password")
			end
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
			create d.make_with_path (path.extended ("packages"))
			if d.exists and d.is_readable then
				d.open_read
				across
					d.entries as c
				loop
					if attached {PATH} c.item as p and then not (p.is_current_symbol or p.is_parent_symbol) then
						if not p.name.starts_with ("_") and then u.directory_path_exists (d.path.extended_path (p)) then
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
		do
			if a_package.has_id then
				l_package := package (v, a_package.id)
			end
			if l_package = Void then
				create uuidg
				l_uuid := (create {UUID_GENERATOR}).generate_uuid
				a_package.update_id (l_uuid.out)
			end
			l_package := a_package
			check has_id: l_package.has_id end
			p := package_path (v, l_package.id)
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end

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
			if attached a_package.owner as o then
				inf.put (o.name, "owner")
			end
			inf.save_to (p.extended ("package.info"))
		end

	save_package_archive (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE; a_file: WSF_UPLOADED_FILE)
		local
			p: PATH
			b: BOOLEAN
		do
			p := package_path (v, a_package.id).extended ("archive.zip")
			b := a_file.move_to (p.name.to_string_8)
			if b then
				a_package.set_archive_path (p)
			end
		end

	delete_package (v: IRON_REPO_VERSION; p: IRON_REPO_PACKAGE)
		local
			l_path: PATH
			d1,d2: DIRECTORY
			dt: DATE_TIME
		do
			create d1.make_with_path (package_path (v, p.id))
			create dt.make_now_utc

			l_path := trash_path.extended (p.id).appended ("-" + dt.definite_duration (create {DATE_TIME}.make_from_epoch (0)).seconds_count.out)
			create d2.make_with_path (l_path)
			if not d2.exists then
				d1.rename_path (d2.path)
				p.reset_id
			end
		end

	package (v: IRON_REPO_VERSION; a_id: READABLE_STRING_GENERAL): detachable IRON_REPO_PACKAGE
		local
			inf: like iron_info
			z,p: like package_path
			u: FILE_UTILITIES
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
				z := p.extended ("package.zip")
				if u.file_path_exists (z) then
					Result.set_archive_path (z.absolute_path)
				else
					z := p.extended ("archive.zip")
					if u.file_path_exists (z) then
						Result.set_archive_path (z.absolute_path)
					else
						z := p.extended (a_id.to_string_32 + ".zip")
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
			p := path.extended ("packages").extended (v.value)
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
		do
			create Result.make (1)
			create it.make
			p := path.extended ("packages").extended (v.value)
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

	associate_package_with_path (v: IRON_REPO_VERSION; a_package: IRON_REPO_PACKAGE; a_path: READABLE_STRING_GENERAL)
		local
			p: PATH
			f: PLAIN_TEXT_FILE
			d: DIRECTORY
		do
			if attached package_by_path (v, a_path) as curr then
				check precondition: False end
			else
				p := path.extended ("packages").extended (v.value).extended (a_path)
				create d.make_with_path (p.parent)
				if not d.exists then
					d.recursive_create_dir
				end
				create f.make_with_path (p)
				if not f.exists then
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
					p := path.extended ("packages").extended (v.value).extended (a_path)
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
			p := path.extended ("packages").extended ("_index_").extended (v.value)
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

	user_path (u: READABLE_STRING_GENERAL): PATH
		do
			Result := path.extended ("users").extended (u)
		end

	package_path (v: IRON_REPO_VERSION; a_id: READABLE_STRING_GENERAL): PATH
		require
			valid_id: not a_id.is_empty
		do
			Result := path.extended ("packages").extended ("_index_").extended (v.value).extended (a_id)
		end

	trash_path: PATH
		do
			Result := path.extended ("packages").extended ("_index_").extended ("trash")
		end

end
