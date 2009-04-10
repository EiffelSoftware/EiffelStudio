note
	description: "[
		The {REQUEST} object contains all data from a user request.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XH_REQUEST

feature {NONE} -- Initialization

	make_empty
		do
			the_request := ""
			target_uri := ""
			request_message := ""
			create {HASH_TABLE [STRING, STRING]} arguments.make (1)
			create {HASH_TABLE [XH_COOKIE, STRING]} cookies.make (1)
			create {HASH_TABLE [STRING, STRING]} environment_vars.make (1)
			create {HASH_TABLE [STRING, STRING]} headers_out.make (1)
			create {HASH_TABLE [STRING, STRING]} headers_in.make (1)
		end

	make_goto_request (a_uri: STRING; a_previous_request: XH_REQUEST)
			-- Replaces the uri in the previous request and
		require
			a_uri_not_empty: not a_uri.is_empty
			a_previous_request_has_headers_in: a_previous_request.request_message.has_substring (Key_headers_in)
		local
			l_i: INTEGER
		do
			l_i := a_previous_request.request_message.substring_index (Key_headers_in, 1)
			make_from_message ("GET " + escape_bad_chars (a_uri) + " HTTP/1.1"
					 + a_previous_request.request_message.substring (l_i, a_previous_request.request_message.count))
		end

	make_from_message (a_message: STRING)
		-- Parses the string an fills attributes of the request object			
		require
			is_correct_arg: a_message.item (1).is_equal (method)
			has_args: a_message.has_substring (Key_arg)
			a_string_not_empty: not a_message.is_empty
			has_http: a_message.has_substring ("HTTP")
			has_headers_in: a_message.has_substring (Key_headers_in)
			has_headers_out: a_message.has_substring (Key_headers_out)
			has_subp_env: a_message.has_substring (Key_subp_env)

		local
			l_i: INTEGER
			l_s: STRING
		do
			request_message := a_message.twin
			l_s := a_message.twin

				-- Read the_request
			l_i := l_s.substring_index (Key_headers_in, 1)
			the_request := l_s.substring (1, l_i - 1 )
			l_s.remove_head (the_request.count)

				-- Read the uri
			target_uri := read_uri (the_request)

				-- Read headers_in				
			headers_in := parse_table (l_s, Key_headers_in, Key_t_key, Key_t_value, Key_t_end)
			l_s.remove_head (l_s.substring_index (Key_t_end, 1) + key_t_end.count-1)

				-- Read headers_out
			headers_out := parse_table (l_s, Key_headers_out, Key_t_key, Key_t_value, Key_t_end)
			l_s.remove_head (l_s.substring_index (Key_t_end, 1) + key_t_end.count-1)

				-- Read subp_env
			environment_vars := parse_table (l_s, Key_subp_env, Key_t_key, Key_t_value, Key_t_end)
			l_s.remove_head (l_s.substring_index (Key_t_end, 1) + key_t_end.count-1)

				-- Read POST/GET params
			arguments := parse_table (l_s, Key_arg, Key_p_key, Key_p_value, Key_t_end)

				-- Read cookies
			cookies := read_cookies (headers_in)
		ensure
			the_request_set: not the_request.is_empty
			target_uri_set: not target_uri.is_empty
		end

feature -- Constants

	Key_headers_in: STRING = "#HI#"
	Key_headers_out: STRING = "#HO#"
	Key_subp_env: STRING = "#SE#"
	Key_t_key: STRING = "#$#"
	Key_t_value: STRING = "#%%#"
	Key_p_key: STRING = "&"
	Key_p_value: STRING = "="
	Key_t_end: STRING = "#E#"
	Key_arg: STRING = "#A#"

	Headers_in_set_cookies: STRING = "Set-Cookie"
	Headers_in_cookie: STRING = "Cookie"
	Headers_eq: STRING = "="
	Headers_sq: STRING = ";"

feature {NONE} -- Access

feature -- Access

	the_request: STRING
			-- The actual request

	target_uri: STRING
			-- The target uri

	arguments: HASH_TABLE [STRING, STRING]
			-- The GET/POST parameters

	headers_in: HASH_TABLE [STRING, STRING]
			-- Headers_in as provided by the http server

	headers_out: HASH_TABLE [STRING, STRING]
			-- Headers_out as provided by the http server	

	environment_vars: HASH_TABLE [STRING, STRING]
			-- Subprocess environment variables as provided by the http server		

	cookies: TABLE [XH_COOKIE, STRING]
			-- Retrives cookies that are stored in the headers_in table.

	request_message: STRING
			-- The original message 	

	method: CHARACTER
			-- P for POST, G for GET
		do
			Result := 'X'
		end

