note
	description: "Summary description for {SEARCH_PACKAGE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SEARCH_PACKAGE_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

	IRON_REPO_HANDLER
		rename
			set_iron as make
		end

	WSF_SELF_DOCUMENTED_HANDLER

create
	make

feature -- Execution	

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_get_request_method then
				if has_iron_version (req) then
					handle_search_package (req, res)
				else
					res.send (create {WSF_REDIRECTION_RESPONSE}.make (iron.page (Void, "/")))
				end
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_search_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			h: WSF_HEADER
			s: detachable STRING
			lst: detachable ITERABLE [IRON_REPO_PACKAGE]
			html_vis: HTML_IRON_REPO_ITERATOR
			html: IRON_REPO_HTML_RESPONSE
			json_vis: JSON_V1_IRON_REPO_ITERATOR
		do
			lst := iron.database.packages (iron_version (req), 1, 0)
			if req.is_content_type_accepted ("text/html") then
				html := new_response_message (req)
				create s.make_empty
				if lst /= Void then
					create html_vis.make (s, req, iron, iron_version (req))
					html_vis.set_user (current_user (req))
					html_vis.visit_package_iterable (lst)
				end

					-- Create new package
				html.set_title ("List of available IRON packages")
				html.set_body (s)
				res.send (html)
			else
				create json_vis.make (req, iron, iron_version (req))
				s := json_vis.packages_to_json (lst)

				create h.make
				h.put_content_type_application_json
				h.put_content_length (s.count)
				res.put_header_lines (h)
				res.put_string (s)
			end
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
			-- Documentation associated with Current handler, in the context of the mapping `m' and methods `a_request_methods'.
			--| `m' and `a_request_methods' are useful to produce specific documentation when the handler is used for multiple mapping.
		do
			create Result.make (m)
			Result.add_description ("List existing packages.")
		end

end
