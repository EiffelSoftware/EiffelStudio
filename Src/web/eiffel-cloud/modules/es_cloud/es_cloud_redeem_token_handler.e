note
	description: "Summary description for {ES_CLOUD_REDEEM_TOKENS_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_REDEEM_TOKEN_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_mod: ES_CLOUD_MODULE; a_mod_api: ES_CLOUD_API)
		do
			es_cloud_module := a_mod
			make_with_cms_api (a_mod_api.cms_api)
			es_cloud_api := a_mod_api
		end

feature -- API

	es_cloud_module: ES_CLOUD_MODULE

	es_cloud_api: ES_CLOUD_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			l_redeem_token: ES_CLOUD_REDEEM_TOKEN
		do
			if req.is_get_request_method then
				if attached {WSF_STRING} req.path_parameter ("redeem") as p_redeem_token then
					l_redeem_token := es_cloud_api.redeem_token (p_redeem_token.value)
					if l_redeem_token /= Void then
						process_get_redeem_token (l_redeem_token, req, res)
					else
						send_not_found_with_message ("Unknown redeem token %"" + html_encoded (p_redeem_token.value) + "%"", req, res)
					end
				else
					process_get_redeem_token (Void, req, res)
				end
			elseif req.is_post_request_method then
				if attached {WSF_STRING} req.form_parameter ("redeem_token") as p_redeem_token then
					l_redeem_token := es_cloud_api.redeem_token (p_redeem_token.value)
				elseif attached {WSF_STRING} req.query_parameter ("redeem_token") as p_redeem_token then
					l_redeem_token := es_cloud_api.redeem_token (p_redeem_token.value)
				elseif attached {WSF_STRING} req.path_parameter ("redeem") as p_redeem_token then
					l_redeem_token := es_cloud_api.redeem_token (p_redeem_token.value)
				end
				if l_redeem_token /= Void then
					process_post (l_redeem_token, req, res)
				else
					send_bad_request (req, res)
				end
			else
				send_bad_request (req, res)
			end
		end

	process_get_redeem_token (a_redeem_token: detachable ES_CLOUD_REDEEM_TOKEN; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING_8
			f: CMS_FORM
			sub: WSF_FORM_SUBMIT_INPUT
			tf: WSF_FORM_TEXT_INPUT
		do
			r := new_generic_response (req, res)
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			create s.make_empty
			if attached api.user as l_user then
				if a_redeem_token = Void then
					create f.make (req.percent_encoded_path_info, "enter_redeem_token")
					f.extend_html_text ("<h2>Enter your redeem token</h2>")
					create tf.make ("redeem_token")
					tf.set_description ("Enter the token you got when purchasing the product")
					tf.set_size (50)
					f.extend (tf)
					create sub.make_with_text ("op", "Search")
					f.extend (sub)
					f.append_to_html (r.wsf_theme, s)
				elseif a_redeem_token.is_redeemed then
					s.append ("<h2>The redeem token [" + html_encoded (a_redeem_token.name) + "] was already converted to a license</h2>")
					if
						attached a_redeem_token.license_key as lic_key and then
						attached es_cloud_api.license_by_key (lic_key) as lic and then
						attached es_cloud_api.user_for_license (lic) as lic_user and then
						lic_user.same_as (l_user)
					then
						s.append ("<p>See your associated license:</p>")
						es_cloud_api.append_short_license_view_to_html (lic, lic_user, es_cloud_module, s)
					else
						s.append ("<p>The associated license is owned by another user!</p>")
					end
				elseif attached es_cloud_api.plan_by_name (a_redeem_token.plan_name) as pl then
					create f.make (req.percent_encoded_path_info, "redeeming")
					f.set_method_post
					f.extend_html_text ("<h2>Redeem token: " + html_encoded (a_redeem_token.name) + "</h2>")
					f.extend_html_text ("<p>Convert to a new %"" + html_encoded (pl.title_or_name) + "%" license ?</p>")
					create sub.make_with_text ("op", form_apply_redeem_token)
					f.extend (sub)
					f.append_to_html (r.wsf_theme, s)
				else
					s.append ("<h2>Corrupted token, please check with your seller.</h2>")
				end
			else
				s.append ("<h2>To redeem a purchase token, you need to have an account and be signed-in.</h2>")
				if attached {CMS_AUTHENTICATION_MODULE} api.module ({CMS_AUTHENTICATION_MODULE}) as l_auth_mod then
					l_auth_mod.append_login_or_register_box_to_html (api, req.path_info, s)
				else
					s.append ("<p>Please Login or Register...</p>")
				end
			end
			r.set_main_content (s)
			r.execute
		end

	process_post (a_redeem_token: ES_CLOUD_REDEEM_TOKEN; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			l_cloud_user: ES_CLOUD_USER
			s: STRING_8
			f: CMS_FORM
			sub: WSF_FORM_SUBMIT_INPUT
		do
			r := new_generic_response (req, res)
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			create s.make_empty
			if attached api.user as l_user then
				l_cloud_user := l_user
				if a_redeem_token.is_redeemed then
					s.append ("<h2 class=%"error%">ERROR: the given redeem token " + html_encoded (a_redeem_token.name) + " was already converted to a license</h2>")
					if
						attached a_redeem_token.license_key as lic_key and then
						attached es_cloud_api.license_by_key (lic_key) as lic and then
						attached es_cloud_api.user_for_license (lic) as lic_user and then
						lic_user.same_as (l_user)
					then
						s.append ("<p>See your associated license at " + es_cloud_module.license_location (lic) + "</p>")
						es_cloud_api.append_short_license_view_to_html (lic, lic_user, es_cloud_module, s)
					else
						s.append ("<p>The associated license is owned by another user!</p>")
					end
				elseif attached es_cloud_api.plan_by_name (a_redeem_token.plan_name) as pl then
					if attached req.form_parameter ("op") as p_op and then p_op.same_string (form_apply_redeem_token)  then
						es_cloud_api.redeem (a_redeem_token, l_cloud_user)
						if
							a_redeem_token.is_redeemed and then
							attached a_redeem_token.license_key as lic_key and then
							attached es_cloud_api.license_by_key (lic_key) as lic and then
							attached es_cloud_api.user_for_license (lic) as lic_user and then
							lic_user.same_as (l_user)
						then
							s.append ("<h2>See your new license</h2>")
							es_cloud_api.append_short_license_view_to_html (lic, lic_user, es_cloud_module, s)
						else
							s.append ("<h2>Unexpected issue: your token was not converted to a new license.</h2>")
						end
					else
						create f.make (req.percent_encoded_path_info, "redeeming")
						f.set_method_post
						f.extend_html_text ("<h2>Redeem token: " + html_encoded (a_redeem_token.name) + "</h2>")
						f.extend_html_text ("<p>Convert to a new %"" + html_encoded (pl.title_or_name) + "%" license ?</p>")
						f.extend_hidden_input ("redeem_token", a_redeem_token.name)
						create sub.make_with_text ("op", form_apply_redeem_token)
						f.extend (sub)
						f.append_to_html (r.wsf_theme, s)
					end
				else
					s.append ("<h2>Corrupted token, please check with your seller.</h2>")
				end
			else
				s.append ("<h2>To redeem a purchase token, you need to have an account and be signed-in.</h2>")
				s.append ("<p>Please Login or Register...</p>")
			end

			r.set_main_content (s)
			r.execute
		end

	form_apply_redeem_token: STRING = "Apply"

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

