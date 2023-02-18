note
	description: "Provide access to configuration options"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_UPDATE_CLIENT_CONFIGURATION

inherit
	SHARED_EXECUTION_ENVIRONMENT

create
	make,
	make_with_config

feature {NONE} -- Implemention

	make (a_uri: STRING_8)
			-- Create a Client configuration with
			-- service uri set to `a_uri' and default
			-- timeout.
		require
			not_null: a_uri /= Void
			not_empty: not a_uri.is_empty
		local
			cfg: like json_configuration
		do
			create cfg.make_with_uri (a_uri)
			json_configuration := cfg
		ensure
			service_root_set: service_root.same_string (a_uri)
		end

	make_with_config
			-- Create client configuration from JSON config file.
		local
			cfg: like json_configuration
		do
			create cfg.make (Execution_environment.current_working_path.extended ("eiffel_download_config.json"))
			json_configuration := cfg
		end

feature -- Access

	connection_timeout: INTEGER
			-- Maximum time the request is allowed to take.
		do
			Result := json_configuration.connection_timeout
		end

	service_root: READABLE_STRING_8
			-- Root uri to drive the interaction.
		do
			Result := json_configuration.service_root
		end

	channel_endpoint (a_channel: READABLE_STRING_8): STRING_8
		do
			create Result.make_from_string (service_root)
			Result.append ("/api/downloads/channel/" + a_channel)
		end

	media_type: STRING
			-- Type of the representation of a resource.
			-- used in the interaction (client/server)
			-- A representation is selected through content negotiation with the Accept header
		do
			Result := "application/json"
		end

feature {NONE} -- Implementation

	json_configuration: ES_UPDATE_JSON_CONFIGURATION
			-- download configuration file

invariant

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
