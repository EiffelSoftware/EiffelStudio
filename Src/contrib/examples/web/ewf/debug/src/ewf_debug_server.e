note
	description: "[
				application service
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_DEBUG_SERVER

inherit
	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

	APPLICATION_LAUNCHER [EWF_DEBUG_EXECUTION]

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			Precursor
--			set_service_option ("verbose", True)
			set_service_option ("port", 9090)
--			set_service_option ("base", "/www-debug/debug_service.fcgi/")
		end

--	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
--		local
--			dbg: WSF_DEBUG_HANDLER
--		do
--			res.put_error ("OH NO uri=" + req.request_uri + "%N")
--			create dbg.make
--			dbg.execute_starts_with ("", req, res)
--		end

end

