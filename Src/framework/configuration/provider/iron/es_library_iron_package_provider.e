note
	date: "$Date$"
	revision: "$Revision$"

class
	ES_LIBRARY_IRON_PACKAGE_PROVIDER

inherit
	ES_LIBRARY_PROVIDER

	EIFFEL_LAYOUT

create
	make

feature {NONE} -- Initialization

	make (a_iron: ES_IRON_SERVICE)
		do
			iron_service := a_iron
		end

feature -- Access

	identifier: STRING = "available packages"
			-- Provider identifier.

	description: detachable READABLE_STRING_32
			-- Optional description
		do
			Result := {STRING_32} "Available IRON packages."
		end

	libraries (a_query: detachable READABLE_STRING_GENERAL; a_target: CONF_TARGET): ARRAYED_LIST [ES_LIBRARY_PROVIDER_ITEM]
		local
			p: IRON_PACKAGE
			i: ES_LIBRARY_PROVIDER_ITEM
			l_api: IRON_INSTALLATION_API
		do
			l_api := iron_service.installation_api
			if
				attached l_api.available_packages as l_iron_packages
			then
				if a_query /= Void then
					create Result.make (l_iron_packages.count)
					across
						scorer.scored_list (a_query, l_iron_packages, False) as ic
					loop
						p := ic.value
						create i.make (ic.score, p, p.identifier)
						i.set_info (l_api.is_package_installed (p), "is_installed")
						Result.extend (i)
					end
				else
					create Result.make (l_iron_packages.count)
					across
						l_iron_packages as ic
					loop
						p := ic
						create i.make (1.0, ic, ic.identifier)
						i.set_info (l_api.is_package_installed (p), "is_installed")
						Result.force (i)
					end
				end
			else
				create Result.make (1)
			end
		end

	updated_date (a_target: CONF_TARGET): detachable DATE_TIME
			-- Date of last update.
		do
		end

	scorer: ES_IRON_PACKAGE_SCORER
		once
			create Result
		end

	sorter: QUICK_SORTER [ES_LIBRARY_PROVIDER_ITEM]
			-- Item sorter.
		once
			create Result.make (create {ES_LIBRARY_PROVIDER_ITEM_COMPARATOR})
		end

feature -- Reset

	reset (a_target: CONF_TARGET)
		do
			iron_service.refresh -- Available packages and installed packages.
		end

feature {NONE} -- Implementation: iron api

	iron_service: ES_IRON_SERVICE

invariant

	iron_service /= Void

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
