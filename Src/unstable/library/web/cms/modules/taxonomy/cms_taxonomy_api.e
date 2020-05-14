note
	description: "[
				API to handle taxonomy vocabularies and terms.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TAXONOMY_API

inherit
	CMS_MODULE_API
		redefine
			initialize
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor

				-- Create the node storage for type blog
			if attached storage.as_sql_storage as l_storage_sql then
				create {CMS_TAXONOMY_STORAGE_SQL} taxonomy_storage.make (l_storage_sql)
			else
				create {CMS_TAXONOMY_STORAGE_NULL} taxonomy_storage.make
			end
		end

feature {CMS_MODULE} -- Access nodes storage.

	taxonomy_storage: CMS_TAXONOMY_STORAGE_I

feature -- Access node

	vocabulary_count: INTEGER_64
			-- Number of vocabulary.
		do
			Result := taxonomy_storage.vocabulary_count
		end

	vocabularies (a_limit: NATURAL_32; a_offset: NATURAL_32): CMS_VOCABULARY_COLLECTION
			-- List of vocabularies ordered by weight and limited by limit and offset.
		do
			Result := taxonomy_storage.vocabularies (a_limit, a_offset)
		end

	vocabulary (a_id: INTEGER_64): detachable CMS_VOCABULARY
			-- Vocabulary associated with id `a_id'.
		require
			valid_id: a_id > 0
		do
			Result := taxonomy_storage.vocabulary (a_id)
		end

	vocabularies_for_type (a_type_name: READABLE_STRING_GENERAL): detachable CMS_VOCABULARY_COLLECTION
			-- Vocabularies associated with content type `a_type_name'.
		do
			Result := taxonomy_storage.vocabularies_for_type (a_type_name)
		end

	types_associated_with_vocabulary (a_vocab: CMS_VOCABULARY): detachable LIST [READABLE_STRING_32]
			-- Type names associated with `a_vocab'.
		do
			Result := taxonomy_storage.types_associated_with_vocabulary (a_vocab)
		end

	vocabularies_for_term (a_term: CMS_TERM): detachable CMS_VOCABULARY_COLLECTION
			-- Vocabularies including `a_term'.
		do
			Result := taxonomy_storage.vocabularies_for_term (a_term)
		end

	is_term_inside_vocabulary (a_term: CMS_TERM; a_vocab: CMS_VOCABULARY): BOOLEAN
			-- Is `a_term' inside `a_vocab' ?
		require
			valid_term: a_term.has_id
			valid_vocabulary: a_vocab.has_id
		do
			Result := taxonomy_storage.is_term_inside_vocabulary (a_term, a_vocab)
		end

	fill_vocabularies_with_terms (a_vocab: CMS_VOCABULARY)
			-- Fill `a_vocab' with associated terms.
		do
			reset_error
			a_vocab.wipe_out
			if attached terms (a_vocab, 0, 0) as lst then
				across
					lst as ic
				loop
					a_vocab.extend (ic.item)
				end
			end
		end

	fill_vocabularies_with_cloud_of_terms (a_vocab: CMS_VOCABULARY_CLOUD)
			-- Fill `a_vocab' with associated terms.
		do
			reset_error
			a_vocab.wipe_out
			if attached cloud_of_terms (a_vocab, 0, 0) as lst then
				across
					lst as ic
				loop
					a_vocab.record (ic.item.term, ic.item.occurrences)
				end
			end
		end

	term_count_from_vocabulary (a_vocab: CMS_VOCABULARY): INTEGER_64
			-- Number of terms from vocabulary `a_vocab'.
		require
			has_id: a_vocab.has_id
		do
			Result := taxonomy_storage.term_count_from_vocabulary (a_vocab)
		end

	terms_of_content (a_content: CMS_CONTENT; a_vocabulary: detachable CMS_VOCABULARY): detachable CMS_TERM_COLLECTION
			-- Terms related to `a_content', and if `a_vocabulary' is set
			-- constrain to be part of `a_vocabulary'.
		require
			content_with_identifier: a_content.has_identifier
		do
			if attached a_content.identifier as l_id then
				Result := terms_of_entity (a_content.content_type, l_id, a_vocabulary)
			end
		end

	terms_of_entity (a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL; a_vocabulary: detachable CMS_VOCABULARY): detachable CMS_TERM_COLLECTION
			-- Terms related to `(a_type_name,a_entity)', and if `a_vocabulary' is set
			-- constrain to be part of `a_vocabulary'.
		do
			Result := taxonomy_storage.terms_of_entity (a_type_name, a_entity, a_vocabulary)
		end

	terms (a_vocab: CMS_VOCABULARY; a_limit: NATURAL_32; a_offset: NATURAL_32): CMS_TERM_COLLECTION
			-- List of terms ordered by weight and limited by limit and offset.
		require
			has_id: a_vocab.has_id
		do
			Result := taxonomy_storage.terms (a_vocab, a_limit, a_offset)
		end

	cloud_of_terms (a_vocab: CMS_VOCABULARY; a_limit: NATURAL_32; a_offset: NATURAL_32): ARRAYED_LIST [TUPLE [term: CMS_TERM; occurrences: NATURAL_64]]
			-- List of terms from vocabulary `a_vocab` ordered by number of usages from `a_offset` to `a_offset + a_limit`.
		require
			has_id: a_vocab.has_id
		do
			Result := taxonomy_storage.cloud_of_terms (a_vocab, a_limit, a_offset)
		end

	term_by_id (a_tid: INTEGER_64): detachable CMS_TERM
		do
			Result := taxonomy_storage.term_by_id (a_tid)
		end

	term_by_text (a_term_text: READABLE_STRING_GENERAL; a_vocabulary: detachable CMS_VOCABULARY): detachable CMS_TERM
			-- Term with text `a_term_text', included in vocabulary `a_vocabulary' if provided.
		do
			Result := taxonomy_storage.term_by_text (a_term_text, a_vocabulary)
		end

	entities_associated_with_term (a_term: CMS_TERM): detachable LIST [TUPLE [entity: READABLE_STRING_32; typename: detachable READABLE_STRING_32]]
			-- Entities and related typename associated with `a_term'.
		require
			a_term_exists: a_term.has_id
		do
			Result := taxonomy_storage.entities_associated_with_term (a_term)
			error_handler.append (taxonomy_storage.error_handler)
		end

feature -- Write

	save_vocabulary (a_voc: CMS_VOCABULARY)
			-- Insert or update vocabulary `a_voc'
			-- and also save {CMS_VOCABULARY}.terms if `a_with_terms' is True.	
		do
			reset_error
			taxonomy_storage.save_vocabulary (a_voc, False)
			error_handler.append (taxonomy_storage.error_handler)
		end

	save_vocabulary_and_terms (a_voc: CMS_VOCABULARY)
			-- Insert or update vocabulary `a_voc'
			-- and also save {CMS_VOCABULARY}.terms.	
		do
			reset_error
			taxonomy_storage.save_vocabulary (a_voc, True)
			error_handler.append (taxonomy_storage.error_handler)
		end

	save_term (a_term: CMS_TERM; voc: detachable CMS_VOCABULARY)
			-- Save `a_term' inside `voc' if set.
		do
			reset_error
			taxonomy_storage.save_term (a_term, voc)
			error_handler.append (taxonomy_storage.error_handler)
		end

	remove_term_from_vocabulary (t: CMS_TERM; voc: CMS_VOCABULARY)
			-- Remove term `t' from vocabulary `voc'.
		do
			reset_error
			taxonomy_storage.remove_term_from_vocabulary (t, voc)
			error_handler.append (taxonomy_storage.error_handler)
		end

	associate_term_with_content (a_term: CMS_TERM; a_content: CMS_CONTENT)
			-- Associate term `a_term' with `a_content'.
		require
			content_with_identifier: a_content.has_identifier
		do
			reset_error
			if attached a_content.identifier as l_id then
				taxonomy_storage.associate_term_with_entity (a_term, a_content.content_type, l_id)
				error_handler.append (taxonomy_storage.error_handler)
			end
		end

	unassociate_term_from_content (a_term: CMS_TERM; a_content: CMS_CONTENT)
			-- Unassociate term `a_term' from `a_content'.
		require
			content_with_identifier: a_content.has_identifier
		do
			reset_error
			if attached a_content.identifier as l_id then
				taxonomy_storage.unassociate_term_from_entity (a_term, a_content.content_type, l_id)
				error_handler.append (taxonomy_storage.error_handler)
			end
		end

	associate_term_with_entity (a_term: CMS_TERM; a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL)
			-- Associate term `a_term' with `(a_type_name, a_entity)'.
		do
			reset_error
			taxonomy_storage.associate_term_with_entity (a_term, a_type_name, a_entity)
			error_handler.append (taxonomy_storage.error_handler)
		end

	unassociate_term_from_entity (a_term: CMS_TERM; a_type_name: READABLE_STRING_GENERAL; a_entity: READABLE_STRING_GENERAL)
			-- Unassociate term `a_term' from `(a_type_name, a_entity)'.
		do
			reset_error
			taxonomy_storage.unassociate_term_from_entity (a_term, a_type_name, a_entity)
			error_handler.append (taxonomy_storage.error_handler)
		end

	associate_vocabulary_with_type (a_voc: CMS_VOCABULARY; a_type_name: READABLE_STRING_GENERAL)
			-- Associate vocabulary `a_voc' with type `a_type_name'.
		require
			existing_term: a_voc.has_id
		do
			reset_error
			taxonomy_storage.associate_vocabulary_with_type (a_voc, a_type_name)
			error_handler.append (taxonomy_storage.error_handler)
		end

	unassociate_vocabulary_with_type (a_voc: CMS_VOCABULARY; a_type_name: READABLE_STRING_GENERAL)
			-- Un-associate vocabulary `a_voc' from type `a_type_name'.
		require
			existing_term: a_voc.has_id
		do
			reset_error
			taxonomy_storage.unassociate_vocabulary_with_type (a_voc, a_type_name)
			error_handler.append (taxonomy_storage.error_handler)
		end

