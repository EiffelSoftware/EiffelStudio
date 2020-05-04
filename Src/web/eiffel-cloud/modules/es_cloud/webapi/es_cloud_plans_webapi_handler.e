note
	description: "Summary description for {ES_CLOUD_PLANS_WEBAPI_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_PLANS_WEBAPI_HANDLER

inherit
	ES_CLOUD_WEBAPI_HANDLER

create
	make

feature -- Execution

	execute (a_version: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		do
			if req.is_get_request_method then
				if attached {WSF_STRING} req.path_parameter ("pid") as pid and then pid.is_integer then
					handle_plan (a_version, pid.integer_value, req, res)
				else
					handle_plan_list (a_version, req, res)
				end
			else
				new_bad_request_error_response (Void, req, res).execute
			end
		end

	handle_plan (a_version: READABLE_STRING_GENERAL; pid: INTEGER; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
		do
			r := new_response (req, res)
			if attached {ES_CLOUD_PLAN} es_cloud_api.plan (pid) as l_plan then
				create tb.make (5)
				tb.force (l_plan.id.out, "id")
				tb.force (l_plan.name, "name")
				if attached l_plan.title as l_title then
					tb.force (l_title, "title")
				end
				if attached l_plan.description as l_description then
					tb.force (l_description, "description")
				end
				tb.force (l_plan.weight.out, "weight")
				tb.force (l_plan.concurrent_sessions_limit.out, "concurrent_sessions_limit")

				r.add_table_iterator_field ("es:plan", tb)
				r.add_link ("plans", "plans", cloud_plans_link (a_version))
				r.add_self (r.location)
			else
				r := new_error_response ("No plan found", req, res)
			end
			r.execute
		end

	handle_plan_list (a_version: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			req.is_get_request_method
		local
			r: like new_response
			tb: STRING_TABLE [detachable ANY]
			tb_plans: STRING_TABLE [detachable ANY]
		do
			r := new_response (req, res)
			if attached es_cloud_api.plans as lst then
				create tb_plans.make (lst.count)
				across
					lst as ic
				loop
					if attached {ES_CLOUD_PLAN} ic.item as l_plan then
						create tb.make (5)
						tb.force (l_plan.id.out, "id")
						tb.force (l_plan.name, "name")
						if attached l_plan.title as l_title then
							tb.force (l_title, "title")
						end
						if attached l_plan.description as l_description then
							tb.force (l_description, "description")
						end
						tb.force (l_plan.weight.out, "weight")
						tb_plans.force (tb, l_plan.id.out)
						r.add_link (url_encoded (l_plan.id.out), html_encoded (l_plan.name), cloud_plan_link (a_version, l_plan.id))
					end
				end
				r.add_table_iterator_field ("es:plans", tb_plans)
			end
			r.execute
		end


note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

