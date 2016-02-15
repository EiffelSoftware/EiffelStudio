note
	description: "Summary description for {ES_LIBRARY_IRON_PROVIDER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_LIBRARY_IRON_PROVIDER

inherit
	ES_LIBRARY_PROVIDER

	ES_CACHE_UTILITIES

	CONF_VALIDITY

feature -- Access

	identifier: STRING = "iron"
			-- Provider identifier.

	description: detachable READABLE_STRING_32
			-- Optional description
		do
			Result := {STRING_32} "Libraries available from installed IRON packages."
		end

	no_cached_libraries (a_target: CONF_TARGET): STRING_TABLE [CONF_SYSTEM_VIEW]
		local
			l_installation_api: IRON_INSTALLATION_API
			l_iron_installation_api_factory: CONF_IRON_INSTALLATION_API_FACTORY
			loc: STRING_32
			pk: IRON_PACKAGE
		do
			create l_iron_installation_api_factory
				--| TODO: improve performance, by caching iron_installation_api in the whole system.
				--| idea: l_iron_installation_api_factory.enable_caching
			l_installation_api := l_iron_installation_api_factory.iron_installation_api (create {IRON_LAYOUT}.make_with_path (eiffel_layout.iron_path, eiffel_layout.installation_iron_path), create {IRON_URL_BUILDER})
			if attached l_installation_api.installed_packages as l_packages then
				create Result.make (l_packages.count)
				across
					l_packages as ic
				loop
					pk := ic.item
					if attached l_installation_api.projects_from_installed_package (pk) as l_projects then
						across
							l_projects as proj_ic
						loop
							loc := {STRING} "iron:" + ic.item.identifier + {STRING_32} ":" + proj_ic.item.name
							if attached conf_system_from (a_target, loc, False) as cfg then
								Result.force (cfg, loc)
								if attached pk.items as l_pk_items then
									across
										l_pk_items as pk_items_ic
									loop
										if attached pk_items_ic.item as l_text then
											cfg.set_info (l_text, pk_items_ic.key)
										end
									end
								end
								if attached pk.title as pk_title then
									cfg.set_info (pk_title, "title")
								end
								if attached pk.description as pk_desc then
									cfg.set_info (pk_desc, "description")
								end
							end
						end
					end
				end
					--| TODO: improve performance, by caching iron_installation_api in the whole system.
					--| this point would be good location to disable the caching.
					--| idea: l_iron_installation_api_factory.disable_caching
			else
				create Result.make (0)
			end
		end

	cache_name (a_target: CONF_TARGET): STRING
		do
			if is_dotnet (a_target) then
				Result := "iron_configuration_libraries_dotnet.cache"
			else
				Result := "iron_configuration_libraries.cache"
			end
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
