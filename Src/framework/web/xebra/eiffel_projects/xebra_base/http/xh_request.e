note
	description: "[
		The {REQUEST} object contains all data from a user request.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_REQUEST

create
	make_from_string

feature {NONE} -- Initialization

	make_from_string (a_string: STRING)
		-- Parses the string an fills attributes of the request object			
		require
			a_string_not_empty: not a_string.is_empty
			is_post_or_get: a_string.item (1).is_equal (Method_post) or a_string.item (1).is_equal (Method_get)
			has_http: a_string.has_substring ("HTTP")
			has_headers_in: a_string.has_substring (Key_headers_in)
			has_headers_out: a_string.has_substring (Key_headers_out)
			has_subp_env: a_string.has_substring (Key_subp_env)
			has_post: a_string.item (1).is_equal (Method_post) implies a_string.has_substring (Key_post_params)
			has_get: a_string.item (1).is_equal (Method_get) implies a_string.has_substring (Key_get_params)
		local
			l_s: STRING
			l_i: INTEGER
		do
			l_s := a_string.twin
				-- Read method
			method := l_s.item (1)

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
			if method.is_equal (Method_post) then
				post_parameters := parse_table (l_s, Key_post_params, Key_p_key, Key_p_value, Key_t_end)
			else
				get_parameters :=  parse_table (l_s, Key_get_params, Key_p_key, Key_p_value, Key_t_end)
			end

				-- Read cookies
			cookies := read_cookies (headers_in)
		ensure
			method_set: method.is_equal (Method_post) or method.is_equal (Method_get)
			post_set: method.is_equal (Method_post) implies attached post_parameters
			post_set: method.is_equal (Method_get) implies attached get_parameters
			the_request_set: not the_request.is_empty
			target_uri_set: not target_uri.is_empty
		end

feature {NONE} -- Constants

	Key_post_params: STRING = "#P#"
	Key_get_params: STRING = "#G#"
	Key_headers_in: STRING = "#HI#"
	Key_headers_out: STRING = "#HO#"
	Key_subp_env: STRING = "#SE#"
	Key_t_key: STRING = "#$#"
	Key_t_value: STRING = "#%%#"
	Key_p_key: STRING = "&"
	Key_p_value: STRING = "="
	Key_t_end: STRING = "#E#"

	Method_post: CHARACTER = 'P'
	Method_get: CHARACTER = 'G'

	Headers_in_set_cookies: STRING = "Set-Cookie"
	Headers_in_cookie: STRING = "Cookie"
	Headers_eq: STRING = "="
	Headers_sq: STRING = ";"

feature -- Access

	the_request: STRING
			-- The actual request

	target_uri: STRING
			-- The target uri

	method: CHARACTER
			-- P for POST, G for GET		

	get_parameters: detachable HASH_TABLE [STRING, STRING]
			-- The GET parameters

	post_parameters: detachable HASH_TABLE [STRING, STRING]
			-- The POST parameters

	headers_in: HASH_TABLE [STRING, STRING]
			-- Headers_in as provided by the http server

	headers_out: HASH_TABLE [STRING, STRING]
			-- Headers_out as provided by the http server	

	environment_vars: HASH_TABLE [STRING, STRING]
			-- Subprocess environment variables as provided by the http server		

	cookies: LINKED_LIST [XH_COOKIE]
			-- Retrives cookies that are stored in the headers_in table.

feature -- Basic Operations

	get_cookie (a_name: STRING): detachable XH_COOKIE
			-- Returns true if there is a cookie with name=a_name in the list of cookies
		do
			from
				cookies.start
			until
				cookies.after
			loop
				if cookies.item_for_iteration.name.is_equal (a_name) then
					Result := cookies.item_for_iteration
				end
				cookies.forth
			end
		end

feature {NONE} -- Internal processing

	read_cookies (a_headers_in: HASH_TABLE [STRING, STRING]): LINKED_LIST [XH_COOKIE]
			-- Parses a hash_table and looks for cookies.
		local
			l_s: detachable STRING
			l_i: INTEGER
			l_name: STRING
			l_value: STRING
			l_has_more: BOOLEAN
		do
			create Result.make
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
						l_s.remove_head (l_value.count + Headers_sq.count +1 )
					else
						l_has_more := False
						l_value := l_s.twin
					end
					Result.put_right (create {XH_COOKIE}.make (l_name, l_value))
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
					l_has_more = false
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
			is_post_or_get: a_the_request.item (1).is_equal (Method_post) or   a_the_request.item (1).is_equal (Method_get)
			is_http_request: a_the_request.has_substring ("HTTP")
		local
			l_i: INTEGER
		do
			Result := ""

			if a_the_request.item (1).is_equal (Method_post) then
				l_i := a_the_request.substring_index ("HTTP",1)
				Result := a_the_request.substring (6, l_i-2)
			elseif a_the_request.item (1).is_equal (Method_get) then
				if a_the_request.has_substring ("?") then
					l_i := a_the_request.substring_index ("?",1)
					Result := a_the_request.substring (5, l_i-1)
				else
					l_i := a_the_request.substring_index ("HTTP",1)
					Result := a_the_request.substring (5, l_i-2)
				end

			end
		ensure
			result_not_empty: not Result.is_empty
		end

	invariant
		post_or_get_attached: attached post_parameters or attached get_parameters
end
