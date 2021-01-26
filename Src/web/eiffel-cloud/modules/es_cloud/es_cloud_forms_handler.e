note
	description: "Summary description for {ES_CLOUD_FORMS_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_FORMS_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_with_cms_api
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_module: ES_CLOUD_MODULE; a_mod_api: ES_CLOUD_API)
		do
			make_with_cms_api (a_mod_api.cms_api)
			module := a_module
			es_cloud_api := a_mod_api
		end

feature -- API

	module: ES_CLOUD_MODULE

	es_cloud_api: ES_CLOUD_API

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler for `req' and respond in `res'.
		local
			u: ES_CLOUD_USER
		do
			if attached {WSF_STRING} req.path_parameter ("form_id") as p_form_id then
				if attached api.user as l_user then
					create u.make (l_user)
				end
				if p_form_id.same_string (contributor_form_id) then
					if u /= Void then
						if req.is_post_request_method then
							post_cloud_contributor (u, req, res)
						else
							get_cloud_contributor (u, req, res)
						end
					else
						get_cloud_contributor (Void, req, res)
					end
				elseif p_form_id.same_string (trial_extension_form_id) then
					if
						u /= Void and then
						attached req.string_item ("license") as s_lic and then
						attached es_cloud_api.license_by_key (s_lic) as lic
					then
						if req.is_post_request_method then
							post_cloud_trial_extension_request (lic, u, req, res)
						else
							get_cloud_trial_extension_request (lic, u, req, res)
						end
					else
						send_bad_request (req, res)
					end
				elseif p_form_id.same_string (university_form_id) then
					if u /= Void then
						if req.is_post_request_method then
							post_cloud_university (u, req, res)
						else
							get_cloud_university (u, req, res)
						end
					else
						get_cloud_university (Void, req, res)
					end
				else
					send_not_found (req, res)
				end
			else
				send_bad_request (req, res)
			end
		end

feature -- Constants

	contributor_form_id: STRING = "contributor"

	trial_extension_form_id: STRING = "trial_extension"

	university_form_id: STRING = "university"

