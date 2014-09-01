note
	description: "Summary description for {SHUTDOWN_CMS_EXECUTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHUTDOWN_CMS_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature -- Execution

	process
		local
			b: STRING
		do
			create b.make_empty
			set_title ("Shutting down the service ...")
			if has_permission ("admin shutdown") then
				if attached {WGI_NINO_CONNECTOR} request.wgi_connector as nino then
					nino.server.shutdown_server
				end
			else
				b.append ("Access denied")
			end
			set_main_content (b)
		end

end
