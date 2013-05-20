note
	description: "[
				WGI_SERVICE
			]"
	specification: "EWSGI specification https://github.com/Eiffel-World/Eiffel-Web-Framework/wiki/EWSGI-specification"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WGI_SERVICE

feature {WGI_CONNECTOR} -- Execution

	execute (req: WGI_REQUEST; res: WGI_RESPONSE)
			-- Execute the request
			-- See `req.input' for input stream
    		--     `req.meta_variables' for the CGI meta variable
			-- and `res' for output buffer
		require
			res_status_unset: not res.status_is_set
		deferred
		ensure
			res_status_set: res.status_is_set
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
