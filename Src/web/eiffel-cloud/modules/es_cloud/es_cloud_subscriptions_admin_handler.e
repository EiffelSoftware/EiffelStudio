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
			s: STRING
		do
			r := new_generic_response (req, res)
			create s.make_from_string ("<h1>Subscriptions...</h1>")
			s.append ("<table style=%"border: solid 1px black%"><tr><th>Users</th><th>Plan</th>")
--			s.append ("<th>Action</th>")
			s.append ("</tr>")
			across
				api.user_api.recent_users (create {CMS_DATA_QUERY_PARAMETERS}.make (0, api.user_api.users_count.to_natural_32)) as ic
			loop
				s.append ("<tr><td>")
				s.append (html_encoded (api.real_user_display_name (ic.item)))
				s.append ("</td>")
				if attached es_cloud_api.user_subscription (ic.item) as sub then
					s.append ("<td>")
					s.append (html_encoded (sub.plan.title_or_name))
					s.append ("</td>")
--					s.append ("<td>")
--					s.append ("Cancel | Upgrade")
--					s.append ("</td>")
				else
					s.append ("<td>")
					s.append ("</td>")
--					s.append ("<td>")
--					s.append ("Upgrade")
--					s.append ("</td>")
				end

				s.append ("</tr>")
			end
			s.append ("</table>%N")

			r.set_main_content (s)
			r.execute
		end

end
