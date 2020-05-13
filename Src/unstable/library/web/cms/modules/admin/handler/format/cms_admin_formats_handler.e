note
	description: "Summary description for {CMS_ADMIN_FORMATS_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_FORMATS_HANDLER

inherit
	CMS_HANDLER

	CMS_API_ACCESS

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			execute as uri_template_execute,
			new_mapping as new_uri_template_mapping
		select
			new_uri_template_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get,
			do_post
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached {WSF_STRING} req.path_parameter ("format-id") as p_format_id then
					-- "/formats/-/add" is used to create a new format!
				if
					api.has_permission ("admin formats") and then
					p_format_id.same_string ("-") and then
					req.percent_encoded_path_info.ends_with_general ("/add")
				then
					do_get_format (Void, req, res) -- New format form!
				else
					do_get_format (p_format_id.value, req, res)
				end
			else
				do_get_formats (req, res)
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if api.has_permission ("admin formats") then
				if attached {WSF_STRING} req.path_parameter ("format-id") as p_format_id then
					do_post_format (p_format_id.url_encoded_value, req, res)
				else
					do_post_format (Void, req, res) -- New format!
				end
			else
				send_access_denied (req, res)
			end
		end

feature -- View/edit Format	

	new_format_web_form (a_path: READABLE_STRING_8; f: detachable CMS_FORMAT; a_response: CMS_RESPONSE): CMS_FORM
		local
			l_name: READABLE_STRING_8
			cb: WSF_FORM_CHECKBOX_INPUT
			hf: WSF_FORM_HIDDEN_INPUT
--			nf: WSF_FORM_NUMBER_INPUT
			ftxt: WSF_FORM_TEXT_INPUT
			ftb: WSF_WIDGET_TABLE
			ftb_row: WSF_WIDGET_TABLE_ROW
			i: INTEGER
			fset: WSF_FORM_FIELD_SET
			l_all_filters: STRING_TABLE [CONTENT_FILTER]

		do
			create Result.make (a_path, Void)
			create ftxt.make ("name")
			ftxt.set_is_required (True)
			ftxt.set_validation_action (agent (fd: WSF_FORM_DATA)
					do
						if attached fd.string_item ("name") as v_name then
							if v_name.is_whitespace then
								fd.report_invalid_field ("name", "Blank value `name` !")
							elseif not v_name.is_valid_as_string_8 then
								fd.report_invalid_field ("name", "Value `name` should not contain any unicode character !")
							elseif v_name.same_string_general ("-") then
								fd.report_invalid_field ("name", "Value `name` can not be `-` !")
							end
						else
							fd.report_invalid_field ("name", "Missing required value `name` !")
						end
					end
				)
			ftxt.set_label ("Name")
			if f /= Void then
				ftxt.set_text_value (f.name)
			end
			Result.extend (ftxt)

			create ftxt.make ("title")
			if f /= Void then
				ftxt.set_text_value (f.title)
			end
			ftxt.set_label ("Title")
			Result.extend (ftxt)

			create fset.make
			fset.set_legend ("Filters")
			Result.extend (fset)

			create l_all_filters.make_caseless (10)
			fset.extend_html_text ("<strong>Included filters</strong>:")
			i := 0
			create ftb.make
			fset.extend (ftb)
			if f /= Void then
				across
					f.filters as f_ic
				loop
					i := i + 1
					l_name := f_ic.item.name
					l_all_filters.force (f_ic.item, l_name)
					create cb.make_with_value ("filters[" + l_name + "]", l_name.to_string_32)
					cb.set_title (f_ic.item.title.to_string_32)
					cb.set_checked (True)

					create hf.make_with_text ("filter_weight[" + l_name + "]", i.out)
--					nf.set_maxlength (4)
--					nf.add_css_style ("width: 30px")
--					nf.set_label ("Order")

					create ftb_row.make (3)
					ftb.add_row (ftb_row)
					ftb_row.add_widget (cb)