feature -- Contributor		

	post_cloud_contributor (a_cloud_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: like new_contributor_form
			r: like new_generic_response
			k: READABLE_STRING_GENERAL
			s: STRING_8
			msg: STRING_8
			l_processed: BOOLEAN
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title (api.html_encoded (api.real_user_display_name (a_cloud_user.cms_user)))
			create s.make_empty

			f := new_contributor_form (a_cloud_user, req)
			f.process (r)
			if
				attached f.last_data as fd and then
				attached fd.item_same_string ("op", form_contributor_submit_op_text)
			then
				if not (attached {WSF_STRING} req.query_parameter ("op") as q_op and then not q_op.same_string (form_contributor_submit_op_text)) then
					create msg.make_empty
					msg.append ("<h2>Application for a %"contributor%" license, from user " + api.user_html_absolute_link (a_cloud_user.cms_user) + "</h2>%N")
					msg.append ("<div><strong>Date</strong>: " + api.date_time_to_iso8601_string (create {DATE_TIME}.make_now_utc) + " (UTC).</div>%N")

					across
						fd as ic
					loop
						k := ic.key
						if
							k.same_string ("contrib_count")
							or k.same_string ("op")
							or k.same_string ("op_add_contrib")
						then
								-- Skip
						else
							msg.append ("<h3>" + utf_8_encoded (k) + "</h3>%N<pre>")
							if attached ic.item as v then
							 	msg.append (utf_8_encoded (v.string_representation))
							end
						 	msg.append ("</pre>%N")
						end
					end
					if attached api.new_html_email (api.setup.site_notification_email, "New Contributor license REQUEST", msg) as e then
						api.process_email (e)
						r.add_success_message ("Your application was submitted, and will be analyzed soon.")
						l_processed := True
					else
						r.add_error_message ("Your application was not recorderd, an error occurred, please use the contact page and copy the following text.")
						across
							fd as ic
						loop
							k := ic.key
							if
								k.same_string ("contrib_count")
								or k.same_string ("op")
								or k.same_string ("op_add_contrib")
							then
									-- Skip
							else
								s.append ("<li>" + html_encoded (ic.key) + ":<pre>")
								if attached ic.item as v then
								 	s.append (html_encoded (v.string_representation))
								end
							 	s.append ("</pre></li>%N")
							end
						end
						l_processed := True
					end
				end
				if not l_processed then
					append_welcome_contributor_header_to (a_cloud_user, s, req)
					fd.apply_to_associated_form
					if attached {WSF_STRING} req.query_parameter ("contrib_count") as p then
						f.set_field_text_value ("contrib_count", p.value)
					end
					f.append_to_html (r.wsf_theme, s)
				end
			else
				append_welcome_contributor_header_to (a_cloud_user, s, req)
				f.append_to_html (r.wsf_theme, s)
			end
			r.set_main_content (s)
			r.execute
		end

	get_cloud_contributor (a_cloud_user: detachable ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			f: like new_contributor_form
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title (api.html_encoded ("Apply for a contributor license"))
			s := ""
			append_welcome_contributor_header_to (a_cloud_user, s, req)
			if a_cloud_user /= Void then
				f := new_contributor_form (a_cloud_user, req)
				if req.is_post_request_method then
					f.process (r)
				end
				f.append_to_html (r.wsf_theme, s)
			end
			r.set_main_content (s)
			r.execute
		end

	append_welcome_contributor_header_to (u: detachable ES_CLOUD_USER; s: STRING_8; req: WSF_REQUEST)
		do
			s.append ("<div class=%"cloud-form-header%">")
			s.append ("[
				<p>
				Eiffel benefits from a thriving community of developers who passionately share Eiffel's goals of high-quality software development based on the principles of Design by Contract and the focus on reusable library components.
				Active members of the community who contribute libraries and tools are entitled to a special Eiffel contributor license providing them access to EiffelStudio at no charge.
				</p>
			]")
			if u = Void then
				s.append ("<p>To request a <em>contributor</em> license, you <strong>must be logged in</strong> and fill a form - please " + api.link ("SIGN IN NOW", {CMS_AUTHENTICATION_MODULE}.roc_login_location + "?destination="+ req.percent_encoded_path_info, Void))
			else
				s.append ("<p>To request a <em>contributor</em> license, please fill in the following form")
			end
			s.append (".</p>")
			s.append ("<p>We ask you to update the form once a year if you wish to retain the license.</p>")
			s.append ("</div>")
		end

	new_contributor_form (u: detachable ES_CLOUD_USER; req: WSF_REQUEST): CMS_FORM
		local
			hb: WSF_FORM_DIV
			f_name: WSF_FORM_TEXT_INPUT
			f_email: WSF_FORM_EMAIL_INPUT
			f_submit: WSF_FORM_SUBMIT_INPUT

			f_contrib_nature: WSF_FORM_SELECT
			f_nature: WSF_FORM_SELECT_OPTION
			f_contrib_name: WSF_FORM_TEXT_INPUT
			f_contrib_description, f_contrib_comments: WSF_FORM_TEXTAREA
			l_hidden: WSF_FORM_HIDDEN_INPUT
			l_but: WSF_FORM_SUBMIT_INPUT

			f_set: WSF_FORM_FIELD_SET
			l_prefix: STRING
			l_contrib_nb: INTEGER
			l_contrib_max: INTEGER
		do
			l_contrib_max := 3
			l_contrib_nb := 1
			if attached {WSF_STRING} req.query_parameter ("contrib_count") as v then
				l_contrib_nb := v.integer_value.max (l_contrib_nb).min (l_contrib_max)
			elseif attached {WSF_STRING} req.form_parameter ("contrib_count") as v then
				l_contrib_nb := v.integer_value.max (l_contrib_nb).min (l_contrib_max)
			end

			create Result.make (req.percent_encoded_path_info, "cloud_contributor")
			Result.set_method_post

			create hb.make
			hb.add_css_class ("horizontal")
			Result.extend (hb)

			create f_name.make ("contributor_name")
			f_name.set_is_required (True)
			f_name.set_label ("Your name")
			if u /= Void then
				f_name.set_text_value (u.cms_user.name)
			end
			hb.extend (f_name)
			create f_email.make ("contributor_email")
			f_email.set_is_required (True)
			f_email.set_label ("Your email")
			if u /= Void and then attached u.cms_user.email as e then
				f_email.set_text_value (e)
			end
			hb.extend (f_email)

			Result.extend_html_text ("<h3>Contributions over the past two years:</h3>")
			across
				1 |..| l_contrib_nb as ic
			loop
				l_prefix := "contrib[" + ic.item.out +"]"
				create f_set.make
				f_set.add_css_class ("contrib-frame")
				f_set.set_legend ("Contribution #" + ic.item.out)
				Result.extend (f_set)
				create hb.make
				hb.add_css_class ("horizontal")
				f_set.extend (hb)

				create f_contrib_nature.make (l_prefix + "[nature]")
				create f_nature.make ("new-library", "New library"); f_contrib_nature.add_option (f_nature)
				create f_nature.make ("add-to-library", "Addition to existing library"); f_contrib_nature.add_option (f_nature)
				create f_nature.make ("tool", "Tool"); f_contrib_nature.add_option (f_nature)
				create f_nature.make ("doc", "Documentation"); f_contrib_nature.add_option (f_nature)
				create f_nature.make ("other", "Other"); f_contrib_nature.add_option (f_nature)
				f_contrib_nature.set_label ("Nature of the contribution")
				hb.extend (f_contrib_nature)

				create f_contrib_name.make (l_prefix + "[name]")
				f_contrib_name.set_label ("Name of the contribution")
				f_contrib_name.set_placeholder ("Name of the contribution")
				hb.extend (f_contrib_name)

				create f_contrib_description.make (l_prefix + "[desc]")
				f_contrib_description.set_cols (60)
				f_contrib_description.set_rows (5)
				f_contrib_description.set_label ("Short description")
				f_contrib_description.set_description ("Use the wikitext syntax")
				f_set.extend (f_contrib_description)
			end
			create l_hidden.make_with_text ("contrib_count", l_contrib_nb.out)
			l_hidden.set_text_value (l_contrib_nb.out)
			Result.extend (l_hidden)
			if l_contrib_nb < l_contrib_max then
				create l_but.make_with_text ("op_add_contrib", "+Add a contribution")
				l_but.set_formmethod ("POST")
				l_but.set_formaction (req.percent_encoded_path_info + "?op=add-contrib&contrib_count=" + (l_contrib_nb + 1).out)
				Result.extend (l_but)
			else
				create f_set.make
				f_set.add_css_class ("contrib-frame")
				f_set.set_legend ("Contributions (comments)")
				Result.extend (f_set)

				create f_contrib_comments.make ("contrib_comments")
				f_contrib_comments.set_cols (60)
				f_contrib_comments.set_rows (20)
				f_contrib_comments.set_label ("Describe your current contributions")
				f_contrib_comments.set_placeholder ("[
					* Nature: New Library | Addition to existing library | Tools | Documentation | Other
					* Name: ...
					* Short description:
					...
					]")
				f_contrib_comments.set_description ("[
					Please follow the given model (using wikitext syntax):<pre>
						* Nature: New Library | Addition to existing library | Tools | Documentation | Other
						* Name: ...
						* Short description:
						...</pre>
					]")
				f_set.extend (f_contrib_comments)
			end

			Result.extend_html_text ("<h3>Planned contributions over the next years:</h3>")

			create f_contrib_comments.make ("next_contrib_comments")
			f_contrib_comments.set_cols (60)
			f_contrib_comments.set_rows (20)
			f_contrib_comments.set_label ("Describe your future contributions")
			f_contrib_comments.set_placeholder ("[
				* Nature: New Library | Addition to existing library | Tools | Documentation | Other
				* Name: ...
				* Short description:
				...
				]")
			f_contrib_comments.set_description ("[
				Please follow the given model (using wikitext syntax):<pre>
					* Nature: New Library | Addition to existing library | Tools | Documentation | Other
					* Name: ...
					* Short description:
					...</pre>
				]")
			Result.extend (f_contrib_comments)

			create f_submit.make_with_text ("op", form_contributor_submit_op_text)
			Result.extend (f_submit)
		end

	form_contributor_submit_op_text: STRING = "Submit"

feature -- Contributor		

	post_cloud_university (a_cloud_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: like new_university_form
			r: like new_generic_response
			k: READABLE_STRING_GENERAL
			s: STRING_8
			msg: STRING_8
			l_processed: BOOLEAN
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title (api.html_encoded (api.real_user_display_name (a_cloud_user.cms_user)))
			create s.make_empty

			f := new_university_form (a_cloud_user, req)
			f.process (r)
			if
				attached f.last_data as fd and then
				attached fd.item_same_string ("op", form_university_submit_op_text)
			then
				if not (attached {WSF_STRING} req.query_parameter ("op") as q_op and then not q_op.same_string (form_university_submit_op_text)) then
					create msg.make_empty
					msg.append ("<h2>Application for a %"university%" license, from user " + api.user_html_absolute_link (a_cloud_user.cms_user) + "</h2>%N")
					msg.append ("<div><strong>Date</strong>: " + api.date_time_to_iso8601_string (create {DATE_TIME}.make_now_utc) + " (UTC).</div>%N")

					across
						fd as ic
					loop
						k := ic.key
						if
							k.same_string ("contrib_count")
							or k.same_string ("op")
							or k.same_string ("op_add_contrib")
						then
								-- Skip
						else
							msg.append ("<h3>" + utf_8_encoded (k) + "</h3>%N<pre>")
							if attached ic.item as v then
							 	msg.append (utf_8_encoded (v.string_representation))
							end
						 	msg.append ("</pre>%N")
						end
					end
					if attached api.new_html_email (api.setup.site_notification_email, "New Contributor license REQUEST", msg) as e then
						api.process_email (e)
						r.add_success_message ("Your application was submitted, and will be analyzed soon.")
						l_processed := True
					else
						r.add_error_message ("Your application was not recorderd, an error occurred, please use the contact page and copy the following text.")
						across
							fd as ic
						loop
							k := ic.key
							if
								k.same_string ("contrib_count")
								or k.same_string ("op")
								or k.same_string ("op_add_contrib")
							then
									-- Skip
							else
								s.append ("<li>" + html_encoded (ic.key) + ":<pre>")
								if attached ic.item as v then
								 	s.append (html_encoded (v.string_representation))
								end
							 	s.append ("</pre></li>%N")
							end
						end
						l_processed := True
					end
				end
				if not l_processed then
					append_welcome_university_header_to (a_cloud_user, s, req)
					fd.apply_to_associated_form
					if attached {WSF_STRING} req.query_parameter ("contrib_count") as p then
						f.set_field_text_value ("contrib_count", p.value)
					end
					f.append_to_html (r.wsf_theme, s)
				end
			else
				append_welcome_university_header_to (a_cloud_user, s, req)
				f.append_to_html (r.wsf_theme, s)
			end
			r.set_main_content (s)
			r.execute
		end

	get_cloud_university (a_cloud_user: detachable ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			f: like new_university_form
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title (api.html_encoded ("Apply for a university license"))
			s := ""
			append_welcome_university_header_to (a_cloud_user, s, req)
			if a_cloud_user /= Void then
				f := new_university_form (a_cloud_user, req)
				if req.is_post_request_method then
					f.process (r)
				end
				f.append_to_html (r.wsf_theme, s)
			end
			r.set_main_content (s)
			r.execute
		end

	append_welcome_university_header_to (u: detachable ES_CLOUD_USER; s: STRING_8; req: WSF_REQUEST)
		do
			s.append ("<div class=%"cloud-form-header%">")
			s.append ("[
				<p>
				Eiffel Software's University Partnership Program has helped universities around the world teach programming and Object-Oriented concepts to its students for years.<br/>
				It is free for students and for professors. Eiffel Software also offers a variety of discounts for research and academic developments.
				</p>
			]")
			if u = Void then
				s.append ("<p>To request a <em>university</em> license, you <strong>must be logged in</strong> and fill a form - please " + api.link ("SIGN IN NOW", {CMS_AUTHENTICATION_MODULE}.roc_login_location + "?destination="+ req.percent_encoded_path_info, Void))
			else
				s.append ("<p>To request a <em>university</em> license, please fill in the following form")
			end
			s.append (".</p>")
			s.append ("<p>We ask you to update the form once a year if you wish to retain the license.</p>")
			s.append ("</div>")
		end

	new_university_form (u: detachable ES_CLOUD_USER; req: WSF_REQUEST): CMS_FORM
		local
			f_name: WSF_FORM_TEXT_INPUT
			f_university: WSF_FORM_TEXT_INPUT
			f_position: WSF_FORM_TEXT_INPUT
			f_email: WSF_FORM_EMAIL_INPUT
			f_submit: WSF_FORM_SUBMIT_INPUT

			f_comments: WSF_FORM_TEXTAREA
			f_set: WSF_FORM_FIELD_SET
		do
			create Result.make (req.percent_encoded_path_info, "cloud_university")
			Result.set_method_post

			create f_name.make ("user_name")
			f_name.set_is_required (True)
			f_name.set_label ("Your name")
			if u /= Void then
				f_name.set_text_value (u.cms_user.name)
			end
			Result.extend (f_name)
			create f_email.make ("user_email")
			f_email.set_is_required (True)
			f_email.set_label ("Enter your university email")
			if u /= Void and then attached u.cms_user.email as e then
				f_email.set_text_value (e)
			end
			f_email.set_description ("Please use your email provided by your university")
			Result.extend (f_email)

			create f_university.make ("university_name")
			f_university.set_is_required (True)
			f_university.set_label ("University name")
			Result.extend (f_university)

			create f_position.make ("university_position")
			f_position.set_label ("Position at the university (professor, assistant, student, ...)")
			Result.extend (f_position)

			create f_comments.make ("comments")
			f_comments.set_cols (60)
			f_comments.set_rows (10)
			f_comments.set_label ("Comments")
			f_comments.set_description ("Enter any comment or information helping us to know you are who you claim to be.")
			Result.extend (f_comments)

			create f_submit.make_with_text ("op", form_university_submit_op_text)
			Result.extend (f_submit)
		end

	form_university_submit_op_text: STRING = "Submit"

feature -- Trial extension

	post_cloud_trial_extension_request (lic: ES_CLOUD_LICENSE; a_cloud_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: like new_trial_extension_request_form
			r: like new_generic_response
			k: READABLE_STRING_GENERAL
			s: STRING_8
			msg: STRING_8
			l_processed: BOOLEAN
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title (api.html_encoded (api.real_user_display_name (a_cloud_user.cms_user)))
			create s.make_empty

			f := new_trial_extension_request_form (lic, a_cloud_user, req)
			f.process (r)
			if
				attached f.last_data as fd and then
				attached fd.item_same_string ("op", form_trial_extension_request_submit_op_text)
			then
				if not (attached {WSF_STRING} req.query_parameter ("op") as q_op and then not q_op.same_string (form_trial_extension_request_submit_op_text)) then
					create msg.make_empty
					msg.append ("<h2>Application for a " + html_encoded (lic.plan.title_or_name) + " period extension license, from user " + api.user_html_absolute_link (a_cloud_user.cms_user) + "</h2>%N")
					msg.append ("<p>License: <em>"+  html_encoded (lic.plan.title_or_name) +"</em> " + api.absolute_link (lic.key, module.license_location (lic), Void) + "</p>%N")
					msg.append ("<div><strong>Date</strong>: " + api.date_time_to_iso8601_string (create {DATE_TIME}.make_now_utc) + " (UTC).</div>%N")

					across
						fd as ic
					loop
						k := ic.key
						if k.same_string ("op") then
								-- Skip
						else
							msg.append ("<h3>" + utf_8_encoded (k) + "</h3>%N<pre>")
							if attached ic.item as v then
							 	msg.append (utf_8_encoded (v.string_representation))
							end
						 	msg.append ("</pre>%N")
						end
					end
					if attached api.new_html_email (api.setup.site_notification_email, "REQUEST for a trial period extension", msg) as e then
						api.process_email (e)
						r.add_success_message ("Your application was submitted, and will be analyzed soon.")
						l_processed := True
					else
						r.add_error_message ("Your application was not recorderd, an error occurred, please use the contact page and copy the following text.")
						across
							fd as ic
						loop
							k := ic.key
							if k.same_string ("op") then
									-- Skip
							else
								s.append ("<li>" + html_encoded (ic.key) + ":<pre>")
								if attached ic.item as v then
								 	s.append (html_encoded (v.string_representation))
								end
							 	s.append ("</pre></li>%N")
							end
						end
						l_processed := True
					end
				end
				if not l_processed then
					fd.apply_to_associated_form
					f.append_to_html (r.wsf_theme, s)
				end
			else
				f.append_to_html (r.wsf_theme, s)
			end
			r.set_main_content (s)
			r.execute
		end

	get_cloud_trial_extension_request (lic: ES_CLOUD_LICENSE; a_cloud_user: ES_CLOUD_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			f: like new_trial_extension_request_form
		do
			r := new_generic_response (req, res)
			r.add_javascript_url (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/js/es_cloud.js", Void))
			r.add_style (r.module_name_resource_url ({ES_CLOUD_MODULE}.name, "/files/css/es_cloud.css", Void), Void)
			r.set_title (api.html_encoded ("Apply for a trial period extension"))
			s := ""
			f := new_trial_extension_request_form (lic, a_cloud_user, req)
			if req.is_post_request_method then
				f.process (r)
			end
			f.append_to_html (r.wsf_theme, s)
			r.set_main_content (s)
			r.execute
		end

	new_trial_extension_request_form (lic: ES_CLOUD_LICENSE; u: ES_CLOUD_USER; req: WSF_REQUEST): CMS_FORM
		local
			f_submit: WSF_FORM_SUBMIT_INPUT
			f_application: WSF_FORM_TEXTAREA
			curr_days, asked_days: NATURAL
		do
			create Result.make (req.percent_encoded_path_info, trial_extension_form_id)
			Result.set_method_post

			asked_days := es_cloud_api.potential_trial_extension_days (lic)
			curr_days := lic.duration_in_days

			Result.extend_hidden_input ("user_id", u.cms_user.id.out)
			Result.extend_hidden_input ("user_name", u.cms_user.name)
			Result.extend_hidden_input ("license", lic.key)

			Result.extend_hidden_input ("current_duration_in_days", curr_days.out)
			Result.extend_hidden_input ("request_number_of_days", asked_days.out)

			if es_cloud_api.is_eligible_to_trial_extension (lic) and then asked_days > 0 then
				Result.extend_html_text ("<div class=%"notice%">You may ask for an extension of " + asked_days.out + " day(s) ...</div>%N")
			else
				Result.extend_html_text ("<div class=%"warning%">You are not eligible to a license period extension...</div>%N")
			end


			Result.extend_html_text ("<p>Your request concerns the <em>"+  html_encoded (lic.plan.title_or_name) +"</em> license: <a href=%"" + api.location_url (module.license_location (lic), Void) + "%">" + html_encoded (lic.key) + "</a>")
			Result.extend_html_text (" (current duration: " + curr_days.out + " days).</p>%N")
			create f_application.make ("application")
			f_application.set_cols (60)
			f_application.set_rows (10)
			f_application.set_label ("trial period extension motivation")
			f_application.set_text_value ("Please extend my trial period, I need more time ...")
			f_application.set_description ("Explain why you need a trial period extension.")
			Result.extend (f_application)

			create f_submit.make_with_text ("op", form_trial_extension_request_submit_op_text)
			Result.extend (f_submit)
		end

	form_trial_extension_request_submit_op_text: STRING = "Submit"

note
	copyright: "2011-2021, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

