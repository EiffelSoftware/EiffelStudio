note
	description: "Summary description for {WEB_SOCKET_WRITER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEB_SOCKET_WRITER

inherit
	WEB_SOCKET_CONSTANTS

feature	-- Messages

	send_text (a_message: READABLE_STRING_8)
			-- Send text frame `a_message`.
		do
			send (text_frame, a_message)
		end

	send_connection_close (a_message: detachable READABLE_STRING_8)
			-- Send connection close frame `a_message`.
		do
			send (connection_close_frame, a_message)
		end

	send_binary (a_data: READABLE_STRING_8)
			-- Send binary frame `a_data`.
		do
			send (Binary_frame, a_data)
		end

feature -- Custom Message

	send (a_opcode: INTEGER; a_message: detachable READABLE_STRING_8)
		local
			i: INTEGER
			l_chunk_size: INTEGER
			l_chunk: READABLE_STRING_8
			l_header_message: STRING
			l_message_count: INTEGER
			n: NATURAL_64
			retried: BOOLEAN
		do
			debug ("ws")
				print (">>do_send (..., "+ opcode_name (a_opcode) +", ..)%N")
			end
			if not retried then
				create l_header_message.make_empty
				l_header_message.append_code ((0x80 | a_opcode).to_natural_32)
				if a_message /= Void then
					l_message_count := a_message.count
				else
					l_message_count := 0
				end
				n := l_message_count.to_natural_64
				if l_message_count > 0xffff then
						--! Improve. this code needs to be checked.
					l_header_message.append_code ((0 | 127).to_natural_32)
					l_header_message.append_character ((n |>> 56).to_character_8)
					l_header_message.append_character ((n |>> 48).to_character_8)
					l_header_message.append_character ((n |>> 40).to_character_8)
					l_header_message.append_character ((n |>> 32).to_character_8)
					l_header_message.append_character ((n |>> 24).to_character_8)
					l_header_message.append_character ((n |>> 16).to_character_8)
					l_header_message.append_character ((n |>> 8).to_character_8)
					l_header_message.append_character ( n.to_character_8)
				elseif l_message_count > 125 then
					l_header_message.append_code ((0 | 126).to_natural_32)
					l_header_message.append_code ((n |>> 8).as_natural_32)
					l_header_message.append_character (n.to_character_8)
				else
					l_header_message.append_code (n.as_natural_32)
				end
				socket_put_string (l_header_message)
				if not socket_was_error then
					l_chunk_size := 16_384 -- 16K TODO: see if we should make it customizable.
					if a_message = Void or else l_message_count < l_chunk_size then
						if a_message /= Void then
							socket_put_string (a_message)
						end
					else
						from
							i := 0
						until
							l_chunk_size = 0 or socket_was_error
						loop
							debug ("ws")
								print ("Sending chunk " + (i + 1).out + " -> " + (i + l_chunk_size).out +" / " + l_message_count.out + "%N")
							end
							l_chunk := a_message.substring (i + 1, l_message_count.min (i + l_chunk_size))
							socket_put_string (l_chunk)
							if l_chunk.count < l_chunk_size then
								l_chunk_size := 0
							end
							i := i + l_chunk_size
						end
						debug ("ws")
							print ("Sending chunk done%N")
						end
					end
				end
			else
					-- FIXME: what should be done on rescue?
			end
		rescue
			retried := True
			io.put_string ("Internal error in " + generator + ".do_send (conn, a_opcode=" + a_opcode.out + ", a_message) !%N")
			retry
		end

feature {NONE} -- Networking

	socket_put_string (s: READABLE_STRING_8)
		deferred
		end

	socket_was_error: BOOLEAN
		deferred
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