--					ftb_row.add_widget (nf)
					ftb_row.add_widget (hf)
					ftb_row.add_widget (create {WSF_WIDGET_RAW_TEXT}.make_with_text (f_ic.item.description))
				end
			end
			fset.extend_html_text ("<strong>Available filters</strong>:")
			create ftb.make
			fset.extend (ftb)
			across
				api.content_filters as f_ic
			loop
				l_name := f_ic.item.name
				if l_all_filters.has (l_name) then
				else
					create cb.make_with_value ("filters[" + l_name + "]", l_name.to_string_32)
					cb.set_title (f_ic.item.title.to_string_32)
					create ftb_row.make (2)
					ftb.add_row (ftb_row)
					ftb_row.add_widget (cb)
					ftb_row.add_widget (create {WSF_WIDGET_RAW_TEXT}.make_with_text (f_ic.item.description))
					l_all_filters.force (f_ic.item, f_ic.item.name)
				end
			end

			create fset.make
			fset.set_legend ("Content types")
			Result.extend (fset)
			across
				api.content_types as ct_ic
			loop
				l_name := ct_ic.item.name
				create cb.make_with_value ("content_types[]", l_name.to_string_32)
				cb.set_title (l_name.to_string_32)
				if f /= Void and then ct_ic.item.has_format (f.name) then
					cb.set_checked (True)
				end
				fset.extend (cb)
			end
			if a_response.has_permission ("admin formats") then
				Result.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("op", "Update"))
				Result.extend (create {WSF_FORM_RESET_INPUT}.make ("Cancel"))
			end
		end

	do_get_format (a_format_id: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_response: CMS_RESPONSE
			s: STRING
			form: CMS_FORM
		do
			if a_format_id = Void then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				l_response.add_to_primary_tabs (l_response.administration_link ("All formats", "formats"))
				l_response.set_title ("Create a new format")
				form := new_format_web_form (api.administration_path ("formats/"), Void, l_response)
				create s.make_empty
				form.append_to_html (l_response.wsf_theme, s)
				l_response.set_main_content (s)
			elseif attached api.format (a_format_id) as f then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				l_response.add_to_primary_tabs (l_response.administration_link ("All formats", "formats"))
				update_response_title (l_response, f, False)
				form := new_format_web_form (api.administration_path ("formats/" + f.name), f, l_response)
				create s.make_empty
				form.append_to_html (l_response.wsf_theme, s)
				l_response.set_main_content (s)
			else
				create {NOT_FOUND_ERROR_CMS_RESPONSE} l_response.make (req, res, api)
			end
			l_response.execute
		end

	do_post_format (a_format_id: detachable READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: detachable CMS_FORMAT
			l_response: CMS_RESPONSE
			s: STRING
			form: CMS_FORM
			lst_to_add,
			lst_to_remove: ARRAYED_LIST [READABLE_STRING_GENERAL]
			l_is_creation: BOOLEAN
		do
			if a_format_id /= Void then
				f := api.format (a_format_id)
			else
				l_is_creation := True
				create f.make ("-", "")
			end
			if f /= Void then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				l_response.add_to_primary_tabs (l_response.administration_link ("All formats", "formats"))
				if a_format_id /= Void then
					l_response.add_to_primary_tabs (l_response.administration_link ("View", "formats/" + a_format_id))
				end
				update_response_title (l_response, f, l_is_creation)
				if a_format_id /= Void then
					form := new_format_web_form (api.administration_path ("formats/" + a_format_id), f, l_response)
				else
					form := new_format_web_form (api.administration_path ("formats/"), f, l_response)
				end
--				form.prepare (l_response)
				form.process (l_response)
				if attached form.last_data as fd then
					if l_is_creation then
						if
							attached fd.string_item ("name") as v_name and then
							not v_name.is_whitespace and then v_name.is_valid_as_string_8 and then
							not v_name.same_string ("-") -- Excluded value!
						then
							create f.make (v_name.to_string_8, Void)
						else
							fd.report_invalid_field ("name", "Bad name value (should not be empty, be blank or contain unicode character)")
						end
					end
					if
						attached fd.string_item ("title") as v_title and then
						not v_title.is_whitespace and then
						v_title.is_valid_as_string_8
					then
						f.set_title (v_title.to_string_8)
					else
						f.set_title (Void)
					end

					if
						attached fd.table_item ("filters") as tb_filters
--						and then
--						attached fd.table_item ("filter_weight") as tb_weight
					then
						create lst_to_remove.make (0)
						create lst_to_add.make (0)
						across
							f.filters as ic
						loop
							if attached tb_filters.value (ic.item.name) then
									-- Keep
							else
								lst_to_remove.extend (ic.item.name)
							end
						end
						across
							tb_filters.values as ic
						loop
							if attached {WSF_STRING} ic.item as l_string then
								if f.filter (l_string.value) = Void then
									lst_to_add.extend (l_string.value)
								end
							end
						end
						across
							lst_to_add as ic
						loop
--							if attached f.filter (ic.item) then
--									-- already there
							if attached api.content_filters.item (ic.item) as l_filter then
								check has_not_filter: f.filter (ic.item) = Void end
								f.add_filter (l_filter)
							end
						end
						across
							lst_to_remove as ic
						loop
							f.remove_filter_by_name (ic.item)
						end
					end
					if
						attached fd.table_item ("content_types") as tb_content_types
					then
						across
							api.content_types as ic
						loop
							ic.item.remove_format (f)
						end
						across
							tb_content_types as ic
						loop
							if
								attached {WSF_STRING} ic.item as s_ct and then
								attached api.content_type (s_ct.value) as ct and then
								not ct.has_format (f.name)
							then
								ct.extend_format (f)
							end
						end
					end
					if fd.has_error then
						fd.apply_to_associated_form
					else
						if l_is_creation then
							if api.formats.item (f.name) /= Void then
								api.formats.remove (f.name)
							end
							api.formats.extend (f)
							l_response.add_to_primary_tabs (l_response.administration_link ("View", "formats/" + f.name))
							update_response_title (l_response, f, False)
						end
						api.save_formats
						form := new_format_web_form (api.administration_path ("formats/" + f.name), f, l_response)
					end
				else
					form := new_format_web_form (api.administration_path ("formats/" + f.name), f, l_response)
				end
				create s.make_empty
				form.append_to_html (l_response.wsf_theme, s)
				l_response.set_main_content (s)
			else
				create {NOT_FOUND_ERROR_CMS_RESPONSE} l_response.make (req, res, api)
			end

			l_response.execute
		end

	update_response_title (a_response: CMS_RESPONSE; f: CMS_FORMAT; is_creation: BOOLEAN)
		do
			if is_creation then
				a_response.set_title ("Create a new CMS content format...")
			else
				if f.name.same_string_general (f.title) then
					a_response.set_title ("CMS content format: " + api.html_encoded (f.name))
				else
					a_response.set_title ("CMS content format: " + api.html_encoded (f.name) + " %"" + api.html_encoded (f.title) + "%"")
				end
			end
		end

feature -- All formats

	do_get_formats (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_response: CMS_RESPONSE
			s: STRING
			f: CMS_FORMAT
			l_count: INTEGER
			l_is_first: BOOLEAN
		do
			l_count := api.formats.count

			create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)

			create s.make_empty
			l_response.set_title ("CMS content formats")

			s.append ("<ul class=%"cms-formats%">%N")
			across
				api.formats as ic
			loop
				f := ic.item
				s.append ("<li class=%"cms_format%">")
				s.append ("<a href=%"")
				s.append (req.absolute_script_url (api.administration_path ("/formats/") + api.url_encoded (f.name)))
				s.append ("%">")
				s.append (html_encoded (f.name))
				s.append ("</a>")
				s.append ("<dl>")
				s.append ("<dt>filters</dt><dd>")
				l_is_first := True
				across
					f.filters as f_ic
				loop
				 	if l_is_first then
				 		l_is_first := False
				 	else
				 		s.append (" + ")
				 	end
					s.append (html_encoded (f_ic.item.name))
				end
				s.append ("</dd>")
				s.append ("<dt>Content types</dt><dd>")
				l_is_first := True
				across
					api.content_types as ct_ic
				loop
					if ct_ic.item.has_format (f.name) then
					 	if l_is_first then
					 		l_is_first := False
					 	else
					 		s.append (", ")
					 	end
						s.append (html_encoded (ct_ic.item.name))
					end
				end
				s.append ("</dd>")
				s.append ("</dl>")
				s.append ("</li>%N")
			end
			s.append ("</ul>%N")

			if l_response.has_permission ("admin formats") then
				s.append (l_response.link ("Create new format", api.administration_path_location ("formats/-/add"), Void))
			end

			l_response.set_main_content (s)
			l_response.execute
		end
end

