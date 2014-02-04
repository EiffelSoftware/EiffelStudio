note
	description: "HTTP request parser (should be in Nino)."
	author: "Olivier Ligot"

class
	HTTP_REQUEST_PARSER

create
	make

feature {NONE} -- Initialization

	make
			-- Create the parser.
		do
			reset
		end

	reset
			-- Reset the parser
		do
			create last_string.make_empty
			create header.make_empty
			create header_map.make (10)
			create method.make_empty
			create uri.make_empty
			has_error := False
		end

feature -- Access

	header: STRING
			-- Header' source

	header_map: HASH_TABLE [STRING, STRING]
			-- Contains key:value of the header

	method: STRING
			-- HTTP verb

	uri: STRING
			--  HTTP endpoint		

	version: detachable STRING
			--  HTTP version


	last_string: STRING
			-- Last string from read_stream		

feature -- Status report

	has_error: BOOLEAN
			-- Error occurred during `parse'

	is_verbose: BOOLEAN
			-- Is verbose for output messages

feature -- Element change

	enable_verbose
			-- Enable version bose.
		do
			is_verbose := True
		ensure
			verbose: is_verbose
		end

feature -- Basic operations

	parse (a_socket: SSL_NETWORK_STREAM_SOCKET)
			-- Parse the HTTP request using `a_socket'.
        require
            input_readable: a_socket /= Void and then a_socket.is_open_read
        local
        	end_of_stream: BOOLEAN
        	pos, n: INTEGER
        	line: detachable STRING
			k, val: STRING
        	txt: STRING
        do
        	reset
            create txt.make (64)
			header := txt

			if attached next_line (a_socket) as l_request_line and then not l_request_line.is_empty then
				txt.append (l_request_line)
				txt.append_character ('%N')
				analyze_request_line (l_request_line)
			else
				has_error := True
			end

			if not has_error or is_verbose then
					-- if `is_verbose' we can try to print the request, even if it is a bad HTTP request
				from
					line := next_line (a_socket)
				until
					line = Void or end_of_stream
				loop
					n := line.count
					if is_verbose then
						log (line)
					end
					pos := line.index_of (':',1)
					if pos > 0 then
						k := line.substring (1, pos-1)
						if line [pos+1].is_space then
							pos := pos + 1
						end
						if line [n] = '%R' then
							n := n - 1
						end
						val := line.substring (pos + 1, n)
						header_map.put (val, k)
					end
					txt.append (line)
					txt.append_character ('%N')
					if line.is_empty or else line [1] = '%R' then
						end_of_stream := True
					else
						line := next_line (a_socket)
					end
				end
			end
		end

feature -- Read Message

	read_response (a_length: INTEGER; a_socket: SSL_NETWORK_STREAM_SOCKET )
		require
            input_readable: a_socket /= Void and then a_socket.is_open_read
    	local
    		l_index : INTEGER
    	do
    		from
    			a_socket.read_character
    			last_string.append_character (a_socket.last_character)
				l_index := 1
			until
				l_index = a_length
			loop
				a_socket.read_character
    			last_string.append_character (a_socket.last_character)
    			l_index := l_index + 1
			end
		end

feature {NONE} -- Implementation

	analyze_request_line (line: STRING)
			-- Analyze `line' as a HTTP request line
		require
			valid_line: line /= Void and then not line.is_empty
		local
			pos, next_pos: INTEGER
		do
			if is_verbose then
				log ("%N## Parse HTTP request line ##")
				log (line)
			end
			pos := line.index_of (' ', 1)
			method := line.substring (1, pos - 1)
			next_pos := line.index_of (' ', pos + 1)
			uri := line.substring (pos + 1, next_pos - 1)
			version := line.substring (next_pos + 1, line.count)
			has_error := method.is_empty
		end

	next_line (a_socket: SSL_NETWORK_STREAM_SOCKET): detachable STRING
			-- Next line fetched from `a_socket' is available.
		require
			is_readable: a_socket.is_open_read
		do
			if a_socket.socket_ok then
				a_socket.read_line_thread_aware
				Result := a_socket.last_string
			end
		end

	log (a_message: READABLE_STRING_8)
			-- Log `a_message'
		do
			io.put_string (a_message)
			io.put_new_line
		end

end
