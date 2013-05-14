note
	description: "Summary description for {SEARCH_PACKAGE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PACKAGE_HANDLER

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
			if is_method_post (req) or is_method_put (req) then
				handle_update_package (req, res)
			elseif is_method_delete (req) then
				handle_delete_package (req, res)
			elseif is_method_get (req) then
				handle_view_package (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_view_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: IRON_REPO_HTML_RESPONSE
			it: HTML_IRON_REPO_ITERATOR
			s: STRING_8
			v: READABLE_STRING_8
		do
			if
				attached {WSF_STRING} req.path_parameter ("id") as p_id and then
			 	attached iron.database.package (iron_version (req), p_id.value) as l_package
			then
				create s.make (1024)
				s.append ("<ul>")
				create it.make (s, req, iron, iron_version (req))
				it.visit_package (l_package)
				if attached iron.database.path_associated_with_package (iron_version (req), l_package) as lst then
					s.append ("<ul><strong><a href=%""+ iron.package_map_web_page (iron_version (req), l_package, Void) +"%">Associated URIs</a></strong>%N")
					v := iron_version (req).value
					across
						lst as c
					loop
						s.append ("<li>")
						s.append ("<a href=%"" + "/" + v + c.item + "%">/" + v + c.item + "</a>")
						s.append ("</li>%N")
					end
					s.append ("</ul>")
				end

				if is_authenticated (req) then
					s.append ("<div><a href=%""+ req.script_url (iron.package_edit_web_page (iron_version (req), l_package)) +"%"Edit this package</a></div>")
				end
				r := new_response_message (req)
				r.add_menu ("Edit", iron.package_edit_web_page (iron_version (req), l_package))
				r.add_menu ("Map", iron.package_map_web_page (iron_version (req), l_package, Void))
				r.set_title ("Package " + iron.html_encoder.encoded_string (l_package.human_identifier))
				r.set_body (s)
				res.send (r)
			else
				res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
			end
		end

	handle_update_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
--			l_theme: WSF_THEME
			f: detachable like new_package_edit_form
--			r: IRON_HTML_RESPONSE
		do
			if attached package_from_id_path_parameter (req, "id") as l_package then
				f := new_package_edit_form (l_package, req, True)
			else
				f := new_package_edit_form (Void, req, True)
			end
			if f /= Void then
				f.process (req, Void, agent on_package_edit_form_processed (?, req, res))
--				r := new_response_message (req)
--				create l_theme
--				r.set_body (f.to_html (l_theme))
--				res.send (r)
			else
				res.send (create {WSF_NOT_FOUND_RESPONSE}.make (req))
			end
		end

	handle_delete_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached package_from_id_path_parameter (req, "id") as l_package then
				iron.database.delete_package (iron_version (req), l_package)
				res.redirect_now (iron.package_list_web_page (iron_version (req)))
			else
				res.send (create {WSF_NOT_FOUND_RESPONSE}.make (req))
			end
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("GET: get information related to package {id} (auth required).")
			Result.add_description ("DELETE: delete package {id} (auth required).")
			Result.add_description ("PUT: update package {id} (auth required).")
		end

end
