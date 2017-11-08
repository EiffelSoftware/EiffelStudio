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
			r.set_title ("EiffelStudio account")
			s := ""

			if attached api.user as u then
				s.append ("<p class=%"es-message%">User "+ api.html_encoded (api.real_user_display_name (u)) +"</p>")
					-- Plan
					-- Installation ...
				s.append ("<div class=%"es-installations%">")
				if
					attached es_cloud_api.user_installations (u) as l_installations and then
					not l_installations.is_empty
				then
					s.append ("<p>EiffelStudio is installed on: <ul>")
					across
						l_installations as ic
					loop
						s.append ("<li class=%"es-installation%">")
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
				s.append ("</div>")
				s.append ("<div class=%"es-subscription%">")
				if attached es_cloud_api.user_subscription (u) as sub then
					l_plan := sub.plan
					s.append ("<p>You are subscribed to plan: <span class=%"es-plan-title%">")
					s.append (html_encoded (l_plan.title_or_name))
					s.append ("</span>")
					s.append ("<ul>")
					s.append ("<li class=%"creation%">Started ")
					s.append (api.date_time_to_string (sub.creation_date))
					s.append ("</li>")
					if sub.is_active then
						if attached sub.expiration_date as exp then
							s.append ("<li class=%"expiration%">Renewal date ")
							s.append (api.date_time_to_string (exp))
							s.append (" (")
							s.append (sub.days_remaining.out)
							s.append (" days remaining)")
							s.append ("</li>")
						else
							s.append ("<li class=%"status success%">ACTIVE</li>")
						end
					else
						s.append ("<li class=%"status warning%">EXPIRED</li>")
					end
					s.append ("</ul>")
				else
					s.append ("Please subscribe to a plan ...")
				end
				s.append ("</div>")
			else
				s.append ("<p>Please Login or Register...</p>")
			end
			if l_plan = Void then
				s.append ("<div class=%"es-plans%">")
				s.append ("<strong>Plans</strong><ul>")
				across
					es_cloud_api.plans as ic
				loop
					l_plan := ic.item
					s.append ("<li class=%"es-plan-box%">")
					s.append (html_encoded (l_plan.title_or_name))
					s.append ("</li>")
				end
				s.append ("</ul>")
				s.append ("</div>")
			end
			r.set_main_content (s)
			r.execute
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

