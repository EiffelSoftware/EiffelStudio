note
	description: "Summary description for {CMS_ROOT_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ROOT_WEBAPI_HANDLER

inherit
	CMS_WEBAPI_HANDLER

	WSF_URI_HANDLER

create
	make

feature -- Access

	router: detachable WSF_ROUTER

feature -- Element change

	set_router (a_router: like router)
		do
			router := a_router
		end

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			rep: HM_WEBAPI_RESPONSE
			vis: WSF_ROUTER_AGENT_ITERATOR
			j: JSON_ARRAY
		do
			rep := new_response (req, res)
			rep.add_string_field ("site_name", api.setup.site_name)
			if attached api.user as u then
				add_user_links_to (u, rep)
			elseif api.has_permission ("account register") then
				rep.add_link ("register", Void, api.webapi_path ("/account/register"))
			end
			if
				attached req.query_parameter ("router") as p_router and then
				p_router.same_string ("yes") and then
				attached router as l_router
			then
				create j.make_empty
				create vis
				vis.on_item_actions.extend (agent (i_item: WSF_ROUTER_ITEM; i_json: JSON_ARRAY)
					local
						jo: JSON_OBJECT
						s: STRING
					do
						create jo.make_with_capacity (3)
						jo.put_string (i_item.mapping.associated_resource, "resource")
						create s.make_empty
						if attached i_item.request_methods as methds and then not methds.is_empty then
							across
								methds as ic
							loop
								if not s.is_empty then
									s.extend (',')
								end
								s.append (ic.item)
							end
							jo.put_string (s, "request_methods")
						else
							s.append ("*")
						end
						jo.put_string (i_item.mapping.description, "description")
						i_json.extend (jo)
					end(?, j))
				vis.process_router (l_router)
				rep.add_iterator_field ("routing", j)
--				vis.on_mapping_actions.extend (agent (i_mapping: WSF_ROUTER_MAPPING; i_json: JSON_OBJECT)
--					do
--					end(?, j))
			end
			rep.add_self (req.percent_encoded_path_info)
			rep.execute
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
