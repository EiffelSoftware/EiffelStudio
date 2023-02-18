note
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_TO_IRON_FACTORY

inherit
	IRON_EXPORTER

feature -- Access

	json_to_packages (a_json_string: READABLE_STRING_8; repo: IRON_REPOSITORY): ARRAYED_LIST [IRON_PACKAGE]
		local
			j: JSON_PARSER
			l_version: detachable READABLE_STRING_8
		do
			create Result.make (0)
			create j.make_with_string (a_json_string)
			j.parse_content
			if j.is_valid and then attached {JSON_OBJECT} j.parsed_json_object as jo then
				if jo.has_key ("_version") and then attached {JSON_STRING} jo.item ("_version") as j_version then
					l_version := j_version.item
				end
				if attached {JSON_ARRAY} jo.item ("packages") as j_packages then
					across
						j_packages.array_representation as c
					loop
						if attached {JSON_OBJECT} c as j_package then
							if attached json_object_to_package (j_package, repo, l_version) as p then
								Result.force (p)
							end
						end
					end
				end
			end
		end

	json_to_package (a_json_string: READABLE_STRING_8): detachable IRON_PACKAGE
		local
			j: JSON_PARSER
			repo: detachable IRON_REPOSITORY
			u: URI
			l_version: detachable READABLE_STRING_8
			fac: IRON_REPOSITORY_FACTORY
		do
			create j.make_with_string (a_json_string)
			j.parse_content
			if j.is_valid and then attached {JSON_OBJECT} j.parsed_json_object as jo then
				if jo.has_key ("_version") and then attached {JSON_STRING} jo.item ("_version") as j_version then
					l_version := j_version.item
				end
					-- FIXME: any need to support local repository here?

				if attached {JSON_OBJECT} jo.item ("repository") as j_repo then
					if
						attached {JSON_STRING} j_repo.item ("uri") as j_uri and
						attached {JSON_OBJECT} jo.item ("package") as j_package
					then
						create u.make_from_string (j_uri.item)
						if attached {JSON_STRING} j_repo.item ("version") as j_version then
							create {IRON_WEB_REPOSITORY} repo.make (u, j_version.item)
						else
							create fac
							repo := fac.new_repository (u.string)
						end
						if
							repo /= Void and then
							attached json_object_to_package (j_package, repo, l_version) as p
						then
							Result := p
						end
					end
				end
			end
		end

	json_to_package_within_repository (a_json_string: READABLE_STRING_8; a_repo: IRON_REPOSITORY): detachable IRON_PACKAGE
		local
			j: JSON_PARSER
			l_version: detachable READABLE_STRING_8
		do
			create j.make_with_string (a_json_string)
			j.parse_content
			if j.is_valid and then attached {JSON_OBJECT} j.parsed_json_object as jo then
				if jo.has_key ("_version") and then attached {JSON_STRING} jo.item ("_version") as j_version then
					l_version := j_version.item
				end
					-- FIXME: any need to support local repository here?

				if
					attached {JSON_OBJECT} jo.item ("package") as j_package
				then
					if
						attached json_object_to_package (j_package, a_repo, l_version) as p
					then
						Result := p
					end
				end
			end
		end

	json_to_package_identifier (a_json_string: READABLE_STRING_8): detachable READABLE_STRING_GENERAL
		local
			j: JSON_PARSER
		do
			create j.make_with_string (a_json_string)
			j.parse_content
			if j.is_valid and then attached {JSON_OBJECT} j.parsed_json_object as jo then
				if attached {JSON_STRING} jo.item ("package-name") as j_package_name then
					Result := j_package_name.item
				elseif
					attached {JSON_OBJECT} jo.item ("package") as j_package
				then
					if attached {JSON_STRING} j_package.item ("name") as j_name then
						Result := j_name.item
					elseif attached {JSON_STRING} j_package.item ("id") as j_id then
						Result := j_id.item
					end
				end
			end
		end

feature {NONE} -- Implementation		

	json_object_to_package (j_package: JSON_OBJECT; repo: IRON_REPOSITORY; a_version: detachable READABLE_STRING_8): detachable IRON_PACKAGE
		local
			s: READABLE_STRING_GENERAL
			k: READABLE_STRING_32
		do
			if
				attached {JSON_STRING} j_package.item ("id") as j_id and
				attached {JSON_STRING} j_package.item ("name") as j_name
			then
				create Result.make (j_id.item, repo)
				if a_version /= Void then
					j_package.put (create {JSON_STRING}.make_from_string (a_version), "_version")
				end
				Result.put_json_item (j_package.representation)
				Result.set_name (j_name.item)
				if attached {JSON_STRING} j_package.item ("title") as j_title then
					Result.set_title (j_title.unescaped_string_32)
				end
				if attached {JSON_STRING} j_package.item ("description") as j_description then
					Result.set_description (j_description.unescaped_string_32)
				end
				if attached {JSON_STRING} j_package.item ("archive") as j_archive then
					Result.set_archive_uri (j_archive.item)
				end
				if attached {JSON_NUMBER} j_package.item ("archive_revision") as j_rev then
					s := j_rev.item
					if s.is_natural then
						Result.set_archive_revision (s.to_natural)
					end
				end
				if attached {JSON_STRING} j_package.item ("archive_size") as j_size then
					s := j_size.item
					if s.is_integer then
						Result.set_archive_size (s.to_integer)
					end
				elseif attached {JSON_NUMBER} j_package.item ("archive_size") as j_size then
					s := j_size.item
					if s.is_integer then
						Result.set_archive_size (s.to_integer)
					end
				end
				if attached {JSON_STRING} j_package.item ("archive_hash") as j_archive_hash then
					Result.set_archive_hash (j_archive_hash.item)
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
				if attached {JSON_OBJECT} j_package.item ("notes") as j_notes then
					across
						j_notes as ic
					loop
						k := @ ic.key.unescaped_string_32
						if attached {JSON_STRING} ic as js then
							Result.put (js.unescaped_string_32, k)
						else
								-- FIXME: should we also include links (represented as JSON objects)?
						end
					end
				end
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
