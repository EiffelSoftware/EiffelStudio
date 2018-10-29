note
	description: "Execution when an exception occurred."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_RESCUE_EXECUTION

inherit
	WGI_EXPORTER

	SHARED_HTML_ENCODER

feature -- Execution

	execute (req: detachable WGI_REQUEST; res: detachable WGI_RESPONSE; e: detachable EXCEPTION)
			-- Exception or internal error occurred, return the eventual trace
			-- as response.
			-- `req` and `res` may be available for processing.
		local
			s: STRING
		do
			if
				res /= Void and then
				e /= Void and then
				attached e.trace as l_trace
			then
				if not res.status_is_set then
					res.set_status_code ({HTTP_STATUS_CODE}.internal_server_error, Void)
				end
				create s.make_empty
				s.append ("<pre>")
				s.append (html_encoder.encoded_string (l_trace))
				s.append ("</pre>")
				if not res.header_committed then
						-- Overwrite any header previously set.
					res.put_header_text ("Content-Type: text/html%R%NContent-Length: " + s.count.out + "%R%N%R%N")
				end
				if res.message_writable then
					res.put_string (s)
				end
				res.push
			end
		end

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