feature -- Web forms

	populate_edit_form (a_response: CMS_RESPONSE; a_form: CMS_FORM; a_content_type_name: READABLE_STRING_8; a_content: detachable CMS_CONTENT)
		local
			ti: detachable WSF_FORM_TEXT_INPUT
			th: WSF_FORM_HIDDEN_INPUT
			w_div: WSF_FORM_DIV
			w_select: WSF_FORM_SELECT
			w_opt: WSF_FORM_SELECT_OPTION
			w_cb: WSF_FORM_CHECKBOX_INPUT
			w_voc_set: WSF_FORM_DIV
			s: STRING_32
			voc: CMS_VOCABULARY
			t: detachable CMS_TERM
			l_terms: detachable CMS_TERM_COLLECTION
			l_has_edit_permission: BOOLEAN
		do
			if
				attached vocabularies_for_type (a_content_type_name) as l_vocs and then not l_vocs.is_empty
			then
				l_has_edit_permission := a_response.has_permissions (<<"update any taxonomy", "update " + a_content_type_name + " taxonomy">>)

				-- Handle Taxonomy fields, if any associated with `content_type'.
				create w_div.make
				w_div.add_css_class ("taxonomy")
				l_vocs.sort
				across
					l_vocs as vocs_ic
				loop
					voc := vocs_ic.item
					create th.make_with_text ("taxonomy_vocabularies[" + voc.id.out + "]", voc.name)
					w_div.extend (th)

					l_terms := Void
					if a_content /= Void then
						l_terms := terms_of_content (a_content, voc)
						if l_terms /= Void then
							l_terms.sort
						end
					end
					create w_voc_set.make
					w_div.extend (w_voc_set)

					if voc.is_tags then
						w_voc_set.extend_html_text ("<strong><label>" + cms_api.html_encoded (cms_api.translation (voc.name, Void)) + "</label></strong>")
--						set_legend (cms_api.translation (voc.name, Void))

						create ti.make ("taxonomy_" + voc.id.out)
						w_voc_set.extend (ti)
						if voc.is_term_required then
							ti.enable_required
						end
						if attached voc.description as l_desc then
							ti.set_description (cms_api.html_encoded (cms_api.translation (l_desc, Void)))
						else
							ti.set_description (a_response.html_encoded (cms_api.translation (voc.name, Void)))
						end
						ti.set_size (70)
						if l_terms /= Void then
							create s.make_empty
							across
								l_terms as ic
							loop
								t := ic.item
								if not s.is_empty then
									s.append_character (',')
									s.append_character (' ')
								end
								if ic.item.text.has (',') then
									s.append_character ('"')
									s.append (t.text)
									s.append_character ('"')
								else
									s.append (t.text)
								end
							end
							ti.set_text_value (s)
						end
						if not l_has_edit_permission then
							ti.set_is_readonly (True)
						end
					else
						fill_vocabularies_with_terms (voc)
						if not voc.terms.is_empty then
							if voc.multiple_terms_allowed then
								if attached voc.description as l_desc then
									w_voc_set.extend_html_text ("<strong><label>" + cms_api.html_encoded (l_desc) + "</label></strong>")
--									w_voc_set.set_legend (cms_api.html_encoded (l_desc))
								else
									w_voc_set.extend_html_text ("<strong><label>" + cms_api.html_encoded (voc.name) + "</label></strong>")
--									w_voc_set.set_legend (cms_api.html_encoded (voc.name))
								end
								across
									voc as voc_terms_ic
								loop
									t := voc_terms_ic.item
									create w_cb.make_with_value ("taxonomy_" + voc.id.out + "[]", t.text)
									w_cb.set_title (t.text)
									w_voc_set.extend (w_cb)
									if l_terms /= Void and then across l_terms as ic some ic.item.text.same_string (t.text) end then
										w_cb.set_checked (True)
									end
									if not l_has_edit_permission then
										w_cb.set_is_readonly (True)
									end
								end
							else
								create w_select.make ("taxonomy_" + voc.id.out)
								w_voc_set.extend (w_select)

								if attached voc.description as l_desc then
									w_select.set_description (cms_api.html_encoded (l_desc))
								else
									w_select.set_description (cms_api.html_encoded (voc.name))
								end
								w_voc_set.extend_html_text ("<strong><label>" + cms_api.html_encoded (voc.name) + "</label></strong>")
--								w_voc_set.set_legend (cms_api.html_encoded (voc.name))

								across
									voc as voc_terms_ic
								loop
									t := voc_terms_ic.item
									create w_opt.make (cms_api.html_encoded (t.text), cms_api.html_encoded (t.text))
									w_select.add_option (w_opt)

									if l_terms /= Void and then across l_terms as ic some ic.item.text.same_string (t.text) end then
										w_opt.set_is_selected (True)
									end
								end
								if not l_has_edit_permission then
									w_select.set_is_readonly (True)
								end
							end
						end
					end
				end

				a_form.submit_actions.extend (agent taxonomy_submit_action (a_response, Current, l_vocs, a_content, ?))

				if
					attached a_form.fields_by_name ("title") as l_title_fields and then
					attached l_title_fields.first as l_title_field
				then
					a_form.insert_after (w_div, l_title_field)
				else
					a_form.extend (w_div)
				end
			end
		end

	taxonomy_submit_action (a_response: CMS_RESPONSE; a_taxonomy_api: CMS_TAXONOMY_API; a_vocs: CMS_VOCABULARY_COLLECTION; a_content: detachable CMS_CONTENT fd: WSF_FORM_DATA)
		require
			vocs_not_empty: not a_vocs.is_empty
		local
			l_voc_name: READABLE_STRING_32
			l_terms_to_remove: ARRAYED_LIST [CMS_TERM]
			l_new_terms: LIST [READABLE_STRING_32]
			l_text: READABLE_STRING_GENERAL
			l_found: BOOLEAN
			t: detachable CMS_TERM
			vid: INTEGER_64
		do
			if
				a_content /= Void and then a_content.has_identifier and then
				attached fd.table_item ("taxonomy_vocabularies") as fd_vocs
			then
				if a_response.has_permissions (<<"update any taxonomy", "update " + a_content.content_type + " taxonomy">>) then
					across
						fd_vocs.values as ic
					loop
						vid := ic.key.to_integer_64
						l_voc_name := ic.item.string_representation

						if attached a_vocs.item_by_id (vid) as voc then
							if attached fd.string_item ("taxonomy_" + vid.out) as l_string then
								l_new_terms := a_taxonomy_api.splitted_string (l_string, ',')
							elseif attached fd.table_item ("taxonomy_" + vid.out) as fd_terms then
								create {ARRAYED_LIST [READABLE_STRING_32]} l_new_terms.make (fd_terms.count)
								across
									fd_terms as t_ic
								loop
									l_new_terms.force (t_ic.item.string_representation)
								end
							else
								create {ARRAYED_LIST [READABLE_STRING_32]} l_new_terms.make (0)
							end

							create l_terms_to_remove.make (0)
							if attached a_taxonomy_api.terms_of_content (a_content, voc) as l_existing_terms then
								across
									l_existing_terms as t_ic
								loop
									l_text := t_ic.item.text
									from
										l_found := False
										l_new_terms.start
									until
										l_new_terms.after
									loop
										if l_new_terms.item.same_string_general (l_text) then
												-- Already associated with term `t_ic.text'.
											l_found := True
											l_new_terms.remove
										else
											l_new_terms.forth
										end
									end
									if not l_found then
											-- Remove term
										l_terms_to_remove.force (t_ic.item)
									end
								end
								across
									l_terms_to_remove as t_ic
								loop
									a_taxonomy_api.unassociate_term_from_content (t_ic.item, a_content)
								end
							end
							across
								l_new_terms as t_ic
							loop
								t := a_taxonomy_api.term_by_text (t_ic.item, voc)
								if
									t = Void and voc.is_tags
								then
										-- Create new term!
									create t.make (t_ic.item)
									a_taxonomy_api.save_term (t, voc)
									if a_taxonomy_api.has_error then
										t := Void
									end
								end
								if t /= Void then
									a_taxonomy_api.associate_term_with_content (t, a_content)
								end
							end
						end
					end
				end
			end
		end

	append_taxonomy_to_xhtml (a_content: CMS_CONTENT; a_response: CMS_RESPONSE; a_output: STRING)
			-- Append taxonomy related to `a_content' to xhtml string `a_output',
			-- using `a_response' helper routines.
		do
			if
				attached vocabularies_for_type (a_content.content_type) as vocs and then not vocs.is_empty
			then
				vocs.sort
				across
					vocs as ic
				loop
					if
						attached terms_of_content (a_content, ic.item) as l_terms and then
						not l_terms.is_empty
					then
						a_output.append ("<ul class=%"taxonomy term-" + ic.item.id.out + "%">")
						a_output.append (cms_api.html_encoded (ic.item.name))
						a_output.append (": ")
						across
							l_terms as t_ic
						loop
							a_output.append ("<li>")
							a_response.add_keyword (t_ic.item.text)
							a_response.append_link_to_html (t_ic.item.text, "taxonomy/term/" + t_ic.item.id.out, Void, a_output)
							a_output.append ("</li>")
						end
						a_output.append ("</ul>%N")
					end
				end
			end
		end

feature -- Helpers

	splitted_string (s: READABLE_STRING_32; sep: CHARACTER): LIST [READABLE_STRING_32]
			-- Splitted string from `s' with separator `sep', and support '"..."' wrapping.
		local
			i,j,n,b: INTEGER
			t: STRING_32
		do
			create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (1)
			Result.compare_objects
			from
				i := 1
				b := 1
				n := s.count
				create t.make_empty
			until
				i > n
			loop
				if s[i].is_space then
					if not t.is_empty then
						t.append_character (s[i])
					end
				elseif s[i] = sep then
					t.left_adjust
					t.right_adjust
					if t.count > 2 and t.starts_with_general ("%"") and t.ends_with_general ("%"") then
						t.remove_head (1)
						t.remove_tail (1)
					end
					Result.force (t)
					create t.make_empty
				elseif s[i] = '"' then
					j := s.index_of ('"', i + 1)
					if j > 0 then
						t.append (s.substring (i, j))
					end
					i := j
				else
					t.append_character (s[i])
				end
				i := i + 1
			end
			if not t.is_empty then
				t.left_adjust
				t.right_adjust
				Result.force (t)
			end
		end

end
