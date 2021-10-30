note
	description: "[
				Class that should be a singleton to setup the configuration library
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_SETTING

inherit
	ANY

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature -- Initialization	

	make
			-- Build configuration setup object
		do
			create conf_location_mapper.make
		end

feature -- Status report

	is_initialized: BOOLEAN
			-- Is setup initialized?

feature -- Initialization

	initialize
			-- Initialize configuration parser behavior.
		do
			if not is_initialized then
				initialize_conf_location_mapper
				is_initialized := conf_location_mapper_initialized
			end
		end

feature -- Access: Configuration location mapper

	conf_location_mapper: CONF_LOCATION_MAPPER
			-- Configuration location mapper

	conf_location_mapper_initialized: BOOLEAN
			-- Configuration location mapper intialized?

	iron_mapping: detachable CONF_LOCATION_IRON_MAPPING
			-- Iron mapping if any.
		require
			is_initialized: is_initialized
		do
			across
				conf_location_mapper.mappings as ic
			until
				Result /= Void
			loop
				if attached {like iron_mapping} ic as res then
					Result := res
				end
			end
		end

feature -- Initialization: Configuration location mapper

	initialize_conf_location_mapper
		do
			if not conf_location_mapper_initialized then

				initialize_iron
				conf_location_mapper_initialized := iron_initialized
			end
		end

feature -- Initialization: Iron

	iron_initialized: BOOLEAN
			-- Iron mapping intialized?

	initialize_iron
		local
			l_iron_mapping: CONF_LOCATION_IRON_MAPPING
			lay: IRON_LAYOUT
		do
			if not iron_initialized then
					-- Custom mapping for IRON...		
				if is_eiffel_layout_defined then
						-- Using ISE Eiffel Environment
					create lay.make_with_path (eiffel_layout.iron_path, eiffel_layout.installation_iron_path)
					create l_iron_mapping.make (lay, create {IRON_URL_BUILDER})
					conf_location_mapper.register (l_iron_mapping)
					iron_initialized := True
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
