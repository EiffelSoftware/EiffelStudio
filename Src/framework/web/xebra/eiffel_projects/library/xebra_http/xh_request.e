note
	description: "[
		The {REQUEST} object contains all data from a user request.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_REQUEST

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Creates an empty request
		do
		--	the_request := ""
			uri := ""
			method := ""
			request_message := ""


			create {HASH_TABLE [STRING, STRING]} environment_vars.make (1)
			create {HASH_TABLE [STRING, STRING]} headers_out.make (1)
			create {HASH_TABLE [STRING, STRING]} headers_in.make (1)
		ensure
			method_attached: method /= Void
		--	the_request_attached: the_request /= Void
			uri_attached: uri /= Void
			request_message_attached: request_message /= Void
			environment_vars_attached: environment_vars /= Void
		end



--	make_goto_request (a_uri: STRING; a_previous_request: XH_REQUEST)
--			-- Replaces the uri in the previous request and
--		require
--			not_a_uri_is_detached_or_empty: a_uri /= Void and then not a_uri.is_empty
--			a_previous_request_has_headers_in: a_previous_request /= Void and then a_previous_request.request_message.has_substring (Key_headers_in)
--		local
--			l_i: INTEGER
--		do
--			make_empty
--			l_i := a_previous_request.request_message.substring_index (Key_headers_in, 1)
--			make_from_message ("GET " + escape_bad_chars (a_uri) + " HTTP/1.1"
--					 + a_previous_request.request_message.substring (l_i, a_previous_request.request_message.count))
--		ensure
--			the_request_attached: the_request /= Void
--			target_uri_attached: target_uri /= Void
--			request_message_attached: request_message /= Void
--			arguments_attached: arguments /= Void
--			cookies_attached: cookies/= Void
--			environment_vars_attached: environment_vars /= Void
--			arguments_attached: arguments /= Void
--	--		content_type_attached: content_type /= Void
--		end

--	make_from_message (a_message: STRING)
--		-- Parses the string an fills attributes of the request object			
--		require
--			not_a_message_is_detached_or_empty: a_message /= Void and then not a_message.is_empty
--			is_correct_arg: a_message.item (1).is_equal (method)
--			has_args: a_message.has_substring (Key_arg)
--			a_string_not_empty: not a_message.is_empty
--			has_http: a_message.has_substring ("HTTP")
--			has_headers_in: a_message.has_substring (Key_headers_in)
--			has_headers_out: a_message.has_substring (Key_headers_out)
--			has_subp_env: a_message.has_substring (Key_subp_env)

--		local
--			l_i: INTEGER
--			l_s: STRING
--		do
--			make_empty
--			request_message := a_message.twin
--			l_s := a_message.twin

--				-- Read the_request
--			l_i := l_s.substring_index (Key_headers_in, 1)
--			the_request := l_s.substring (1, l_i - 1 )
--			l_s.remove_head (the_request.count)

--				-- Read the uri
--			target_uri := read_uri (the_request)

--				-- Read headers_in				
--			headers_in := parse_table (l_s, Key_headers_in, Key_t_key, Key_t_value, Key_t_end)
--			l_s.remove_head (l_s.substring_index (Key_t_end, 1) + key_t_end.count-1)

--				-- Read headers_out
--			headers_out := parse_table (l_s, Key_headers_out, Key_t_key, Key_t_value, Key_t_end)
--			l_s.remove_head (l_s.substring_index (Key_t_end, 1) + key_t_end.count-1)

--				-- Read subp_env
--			environment_vars := parse_table (l_s, Key_subp_env, Key_t_key, Key_t_value, Key_t_end)
--			l_s.remove_head (l_s.substring_index (Key_t_end, 1) + key_t_end.count-1)

--				-- Read arguments
----			content_type := ""
--			create arguments.make (1)
--			read_arguments (l_s)

--				-- Read cookies
--			cookies := read_cookies (headers_in)
--		ensure
--			the_request_attached: the_request /= Void and then not the_request.is_empty
--			target_uri_attached: target_uri /= Void and then not target_uri.is_empty
--			request_message_attached: request_message /= Void
--			arguments_attached: arguments /= Void
--			cookies_attached: cookies/= Void
--			environment_vars_attached: environment_vars /= Void
--			arguments_attached: arguments /= Void
--			arguments_attached: arguments /= Void
--	--		content_type_attached: content_type /= Void
--		end

feature -- Constants

--	Key_headers_in: STRING = "#HI#"
--	Key_headers_out: STRING = "#HO#"
--	Key_subp_env: STRING = "#SE#"
--	Key_t_key: STRING = "#$#"
--	Key_t_value: STRING = "#%%#"
--	Key_p_key: STRING = "&"
--	Key_p_value: STRING = "="
--	Key_t_end: STRING = "#E#"
--	Key_arg: STRING = "#A#"
----	Key_content_type_start: STRING = "#CT#"
----	Key_content_type_end: STRING = "#CTE#"


--	Content_type_form_urlencoded: STRING = "application/x-www-form-urlencoded"

