note
	description: "Summary description for {ARCHIVE_PACKAGE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARCHIVE_PACKAGE_HANDLER

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
			if is_method_post (req) then
				handle_post (req, res)
			elseif is_method_delete (req) then
				handle_delete (req, res)
			elseif is_method_get (req) then
				handle_get (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
--			html: like new_response_message
--			s: STRING
		do
--			if is_content_type_text_html_accepted (req) then
--				req.is_content_type_accepted ("text/html") then
--				html := new_response_message (req)
--				create s.make_empty

--				html.set_title ("Archive ..")
--				html.set_body (s)
--				res.send (html)
--			else
				handle_download_package (req, res)
--			end
		end

	handle_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			cl: CELL [detachable PATH]
		do
			if is_authenticated (req) then
				if attached package_from_id_path_parameter (req, "id") as l_package then
					if attached {WSF_UPLOADED_FILE} req.form_parameter ("file") as l_uploaded_file then
						iron.database.save_uploaded_package_archive (iron_version (req), l_package, l_uploaded_file)
						redirect_to_package_view (req, res, l_package)
					elseif attached {WSF_STRING} req.form_parameter ("url") as l_url then
						create cl.put (Void)
						download (l_url.url_encoded_value, cl, req)
						if attached cl.item as p then
							iron.database.save_package_archive (iron_version (req), l_package, p, False)
						else
							res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
						end
					else
						res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
					end
				else
					res.send (create {WSF_NOT_FOUND_RESPONSE}.make (req))
				end
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_delete (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if is_authenticated (req) then
				if attached package_from_id_path_parameter (req, "id") as l_package then
					if l_package.has_archive then
						iron.database.delete_package_archive (iron_version (req), l_package)
					end
					redirect_to_package_view (req, res, l_package)
				else
					res.send (create {WSF_NOT_FOUND_RESPONSE}.make (req))
				end
			else
				res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
			end
		end

	handle_download_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WSF_FORCE_DOWNLOAD_RESPONSE
		do
			if attached package_from_id_path_parameter (req, "id") as l_package then
				if attached l_package.archive_path as p then
					create m.make (p.utf_8_name)
					m.set_base_name (l_package.id.as_lower + ".zip")
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
