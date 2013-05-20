deferred class HTTP_REQUEST_HANDLER

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create request_uri.make_empty
			create script_name.make_empty
			create query_string.make_empty
			create answer
			create headers.make (0)
		end

feature -- Access

	request_uri: STRING
			-- requested url

	script_name: STRING
			-- Script name

	query_string: STRING
			-- Query string	

	data: detachable STRING
			-- the entire request message

	headers : HASH_TABLE [STRING, STRING]
		-- Provides access to the request's HTTP headers, for example:
		-- headers["Content-Type"] is "text/plain"

	answer: HTTP_RESPONSE
			-- reply to this request

feature -- Execution

	process
			-- process the request and create an answer
		require
			valid_uri: request_uri /= Void
		deferred
		end

feature -- Recycle

	reset
			-- reinit the fields
		do
			request_uri.wipe_out
			script_name.wipe_out
			query_string.wipe_out
			data := Void
			answer.reset
		end

feature -- Element change

	set_uri (new_uri: STRING)
			-- set new URI
		require
			valid_uri: new_uri /= Void
		local
			p: INTEGER
		do
			request_uri := new_uri
			p := new_uri.index_of ('?', 1)
			if p > 0 then
				script_name := new_uri.substring (1, p - 1)
				query_string := new_uri.substring (p + 1, new_uri.count)
			else
				script_name := new_uri.string
				query_string := ""
			end
		end

	set_data (new_data: STRING)
			-- set new data
		do
			data := new_data
		end

	set_headers ( a_header : HASH_TABLE [STRING, STRING] )
		do
			headers := a_header
		end

feature {NONE} -- Implementation

	real_filename (fn: STRING): STRING
			-- Real filename from url-path `fn'
			--| Find a better design for this piece of code
			--| Eventually in a spec/$ISE_PLATFORM/ specific cluster
		do
			if {PLATFORM}.is_windows then
				create Result.make_from_string (fn)
				Result.replace_substring_all ("/", "\")
				if Result[Result.count] = '\' then
					Result.remove_tail (1)
				end
			else
				Result := fn
				if Result[Result.count] = '/' then
					Result := Result.substring (1, Result.count - 1)
				end
			end
		end

note
	copyright: "2011-2011, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