--	Headers_in_set_cookies: STRING = "Set-Cookie"
--	Headers_in_cookie: STRING = "Cookie"
--	Headers_eq: STRING = "="
--	Headers_sq: STRING = ";"

	Method_post: STRING = "POST"
	Method_get: STRING = "GET"


feature {NONE} -- Access

feature -- Access

--	content_type: STRING
			-- The content type of the post data

--	the_request: STRING
			-- The actual request

	request_message: STRING
			-- The original request message

	method: STRING
			-- The method of the request, POST or GET

	uri: STRING
			-- The target uri

	headers_in: HASH_TABLE [STRING, STRING]
			-- Headers_in as provided by the http server

	headers_out: HASH_TABLE [STRING, STRING]
			-- Headers_out as provided by the http server	

	environment_vars: HASH_TABLE [STRING, STRING]
			-- Subprocess environment variables as provided by the http server		

	args: STRING
			-- The post or get arguments (as string)


	cookies: HASH_TABLE [XH_COOKIE, STRING]
			-- Retrives cookies that are stored in the headers_in table.
		local
			l_parser: XH_REQUEST_COOKIE_PARSER
		once
				-- Read the cookies
			create Result.make (1)
			if attached {STRING} headers_in ["Cookie"] as l_cookies_string then
				create l_parser.make
				if attached {like cookies} l_parser.cookie_table (l_cookies_string) as l_cookies then
					Result := l_cookies
				end

			end
		ensure
			result_attached: Result /= Void
		end

	argument_table: HASH_TABLE [STRING, STRING]
			-- Retrives arguments as table.
		local
			l_parser: XH_REQUEST_ARG_TABLE_PARSER
		once
			create Result.make (1)
			if (method.is_equal (Method_get) or is_form_encoded) and not args.is_empty then
				create l_parser.make
				if attached {like argument_table} l_parser.argument_table (args) as l_arg_table then
					Result := l_arg_table
				end
			end
		ensure
			result_attached: Result /= Void
		end


feature -- Status setting

	set_target_uri (a_target_uri: like uri)
			-- Sets the target uri.
		require
			not_a_target_uri_is_detached_or_empty: a_target_uri /= Void and then not a_target_uri.is_empty
		do
			uri := a_target_uri
		ensure
			target_uri_set: equal (uri, a_target_uri)
		end

	set_headers_in (a_headers_in: like headers_in)
			-- Sets the headers_in.
		require
			a_headers_attached: a_headers_in /= Void
		do
			headers_in := a_headers_in
		ensure
			headers_in_set: equal (headers_in, a_headers_in)
		end

	set_headers_out (a_headers_out: like headers_out)
			-- Sets the headers_out.
		require
			a_headers_attached: a_headers_out /= Void
		do
			headers_out := a_headers_out
		ensure
			headers_out_set: equal (headers_out, a_headers_out)
		end

	set_environment_vars (a_environment_vars: like environment_vars)
			-- Sets the environment_vars.
		require
			a_environment_vars_attached: a_environment_vars /= Void
		do
			environment_vars := a_environment_vars
		ensure
			environment_vars_set: equal (environment_vars, a_environment_vars)
		end

	set_args (a_args: like args)
			-- Sets args.
		require
			a_args_attached: a_args /= Void
		do
			args := a_args
		ensure
			args_set: equal (args, a_args)
		end

	set_method (a_method: like method)
			-- Sets method.
		require
			a_method_attached: a_method /= Void
		do
			method := a_method
		ensure
			method_set: equal (method, a_method)
		end

	set_request_message (a_request_message: like request_message)
			-- Sets request_message.
		require
			a_request_message_attached: a_request_message /= Void
		do
			request_message := a_request_message
		ensure
			request_message_set: equal (request_message, a_request_message)
		end


feature -- Basic Operations

--	get_cookie (a_name: STRING): detachable XH_COOKIE
--			-- Returns true if there is a cookie with name=a_name in the list of cookies
--		do
--			Result := cookies [a_name]
--		end

