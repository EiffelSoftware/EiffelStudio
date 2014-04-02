note
	description: "Summary description for {ESA_ROOT_API_TEST}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ROOT_API_TEST

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
		do
			 make_and_launch
		end

	on_clean
			-- <Precursor>
		do
			shutdown
		end

feature -- Test


	test_home_unnaceptable
			-- New test routine
		do
			if attached execute_get ("") as l_resp then
				assert("Expected status 406", l_resp.status = 406)
			end
		end

	test_home_accept_html
			-- New test routine
		do
			media_type := "html"
			if attached execute_get ("") as l_resp then
				assert("Expected status 200", l_resp.status = 200)
				if attached l_resp.header ("Content-Type") as l_type then
					assert("Expected Content-Type text/html", l_type.same_string ("text/html"))
				end

			end
		end

	test_home_accept_cj
			-- New test routine
		do
			media_type := "cj"
			if attached {HTTP_CLIENT_RESPONSE} execute_get ("") as l_resp then
				assert("Expected status 200", l_resp.status = 200)
				if attached l_resp.header ("Content-Type") as l_type then
					assert("Expected Content-Type application/vnd.collection+json", l_type.same_string ("application/vnd.collection+json"))
				end
			end
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
