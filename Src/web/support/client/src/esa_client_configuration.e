note
	description: "Provide access to configuration options."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CLIENT_CONFIGURATION

inherit

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Implemention

	make
		do
			create json_configuration.make (Execution_environment.current_working_path.extended ("esa_config.json"))
		end


	json_configuration: ESA_JSON_CONFIGURATION
			-- esa configuration file

feature -- Access

	connection_timeout: INTEGER
			-- Maximum time the request is allowed to take.
		do
			Result := json_configuration.connection_timeout.as_integer_32
		end

	service_root: STRING_8
			-- Root uri to drive the interaction.
		do
			Result := json_configuration.service_root
		end

	media_type: STRING
			-- Type of the representation of a resource.
			-- used in the interaction (client/server)
			-- A representation is selected through content negotiation with the Accept header
		do
			Result := "application/vnd.collection+json"
		end

end
