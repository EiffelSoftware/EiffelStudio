note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_REPOSITORY

inherit
	ITERABLE [IRON_PACKAGE]

feature {NONE} -- Initialization

	initialize
		do
			create_available_packages
		end

	create_available_packages
			-- Create `available_packages'
		deferred
		end

feature -- Access

	available_packages_count: INTEGER
			-- Count of available packages.
		deferred
		end

	available_packages: ITERABLE [IRON_PACKAGE]
			-- Available package for current repository.

	location_string: READABLE_STRING_8
		do
			Result := location.string
		end

	location: URI
			-- URI location of Current repository.
			--| Could be http:// file:// ...
		deferred
		end

	new_cursor: ITERATION_CURSOR [IRON_PACKAGE]
			-- Fresh cursor associated with current structure
		do
			Result := available_packages.new_cursor
		end

feature -- Query

	package_associated_with_id (a_id: READABLE_STRING_GENERAL): detachable IRON_PACKAGE
		do
			across
				available_packages as p
			until
				Result /= Void
			loop
				if a_id.is_case_insensitive_equal (p.id) then
					Result := p
				end
			end
		end

	packages_associated_with_name (a_name: READABLE_STRING_GENERAL): detachable LIST [IRON_PACKAGE]
		local
			l_package: detachable IRON_PACKAGE
		do
			create {ARRAYED_LIST [IRON_PACKAGE]} Result.make (1)
			across
				available_packages as p
			loop
				l_package := p
				if l_package.is_identified_by (a_name) then
					Result.force (l_package)
				end
			end
			if Result.is_empty then
				Result := Void
			end
		end

	package_associated_with_uri (a_uri: URI): detachable IRON_PACKAGE
		local
			s: READABLE_STRING_8
			l_location_string: like location_string
		do
			s := a_uri.string
			l_location_string := location_string
			if s.starts_with (l_location_string) then
				s := s.substring (l_location_string.count + 1, s.count)
				across
					available_packages as p
				until
					Result /= Void
				loop
					across
						p.associated_paths as pn
					until
						Result /= Void
					loop
						if s.starts_with (pn) then
							Result := p
						end
					end
				end
			end
		end

feature -- Status report

	is_located_at (a_location: like location): BOOLEAN
			-- Is Current repository located at `a_location' ?
		do
			Result := location.is_same_uri (a_location)
		end

	is_same_repository (other: IRON_REPOSITORY): BOOLEAN
			-- Is Current and `other' represent the same repository?
		deferred
		end

feature -- Change

	reset_available_packages
		deferred
		end

	put_package (p: IRON_PACKAGE)
		deferred
		end

feature {IRON_EXPORTER} -- Change		

	set_package_list (v: like available_packages)
		do
			available_packages := v
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
