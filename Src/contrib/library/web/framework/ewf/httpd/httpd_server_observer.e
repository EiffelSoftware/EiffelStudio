note
	description: "Summary description for {HTTPD_SERVER_OBSERVER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_SERVER_OBSERVER

feature -- Event

	on_launched (a_port: INTEGER)
			-- Associated server launched listening on port `a_port'.
		deferred
		end

	on_stopped
			-- Associated server stopped.
			--| the server may restart itself after being rescued.
		deferred
		end

	on_terminated
			-- Associated server terminated.
		deferred
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
