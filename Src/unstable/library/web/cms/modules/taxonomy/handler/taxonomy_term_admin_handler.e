note
	description: "[
			Request handler related to 
				/admin/taxonomy/term/{termid}
			]"
	date: "$Date$"
	revision: "$revision$"

class
	TAXONOMY_TERM_ADMIN_HANDLER

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
			tid: INTEGER_64
			s: STRING
			f: CMS_FORM
			t: detachable CMS_TERM
			l_parents: detachable CMS_VOCABULARY_COLLECTION
		do
			if
				attached {WSF_STRING} req.path_parameter ("termid") as p_termid and then
				p_termid.is_integer
			then
				tid := p_termid.value.to_integer_64
				if tid > 0 then
					t := taxonomy_api.term_by_id (tid)
				end
			end

				-- Responding with `main_content_html (l_page)'.
			create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
			if l_page.has_permission ("admin taxonomy") then

				if t = Void then
					l_page.set_title ("New term ...")
					create t.make ("")
				else
					l_page.set_title (t.text)
				end
				create s.make_empty
				f := edit_form (t, l_page, req)
				f.process (l_page)
				if
					attached f.last_data as fd and then
					fd.is_valid
				then
					if attached fd.string_item ("op") as l_op and then l_op.same_string ("Save changes") then
						if attached fd.string_item ("text") as l_text then
							t.set_text (l_text)
							l_page.set_title (t.text)
						end
						if attached fd.string_item ("description") as l_description then
							t.set_description (l_description)
						end
						if attached fd.string_item ("weight") as l_weight and then l_weight.is_integer then
							t.set_weight (l_weight.to_integer)
						end
						taxonomy_api.save_term (t, Void)
						if taxonomy_api.has_error then
							fd.report_error ("Term creation failed!")
						else
							l_page.add_success_message ("Term creation succeed.")
							s.append ("<div>View term: ")
							s.append (l_page.link (t.text, api.administration_path_location ("taxonomy/term/" + t.id.out), Void))
							s.append ("</div>")

							if
								attached fd.table_item ("vocabularies") as voc_tb  and then
								attached taxonomy_api.vocabularies (0, 0) as l_vocabularies
							then
								l_parents := taxonomy_api.vocabularies_for_term (t)
								across
									voc_tb as vid_ic
								until
									taxonomy_api.has_error
								loop
									if attached l_vocabularies.item_by_id (vid_ic.item.string_representation.to_integer_64) as v then
										if l_parents /= Void and then attached l_parents.item_by_id (v.id) as l_v then
												-- Already as parent!
											l_parents.remove (l_v)
										else
											taxonomy_api.save_term (t, v)
											l_vocabularies.remove (v)
										end
									end
								end
								if l_parents /= Void then
									across
										l_parents as v_ic
									until
										taxonomy_api.has_error
									loop
										taxonomy_api.remove_term_from_vocabulary (t, v_ic.item)
									end
								end
							end
	--						l_page.set_redirection (l_page.location)
						end
					else
						fd.report_error ("Invalid form data!")
					end
				end
				f.append_to_html (l_page.wsf_theme, s)
				l_page.set_main_content (s)
				l_page.execute
			else
				send_access_denied (req, res)
			end
		end

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_page: CMS_RESPONSE
			tid: INTEGER_64
			s: STRING
			f: CMS_FORM
			t: detachable CMS_TERM
		do
			if
				attached {WSF_STRING} req.path_parameter ("termid") as p_termid and then
				p_termid.is_integer
			then
				tid := p_termid.value.to_integer_64
				if tid > 0 then
					t := taxonomy_api.term_by_id (tid)
				end
			end
				-- Responding with `main_content_html (l_page)'.
			create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
			if l_page.has_permission ("admin taxonomy") then
				if t = Void then
					l_page.set_title ("Create term ...")
					create t.make ("")
				else
					l_page.set_title (t.text)
				end
				create s.make_empty
				f := edit_form (t, l_page, req)
				f.append_to_html (l_page.wsf_theme, s)
				l_page.set_main_content (s)
				l_page.execute
			else
				send_access_denied (req, res)
			end
		end

	edit_form (t: CMS_TERM; a_page: CMS_RESPONSE; req: WSF_REQUEST): CMS_FORM
		local
			f: CMS_FORM
			voc: detachable CMS_VOCABULARY
			w_tf: WSF_FORM_TEXT_INPUT
			w_txt: WSF_FORM_TEXTAREA
			w_set: WSF_FORM_FIELD_SET
			w_cb: WSF_FORM_CHECKBOX_INPUT
			l_parents: detachable CMS_VOCABULARY_COLLECTION
		do
			create f.make (req.percent_encoded_path_info, "taxonomy")
			if t.has_id then
				f.extend_html_text (a_page.link ("View associated entities", "taxonomy/term/" + t.id.out, Void))
			end
			create w_tf.make_with_text ("text", t.text)
			w_tf.set_is_required (True)
			w_tf.set_label ("Text")
			f.extend (w_tf)

			create w_txt.make ("description")
			w_txt.set_label ("Description")
			w_txt.set_rows (3)
			w_txt.set_cols (60)
			if attached t.description as l_desc then
				w_txt.set_text_value (api.html_encoded (l_desc))
			end
			w_txt.set_description ("Description of the terms; can be used by modules or administration.")
			f.extend (w_txt)

			create w_tf.make_with_text ("weight", t.weight.out)
			w_tf.set_label ("Weight")
			w_tf.set_description ("Terms are sorted in ascending order by weight.")
			f.extend (w_tf)

			if attached taxonomy_api.vocabularies (0, 0) as vocs then
				if t.has_id then
					l_parents := taxonomy_api.vocabularies_for_term (t)
				end
				create w_set.make
				w_set.set_legend ("Associated vocabularies")
				across
					vocs as ic
				loop
					voc := ic.item
					create w_cb.make_with_value ("vocabularies[]", ic.item.id.out)
					w_cb.set_title (voc.name)
					if
						l_parents /= Void and then
						across l_parents as p_ic some p_ic.item.id = ic.item.id end
					then
						w_cb.set_checked (True)
					end
					w_set.extend (w_cb)
				end
				if w_set.count > 0 then
					f.extend (w_set)
				end
			end

			f.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("op", "Save changes"))
			Result := f
		end


end
