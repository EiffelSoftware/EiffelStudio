note
	description: "Summary description for {JSON_TO_IRON_FACTORY}."
	author: ""
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
			create j.make_parser (a_json_string)
			if j.is_parsed and then attached {JSON_OBJECT} j.parse as jo then
				if jo.has_key ("_version") and then attached {JSON_STRING} jo.item ("_version") as j_version then
					l_version := j_version.item
				end
				if attached {JSON_ARRAY} jo.item ("packages") as j_packages then
					across
						j_packages.array_representation as c
					loop
						if attached {JSON_OBJECT} c.item as j_package then
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
			create j.make_parser (a_json_string)
			if j.is_parsed and then attached {JSON_OBJECT} j.parse as jo then
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

feature {NONE} -- Implementation		

	json_object_to_package (j_package: JSON_OBJECT; repo: IRON_REPOSITORY; a_version: detachable READABLE_STRING_8): detachable IRON_PACKAGE
		do
			if
				attached {JSON_STRING} j_package.item ("id") as j_id and
				attached {JSON_STRING} j_package.item ("name") as j_name
			then
				create Result.make (j_id.item, repo)
				if a_version /= Void then
					j_package.put (create {JSON_STRING}.make_json (a_version), "_version")
				end
				Result.put_json_item (j_package.representation)
				Result.set_name (j_name.item)
				if attached {JSON_STRING} j_package.item ("title") as j_title then
					Result.set_title (j_title.item)
				end
				if attached {JSON_STRING} j_package.item ("description") as j_description then
					Result.set_description (j_description.item)
				end
				if attached {JSON_STRING} j_package.item ("archive") as j_archive then
					Result.set_archive_uri (j_archive.item)
				end
				if attached {JSON_STRING} j_package.item ("archive_hash") as j_archive_hash then
					Result.set_archive_hash (j_archive_hash.item)
				end
				if attached {JSON_ARRAY} j_package.item ("paths") as j_paths then
					across
						j_paths.array_representation as c
					loop
						if attached {JSON_STRING} c.item as js then
							Result.associated_paths.force (js.item)
						end
					end
				end
				if attached {JSON_ARRAY} j_package.item ("tags") as j_tags then
					across
						j_tags.array_representation as c
					loop
						if attached {JSON_STRING} c.item as js then
							Result.tags.force (js.item)
						end
					end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
