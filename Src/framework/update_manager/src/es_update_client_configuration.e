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
			implementation_service_root := cfg.service_root
			json_configuration := cfg
		ensure
			connection_timeout_set: connection_timeout = default_timeout
			service_root_set: service_root.same_string (a_uri)
		end

	make_with_config
			-- Create client configuration from JSON config file.
		local
			cfg: like json_configuration
		do

			create cfg.make (Execution_environment.current_working_path.extended ("eiffel_download_config.json"))
			implementation_service_root := cfg.service_root
			json_configuration := cfg
		end

	json_configuration: detachable ES_UPDATE_JSON_CONFIGURATION
			-- download configuration file

feature -- Access

	connection_timeout: INTEGER
			-- Maximum time the request is allowed to take.
		do
			Result := if attached json_configuration as cfg then cfg.connection_timeout.as_integer_32 else Default_timeout end
		end

	service_root: STRING_8
			-- Root uri to drive the interaction.
		do
			Result := if attached json_configuration as cfg then cfg.service_root else {ES_UPDATE_CONSTANTS}.update_service_url end
		end

	media_type: STRING
			-- Type of the representation of a resource.
			-- used in the interaction (client/server)
			-- A representation is selected through content negotiation with the Accept header
		do
			Result := "application/json"
		end

feature {NONE} -- Implementation

	implementation_service_root: STRING
			-- Root uri to drive the interaction.

	default_timeout: INTEGER = 30
			-- Default time the request is allowed to take.

end
