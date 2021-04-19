note
	description: "Summary description for {ES_CLOUD_STORE_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_STORE_ADMIN_HANDLER

inherit
	ES_CLOUD_ADMIN_HANDLER

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if api.has_permission ("manage es store") then
				if req.is_get_request_method then
					if attached {WSF_STRING} req.path_parameter ("currency") as p_currency then
						display_store (p_currency.url_encoded_value, req, res)
					else
						display_store (Void, req, res)
					end
				elseif req.is_post_request_method then
					post_store (req, res)
				else
					send_bad_request (req, res)
				end
			else
				send_access_denied (req, res)
			end
		end

	post_store (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			f: like new_cloud_edit_store_form
		do
			if api.has_permission ("manage es store") then
				r := new_generic_response (req, res)
				add_primary_tabs (r)
				create s.make_empty
				s.append ("<h1>Store ...</h1>")

				f := new_cloud_edit_store_form (req, Void)
				if f /= Void then
					f.process (r)
					if attached {WSF_FORM_DATA} f.last_data as fd then
						if
							attached fd.string_item ("store_currency") as l_currency and then
							attached fd.string_item ("store_json") as l_json
						then
							if attached es_cloud_api.json_to_store ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_json), l_currency.to_string_8, True) as l_store then
								es_cloud_api.save_store (l_store)
							else
								fd.report_error ("Could not save associated store")
							end
						else
							fd.report_error ("Missing field!")
						end
						if fd.has_error then
							f.append_to_html (r.wsf_theme, s)
							r.add_error_message ("Error: could not save the store")
						else
							r.add_success_message ("Store saved")
							r.set_redirection (req.request_uri)
						end
					end
				end
				r.set_main_content (s)
				r.execute
			else
				send_access_denied (req, res)
			end
		end

	display_store (a_currency: detachable READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING_8
			f: CMS_FORM
		do
			if api.has_permission ("manage es store") then
				r := new_generic_response (req, res)
				add_primary_tabs (r)
				create s.make_from_string ("<h1>Store...</h1>")
				if api.has_permission ("admin es store") then
					f := new_cloud_edit_store_form (req, es_cloud_api.store (a_currency, True))
					f.append_to_html (r.wsf_theme, s)
				end
				r.set_main_content (s)
				r.execute
			else
				send_access_denied (req, res)
			end
		end

	new_cloud_edit_store_form (req: WSF_REQUEST; a_store: detachable ES_CLOUD_STORE): CMS_FORM
		local
			tf: WSF_FORM_TEXT_INPUT
			l_area: WSF_FORM_TEXTAREA
			l_submit: WSF_FORM_SUBMIT_INPUT
		do
			create Result.make (req.percent_encoded_path_info, "es-cloud-edit-store")
			Result.set_method_post

			if a_store /= Void then
				create tf.make_with_text ("store_currency", a_store.currency)
			else
				create tf.make_with_text ("store_currency", "")
			end
			tf.set_label ("Currency")
			tf.set_description ("Leave empty to use the default currency.")
			Result.extend (tf)

			create l_area.make ("store_json")
			if a_store /= Void then
				l_area.set_text_value (es_cloud_api.store_to_json (a_store))
			end
			l_area.set_label ("Store")
			l_area.set_cols (80)
			l_area.set_rows (25)
			Result.extend (l_area)


			if a_store /= Void then
				create l_submit.make_with_text ("op", save_store_text)
				Result.extend (l_submit)
			else
				create l_submit.make_with_text ("op", add_store_text)
				Result.extend (l_submit)
			end
		end

	add_store_text: STRING_32 = "Add Store"
	save_store_text: STRING_32 = "Save Store"

end
