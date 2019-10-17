note
	description: "Summary description for {ES_CLOUD_SUBSCRIPTIONS_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_SUBSCRIPTIONS_ADMIN_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_handler
		end

	WSF_URI_HANDLER

create
	make

feature {NONE} -- Creation

	make (a_es_cloud_api: ES_CLOUD_API)
		do
			es_cloud_api := a_es_cloud_api
			make_handler (a_es_cloud_api.cms_api)
		end

	es_cloud_api: ES_CLOUD_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			sub: detachable ES_CLOUD_PLAN_SUBSCRIPTION
			s: STRING
			l_plan_filter: detachable READABLE_STRING_GENERAL
		do
			if api.has_permission ("manage es accounts") then
				if attached {WSF_STRING} req.query_parameter ("plan") as p_plan then
					l_plan_filter := p_plan.value
				end
				r := new_generic_response (req, res)
				r.add_to_primary_tabs (api.administration_link ("Available plans", "/cloud/plans/"))
				if l_plan_filter /= Void then
					create s.make_from_string ("<h1>Subscriptions for plan %"" + html_encoded (l_plan_filter) + "%"</h1>")
					s.append ("Click <a href=%"" + req.script_url (req.percent_encoded_path_info) + "%">for any plan</a>.")
				else
					create s.make_from_string ("<h1>Subscriptions</h1>")
					s.append ("See <a href=%"" + api.administration_path ("/cloud/plans/") + " %">available plans</a>.")
				end
				s.append ("<table class=%"with_border%" style=%"border: solid 1px black%"><tr><th>Users</th><th>Plan</th><th>Until</th>")
	--			s.append ("<th>Action</th>")
				s.append ("</tr>")
				across
					api.user_api.recent_users (create {CMS_DATA_QUERY_PARAMETERS}.make (0, api.user_api.users_count.to_natural_32)) as ic
				loop
					sub := es_cloud_api.user_subscription (ic.item)
					if
						l_plan_filter = Void
						or else (sub /= Void and then l_plan_filter.is_case_insensitive_equal (sub.plan.name))
					then
						s.append ("<tr><td><a href=%"")
--						s.append (api.administration_path ("user/" + ic.item.id.out))
						s.append (api.administration_path ("cloud/installations/?user=" + ic.item.id.out))
						s.append ("%">")
						s.append (html_encoded (api.real_user_display_name (ic.item)))
						s.append ("</a></td>")

						if sub /= Void then
							s.append ("<td>")
							s.append (html_encoded (sub.plan.title_or_name))
							s.append ("</td>")
							s.append ("<td>")
							if sub.is_active then
								if attached sub.expiration_date as dt then
									s.append (html_encoded (date_time_to_string (dt)))
									s.append (" ( " + sub.days_remaining.out + " days remaining )")
								else
									s.append ("<strong>ACTIVE</strong>")
									s.append (" (since ")
									s.append (html_encoded (date_time_to_string (sub.creation_date)))
									s.append (")")
								end
							else
								s.append ("<strong>EXPIRED</strong>")
								if attached sub.expiration_date as dt then
									s.append (" (since ")
									s.append (html_encoded (date_time_to_string (dt)))
									s.append (")")
								end
							end
							s.append ("</td>")
		--					s.append ("<td>")
		--					s.append ("Cancel | Upgrade")
		--					s.append ("</td>")
						else
							s.append ("<td>")
							s.append ("</td>")
							s.append ("<td>")
							s.append ("</td>")
		--					s.append ("<td>")
		--					s.append ("Upgrade")
		--					s.append ("</td>")
						end

						s.append ("</tr>")
					end
				end
				s.append ("</table>%N")

				r.set_main_content (s)
				r.execute
			else
				send_access_denied (req, res)
			end
		end

end
