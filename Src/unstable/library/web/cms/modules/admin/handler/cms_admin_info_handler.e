note
	description: "Display information about ROC CMS installation."
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
				if api.has_permission ({CMS_ADMIN_MODULE_ADMINISTRATION}.perm_view_system_info) then
					r := new_generic_response (req, res)
					create s.make_empty
					r.set_title ("System Information")
					r.add_to_primary_tabs (api.administration_link ("Administration", ""))
					append_system_info_to (s)
					r.set_main_content (s)
					r.execute
				else
					send_access_denied (req, res)
				end
			else
				send_bad_request (req, res)
			end
		end

	append_system_info_to (s: STRING)
		local
			l_mailer, l_previous_mailer: NOTIFICATION_MAILER
		do
			s.append ("<ul>")
			across
				api.setup.system_info as ic
			loop
				s.append ("<li><strong>"+ html_encoded (ic.key) +":</strong> ")
				s.append (html_encoded (ic.item))
				s.append ("</li>")
			end
			s.append ("<li><strong>Storage:</strong> ")
			s.append (" -&gt; ")
			s.append (api.storage.generator)
			s.append ("</li>")

			s.append ("<li><strong>Mailer:</strong> ")
			l_mailer := api.setup.mailer
			from until l_mailer = Void loop
				s.append (" -&gt; ")
				s.append (l_mailer.generator)
				if attached {NOTIFICATION_CHAIN_MAILER} l_mailer as l_chain_mailer then
					l_mailer := l_chain_mailer.next
				else
					l_mailer := Void
				end
			end
			s.append ("</li>")
			s.append ("</ul>")
		end

end
