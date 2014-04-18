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
	ESA_SERVER_TEST
		undefine
			default_create
		redefine
			context_executor
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		local
			l_rest: ESA_RESET_DB
			l_list: ARRAYED_LIST[READABLE_STRING_GENERAL]
			l_old_dir : STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create l_env
			l_old_dir := l_env.current_working_directory
		    l_env.change_working_directory (current_dir)
			create l_rest
			create l_list.make_from_array (<<server_name, database_name, schema>>)
			l_rest.reset_db (l_list, False, Void)
			assert ("not_has_error", not l_rest.has_error)
			l_env.change_working_directory (l_old_dir)

			make_and_launch
		end

	on_clean
			-- <Precursor>
		do
			shutdown
		end

feature -- API Service

	esa_api_service: ESA_API_SERVICE
			-- Current API Service
		do
			Result := esa_config.api_service
		end

feature -- Security

	security: ESA_SECURITY_PROVIDER
		do
			create Result
		end

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

end