--	has_cookie (a_name: STRING): BOOLEAN
--			-- Is there a cookie with the specified `a_name'
--		do
--			Result := cookies.valid_key (a_name)
--		end

	call_pre_handler (a_form_handler: XH_FORM_HANDLER; a_response: XH_RESPONSE)
			-- Calls the right pre_handler on the servlet
		require
			a_form_handler_attached: a_form_handler /= Void
			a_response_attached: a_response /= Void
		do
			if method.is_equal (Method_post) then
				a_form_handler.handle_form (Current, a_response)
			end
		end

feature {NONE} -- Internal processing

--	escape_bad_chars (a_s: STRING): STRING
--			-- Check for bad characters
--		require
--			not_a_s_is_detached_or_not_empty: a_s /= Void implies not a_s.is_empty
--		do
--			--TODO: complete, better mechanism
--			Result := a_s.twin

--			Result.replace_substring_all ("?", "#qu#")
--			Result.replace_substring_all ("=", "#eq#")
--			Result.replace_substring_all ("#", "#r#")
--		ensure
--			Result_attached: Result /= Void
--		end


--	read_cookies (a_headers_in: HASH_TABLE [STRING, STRING]): HASH_TABLE [XH_COOKIE, STRING]
--			-- Parses a hash_table and looks for cookies.
--		require
--			a_headers_in_attached: a_headers_in /= Void
--		local
--			l_s: detachable STRING
--			l_i: INTEGER
--			l_name: STRING
--			l_value: STRING
--			l_has_more: BOOLEAN
--		do
--			create {HASH_TABLE [XH_COOKIE, STRING]} Result.make (1)
--			if attached a_headers_in.item (Headers_in_cookie) as l_item then
--				l_s := l_item
--				from l_has_more := true until not l_has_more loop
--					l_i := l_s.substring_index (Headers_eq, 1)
--					l_name := l_s.substring (1, l_i - 1)
--					l_s.remove_head (l_i - 1 + Headers_eq.count)
--					if l_s.has_substring (Headers_sq) then
--						l_has_more := True
--						l_i := l_s.substring_index (Headers_sq, 1)
--						l_value := l_s.substring (1, l_i - 1)
--						l_s.remove_head (l_value.count + Headers_sq.count + 1)
--					else
--						l_has_more := False
--						l_value := l_s.twin
--					end
--					Result.put (create {XH_COOKIE}.make (l_name, l_value), l_name)
--				end
--			end
--		ensure
--			Result_attached: Result /= Void
--		end

--	parse_table (a_string: STRING; a_key_in: STRING; a_key_key: STRING; a_key_value: STRING
--				 a_key_out: STRING): HASH_TABLE [STRING, STRING]
--			-- Process string only from the first occurence of key_in until
--			-- the first occurence of key_out. Extracts all pairs and writes
--			-- them into Result
--		require
--			not_a_string_is_detached_or_empty: a_string /= Void and then not a_string.is_empty
--			not_a_key_in_is_detached_or_empty: a_key_in /= Void and then not a_key_in.is_empty
--			not_a_key_key_is_detached_or_empty: a_key_key /= Void and then not a_key_key.is_empty
--			not_a_key_value_is_detached_or_empty: a_key_value /= Void and then not a_key_value.is_empty
--			not_a_key_out_is_detached_or_empty: a_key_out /= Void and then not a_key_out.is_empty
--			has_a_key_in: a_string.has_substring (a_key_in)
--			has_a_key_out: a_string.has_substring (a_key_out)
--			a_key_in_before_a_key_out: a_string.substring_index (a_key_in, 1) < a_string.substring_index (a_key_out, 1)
--		local
--			l_s: STRING
--			l_i: INTEGER
--			l_j: INTEGER
--			l_key: STRING
--			l_value: STRING
--			l_has_more: BOOLEAN
--		do
--			create Result.make (8)

--			l_i := a_string.substring_index (a_key_in, 1)
--			l_j := a_string.substring_index (a_key_out, 1)
--			l_s := a_string.substring (l_i + a_key_in.count , l_j - 1)

--			if l_s.has_substring (a_key_key) and l_s.has_substring (a_key_value) then
--				from
--					l_has_more := true
--				until
--					not l_has_more
--				loop
--						-- Read the headers_in table
--					l_i := l_s.substring_index (a_key_key, 1)
--					l_j := l_s.substring_index (a_key_value, 1)
--					l_key := l_s.substring (l_i + a_key_key.count , l_j-1)
--					l_s.remove_head (a_key_key.count)
--					l_j := l_j - a_key_key.count
--					if l_s.has_substring (a_key_key) then
--							-- There is another key value pair
--						l_i := l_s.substring_index (a_key_key, 1)
--						l_value := l_s.substring (l_j + a_key_value.count, l_i-1)
--						l_has_more := true
--					else
--							-- It was the last one
--						l_s.remove_head (l_key.count + a_key_value.count)
--						l_value := l_s.twin
--						l_has_more := false
--					end

--					l_s.remove_head (l_i - 1)
--					Result.put (l_value.twin, l_key.twin)
--				end
--			end
--		ensure
--			result_not_void: attached Result
--		end

	is_form_encoded: BOOLEAN
			-- Checks if the headers_in contain 'application/x-www-form-urlencoded'
		do
			Result := False
			if attached {STRING} headers_in ["Content-Type"] as l_ct then
				if l_ct.is_equal ("application/x-www-form-urlencoded") then
					Result := True
				end
			end
		end

--	read_uri (a_the_request: STRING): STRING
--				-- Reads the uri from a the_request
--		require
--			not_a_the_request_is_detached_or_empty: a_the_request /= Void and then not a_the_request.is_empty
--			is_http_request: a_the_request.has_substring ("HTTP")
--			has_valid_method: a_the_request.item (1).is_equal (method)
--		deferred
--		ensure
--			not_Result_is_detached_or_empty: Result /= Void and then not Result.is_empty
--		end

invariant
		--	the_request_attached: the_request /= Void
			target_uri_attached: uri /= Void
			request_message_attached: request_message /= Void
			environment_vars_attached: environment_vars /= Void
			method_attached: method /= Void
			valid_method: (method /= Void and then not method.is_empty) implies (method.is_equal (Method_get) or method.is_equal (Method_post))
end
