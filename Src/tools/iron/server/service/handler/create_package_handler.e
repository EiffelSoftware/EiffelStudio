note
	description: "Summary description for {CREATE_PACKAGE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_PACKAGE_HANDLER

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
			if is_authenticated (req) then
				if req.is_get_request_method then
					handle_form_create_package (req, res)
				else
					res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
				end
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_form_create_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_theme: WSF_REQUEST_THEME
			f: like new_package_edit_form
			r: IRON_REPO_HTML_RESPONSE
		do
			f := new_package_edit_form (Void, req, False)
			r := new_response_message (req)
			create l_theme.make_with_request (req)
			r.set_body (f.to_html (l_theme))

			res.send (r)
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
			-- Documentation associated with Current handler, in the context of the mapping `m' and methods `a_request_methods'.
			--| `m' and `a_request_methods' are useful to produce specific documentation when the handler is used for multiple mapping.
		do
			create Result.make (m)
			Result.add_description ("[GET] web form to create a new package entry (authentication required).")
		end

end
