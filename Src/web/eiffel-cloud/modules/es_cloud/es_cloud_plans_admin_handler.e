note
	description: "Summary description for {ES_CLOUD_PLANS_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_PLANS_ADMIN_HANDLER

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
			if req.is_get_request_method then
				display_plans (req, res)
			elseif req.is_post_request_method then
				post_plan (req, res)
			else
				send_bad_request (req, res)
			end
		end

	post_plan (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			l_plan: detachable ES_CLOUD_PLAN
			l_plan_name, l_plan_title, l_plan_description: detachable READABLE_STRING_32
			s: STRING
		do
			r := new_generic_response (req, res)
			create s.make_empty
			if attached {CMS_FORM} new_edit_plan_form (req, Void) as f then
				f.process (r)
				if attached f.last_data as fd then
					l_plan_name := fd.string_item ("name")
					l_plan_title := fd.string_item ("title")
					l_plan_description := fd.string_item ("description")
					if l_plan_name = Void then
						fd.report_invalid_field ("name", "Missing name")
					else
						l_plan := es_cloud_api.plan_by_name (l_plan_name)
						if l_plan /= Void then
							r.add_warning_message ("Updating existing plan.")
						else
							create l_plan.make (l_plan_name)
						end
						l_plan.set_title (l_plan_title)
						l_plan.set_description (l_plan_description)
						es_cloud_api.save_plan (l_plan)
						if es_cloud_api.has_error then
							fd.report_error ("Issue while saving plan!")
						else
							r.add_success_message ("Plan successfully saved.")
							r.set_redirection (r.location)
						end
					end
					if fd.has_error then
						f.append_to_html (r.wsf_theme, s)
					end
				end
			end
			r.set_main_content (s)
			r.execute
		end

	display_plans (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
		do
			r := new_generic_response (req, res)
			create s.make_from_string ("<h1>Plans...</h1>")
			s.append ("<table style=%"border: solid 1px black%"><tr><th>Name</th><th>Title</th>")
			s.append ("</tr>")
			across
				es_cloud_api.plans as ic
			loop
				s.append ("<tr><td>")
				s.append ("<a href=%""+ api.administration_path ("/cloud/subscriptions/?plan=" + url_encoded (ic.item.name)) + "%">")
				s.append (html_encoded (ic.item.name))
				s.append ("</a></td>")
				if attached ic.item.title as l_title then
					s.append ("<td>")
					s.append (html_encoded (l_title))
					s.append ("</td>")
				else
					s.append ("<td>")
					s.append ("</td>")
				end
				if attached ic.item.description as l_description then
					s.append ("<td>")
					s.append (html_encoded (l_description))
					s.append ("</td>")
				else
					s.append ("<td>")
					s.append ("</td>")
				end
				s.append ("</tr>")
			end
			s.append ("</table>%N")
			if api.has_permission ("admin es plans") then
				if attached new_edit_plan_form (req, Void) as f then
					f.append_to_html (r.wsf_theme, s)
				end
			end
			r.set_main_content (s)
			r.execute
		end

	new_edit_plan_form (req: WSF_REQUEST; a_plan: detachable ES_CLOUD_PLAN): CMS_FORM
		local
			tf: WSF_FORM_TEXT_INPUT
			l_area: WSF_FORM_TEXTAREA
			l_submit: WSF_FORM_SUBMIT_INPUT
		do
			create Result.make (req.percent_encoded_path_info, "es-cloud-edit-plan")
			Result.extend_html_text ("<h1>Create a new plan...</h1>")
			create tf.make ("name")
			if a_plan /= Void then
				tf.set_text_value (a_plan.name.as_string_32)
			end
			tf.set_label ("Name")
			tf.set_size (20)
			Result.extend (tf)
			create tf.make ("title")
			if a_plan /= Void and then attached a_plan.title as l_title then
				tf.set_text_value (l_title)
			end
			tf.set_label ("Title")
			tf.set_size (20)
			Result.extend (tf)

			create l_area.make ("description")
			if a_plan /= Void and then attached a_plan.description as l_desc then
				l_area.set_text_value (l_desc)
			end
			l_area.set_label ("Description")
			l_area.set_cols (60)
			l_area.set_rows (5)
			Result.extend (l_area)

			create l_submit.make_with_text ("op", "Add Plan")
			Result.extend (l_submit)
		end

end
