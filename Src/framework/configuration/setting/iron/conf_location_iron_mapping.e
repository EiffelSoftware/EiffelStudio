note
	description: "[
				Mapping between
			 		- a iron location as specified in Eiffel Configuration File (.ecf)
						i.e http://iron.eiffel.com/....
					- and the local path of the installed library (if it was already installed)
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOCATION_IRON_MAPPING

inherit
	CONF_LOCATION_MAPPING

create
	make

feature {NONE} -- Initialization

	make (a_layout: IRON_LAYOUT; a_urls: like iron_urls)
			-- Initialize Current with `a_layout'.
		do
			iron_layout := a_layout
			iron_urls := a_urls
		end

	iron_layout: IRON_LAYOUT

	iron_urls: IRON_URL_BUILDER

feature -- Access

	mapped_location (a_location: READABLE_STRING_32): detachable READABLE_STRING_32
			-- Path mapped with `a_location' if any.
		local
			l_uri: STRING_32
		do
				--| Hardcoded for now, but we can imagine abstracting the "mapping"
				--| and have Iron out of the configuration lib.
			if
				a_location.starts_with ("iron:")
				or a_location.starts_with ("http:")
				or a_location.starts_with ("https:")
			then
					-- Absolute IRON library URL or iron reference
				create l_uri.make_from_string (a_location)
				update_location_to_uri (l_uri)
				if attached iron_api.local_path_associated_with_uri (l_uri) as p then
					Result := p.name
				end
			end
		end

	expected_action_parameters (a_location: READABLE_STRING_32): detachable CONF_LOCATION_MAPPER_ACTION
			-- <Precursor>
			--| for instance with iron, a possible action would be to install related package.
		local
			l_uri: STRING_32
		do
			if
				a_location.starts_with ("iron:")
				or a_location.starts_with ("http:")
				or a_location.starts_with ("https:")
			then
					-- Absolute IRON library URL or iron reference
				create l_uri.make_from_string (a_location)
				update_location_to_uri (l_uri)
				if attached iron_api.local_path_associated_with_uri (l_uri) as p then
						-- mapping exists.
				elseif
					attached iron_api.available_package_name_for_uri (l_uri) as l_package_name
				then
					create Result.make (Current, l_uri, "iron install")
					Result.parameters ["package_name"] := l_package_name.to_string_32
				end
			end
		end

feature -- Change

	refresh
		do
			if attached internal_iron_api as api then
				if not api.is_up_to_date then
					internal_iron_api := Void
				end
			end
		end

feature -- Access		

	iron_api: IRON_INSTALLATION_API
		local
			l_iron_api: detachable like iron_api
			fac: CONF_IRON_INSTALLATION_API_FACTORY
		do
			l_iron_api := internal_iron_api
			if l_iron_api /= Void and then not l_iron_api.is_up_to_date then
				l_iron_api := Void
			end
			if l_iron_api = Void then
				create fac
				l_iron_api := fac.iron_installation_api (iron_layout, iron_urls)
				internal_iron_api := l_iron_api
			end
			Result := l_iron_api
		end

feature {NONE} -- Implementation

	internal_iron_api: detachable like iron_api

	update_location_to_uri (a_location: STRING_32)
		require
			a_location_not_void: a_location /= Void
		do
			a_location.replace_substring_all ({STRING_32} "\", {STRING_32} "/")
		ensure
			a_location_has_not_windows_separator: not a_location.has ('\')
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
