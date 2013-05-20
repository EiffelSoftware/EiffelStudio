note
	description: "Summary description for {POST_REQUEST_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POST_REQUEST_HANDLER

inherit
	GET_REQUEST_HANDLER
		redefine
			process
		end

create
	make

feature -- Execution

	process
			-- process the request and create an answer
		local
			l_data: STRING
			s: detachable STRING
			n: INTEGER
			sock: like socket
		do
			from
				n := 1_024
				sock := socket
				if sock.socket_ok then
					sock.read_stream_thread_aware (n)
					s := sock.last_string
				else
					s := Void
				end
				create l_data.make_empty
			until
				s = Void or else s.count < n
			loop
				l_data.append_string (s)
				if sock.socket_ok then
					sock.read_stream_thread_aware (n)
					s := sock.last_string
				else
					s := Void
				end
			end
			Precursor
		end

end
