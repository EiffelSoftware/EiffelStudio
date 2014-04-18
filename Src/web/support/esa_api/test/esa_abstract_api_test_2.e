note
	description: "Summary description for {ESA_ABSTRACT_API_TEST_2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ABSTRACT_API_TEST_2
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
			l_clean: ESA_CLEAN_DB
			e: EXECUTION_ENVIRONMENT
		do
			make_and_launch
			create l_clean
			l_clean.clean_db (db_connection)
			create e
			e.sleep (1_000_000_000 * 2)
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

end
