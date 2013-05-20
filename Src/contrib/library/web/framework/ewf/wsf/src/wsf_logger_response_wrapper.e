note
	description: "[
					This class is a logger on a standard WSF_RESPONSE
					It is used to record response
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_LOGGER_RESPONSE_WRAPPER

inherit
	WSF_RESPONSE

	WSF_RESPONSE_EXPORTER

create
	make_from_response

feature {NONE} -- Initialization

	make_from_response (res: WSF_RESPONSE; a_out, a_err: FILE)
		local
			l_log_wgi_response: WGI_LOGGER_RESPONSE
		do
			wsf_response := res
			create l_log_wgi_response.make_with_response_and_output (res.wgi_response, a_out, a_err)
			make_from_wgi (l_log_wgi_response)
		end

feature {WSF_RESPONSE_EXPORTER} -- Access

	wsf_response: WSF_RESPONSE
			-- Original WSF response object.

invariant
	wsf_response_attached: wsf_response /= Void

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
