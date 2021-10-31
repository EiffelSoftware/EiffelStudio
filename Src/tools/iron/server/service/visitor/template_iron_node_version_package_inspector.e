note
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_IRON_NODE_VERSION_PACKAGE_INSPECTOR

inherit
	TEMPLATE_INSPECTOR

create
	register

feature -- Internal data

	internal_data (fn: STRING_8; obj: detachable IRON_NODE_VERSION_PACKAGE): detachable CELL [detachable ANY]
		do
			if obj /= Void then
				if fn.is_case_insensitive_equal_general ("id") then
					Result := cell_of (obj.id)
				elseif fn.is_case_insensitive_equal_general ("human_identifier") then
					Result := cell_of (obj.human_identifier)
				elseif fn.is_case_insensitive_equal_general ("identifier") then
					Result := cell_of (obj.identifier)
				elseif fn.is_case_insensitive_equal_general ("description") then
					Result := cell_of (obj.description)
				elseif fn.is_case_insensitive_equal_general ("was_downloaded") then
					Result := cell_of (obj.download_count > 0)
				elseif fn.is_case_insensitive_equal_general ("download_count") then
					Result := cell_of (obj.download_count)
				elseif fn.is_case_insensitive_equal_general ("name") then
					Result := cell_of (obj.name)
				elseif fn.is_case_insensitive_equal_general ("title") then
					Result := cell_of (obj.title)
				elseif fn.is_case_insensitive_equal_general ("owner") then
					Result := cell_of (obj.owner)
				elseif fn.is_case_insensitive_equal_general ("tags") then
					Result := cell_of (obj.tags)
				elseif fn.is_case_insensitive_equal_general ("links") then
					Result := cell_of (obj.links)
				elseif fn.is_case_insensitive_equal_general ("notes") then
					Result := cell_of (obj.notes)
				elseif fn.is_case_insensitive_equal_general ("items") then
					Result := cell_of (obj.items)
				elseif fn.is_case_insensitive_equal_general ("has_archive") then
					Result := cell_of (obj.has_archive)
				elseif fn.is_case_insensitive_equal_general ("archive_file_size") then
					Result := cell_of (obj.archive_file_size)
				elseif fn.is_case_insensitive_equal_general ("archive_md5") then
					Result := cell_of (obj.archive_md5)
				elseif fn.is_case_insensitive_equal_general ("archive_sha1") then
					Result := cell_of (obj.archive_sha1)
				elseif fn.is_case_insensitive_equal_general ("archive_hash") then
					Result := cell_of (obj.archive_hash)
				elseif fn.is_case_insensitive_equal_general ("archive_revision") then
					Result := cell_of (obj.archive_revision)
				elseif fn.is_case_insensitive_equal_general ("archive_last_modified") then
					if attached obj.archive_last_modified as dt then
						Result := cell_of ((create {HTTP_DATE}.make_from_date_time (dt)).string)
					else
						Result := cell_of ("")
					end
				elseif fn.is_case_insensitive_equal_general ("text_last_modified") then
					if attached obj.last_modified as dt then
						Result := cell_of ((create {HTTP_DATE}.make_from_date_time (dt)).string)
					else
						Result := cell_of ("")
					end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
