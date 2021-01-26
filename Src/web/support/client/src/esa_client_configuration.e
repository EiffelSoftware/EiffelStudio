note
	description: "Provide access to configuration options."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CLIENT_CONFIGURATION

inherit
	SHARED_EXECUTION_ENVIRONMENT

create
	make,
	make_with_config

feature {NONE} -- Implemention

	make (a_uri: READABLE_STRING_8)
			-- Create a Client configuration with
			-- service uri set to `a_uri' and default
			-- timeout.
		require
			not_null: a_uri /= Void
			not_empty: not a_uri.is_empty
		do
			implementation_service_root := a_uri
			config_mode := False
		ensure
			connection_timeout_set: connection_timeout = default_timeout
			service_root_set: service_root.same_string (a_uri)
		end

	make_with_config
			-- Create client configuration from JSON config file.
		local
			cfg: like json_configuration
		do
			config_mode := True

			create cfg.make (Execution_environment.current_working_path.extended ("esa_config.json"))
			implementation_service_root := cfg.service_root
			json_configuration := cfg
		end

	json_configuration: detachable ESA_JSON_CONFIGURATION
			-- esa configuration file

feature -- Access

	connection_timeout: INTEGER
			-- Maximum time the request is allowed to take.
		do
			if config_mode and then attached json_configuration as cfg then
				Result := cfg.connection_timeout.as_integer_32
			else
				Result := Default_timeout
			end
		end

	service_root: READABLE_STRING_8
			-- Root uri to drive the interaction.
		do
			if config_mode and then attached json_configuration as cfg then
				Result := cfg.service_root
			else
				Result := implementation_service_root
			end
		end

	media_type: READABLE_STRING_8
			-- Type of the representation of a resource.
			-- used in the interaction (client/server)
			-- A representation is selected through content negotiation with the Accept header
		do
			Result := "application/vnd.collection+json"
		end

feature {NONE} -- Implementation

	implementation_service_root: READABLE_STRING_8
			-- Root uri to drive the interaction.

	default_timeout: INTEGER = 30
			-- Default time the request is allowed to take.

	config_mode: BOOLEAN
			-- Is setup based on config file or via API?		
end
