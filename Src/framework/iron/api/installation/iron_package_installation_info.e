note
	description: "Summary description for {IRON_PACKAGE_INSTALLATION_INFO}."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_PACKAGE_INSTALLATION_INFO

create
	make_with_package,
	make_with_file

feature {NONE} -- Initialization

	make_with_package (a_package: IRON_PACKAGE; a_path: PATH; a_install_path: PATH)
			-- Create installation info that will be located at `a_path'
			-- and regarding package installed at `a_install_path'.
		do
			path := a_path
			installation_path := a_install_path
			package := a_package
			repository_location := a_package.repository.location
		end

	make_with_file (a_path: PATH)
			-- Create Current from installation info file `a_path'.
		do
			path := a_path
			load
		end

feature -- Access: core

	path: PATH

	installation_path: PATH

feature -- Access	

	repository_location: detachable URI

	package: detachable IRON_PACKAGE

feature -- Status report

	is_valid: BOOLEAN
		do
			Result := not installation_path.is_empty
		end

feature -- Storage

	load
			-- Load installation information from `path'.
		local
			jp: JSON_PARSER
			fac: IRON_REPOSITORY_FACTORY
			repo: detachable IRON_REPOSITORY
			pf: IRON_PACKAGE_FILE
			l_id, l_name: detachable READABLE_STRING_32
			ut: FILE_UTILITIES
			l_package_file_fac: IRON_PACKAGE_FILE_FACTORY
			p: detachable PATH
		do
			create installation_path.make_empty
			if attached file_content (path) as s then
				create jp.make_with_string (s)
				jp.parse_content
				if jp.is_valid and then attached {JSON_OBJECT} jp.parsed_json_object as jo then
					if
						attached {JSON_OBJECT} jo.item ("repository") as j_repo and then
						attached {JSON_STRING} j_repo.item ("uri") as j_repo_uri
					then
						create fac
						repo := fac.new_repository (j_repo_uri.item)
					end
					if repo /= Void then
						repository_location := repo.location
						if attached {JSON_STRING} jo.item ("package-id") as j_id then
							l_id := j_id.item
						end
						if attached {JSON_STRING} jo.item ("package-name") as j_name then
							l_name := j_name.item
						end

						if attached {JSON_STRING} jo.item ("local-path") as j_local_path then
							if attached {IRON_WORKING_COPY_REPOSITORY} repo as l_wc_repo then
								create installation_path.make_from_string (j_local_path.unescaped_string_32)
								if l_name /= Void then
									create l_package_file_fac
										-- Try "package.iron"
									p := installation_path.extended ("package").appended_with_extension ("iron")
									if not ut.file_path_exists (p) then
											-- Try "${package_name}.iron"
										p := installation_path.extended (l_name).appended_with_extension ("iron")
									end
									if not ut.file_path_exists (p) then
											-- Try first iron file in this folder.
										p := first_iron_file_path_from (installation_path)
									end
									if p /= Void and then ut.file_path_exists (p) then
										pf := l_package_file_fac.new_package_file (p)
										package := pf.to_package (l_wc_repo)
									end
								end
							else
									-- Resolve ...
								create installation_path.make_from_string (j_local_path.unescaped_string_32)
								if attached {JSON_OBJECT} jo.item ("package") as j_package then
									package := json_object_to_package (j_package, repo)
								end
							end
						else
							create installation_path.make_empty
						end
					else
							-- Error .. should contain valid repository information !
					end
				end
			end
		end

	save
			-- Save current installation information into `path'.
		require
			is_valid: is_valid
			repository_location /= Void
			package /= Void
		local
			j: STRING
			js: JSON_STRING
			p: PATH
			f: PLAIN_TEXT_FILE
			l_package: like package
		do
			l_package := package

			create j.make (512)
			j.append_character ('{')
			p := installation_path

			j.append ("%"local-path%": ")
			js := installation_path.name
			j.append (js.representation)
			if l_package /= Void then
				if attached l_package.name as l_name then
					j.append (", %"package-name%": ")
					js := l_name
					j.append (js.representation)
				elseif attached l_package.id as l_id then
					j.append (", %"package-id%": ")
					js := l_id
					j.append (js.representation)
				end
			end
			if attached repository_location as repo_loc then
				j.append (",")
				j.append ("%"repository%": {")
				j.append ("%"uri%":")
				js := repo_loc.string
				j.append (js.representation)
				j.append_character ('}')
			end

			if
				l_package /= Void and then
				attached l_package.json_item as l_json and then
				l_json.is_valid_as_string_8
			then
					-- FIXME: check if `l_json` is valid JSON value as well [2018-01-15]
				j.append_character (',')
				j.append ("%"package%":")
				j.append (l_json.to_string_8)
			end

			j.append_character ('}')

			ensure_folder_exists (path.parent)
			create f.make_with_path (path)
			f.create_read_write
			f.put_string (j)
			f.put_new_line
			f.close
		end

feature -- Conversion

	json_object_to_package (j_package: JSON_OBJECT; repo: IRON_REPOSITORY): detachable IRON_PACKAGE
		local
			s: READABLE_STRING_GENERAL
		do
			if
				attached {JSON_STRING} j_package.item ("id") as j_id and
				attached {JSON_STRING} j_package.item ("name") as j_name
			then
				create Result.make (j_id.item, repo)
				Result.put_json_item (j_package.representation)
				Result.set_name (j_name.item)
				if attached {JSON_STRING} j_package.item ("title") as j_title then
					Result.set_title (j_title.unescaped_string_32)
				end
				if attached {JSON_STRING} j_package.item ("description") as j_description then
					Result.set_description (j_description.unescaped_string_32)
				end
				if attached {JSON_NUMBER} j_package.item ("archive_revision") as j_rev then
					s := j_rev.item
					if s.is_natural then
						Result.set_archive_revision (s.to_natural)
					end
				end
				if attached {JSON_STRING} j_package.item ("archive") as j_archive then
					Result.set_archive_uri (j_archive.item)
				end
				if attached {JSON_STRING} j_package.item ("archive_hash") as j_archive_hash then
					Result.set_archive_hash (j_archive_hash.item)
				end
				if attached {JSON_NUMBER} j_package.item ("archive_size") as j_size then
					s := j_size.item
					if s.is_integer then
						Result.set_archive_size (s.to_integer)
					end
				end
				if attached {JSON_ARRAY} j_package.item ("paths") as j_paths then
					across
						j_paths.array_representation as c
					loop
						if attached {JSON_STRING} c as js then
							Result.associated_paths.force (js.item)
						end
					end
				end
				if attached {JSON_ARRAY} j_package.item ("tags") as j_tags then
					across
						j_tags.array_representation as c
					loop
						if attached {JSON_STRING} c as js then
							Result.tags.force (js.unescaped_string_32)
						end
					end
				end
				if attached {JSON_OBJECT} j_package.item ("links") as j_links then
					across
						j_links as c
					loop
						if attached {JSON_STRING} c as js then
							Result.put (js.unescaped_string_32, {STRING_32} "link["+ @ c.key.unescaped_string_32 +"]")
						end
					end
				end
				if attached {JSON_OBJECT} j_package.item ("notes") as j_notes then
					across
						j_notes as c
					loop
						if attached {JSON_STRING} c as js then
							Result.put (js.unescaped_string_32, @ c.key.unescaped_string_32)
						end
					end
				end
			end
		end

feature {NONE} -- Helpers

	first_iron_file_path_from (p: PATH): detachable PATH
		local
			d: DIRECTORY
		do
			create d.make_with_path (p)
			if d.exists then
				across
					d.entries as ic
				until
					Result /= Void
				loop
					if ic.is_current_symbol or ic.is_parent_symbol then
					elseif attached ic.extension as e and then e.is_case_insensitive_equal_general ("iron") then
						Result := p.extended_path (ic)
					end
				end
			end
		end

	ensure_folder_exists (p: PATH)
		local
			d: DIRECTORY
		do
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end
		end

	file_content (p: PATH): detachable STRING
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			if f.exists and then f.is_access_readable then
				f.open_read
				create Result.make (1_024)
				from
				until
					f.exhausted
				loop
					f.read_stream (1_024)
					Result.append (f.last_string)
				end
				f.close
			end
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
