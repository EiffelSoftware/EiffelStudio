note
	description : "OPENID demo application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit

	WSF_ROUTED_SKELETON_SERVICE
		undefine
			requires_proxy
		end
	
	WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_SERVICE

	WSF_SERVICE

	WSF_NO_PROXY_POLICY

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
		local
			launcher: WSF_NINO_SERVICE_LAUNCHER
			opts: WSF_SERVICE_LAUNCHER_OPTIONS
		do
			initialize_router

			create opts.make
			opts.set_verbose (True)
			opts.set_option ("port", 0)
			create launcher.make (Current, opts)
			launcher.on_launched_actions.extend (agent on_launched)
			launcher.launch
		end

	on_launched (conn: WGI_CONNECTOR)
		local
			e: EXECUTION_ENVIRONMENT
		do
			if attached {WGI_NINO_CONNECTOR} conn as nino then
				create e
				if attached e.get ("COMSPEC") as l_comspec then
					e.launch (l_comspec + " /C start " + "http://localhost:" + nino.port.out + "/")
				else
					e.launch ("http://localhost:" + nino.port.out + "/")
				end
			end
		end

	setup_router
		do
			map_uri_template_agent ("/", agent handle_root)
			map_uri_template_agent ("/openid", agent handle_openid)
		end

	handle_root (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WSF_HTML_PAGE_RESPONSE
			s: STRING
		do
			create m.make
			m.set_title ("EWF::OpenID demo")
			create s.make_empty
			s.append ("<form action=%"" + req.script_url ("/openid") + "%" method=%"POST%">%N")
			s.append ("<strong>OpenID identifier</strong> <input type='text' name='openid_identifier' value='' size='60'/>")
			s.append ("<input type='submit' name='op' value='sign with OpenID' />")
			s.append ("</form>%N")
			s.append ("<form action=%"" + req.script_url ("/openid") + "%" method=%"POST%">%N")
			s.append ("<strong>OpenID identifier</strong> <input type='text' name='openid_identifier' value='https://www.google.com/accounts/o8/id' size='60'/>")
			s.append ("<input type='submit' name='op' value='sign with Google' />")
			s.append ("</form>%N")
			m.set_body (s)
			res.send (m)
		end

	handle_openid (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WSF_HTML_PAGE_RESPONSE
			redir: WSF_HTML_DELAYED_REDIRECTION_RESPONSE
			s: STRING
			o: OPENID_CONSUMER
			v: OPENID_CONSUMER_VALIDATION
		do
			if attached req.string_item ("openid.mode") as l_openid_mode then
				create m.make
				m.set_title ("EWF::OpenID demo")
				create s.make_empty

				if l_openid_mode.same_string ("id_res") then
					o := new_openid_consumer (req)
					create v.make_from_items (o, req.items_as_string_items)
					v.validate
					if v.is_valid then
						s.append ("<div>User authenticated</div>")
						s.append ("<ul>Request items")
						across
							req.items as c
						loop
							s.append ("<li>" + c.item.url_encoded_name + "=" + c.item.string_representation + "</li>")
						end
						s.append ("</ul>")
						s.append ("<ul>Attributes")
						across
							v.attributes as c
						loop
							s.append ("<li>" + c.key + "=" + c.item + "</li>")
						end
						s.append ("</ul>")
					else
						s.append ("<div>User authentication failed!!!</div>")
					end
				else
					s.append ("<div>Unexpected OpenID.mode=" + l_openid_mode + "</div>")
				end
				m.set_body (s)
				res.send (m)
			elseif attached req.string_item ("openid_identifier") as l_id then
				create s.make_empty

				o := new_openid_consumer (req)
				s.append ("Testing " + l_id + "<br>%N")
				s.append ("Return-to" + o.return_url + "<br>")
				if attached o.auth_url (l_id) as l_auth_url then
					s.append ("<a href=%""+ l_auth_url + "%">Click to sign with " + l_id + "</a><br>")
					create redir.make (l_auth_url, 1)
					s.append ("Automatically follow link in " + redir.delay.out + " second(s)<br>")
					redir.set_title ("EWF::OpenID demo")
					redir.set_body (s)
					res.send (redir)
				else
					create m.make
					m.set_title ("EWF::OpenID demo")
					m.set_body (s)
					res.send (m)
				end
			else
				res.redirect_now ("/")
			end
		end

	new_openid_consumer (req: WSF_REQUEST): OPENID_CONSUMER
		do
			create Result.make (req.absolute_script_url ("/openid"))

			Result.ask_email (True)
			Result.ask_all_info (False)
--			Result.ask_nickname (False)
--			Result.ask_fullname (False)
--			Result.ask_country (True)
		end
end
