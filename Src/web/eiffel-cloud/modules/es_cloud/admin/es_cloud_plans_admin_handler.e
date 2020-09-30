note
	description: "Summary description for {ES_CLOUD_PLANS_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_PLANS_ADMIN_HANDLER

inherit
	ES_CLOUD_ADMIN_HANDLER

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if api.has_permission ("manage es accounts") then
				if req.is_get_request_method then
					if attached {WSF_STRING} req.path_parameter ("pid") as p_pid then
						if attached es_cloud_api.plan_by_name (p_pid.value) as p then
							display_plan (p, req, res)
						else
							send_bad_request (req, res)
						end
					else
						display_plans (req, res)
					end
				elseif req.is_post_request_method then
					post_plan (req, res)
				else
					send_bad_request (req, res)
				end
			else
				send_access_denied (req, res)
			end
		end

	post_plan (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			l_plan: detachable ES_CLOUD_PLAN
			l_plan_name: detachable READABLE_STRING_8
			l_plan_title, l_plan_description, l_plan_data, l_op: detachable READABLE_STRING_32
			l_plan_id: INTEGER
			l_confirmation_field: WSF_FORM_SUBMIT_INPUT
			s: STRING
			f: CMS_FORM
		do
			r := new_generic_response (req, res)
			add_primary_tabs (r)
			create s.make_empty
			f := new_edit_plan_form (req, Void)
			if f /= Void then
				f.process (r)
				if attached f.last_data as fd then
					l_plan_id := fd.integer_item ("id")
					if
						attached fd.string_item ("name") as l_plan_name_32 and then
						l_plan_name_32.is_valid_as_string_8
					then
						l_plan_name := l_plan_name_32.to_string_8
					else
						l_plan_name := Void
					end
					l_plan_title := fd.string_item ("title")
					l_plan_description := fd.string_item ("description")
					l_plan_data := fd.string_item ("data")
					l_op := fd.string_item ("op")
					if l_plan_id /= 0 then
						l_plan := es_cloud_api.plan (l_plan_id)
					end
					if l_plan_name = Void then
						fd.report_invalid_field ("name", "Missing name")
					else
						if l_plan = Void then
							l_plan := es_cloud_api.plan_by_name (l_plan_name)
						end
						if
							l_op /= Void and then (
									l_op.same_string (delete_plan_text)
									or l_op.same_string (confirm_delete_plan_text)
								)
						then
							if attached fd.string_item (confirmation_field_name) as l_confirmation and then l_confirmation.same_string ("yes") then
								if l_plan /= Void then
									es_cloud_api.delete_plan (l_plan)
									if es_cloud_api.has_error then
										fd.report_error ("Issue while deleting plan!")
									else
										r.add_success_message ("Plan successfully deleted.")
										r.set_redirection (api.administration_path ("/cloud/plans/"))
									end
								else
									fd.report_error ("Could not find and delete plan %""+ l_plan_name +"%"!")
									r.add_error_message ("Could not find and delete plan %""+ l_plan_name +"%"!")
								end
							else
								f := new_edit_plan_form (req, l_plan)
								r.add_notice_message ("Please confirm the plan deletion!")
								fd.report_error ("Please confirm the plan deletion!")

								create l_confirmation_field.make ("op")
								l_confirmation_field.set_text_value (confirm_delete_plan_text)
								f.extend (l_confirmation_field)
								f.set_field_text_value (confirmation_field_name, "yes")
								if attached f.fields_by_name ("op") as lst then
									across
										lst as ic
									loop
										if
											attached {WSF_FORM_SUBMIT_INPUT} ic.item as l_op_submit and then
											attached l_op_submit.default_value as dv and then dv.same_string_general (delete_plan_text)
										then
											f.remove (l_op_submit)
										end
									end
								end

							end
						else
							if l_plan /= Void then
								r.add_warning_message ("Updating existing plan.")
								l_plan.set_name (l_plan_name)
							else
								create l_plan.make (l_plan_name)
							end
							l_plan.set_title (l_plan_title)
							l_plan.set_description (l_plan_description)
							l_plan.set_data (l_plan_data)
							es_cloud_api.save_plan (l_plan)
							if es_cloud_api.has_error then
								fd.report_error ("Issue while saving plan!")
							else
								r.add_success_message ("Plan successfully saved.")
								r.set_redirection (api.administration_path ("/cloud/plans/"))
							end
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
			add_primary_tabs (r)
			create s.make_from_string ("<h1>Plans...</h1>")
			s.append ("<table class=%"with_border%" style=%"border: solid 1px black%"><tr><th>Name</th><th>Title</th><th>Description</th><th>data</th><th/>")
			s.append ("</tr>")
			across
				es_cloud_api.sorted_plans as ic
			loop
				s.append ("<tr><td>")
				s.append ("<a href=%""+ api.administration_path ("/cloud/plans/" + url_encoded (ic.item.name)) + "%">")
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
				if attached ic.item.data as l_data then
					s.append ("<td>")
					s.append (html_encoded (l_data))
					s.append ("</td>")
				else
					s.append ("<td>")
					s.append ("</td>")
				end

				s.append ("<td>")
				s.append ("<a href=%""+ api.administration_path ("/cloud/plans/" + url_encoded (ic.item.name)) + "%">Edit</a> | ")
				s.append ("<a href=%""+ api.administration_path ("/cloud/subscriptions/?plan=" + url_encoded (ic.item.name)) + "%">Subscriptions</a>")
				s.append ("</td>")

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

	display_plan (a_plan: ES_CLOUD_PLAN; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
		do
			r := new_generic_response (req, res)
			add_primary_tabs (r)
			if api.has_permission ("admin es plans") then

				create s.make_from_string ("<h1>Plan "+ html_encoded (a_plan.name) +"</h1>")
				s.append ("<p><a href=%""+ api.administration_path ("/cloud/subscriptions/?plan=" + url_encoded (a_plan.name)) + "%">Subscriptions to plan ")
				s.append (html_encoded (a_plan.name))
				s.append ("</a></p>")

				if attached new_edit_plan_form (req, a_plan) as f then
					f.append_to_html (r.wsf_theme, s)
				end
			else
				s := "Permission denied!"
			end
			r.set_main_content (s)
			r.execute
		end

	new_edit_plan_form (req: WSF_REQUEST; a_plan: detachable ES_CLOUD_PLAN): CMS_FORM
		local
			hf: WSF_FORM_HIDDEN_INPUT
			tf: WSF_FORM_TEXT_INPUT
			l_area: WSF_FORM_TEXTAREA
			l_submit: WSF_FORM_SUBMIT_INPUT
		do
			create Result.make (req.percent_encoded_path_info, "es-cloud-edit-plan")
			Result.extend_html_text ("<h1>Create a new plan...</h1>")
			create hf.make ("id")
			if a_plan /= Void and then a_plan.has_id then
				hf.set_text_value (a_plan.id.out)
			end
			Result.extend (hf)

			create hf.make (confirmation_field_name)
			Result.extend (hf)

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
			l_area.set_rows (25)
			Result.extend (l_area)

			create tf.make ("data")
			if a_plan /= Void and then attached a_plan.data as l_data then
				tf.set_text_value (l_data)
			end
			tf.set_label ("Data")
			tf.set_size (70)
			Result.extend (tf)

			if a_plan /= Void then
				create l_submit.make_with_text ("op", save_plan_text)
				Result.extend (l_submit)
				if attached es_cloud_api.plan_subscriptions (a_plan) as subs and then not subs.is_empty then
					Result.extend_raw_text ("Plan has " + subs.count.out + " subscription(s).")
				else
					create l_submit.make_with_text ("op", delete_plan_text)
					Result.extend (l_submit)
				end
			else
				create l_submit.make_with_text ("op", add_plan_text)
				Result.extend (l_submit)
			end
		end

	add_plan_text: STRING_32 = "Add Plan"
	save_plan_text: STRING_32 = "Save Plan"
	delete_plan_text: STRING_32 = "Delete Plan"

	confirm_delete_plan_text: STRING_32 = "Confirm Plan Deletion"

	confirmation_field_name: STRING = "confirmation"

end
