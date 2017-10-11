note
	description: "Summary description for {CMS_ADMIN_INFO_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_INFO_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		local
			r: like new_generic_response
			s: STRING
		do
			if req.is_get_request_method then
				r := new_generic_response (req, res)
				create s.make_empty
				r.set_title ("System Information")
				r.add_to_primary_tabs (api.administration_link ("Administration", ""))
				append_system_info_to (s)
				r.set_main_content (s)
				r.execute
			else
				send_bad_request (req, res)
			end
		end

	append_system_info_to (s: STRING)
		local
			n: INTEGER
		do
			s.append ("<ul>")
			s.append ("<li><strong>Current direction:</strong> ")
			s.append (html_encoded ((create {EXECUTION_ENVIRONMENT}).current_working_path.name))
			s.append ("</li>")
			s.append ("<li><strong>Site:</strong> ")
			s.append (html_encoded (api.setup.site_location.name))
			s.append ("</li>")
			s.append ("<li><strong>Cache:</strong> ")
			s.append (html_encoded (api.setup.cache_location.name))
			s.append ("</li>")
			s.append ("<li><strong>Files:</strong> ")
			s.append (html_encoded (api.setup.files_location.name))
			s.append ("</li>")
			s.append ("<li><strong>Temp:</strong> ")
			s.append (html_encoded (api.setup.temp_location.name))
			s.append ("</li>")
			s.append ("<li><strong>Storage:</strong>")
			n := s.count
			across
				api.setup.storage_drivers as ic
			loop
				if s.count > n then
					s.append (", ")
				else
					s.append (" ")
				end
				s.append (html_encoded (ic.key))
			end
			s.append (" -&gt; ")
			s.append (api.storage.generator)
			s.append ("</li>")
			s.append ("</ul>")
		end

end
