note
	description: "[
		The {REQUEST} object contains all data from a user request.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	REQUEST

create
	make_from_string

feature {NONE} -- Initialization

	make_from_string (a_string: STRING)
			-- Parses the string an creates this request object
		do
				file_identifier := ""
				the_request := ""
				create get_parameters.make(1)
				create post_parameters.make(1)
				create headers_in.make (1)
				parse_string(a_string)
		end

feature -- Processing



	parse_table (a_string: STRING; a_key_in: STRING; a_key_out: STRING): HASH_TABLE [STRING, STRING]
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
			l_method: STRING
		do
			create Result.make (12)

			l_i := a_string.substring_index (a_key_in, 1)
			l_j := a_string.substring_index (a_key_out, 1)
			l_s := a_string.substring (l_i + a_key_in.count , l_j - 1 - a_key_out.count)

			from
				l_has_more := true
			until
				l_has_more = false
			loop
					-- Read the headers_in table
				l_i := l_s.substring_index (Key_t_key, 1)
				l_j := l_s.substring_index (Key_t_value, 1)
				l_key := l_s.substring (l_i + Key_t_key.count , l_j-1)
				l_s.remove_head (Key_t_key.count)
				l_j := l_j - Key_t_key.count
				if l_s.has_substring (Key_t_key) then
						-- There is another key value pair
					l_i := l_s.substring_index (Key_t_key, 1)
					l_value := l_s.substring (l_j + Key_t_value.count, l_i-1)
					l_has_more := true
				else
						-- It was the last one
					l_s.remove_head (l_key.count + Key_t_value.count)
					l_value := l_s.twin
					l_has_more := false
				end

				l_s.remove_head (l_i - 1)
				Result.put (l_value.twin, l_key.twin)
			end
		end

	parse_string (a_string: STRING)
			-- Parses the string an fills attributes of the request object			
		local
			l_s: STRING
			l_i: INTEGER
			l_j: INTEGER
			l_key: STRING
			l_value: STRING
			l_has_more: BOOLEAN
			l_method: STRING
		do
			l_s := a_string.twin
				-- Read method
			l_method := l_s.substring (1, 2)

			if l_s.has_substring (Key_headers_in) then

					-- Read the_request
				l_i := l_s.substring_index (Key_headers_in, 1)
				the_request := l_s.substring (1, l_i - 1 )
				l_s.remove_head (the_request.count)

					-- Read headers_in					
				headers_in := parse_table (l_s, Key_headers_in, Key_t_end)

					-- Read headers_out

					-- Read subp_env

					-- Read POST/GET params

			end

		end


--	make (a_file_identifier: STRING; a_session: SESSION)
--			--`a_file_identifier': Identifies the identifier of the requested web application
--		do
--			file_identifier := a_file_identifier
--			session := a_session
--			create headers_in.make (1)
--		end

feature -- Constants

	Key_post_params: STRING = "#POST#"
	Key_get_params: STRING = "#GET#"
	Key_headers_in: STRING = "#HEADERS_IN#"
	Key_headers_out: STRING = "#HEADERS_OUT#"
	Key_subp_env: STRING = "#SUBP_ENV#"
	Key_t_key: STRING = "#$#"
	Key_t_value: STRING = "#%%#"
	Key_t_end: STRING = "#TEND#"

feature -- Access

	file_identifier: STRING
			-- Identifies the identifier of the requested web application

--	session: SESSION
			-- The session associated with this request

	the_request: STRING
			-- The actual request

	get_parameters: HASH_TABLE [STRING, STRING]
			-- The GET parameters

	post_parameters: HASH_TABLE [STRING, STRING]
			-- The POST parameters

	headers_in: HASH_TABLE [STRING, STRING]
			-- Headers_in as provided by the http server
end
