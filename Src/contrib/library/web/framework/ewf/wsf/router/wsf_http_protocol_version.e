note

	description: "[
						Parsed form of HTTP-Version field of request line.

						See http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.1 for specification if the protocol is HTTP.
						CGI 1.1 (not official specification) supports alternative protocols
						and extension tokens. We do not currently recognise any of
						these as valid.


	date: "$Date$"
	revision: "$Revision$"
					]"

class WSF_HTTP_PROTOCOL_VERSION

create

	make

feature {NONE} -- Initialization

	make (a_protocol: READABLE_STRING_8)
			-- Create by parsing `a_protocol'.
		require
			a_protocol_attached: a_protocol /= Void
		local
			l_tokens: LIST [READABLE_STRING_8]
			l_protocol_name, l_protocol_version, l_major, l_minor: STRING_8	
		do
			l_tokens := a_protocol.split ('/')
			if l_tokens.count = 2 then
				l_protocol_name := l_tokens [1].as_string_8
				l_protocol_name.left_adjust
				l_protocol_name.right_adjust
				if l_protocol_name.is_case_insensitive_equal ({HTTP_CONSTANTS}.http_version_1_0.substring (1, 4)) then
					l_protocol_version := l_tokens [2].as_string_8
					l_protocol_version.left_adjust
					l_protocol_version.right_adjust
					l_tokens := l_protocol_version.split ('.')
					if l_tokens.count = 2 then
						l_major := l_tokens [1].as_string_8
						l_major.left_adjust
						l_major.right_adjust
						l_minor := l_tokens [2].as_string_8
						l_minor.left_adjust
						l_minor.right_adjust
						if l_major.is_natural then
							major := l_major.to_natural
							is_valid := True
							-- We should be able to work with version 2
							-- or greater by just functioning as HTTP/1.1
						end
						if l_minor.is_natural then
							minor := l_minor.to_natural
						end
					end
				end
			end			
		end

feature -- Access

	major: NATURAL
			-- Major version of HTTP protocol;
			-- Typically 1

	minor: NATURAL
			-- Major version of HTTP protocol;
			-- Typically 1 or 0

feature -- Status report

	is_valid: BOOLEAN
			-- Was SERVER_PROTOCOL parsed successfully as HTTP?

end
