note
	description: "Summary description for {PACKAGE_MAP_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PACKAGE_MAP_HANDLER

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
			if
				req.is_request_method ({WSF_REQUEST_METHODS}.method_delete)
				or attached {WSF_STRING} req.query_parameter ("method") as p_method and then
				   p_method.is_case_insensitive_equal ("delete")
			then
				handle_delete_package_map (req, res)
			elseif req.is_post_request_method then
				handle_create_package_map (req, res)
			elseif req.is_get_request_method then
				handle_view_package_map (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_view_package_map (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: IRON_REPO_HTML_RESPONSE
			s: STRING_8
			v: READABLE_STRING_8
			f: WSF_FORM
			fi: WSF_FORM_TEXT_INPUT
		do
			if
				attached {WSF_STRING} req.path_parameter ("id") as p_id and then
			 	attached iron.database.package (iron_version (req), p_id.value) as l_package
			then
				r := new_response_message (req)
				r.add_menu ("View", iron.package_view_web_page (iron_version (req), l_package))
				create s.make_empty
				s.append ("<strong>[")
				s.append (r.html_encoded_string (l_package.human_identifier))
				s.append ("] maps:</strong>")
				if attached iron.database.path_associated_with_package (iron_version (req), l_package) as lst then
					s.append ("<ul>%N")
					v := iron_version (req).value
					across
						lst as c
					loop
						s.append ("<li>")
						s.append ("<a href=%"" + "/" + v + c.item + "%">/" + v + " " + c.item + "</a>")
						s.append (" <a style=%"color: red;%" href=%"" + iron.package_map_web_page (iron_version (req), l_package, c.item) + "?method=DELETE%">DEL</a>")
						s.append ("</li>%N")
					end
					s.append ("</ul>")
				end
				create f.make (iron.package_map_web_page (iron_version (req), l_package, Void), "new_map")
				create fi.make ("map")
				fi.set_label ("Path association")
				fi.set_description ("Associate the path with current package.")
				f.extend (fi)
				f.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("op", "ADD"))

				f.append_to_html (create {WSF_REQUEST_THEME}.make_with_request (req), s)
				r.set_body (s)
				res.send (r)
			else
				res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
			end
		end

	handle_create_package_map (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_path: detachable STRING_32
			m: IRON_REPO_HTML_RESPONSE
			s: STRING
		do
			m := new_response_message (req)

			create s.make_empty
			if
				attached {WSF_STRING} req.path_parameter ("id") as p_id and then
			 	attached iron.database.package (iron_version (req), p_id.value) as l_package
			then
				m.add_menu ("View", iron.package_view_web_page (iron_version (req), l_package))

				if attached req.string_item ("map") as s_path then
					l_path := s_path
				end
				if l_path = Void then
					if
						attached {WSF_TABLE} req.item ("map") as p_map
					then
						create l_path.make_empty
						across
							p_map as c
						loop
							if not l_path.is_empty then
								l_path.append_character ('/')
							end
							l_path.append (c.item.string_representation)
						end
					end
				end
				if l_path /= Void then
					if l_path.starts_with ("/") then
						l_path.remove_head (1)
					end
					if attached iron.database.package_by_path (iron_version (req), l_path) as p_curr then
						s.append ("Already associated to " + m.html_encoded_string (p_curr.human_identifier))
					else
						iron.database.associate_package_with_path (iron_version (req), l_package, l_path)
						if iron.database.package_by_path (iron_version (req), l_path) ~ l_package then
							-- succeed
							s.append ("association created.")
						else
							-- failure
							s.append ("association creation failed.")
						end
					end
				else
					s.append ("Missing map parameter.")
				end
				s.append ("<div>")
				s.append ("<a href=%"" + iron.package_map_web_page (iron_version (req), l_package, Void) + "%">"+ m.html_encoded_string (l_package.human_identifier) +"</a>")
				s.append ("</div>")
			else
				s.append ("Missing package id parameter.")
			end
			m.set_body (s)

			res.send (m)
		end

	handle_delete_package_map (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_path: STRING_32
			m: IRON_REPO_HTML_RESPONSE
			s: STRING
		do
			m := new_response_message (req)
			create s.make_empty
			if
				attached {WSF_STRING} req.path_parameter ("id") as p_id and then
			 	attached iron.database.package (iron_version (req), p_id.value) as l_package
			then
				m.add_menu ("View", iron.package_view_web_page (iron_version (req), l_package))
				if
					attached {WSF_TABLE} req.path_parameter ("map") as p_map
				then
					create l_path.make_empty
					across
						p_map as c
					loop
						if not l_path.is_empty then
							l_path.append_character ('/')
						end
						l_path.append (c.item.string_representation)
					end
					if iron.database.package_by_path (iron_version (req), l_path) ~ l_package then
						iron.database.unassociate_package_with_path (iron_version (req), l_package, l_path)
						if iron.database.package_by_path (iron_version (req), l_path) = Void then
							-- succeed
							s.append ("association removed.")
						else
							-- failure
							s.append ("association removal failed.")
						end
					else
						s.append ("Not associated.")
					end
				else
					s.append ("Missing map parameter.")
				end
				s.append ("<div>")
				s.append ("<a href=%"" + iron.package_map_web_page (iron_version (req), l_package, Void) + "%">"+ m.html_encoded_string (l_package.human_identifier) +"</a>")
				s.append ("</div>")
			else
				s.append ("Missing package id parameter.")
			end
			m.set_body (s)

			res.send (m)
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("GET: get package map information.")
			Result.add_description ("POST: create package map (auth required).")
			Result.add_description ("DELETE: delete package map (auth required).")
		end

end
