note
	description: "Summary description for {ES_CLOUD_PLANS_TOKENS_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_REDEEM_TOKENS_ADMIN_HANDLER

inherit
	ES_CLOUD_ADMIN_HANDLER
		rename
			make as make_admin_handler
		end

	WSF_URI_TEMPLATE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_es_cloud_api: ES_CLOUD_API; a_admin_module: ES_CLOUD_MODULE_ADMINISTRATION)
		do
			admin_module := a_admin_module
			make_admin_handler (a_es_cloud_api)
		end

feature -- Access

	admin_module: ES_CLOUD_MODULE_ADMINISTRATION

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if api.has_permission ("manage es accounts") then
				if req.is_get_request_method then
					if attached {WSF_STRING} req.path_parameter ("pid") as p_pid then
						if attached es_cloud_api.plan_by_name (p_pid.value) as p then
							if
								attached {WSF_STRING} req.path_parameter ("source") as p_src and then
								attached {WSF_STRING} req.path_parameter ("name") as p_name and then
								attached {WSF_STRING} req.path_parameter ("ext") as p_ext
							then
								export_unused_redeem (p, p_src.value, p_name.value, p_ext.value, req, res)
							else
								display_redeem_for_plan (p, req, res)
							end
						else
							send_bad_request (req, res)
						end
					else
						display_plans (req, res)
					end
				elseif req.is_post_request_method then
					if attached {WSF_STRING} req.form_parameter ("plan") as p_name then
						if attached es_cloud_api.plan_by_name (p_name.value) as p then
							process_post (p, req, res)
						else
							send_bad_request (req, res)
						end
					else
						display_plans (req, res)
					end
				else
					send_bad_request (req, res)
				end
			else
				send_access_denied (req, res)
			end
		end

	display_plans (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING_8
			nb: INTEGER
		do
			r := new_generic_response (req, res)
			add_primary_tabs (r)
			create s.make_from_string ("<h1>Redeem token for plans...</h1>")
			s.append ("<table class=%"with_border%" style=%"border: solid 1px black%"><tr><th>Name</th><th>Title</th><th>Actions</th>")
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
				s.append ("<td>")
				s.append ("<a href=%""+ api.administration_path ("/cloud/redeem/plans/" + url_encoded (ic.item.name)) + "/%">Tokens</a>")
				nb := es_cloud_api.unused_redeem_tokens_count (ic.item)
				if nb > 0 then
					s.append (" (unused: " + nb.out + ")")
				else
					s.append (" (no more token)")
				end
				s.append ("</td>")
				s.append ("</tr>")
			end
			s.append ("</table>%N")
			r.set_main_content (s)
			r.execute
		end

	export_unused_redeem (a_plan: ES_CLOUD_PLAN; a_src, a_name, a_ext: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: WSF_PAGE_RESPONSE
			fn: STRING_32
			l_src: READABLE_STRING_GENERAL
			tks: ARRAYED_LIST [ES_CLOUD_REDEEM_TOKEN]
			b: STRING_8
		do
			if api.has_permission ("admin es licenses") then
				if attached es_cloud_api.redeem_tokens (a_plan, Void) as lst then
					create tks.make (10)
					across
						lst as ic
					loop
						if not ic.item.is_redeemed then
							l_src := ic.item.origin
							if l_src = Void then
								l_src := "?"
							end
							if l_src.is_case_insensitive_equal (a_src) then
								tks.force (ic.item)
							end
						end
					end
				end
				if tks /= Void and then not tks.is_empty then
					if a_ext.is_case_insensitive_equal ("txt") then
						create b.make_empty
						b.append ("# product.name=" + a_plan.name + "%N")
						b.append ("# product.title=" + a_plan.title_or_name + "%N")
						b.append ("# " + tks.count.out + " redeem token(s) [" + api.utf_8_encoded (a_src) + "]%N%N")
						create r.make_with_body (b)
						r.header.put_content_type_text_plain
						across
							tks as ic
						loop
							b.append (ic.item.name)
							if attached ic.item.version as v and then not v.is_whitespace then
								b.append_character (' ')
								b.append ("# version=")
								b.append (api.utf_8_encoded (v))
							end
							b.append_character ('%N')
						end
						create fn.make_from_string_general (a_src)
						fn.append_character ('-')
						fn.append_character ('-')
						fn.append_string_general (a_name)
						fn.append_character ('.')
						fn.append_string_general (a_ext)
						r.header.put_content_disposition ("attachment", "filename=%""+ fn +"%"")
						res.send (r)
					else
						send_bad_request (req, res)
					end
				else
					send_not_found (req, res)
				end
			else
				send_access_denied (req, res)
			end
		end

	display_redeem_for_plan (a_plan: ES_CLOUD_PLAN; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			sub: WSF_FORM_SUBMIT_INPUT
			f: CMS_FORM
			tks_by_src: STRING_TABLE [ARRAYED_LIST [ES_CLOUD_REDEEM_TOKEN]]
			tks: ARRAYED_LIST [ES_CLOUD_REDEEM_TOKEN]
			l_src: detachable READABLE_STRING_GENERAL
			fn: READABLE_STRING_32
		do
			r := new_generic_response (req, res)
			add_primary_tabs (r)
			if api.has_permission ("admin es licenses") then
				create s.make_from_string ("<h1>Redeem tokens for plan "+ html_encoded (a_plan.name) +"</h1>")
				if attached es_cloud_api.redeem_tokens (a_plan, Void) as lst then
					create tks_by_src.make_caseless (1)
					across
						lst as ic
					loop
						if not ic.item.is_redeemed then
							l_src := ic.item.origin
							if l_src = Void then
								l_src := "?"
							end
							tks := tks_by_src [l_src]
							if tks = Void then
								create tks.make (10)
								tks_by_src [l_src] := tks
							end
							tks.force (ic.item)
						end
					end
					if attached req.query_parameter ("export") as p_export then
						across
							tks_by_src as g_ic
						loop
							tks := g_ic.item
							s.append ("<h3>"+ tks.count.out +" (unused) redeem token(s) for %"" + html_encoded (g_ic.key) + "%"</h3>%N")
							s.append ("<textarea cols=%"40%" rows=%""+ tks.count.min (25).max (5).out +"%">")
							across
								tks as ic
							loop
								s.append (html_encoded (ic.item.name))
								s.append ("%N")
							end
							s.append ("</textarea>")
						end
					else
						s.append ("<div>")
						s.append ("<a href=%""+ req.percent_encoded_path_info + "?export%">Export unused tokens by origin</a>: ")
						across
							tks_by_src as g_ic
						loop
							tks := g_ic.item
							if tks.count > 0 then
								s.append (" <a href=%""+ req.percent_encoded_path_info + "unused/" + url_encoded (g_ic.key) + "--" + url_encoded (a_plan.name)  + ".txt%">" + html_encoded (g_ic.key) + "--" + html_encoded (a_plan.name)+".txt</a> ")
							end
						end
						s.append ("</div>%N")

						s.append ("<h3>Unused redeem tokens</h3>%N")
						across
							tks_by_src as g_ic
						loop
							tks := g_ic.item
							s.append ("<h4>"+ tks.count.out +" (unused) redeem token(s) for %"" + html_encoded (g_ic.key) + "%"</h4>%N")
							s.append ("<table class=%"with_border%" ><tr><th>Token</th><th>Origin</th><th>Status</th><th>Limitation</th><th>notes</th>%N")
							across
								tks as ic
							loop
								if not ic.item.is_redeemed then
									append_redeem_token (ic.item, s)
								end
							end
							s.append ("</table>%N")
						end

						s.append ("<h3>Used redeem tokens</h3>%N")
						s.append ("<table class=%"with_border%"><tr><th>Token</th><th>Origin</th><th>Status</th><th>Limitation</th><th>notes</th>%N")
						across
							lst as ic
						loop
							if ic.item.is_redeemed then
								append_redeem_token (ic.item, s)
							end
						end
						s.append ("</table>%N")
					end
				end
				create f.make (req.percent_encoded_path_info, "create-redeem-tokens")
				f.set_method_post
				f.extend_hidden_input ("plan", a_plan.name)
				create sub.make_with_text ("op", "Create new set of tokens")
				f.extend (sub)
				f.append_to_html (r.wsf_theme, s)
			else
				s := "Permission denied!"
			end
			r.set_main_content (s)
			r.execute
		end

	append_redeem_token (a_redeem_token: ES_CLOUD_REDEEM_TOKEN; s: STRING)
		do
			s.append ("<tr class=%"redeem_token%">")
			s.append ("<td class=%"name%">")
			s.append (html_encoded (a_redeem_token.name))
			s.append ("</td>")
			s.append ("<td class=%"origin%">")
			if attached a_redeem_token.origin as l_origin then
				s.append (html_encoded (l_origin))
			end
			s.append ("</td>")
			s.append ("<td class=%"status%">")
			if attached a_redeem_token.license_key as k then
				if attached es_cloud_api.license_by_key (k) as lic then
					s.append ("<a href=%"" + api.location_url (admin_module.module.license_location (lic), Void) + "%">")
					s.append (html_encoded (lic.key))
					s.append ("</a>")
					if attached a_redeem_token.redeem_date as dt then
						s.append (" <span class=%"date%">(")
						s.append (api.date_time_to_iso8601_string (dt))
						s.append (")</span>")
					end
				else
					s.append ("license #" + html_encoded (k))
				end
			else
--				s.append ("UNUSED")
			end
			s.append ("</td>")
			s.append ("<td class=%"limitation%">")
			if attached a_redeem_token.version as v then
				s.append ("version " + html_encoded (v))
			end
			s.append ("</td>")
			s.append ("<td class=%"notes%">")
			if attached a_redeem_token.notes as l_notes then
				s.append (html_encoded (l_notes))
			end
			s.append ("</td>")
			s.append ("</tr>")
		end

	process_post (pl: ES_CLOUD_PLAN; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			s: STRING
			l_tok_prefix: READABLE_STRING_8
			f: CMS_FORM
			tf: WSF_FORM_TEXT_INPUT
			numtf: WSF_FORM_NUMBER_INPUT
			sub: WSF_FORM_SUBMIT_INPUT
			nb: INTEGER
			l_news: ARRAYED_LIST [ES_CLOUD_REDEEM_TOKEN]
			toks: STRING_32
		do
			if
				api.has_permission ("admin es licenses") and then
				attached api.user as u
			then
				r := new_generic_response (req, res)
				add_primary_tabs (r)

				create s.make_empty
				create f.make (req.percent_encoded_path_info, "create-redeem")
				f.set_method_post

				f.extend_hidden_input ("plan", pl.name)

				create tf.make ("origin")
				tf.set_label ("Origin/Shop")
				tf.enable_required
				tf.set_description ("Origin name to identify the service selling the related tokens, ...")
				f.extend (tf)

				create tf.make ("token_prefix")
				tf.set_label ("Prefix for the token")
				tf.set_maxlength (10)
				tf.set_description ("Optional redeem token prefix")
				f.extend (tf)

				create tf.make ("version_limitation")
				tf.set_label ("Limit to specific version")
				tf.set_maxlength (10)
				tf.set_description ("Optional version limitation")
				f.extend (tf)

				create tf.make_with_text ("token_notes", {STRING_32} "generated the " + api.formatted_date_time_yyyy_mm_dd__hh_min_ss (create {DATE_TIME}.make_now_utc) + {STRING_32} " by " + api.real_user_display_name (u))
				tf.set_label ("Notes")
				tf.set_description ("Optional notes")
				f.extend (tf)

				create numtf.make ("token_count")
				numtf.set_label ("Quantity")
				numtf.enable_required
				numtf.set_max (1_000)
				numtf.set_text_value ("50")
				numtf.set_description ("Number of tokens to generate")
				f.extend (numtf)

				create sub.make_with_text ("op", form_generate_text)
				f.extend (sub)
				if attached req.form_parameter ("op") as p_op and then p_op.same_string (form_generate_text) then
					f.process_cms_response (r)
				end
				if
					attached {WSF_FORM_DATA} f.last_data as fd and then
					not fd.has_error and then
					attached fd.string_item ("op") as l_op and then l_op.same_string (form_generate_text)
				then
					nb := fd.integer_item ("token_count")
					s.append ("<h2>Generating " + nb.out + " new redeem tokens for plan " + html_encoded (pl.title_or_name) + "</h2>")
					create l_news.make (nb)
					if attached fd.string_item ("token_prefix") as tp then
						if tp.is_valid_as_string_8 then
							l_tok_prefix := tp.to_string_8
						else
							fd.report_invalid_field ("token_prefix", "token prefix should not contain any Unicode characters.")
						end
					end
					if fd.has_error then
						r.report_form_errors (fd)
						s.append ("<h2>Generate new redeem tokens for plan " + html_encoded (pl.title_or_name) + "</h2>")
						f.append_to_html (r.wsf_theme, s)
					else
						es_cloud_api.create_redeem_tokens (nb, pl, fd.string_item ("version_limitation"), fd.string_item ("origin"), l_tok_prefix, fd.string_item ("token_notes"), l_news)
						s.append ("<h3>" + l_news.count.out + " new tokens created:</h3>")
						create toks.make_empty
						across
							l_news as ic
						loop
							toks.append_string_general (ic.item.name)
							toks.extend ('%N')
							s.append ("<li>" + html_encoded (ic.item.name) + "</li>")
						end
						s.append ("<textarea cols=%"40%" rows=%"10%">" + html_encoded (toks) + "</textarea>")
					end
				else
					s.append ("<h2>Generate new redeem tokens for plan " + html_encoded (pl.title_or_name) + "</h2>")
					f.append_to_html (r.wsf_theme, s)
				end

				r.set_main_content (s)
				r.execute

			else
				send_access_denied (req, res)
			end
		end

	form_generate_text: STRING = "Generate tokens"

end
