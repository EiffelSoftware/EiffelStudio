note
	description: "[
			Request handler related to 
				/admin/taxonomy/vocabulary/
				/admin/taxonomy/vocabulary/{vocid}
			]"
	date: "$Date$"
	revision: "$revision$"

class
	TAXONOMY_VOCABULARY_ADMIN_HANDLER

inherit
	CMS_MODULE_HANDLER [CMS_TAXONOMY_API]
		rename
			module_api as taxonomy_api
		end

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

	CMS_API_ACCESS

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler for any kind of mapping.
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler for URI mapping.
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler for URI-template mapping.
		do
			execute (req, res)
		end

feature -- HTTP Methods	

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_page: CMS_RESPONSE
			voc: CMS_VOCABULARY
			l_typename: READABLE_STRING_GENERAL
			s: STRING
		do
			if not api.has_permission ("admin taxonomy") then
				send_access_denied (req, res)
			else
				if attached {WSF_STRING} req.form_parameter ("op") as p_op then
					if p_op.same_string ("New Vocabulary") then
						if
							attached {WSF_STRING} req.form_parameter ("vocabulary_name") as p_name and then
							not p_name.is_empty
						then
							create voc.make (p_name.value)
							taxonomy_api.save_vocabulary (voc)
							create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
							if taxonomy_api.has_error then
								l_page.add_error_message ("Vocabulary creation failed!")
							else
								l_page.add_success_message ("Vocabulary creation succeed!")
								l_page.set_redirection (api.administration_path_location ("taxonomy/vocabulary/" + voc.id.out))
							end
						else
							create {BAD_REQUEST_ERROR_CMS_RESPONSE} l_page.make (req, res, api)
						end
					elseif
						p_op.same_string ("Save changes") and then
						attached {WSF_STRING} req.path_parameter ("vocid") as p_vocid and then p_vocid.is_integer and then
						attached taxonomy_api.vocabulary (p_vocid.value.to_integer_64) as l_vocabulary
					then
						create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
						create s.make_empty
						l_page.add_notice_message ("Vocabulary " +  l_vocabulary.id.out)
						if attached {WSF_STRING} req.form_parameter ("name") as p_name then
							l_vocabulary.set_name (p_name.value)
						end
						if attached {WSF_STRING} req.form_parameter ("description") as p_desc then
							l_vocabulary.set_description (p_desc.value)
						end
						if attached {WSF_STRING} req.form_parameter ("weight") as p_weight and then p_weight.is_integer then
							l_vocabulary.set_weight (p_weight.integer_value)
						end
						taxonomy_api.save_vocabulary (l_vocabulary)
						if taxonomy_api.has_error then
							l_page.add_error_message ("Could not save vocabulary")
						elseif
							attached {WSF_TABLE} req.form_parameter ("typenames") as typenames_table
						then
							across
								typenames_table as ic
							loop
								l_typename := ic.item.string_representation
								create voc.make_from_term (l_vocabulary)
								voc.set_associated_content_type (l_typename, False, False, False)
								l_page.add_notice_message ("Content type :" + api.html_encoded (l_typename))
								if attached {WSF_TABLE} req.form_parameter ({STRING_32} "vocabulary_" + l_typename.as_string_32) as opts then
									across
										opts as o_ic
									loop
										if o_ic.item.same_string ("tags") then
											voc.set_is_tags (True)
										elseif o_ic.item.same_string ("multiple") then
											voc.allow_multiple_term (True)
										elseif o_ic.item.same_string ("required") then
											voc.set_is_term_required (True)
										end
									end
								end
								taxonomy_api.associate_vocabulary_with_type (voc, l_typename)
								if taxonomy_api.has_error then
									l_page.add_error_message ("Could not save vocabulary content type associations.")
								end
							end
						end
						if not taxonomy_api.has_error then
							l_page.add_notice_message (l_page.link ({STRING_32} "Back to vocabulary %"" + l_vocabulary.name + "%"", api.administration_path_location ("taxonomy/vocabulary/" + l_vocabulary.id.out), Void))
						end
						l_page.set_main_content (s)
					else
						create {NOT_IMPLEMENTED_ERROR_CMS_RESPONSE} l_page.make (req, res, api)
					end
				else
					create {BAD_REQUEST_ERROR_CMS_RESPONSE} l_page.make (req, res, api)
				end
				l_page.execute
			end
		end

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			tid: INTEGER_64
		do
			if not api.has_permission ("admin taxonomy") then
				send_access_denied (req, res)
			else
				if attached {WSF_STRING} req.path_parameter ("vocid") as p_vocid then
					if p_vocid.is_integer then
						tid := p_vocid.value.to_integer_64
					end
				end
				if tid > 0 then
					do_get_vocabulary (tid, req, res)
				else
					do_get_vocabularies (req, res)
				end
			end
		end

	do_get_vocabulary (tid: INTEGER_64; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		require
			valid_tid: tid > 0
		local
			l_page: CMS_RESPONSE
			s: STRING
			l_typename: detachable READABLE_STRING_8
			v: detachable CMS_VOCABULARY
			l_typenames: detachable LIST [READABLE_STRING_32]
			f: CMS_FORM
			wtb: WSF_WIDGET_TABLE
			wtb_row: WSF_WIDGET_TABLE_ROW
			wtb_item: WSF_WIDGET_TABLE_ITEM
			voc: detachable CMS_VOCABULARY
			l_term: detachable CMS_TERM
			tf_input: WSF_FORM_TEXT_INPUT
			tf_text: WSF_FORM_TEXTAREA
			tf_num: WSF_FORM_NUMBER_INPUT
			w_set: WSF_FORM_FIELD_SET
			w_cb: WSF_FORM_CHECKBOX_INPUT
			sub: WSF_FORM_SUBMIT_INPUT
		do
			voc := taxonomy_api.vocabulary (tid)
			if voc /= Void then
					-- Responding with `main_content_html (l_page)'.
				create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
				l_page.set_title (voc.name)
				taxonomy_api.fill_vocabularies_with_terms (voc)

				create f.make (req.percent_encoded_path_info, "taxonomy")

				create tf_input.make_with_text ("name", voc.name)
				f.extend (tf_input)

				create tf_text.make ("description")
				tf_text.set_text_value (voc.description)
				tf_text.set_description ("Description of the vocabulary; also used as intructions to present to the user when selecting terms.")
				tf_text.set_rows (3)
				f.extend (tf_text)

				create tf_num.make_with_text ("weight", voc.weight.out)
				tf_num.set_label ("weight")
				tf_num.set_description ("Items are displayed in ascending order by weight.")
				f.extend (tf_num)

				create wtb.make
				wtb.add_css_class ("with_border")
				create wtb_row.make (2)
				create wtb_item.make_with_text ("Text")
				wtb_row.set_item (wtb_item, 1)
				create wtb_item.make_with_text ("Description")
				wtb_row.set_item (wtb_item, 2)
				wtb.add_head_row (wtb_row)
				across
					voc as ic
				loop
					l_term := ic.item

					create wtb_row.make (3)
					wtb.add_row (wtb_row)

					create wtb_item.make_with_text (l_page.link (ic.item.text, api.administration_path_location ("taxonomy/term/" + l_term.id.out), Void))
					wtb_row.set_item (wtb_item, 1)
					if attached ic.item.description as l_desc then
						create wtb_item.make_with_text (api.html_encoded (l_desc))
					else
						create wtb_item.make_with_text ("")
					end
					wtb_row.set_item (wtb_item, 2)
				end
				if wtb.body_row_count > 0 then
					f.extend (wtb)
				else
					f.extend_raw_text ("No terms.")
				end

				create w_set.make
				w_set.set_legend ("Content types")
				f.extend (w_set)


				l_typenames := taxonomy_api.types_associated_with_vocabulary (voc)
				create wtb.make
				wtb.add_css_class ("with_border")
				create wtb_row.make (5)
				wtb_row.set_item (create {WSF_WIDGET_TABLE_ITEM}.make_with_text ("Type"), 1)
				create wtb_item.make_with_text ("Settings ...")
				wtb_item.add_html_attribute ("colspan", "3")
				wtb_row.set_item (wtb_item, 2)
				wtb.add_head_row (wtb_row)

				across
					api.content_types as ic
				loop
					create wtb_row.make (4)
					wtb.add_row (wtb_row)

					l_typename := ic.item.name
					create w_cb.make_with_value ("typenames[]", api.html_encoded (l_typename))
					w_cb.set_title (ic.item.name.to_string_32)
					wtb_row.set_item (create {WSF_WIDGET_TABLE_ITEM}.make_with_content (w_cb), 1)

					v := Void
					if
						l_typenames /= Void and then
						across l_typenames as tn_ic some l_typename.is_case_insensitive_equal_general (tn_ic.item) end
					then
						w_cb.set_checked (True)
						if attached taxonomy_api.vocabularies_for_type (l_typename) as v_list then
							across v_list as v_ic until v /= Void loop
								if v_ic.item.id = voc.id then
									v := v_ic.item
								end
							end
						end
					end
					create w_cb.make_with_value ("vocabulary_" + l_typename +"[]", "tags")
					w_cb.set_title ("Tags")
					w_cb.set_checked (v /= Void and then v.is_tags)
					wtb_row.set_item (create {WSF_WIDGET_TABLE_ITEM}.make_with_content (w_cb), 2)

					create w_cb.make_with_value ("vocabulary_" + l_typename +"[]", "multiple")
					w_cb.set_title ("Multiple Select")
					w_cb.set_checked (v /= Void and then v.multiple_terms_allowed)
					wtb_row.set_item (create {WSF_WIDGET_TABLE_ITEM}.make_with_content (w_cb), 3)

					create w_cb.make_with_value ("vocabulary_" + l_typename +"[]", "required")
					w_cb.set_title ("Required")
					w_cb.set_checked (v /= Void and then v.is_term_required)
					wtb_row.set_item (create {WSF_WIDGET_TABLE_ITEM}.make_with_content (w_cb), 4)
				end
				if wtb.body_row_count > 0 then
					w_set.extend (wtb)
				end

				create sub.make_with_text ("op", "Save changes")
				f.extend (sub)

				create s.make_empty
				f.append_to_html (l_page.wsf_theme, s)
				l_page.set_main_content (s)
				l_page.execute
			else
					-- Responding with `main_content_html (l_page)'.
				send_not_found (req, res)
			end
		end

	do_get_vocabularies (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_page: CMS_RESPONSE
			s: STRING
			l_typenames: detachable LIST [READABLE_STRING_32]
			f: CMS_FORM
			wtb: WSF_WIDGET_TABLE
			wtb_row: WSF_WIDGET_TABLE_ROW
			wtb_item: WSF_WIDGET_TABLE_ITEM
			voc: detachable CMS_VOCABULARY
			tf_input: WSF_FORM_TEXT_INPUT
			w_set: WSF_FORM_FIELD_SET
			sub: WSF_FORM_SUBMIT_INPUT
		do
				-- Responding with `main_content_html (l_page)'.
			create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
			create wtb.make
			wtb.add_css_class ("with_border")
			create wtb_row.make (3)
			create wtb_item.make_with_text ("Name")
			wtb_row.set_item (wtb_item, 1)
			create wtb_item.make_with_text ("Type")
			wtb_row.set_item (wtb_item, 2)
			create wtb_item.make_with_text ("Operations")
			wtb_row.set_item (wtb_item, 3)
			wtb.add_head_row (wtb_row)

			if attached taxonomy_api.vocabularies (0, 0) as lst then
				across
					lst as ic
				loop
					voc := ic.item
					create wtb_row.make (3)
					wtb.add_row (wtb_row)

					create wtb_item.make_with_text (l_page.link (ic.item.name, api.administration_path_location ("taxonomy/vocabulary/" + ic.item.id.out), Void))
--						if attached ic.item.description as l_desc then
--							s.append (" : <em>")
--							s.append (api.html_encoded (l_desc))
--							s.append ("</em>")
--						end
					wtb_row.set_item (wtb_item, 1)
					l_typenames := taxonomy_api.types_associated_with_vocabulary (voc)
					if l_typenames /= Void then
						create s.make_empty
						across
							l_typenames as types_ic
						loop
							if not s.is_empty then
								s.append_character (',')
								s.append_character (' ')
							end
							s.append (api.html_encoded (types_ic.item))
						end
						create wtb_item.make_with_text (s)
						wtb_row.set_item (wtb_item, 2)
					end

					s := l_page.link ("edit", api.administration_path_location ("taxonomy/vocabulary/" + voc.id.out), Void)
					create wtb_item.make_with_text (s)
					wtb_row.set_item (wtb_item, 3)
				end
			end
			create f.make (req.percent_encoded_path_info, "taxonomy")
			f.set_method_post

			f.extend (wtb)

			create w_set.make
			w_set.set_legend ("Create a new vocabulary")
			create tf_input.make_with_text ("vocabulary_name", "")
			tf_input.set_label ("Vocabulary name")
			w_set.extend (tf_input)
			create sub.make_with_text ("op", "New Vocabulary")
			w_set.extend (sub)
			f.extend (w_set)

			create s.make_empty
			f.append_to_html (l_page.wsf_theme, s)
			l_page.set_title ("Vocabularies")
			l_page.set_main_content (s)
			l_page.execute
		end

end
