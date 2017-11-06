note
	description: "Summary description for {ES_CLOUD_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_mod_api: ES_CLOUD_API)
		do
			make_with_cms_api (a_mod_api.cms_api)
			es_cloud_api := a_mod_api
		end

feature -- API

	es_cloud_api: ES_CLOUD_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			l_uid: READABLE_STRING_GENERAL
		do
			if req.is_get_request_method then
				get_cloud (req, res)
--			elseif req.is_post_request_method then
			else
				send_bad_request (req, res)
			end
		end

	get_cloud (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			l_plan: detachable ES_CLOUD_PLAN
		do
			r := new_generic_response (req, res)
			s := "<h1>EiffelStudio Cloud</h1>"

			if attached api.user as u then
				s.append ("<p>Welcome user "+ api.html_encoded (api.real_user_display_name (u)) +"</p>")
					-- Plan
					-- Installation ...
				if
					attached es_cloud_api.user_installations (u) as l_installations and then
					not l_installations.is_empty
				then
					s.append ("<p>EiffelStudio is installed on: <ul>")
					across
						l_installations as ic
					loop
						s.append ("<li>")
						s.append (html_encoded (ic.item.installation_id))
						if attached ic.item.creation_date as l_creation_date then
							s.append (" <span class=%"creation%">")
							s.append (date_time_to_string (l_creation_date))
							s.append ("</span>")
						end
						if attached ic.item.access_date as l_access_date then
							s.append (" <span class=%"access%">")
							s.append (date_time_to_string (l_access_date))
							s.append ("</span>")
						end
						s.append ("</li>%N")
					end
					s.append ("</ul></p>")
				else
					s.append ("<p>EiffelStudio is not yet installed.</p>")
				end
				if attached es_cloud_api.user_subscription (u) as sub then
					l_plan := sub.plan
					s.append ("You are subscribed to plan: <strong>")
					s.append (html_encoded (l_plan.title_or_name))
					s.append ("</strong><ul>")
					debug
						s.append ("<li>Started ")
						s.append (api.date_time_to_string (sub.creation_date))
						s.append ("</li>")
					end
					if sub.is_active then
						if attached sub.expiration_date as exp then
							s.append ("<li>Renewal date ")
							s.append (api.date_time_to_string (exp))
							s.append (" (")
							s.append (sub.days_remaining.out)
							s.append (" days remaining)")
							s.append ("</li>")
						else
							s.append ("<li><strong>ACTIVE</strong></li>")
						end
					else
						s.append ("<li><strong>EXPIRED</strong></li>")
					end
					s.append ("</ul>")
				else
					s.append ("Please subscribe to a plan ...")
				end
			else
				s.append ("<p>Please Login or Register...</p>")
			end
			if l_plan = Void then
				s.append ("<ul><strong>Plans</strong>")
				across
					es_cloud_api.plans as ic
				loop
					l_plan := ic.item
					s.append ("<li>")
					s.append (html_encoded (l_plan.title_or_name))
					s.append ("</li>")
				end
				s.append ("</ul>")
			end

			r.set_main_content (s)
			r.execute
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

