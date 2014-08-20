note
	description: "Summary description for {ESA_ABSTRACT_API_TEST}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ABSTRACT_API_TEST

inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end

	ESA_HTTP_CLIENT_HELPER
		undefine
			default_create
		redefine
			context_executor
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
		end

	on_clean
			-- <Precursor>
		do
--			shutdown
		end

feature -- API Service

	esa_api_service: ESA_API_SERVICE
			-- Current API Service
		do
			Result := esa_config.api_service
		end

feature -- Security

	security: SECURITY_PROVIDER
		do
			create Result
		end

	is_server_prepared : BOOLEAN

feature -- Context Executor

	media_type: detachable STRING

	context_executor: HTTP_CLIENT_REQUEST_CONTEXT
		local
			l_ctx_factory: ESA_CONTEXT_FACTORY
		do
			create l_ctx_factory
			if attached media_type as l_media_type and then l_media_type.same_string("cj") then
				 Result := l_ctx_factory.cj_context_executor
			elseif attached media_type as l_media_type and then l_media_type.same_string("html") then
				Result := l_ctx_factory.text_context_executor
			else
				Result := l_ctx_factory.unknown_context_executor
			end

		end

	current_dir: STRING
		local
			l_path: PATH
			l_env: EXECUTION_ENVIRONMENT
		do
			Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("..")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("database")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
			Result.append ("mssql")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
		end

	server_name: STRING = "JVELILLA\SQLEXPRESS"
		-- Server Name.

	database_name: STRING = "EiffelDBIntegration"
		-- Database Name.

	schema : STRING = "eiffeldbintegration"
	 	-- Database schema.


	db_connection: DATABASE_CONNECTION
		do
			if attached esa_config as l_config then
				Result := l_config.database
			else
				check False then end
			end
		end


	esa_config: ESA_CONFIG
		do
			Result := (create {ESA_CONFIGURATION_FACTORY}).esa_config_test (Void)
		end

end
