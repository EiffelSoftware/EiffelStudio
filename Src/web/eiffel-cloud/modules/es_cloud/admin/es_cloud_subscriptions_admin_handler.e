note
	description: "Summary description for {ES_CLOUD_SUBSCRIPTIONS_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_SUBSCRIPTIONS_ADMIN_HANDLER

inherit
	ES_CLOUD_ADMIN_HANDLER

	WSF_URI_HANDLER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			sub: detachable ES_CLOUD_PLAN_SUBSCRIPTION
			s: STRING
			l_user: ES_CLOUD_USER
			l_org: ES_CLOUD_ORGANIZATION
			l_plan_filter: detachable READABLE_STRING_GENERAL
			orgs: detachable LIST [ES_CLOUD_ORGANIZATION]
		do
			if api.has_permission ("manage es accounts") then
				if attached {WSF_STRING} req.query_parameter ("plan") as p_plan then
					l_plan_filter := p_plan.value
				end
				r := new_generic_response (req, res)
				add_primary_tabs (r)

				if l_plan_filter /= Void then
					create s.make_from_string ("<h1>Subscriptions for plan %"" + html_encoded (l_plan_filter) + "%"</h1>")
					s.append ("Click <a href=%"" + req.script_url (req.percent_encoded_path_info) + "%">for any plan</a>.")
				else
					create s.make_from_string ("<h1>Subscriptions</h1>")
					s.append ("See <a href=%"" + api.administration_path ("/cloud/plans/") + " %">available plans</a>.")
				end
				s.append ("<table class=%"with_border%" style=%"border: solid 1px black%"><tr><th>Entity</th><th>Plan</th><th>Until</th><th>Last</th><th>organization(s)</th>")
	--			s.append ("<th>Action</th>")
				s.append ("</tr>")
				across
--					api.user_api.recent_users (create {CMS_DATA_QUERY_PARAMETERS}.make (0, api.user_api.users_count.to_natural_32)) as ic
					es_cloud_api.subscriptions as ic
				loop
--					create l_user.make (ic.item)
					sub := ic.item
					l_user := Void
					l_org := Void
					if attached {ES_CLOUD_PLAN_USER_SUBSCRIPTION} sub as u_sub then
						l_user := u_sub.user
						orgs := es_cloud_api.user_organizations (u_sub.user)
					elseif attached {ES_CLOUD_PLAN_ORGANIZATION_SUBSCRIPTION} sub as o_sub then
						l_org := o_sub.organization
					else
						check should_not_occur: False end
					end
					if
						(sub /= Void or orgs /= Void) and
						(	l_plan_filter = Void
							or else (sub /= Void and then l_plan_filter.is_case_insensitive_equal (sub.plan.name))
						)
					then
						s.append ("<tr><td>")
						if l_org /= Void then
							s.append ("[ORG] <a href=%"")
							s.append (api.administration_path ("cloud/organizations/" + sub.entity_id.out + "/"))
							s.append ("%">")
							s.append (html_encoded (l_org.name))
						elseif l_user /= Void then
							 s.append ("<a href=%"")
							s.append (api.administration_path ("cloud/installations/?user=" + sub.entity_id.out))
							s.append ("%">")
							s.append (html_encoded (api.real_user_display_name (l_user)))
						end
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
							s.append ("<td>")
							if l_user /= Void then
								if
									attached {ES_CLOUD_SESSION} es_cloud_api.last_user_session (l_user, Void) as l_last and then
									attached l_last.last_date as dt
								then
									s.append ("<time class=%"timeago%" datetime=%"" + date_time_to_timestamp_string (dt) + "%">")
									s.append (html_encoded (date_time_to_string (dt)))
									s.append ("</time>")
								end
							end
							s.append ("</td>")
						else
							s.append ("<td>")
							s.append ("</td>")
							s.append ("<td>")
							s.append ("</td>")
							s.append ("<td>")
							s.append ("</td>")
						end
						if l_user /= Void and orgs /= Void then
							s.append ("<td>")
							across
								orgs as o_ic
							loop
								s.append ("<a href=%"")
								s.append (api.administration_path ("cloud/organizations/" + o_ic.item.id.out + "/"))
								s.append ("%">")
								s.append (html_encoded (o_ic.item.name))
								s.append ("</a> ")
							end
							s.append ("</td>")
						else
							s.append ("<td>")
							s.append ("</td>")
						end

						s.append ("</tr>")
					end
				end
				s.append ("</table>%N")

				s.append ("<br/>%N")

				s.append ("<table class=%"with_border%" style=%"border: solid 1px black%"><tr><th>organizations</th><th>Plan</th><th>Until</th>")
	--			s.append ("<th>Action</th>")
				s.append ("</tr>")
				across
					es_cloud_api.organizations as ic
				loop
					sub := es_cloud_api.organization_subscription (ic.item)
					if
						l_plan_filter = Void
						or else (sub /= Void and then l_plan_filter.is_case_insensitive_equal (sub.plan.name))
					then
						s.append ("<tr><td><a href=%"")
						s.append (api.administration_path ("cloud/organizations/" + ic.item.id.out + "/"))
						s.append ("%">")
						s.append (html_encoded (ic.item.name))
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
