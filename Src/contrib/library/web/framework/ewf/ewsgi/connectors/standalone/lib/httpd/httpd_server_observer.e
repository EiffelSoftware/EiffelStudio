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

end