feature -- Basic Operations

	get_cookie (a_name: STRING): detachable XH_COOKIE
			-- Returns true if there is a cookie with name=a_name in the list of cookies
		do
			Result := cookies [a_name]
		end

	has_cookie (a_name: STRING): BOOLEAN
			-- Is there a cookie with the specified `a_name'
		do
			Result := cookies.valid_key (a_name)
		end

	call_pre_handler (servlet: XWA_SERVLET; response: XH_RESPONSE)
			-- Calls the right pre_handler on the servlet
		deferred
		end

feature {NONE} -- Internal processing

	escape_bad_chars (a_s: STRING): STRING
			-- Check for bad characters
		do
			--TODO: complete, better mechanism
			Result := a_s.twin

			Result.replace_substring_all ("?", "#qu#")
			Result.replace_substring_all ("=", "#eq#")
			Result.replace_substring_all ("#", "#r#")

		end


	read_cookies (a_headers_in: HASH_TABLE [STRING, STRING]): TABLE [XH_COOKIE, STRING]
			-- Parses a hash_table and looks for cookies.
		local
			l_s: detachable STRING
			l_i: INTEGER
			l_name: STRING
			l_value: STRING
			l_has_more: BOOLEAN
		do
			create {HASH_TABLE [XH_COOKIE, STRING]} Result.make (10)
			if attached a_headers_in.item (Headers_in_cookie) as l_item then
				l_s := l_item
				from l_has_more := true until not l_has_more loop
					l_i := l_s.substring_index (Headers_eq, 1)
					l_name := l_s.substring (1, l_i - 1)
					l_s.remove_head (l_i - 1 + Headers_eq.count)
					if l_s.has_substring (Headers_sq) then
						l_has_more := True
						l_i := l_s.substring_index (Headers_sq, 1)
						l_value := l_s.substring (1, l_i - 1)
						l_s.remove_head (l_value.count + Headers_sq.count + 1)
					else
						l_has_more := False
						l_value := l_s.twin
					end
					Result.put (create {XH_COOKIE}.make (l_name, l_value), l_name)
				end
			end
		end

	parse_table (a_string: STRING; a_key_in: STRING; a_key_key: STRING; a_key_value: STRING
				 a_key_out: STRING): HASH_TABLE [STRING, STRING]
			-- Process string only from the first occurence of key_in until
			-- the first occurence of key_out. Extracts all pairs and writes
			-- them into Result
		require
			has_a_key_in: a_string.has_substring (a_key_in)
			has_a_key_out: a_string.has_substring (a_key_out)
			a_key_in_before_a_key_out: a_string.substring_index (a_key_in, 1) < a_string.substring_index (a_key_out, 1)
		local
			l_s: STRING
			l_i: INTEGER
			l_j: INTEGER
			l_key: STRING
			l_value: STRING
			l_has_more: BOOLEAN
		do
			create Result.make (8)

			l_i := a_string.substring_index (a_key_in, 1)
			l_j := a_string.substring_index (a_key_out, 1)
			l_s := a_string.substring (l_i + a_key_in.count , l_j - 1)

			if l_s.has_substring (a_key_key) and l_s.has_substring (a_key_value) then
				from
					l_has_more := true
				until
					not l_has_more
				loop
						-- Read the headers_in table
					l_i := l_s.substring_index (a_key_key, 1)
					l_j := l_s.substring_index (a_key_value, 1)
					l_key := l_s.substring (l_i + a_key_key.count , l_j-1)
					l_s.remove_head (a_key_key.count)
					l_j := l_j - a_key_key.count
					if l_s.has_substring (a_key_key) then
							-- There is another key value pair
						l_i := l_s.substring_index (a_key_key, 1)
						l_value := l_s.substring (l_j + a_key_value.count, l_i-1)
						l_has_more := true
					else
							-- It was the last one
						l_s.remove_head (l_key.count + a_key_value.count)
						l_value := l_s.twin
						l_has_more := false
					end

					l_s.remove_head (l_i - 1)
					Result.put (l_value.twin, l_key.twin)
				end
			end
		ensure
			result_not_void: attached Result
		end

	read_uri (a_the_request: STRING): STRING
				-- Reads the uri from a the_request
		require
			is_http_request: a_the_request.has_substring ("HTTP")
			has_valid_method: a_the_request.item (1).is_equal (method)
		deferred
		ensure
			result_not_empty: not Result.is_empty
		end
end
