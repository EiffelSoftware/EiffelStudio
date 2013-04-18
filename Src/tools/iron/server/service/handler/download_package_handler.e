note
	description: "Summary description for {DOWNLOAD_PACKAGE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_PACKAGE_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

	IRON_REPO_HANDLER
		rename
			set_iron as make
		end

create
	make

feature -- Execution	

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_get_request_method then
				handle_download_package (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_download_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WSF_FORCE_DOWNLOAD_RESPONSE
		do
			if
				attached {WSF_STRING} req.path_parameter ("id") as s_id and then
				attached iron.database.package (iron_version (req), s_id.value) as l_package
			then
				if attached l_package.archive_path as p then
					create m.make (p.utf_8_name)
					m.set_base_name (s_id.value.as_lower + ".zip")
					m.set_no_cache
					res.send (m)
				else
					res.send (create {WSF_NOT_FOUND_RESPONSE}.make (req))
				end
			else
				res.send (create {WSF_NOT_FOUND_RESPONSE}.make (req))
			end
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("Download archive for package {id}.")
		end

end
