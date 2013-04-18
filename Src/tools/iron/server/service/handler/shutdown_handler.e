note
	description: "Summary description for {SHUTDOWN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHUTDOWN_HANDLER

inherit
	WSF_URI_HANDLER

	IRON_REPO_HANDLER
		rename
			set_iron as make
		end

create
	make

feature -- Execution	

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: IRON_REPO_HTML_RESPONSE
		do
			if req.is_get_request_method then
				m := new_response_message (req)
				m.set_title ("Shutdown ...")
				m.set_body ("Server is shutting down...")
				res.send (m)
				if attached {WGI_NINO_CONNECTOR} req.wgi_connector as nino then
					nino.server.shutdown_server
				end
				(create {EXCEPTIONS}).die (0)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.set_is_hidden (True)
			Result.add_description ("Shutdown server.")
		end

end
