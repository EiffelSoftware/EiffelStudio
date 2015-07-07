note
	description: "Summary description for {CMS_NODE_TYPE_WEBFORM_MANAGER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_NODE_TYPE_WEBFORM_MANAGER [G -> CMS_NODE]

inherit
	CMS_NODE_TYPE_WEBFORM_MANAGER_I [G]

	SHARED_WSF_PERCENT_ENCODER

feature -- Forms ...		

	populate_form (response: NODE_RESPONSE; f: CMS_FORM; a_node: detachable CMS_NODE)
		local
			ti: WSF_FORM_TEXT_INPUT
			fset: WSF_FORM_FIELD_SET
			ta, sum: CMS_FORM_TEXTAREA
			tselect: WSF_FORM_SELECT
			opt: WSF_FORM_SELECT_OPTION
			cms_format: CMS_EDITOR_CONTENT_FORMAT
			l_uri: detachable READABLE_STRING_8
		do
			create cms_format

			create ti.make ("title")
			ti.set_label ("Title")
			ti.set_size (70)
			if a_node /= Void then
				ti.set_text_value (a_node.title)
			end
			ti.set_is_required (True)
			f.extend (ti)

			f.extend_html_text ("<br/>")

				-- Select field has to be initialized before textareas are replaced, because they depend on the selection of the field
			create tselect.make ("format")
			tselect.set_label ("Body's format")
			tselect.set_is_required (True)

				-- Main Content
			create ta.make ("body")
			ta.set_rows (10)
			ta.set_cols (70)
			ta.show_as_editor_if_selected (tselect, cms_format.name)
			if a_node /= Void then
				ta.set_text_value (a_node.content)
			end
			ta.set_label ("Content")
			ta.set_description ("This is the main content")
			ta.set_is_required (False)

				-- Summary
			create sum.make ("summary")
			sum.set_rows (3)
			sum.set_cols (70)
				-- if cms_html is selected
			sum.show_as_editor_if_selected (tselect, cms_format.name)
			if a_node /= Void then
				sum.set_text_value (a_node.summary)
			end
			sum.set_label ("Summary")
			sum.set_description ("This is the summary")
			sum.set_is_required (False)

			create fset.make
			fset.set_legend ("Body")

				-- Add summary
			fset.extend (sum)
			fset.extend_html_text("<br />")

				-- Add content (body)
			fset.extend (ta)
			fset.extend_html_text ("<br/>")

			across
				 content_type.available_formats as c
			loop
				create opt.make (c.item.name, c.item.title)
				if attached c.item.html_help as f_help then
					opt.set_description ("<ul>" + f_help + "</ul>")
				end
				tselect.add_option (opt)
			end
			if a_node /= Void and then attached a_node.format as l_format then
				tselect.set_text_by_value (l_format)
			end

			fset.extend (tselect)

			f.extend (fset)

				-- Path alias		
			create ti.make ("path_alias")
			ti.set_label ("Path")
			ti.set_size (70)
			if a_node /= Void and then a_node.has_id then
				if attached a_node.link as lnk then
					l_uri := lnk.location
				else
					l_uri := percent_encoder.percent_decoded_string (response.api.location_alias (response.node_api.node_path (a_node)))
				end
				ti.set_text_value (l_uri)
				ti.set_description ("Optionally specify an alternative URL path by which this content can be accessed. For example, type 'about' when writing an about page. Use a relative path or the URL alias won't work.")
				ti.set_validation_action (agent (fd: WSF_FORM_DATA; a_response: CMS_RESPONSE)
						do
							if
								attached fd.string_item ("path_alias") as f_path_alias
							then
								if a_response.api.is_valid_path_alias (f_path_alias) then
										-- Ok.
								elseif f_path_alias.is_empty then
										-- Ok
								elseif f_path_alias.starts_with_general ("/") then
									fd.report_invalid_field ("path_alias", "Path alias should not start with a slash '/' .")
								elseif f_path_alias.has_substring ("://") then
									fd.report_invalid_field ("path_alias", "Path alias should not be absolute url .")
								else
										-- TODO: implement full path alias validation
								end
								if
									attached a_response.api.source_of_path_alias (f_path_alias) as l_aliased_location
								then
									fd.report_invalid_field ("path_alias", "Path is already aliased to location %"" + a_response.link (Void, l_aliased_location, Void) + "%" !")
								end
							end
						end(?, response)
					)
			end
			if
				attached f.fields_by_name ("title") as l_title_fields and then
				attached l_title_fields.first as l_title_field
			then
				f.insert_after (ti, l_title_field)
			else
				f.extend (ti)
			end
		end

	update_node	(response: NODE_RESPONSE; fd: WSF_FORM_DATA; a_node: CMS_NODE)
		local
			b,s: detachable READABLE_STRING_8
			f: detachable CONTENT_FORMAT
		do
			if attached fd.integer_item ("id") as l_id and then l_id > 0 then
				check a_node.id = l_id end
			end
			if attached fd.string_item ("title") as l_title then
				a_node.set_title (l_title)
			end

			if attached fd.string_item ("body") as l_body then
				b := l_body
			end

			-- Read out the summary field from the form data
			if attached fd.string_item ("summary") as l_summary then
				s := l_summary
			end

			if attached fd.string_item ("format") as s_format and then attached response.api.format (s_format) as f_format then
				f := f_format
			elseif a_node /= Void and then attached a_node.format as s_format and then attached response.api.format (s_format) as f_format then
				f := f_format
			else
				f := response.formats.default_format
			end

			-- Update node with summary and body content
			if b /= Void then
				a_node.set_content (b, s, f.name)
			end


		end

	new_node (response: NODE_RESPONSE; fd: WSF_FORM_DATA; a_node: detachable CMS_NODE): G
			-- <Precursor>
		local
			b,s: detachable READABLE_STRING_8
			f: detachable CONTENT_FORMAT
			l_node: detachable like new_node
		do
			if attached {like new_node} a_node as l_arg_node then
				l_node := l_arg_node
			else
				l_node := content_type.new_node (a_node)
			end
			if attached fd.integer_item ("id") as l_id and then l_id > 0 then
				if l_node /= Void then
					check l_node.id = l_id end
				else
					if attached {like new_node} response.node_api.node (l_id) as n then
						l_node := n
					else
						-- FIXME: Error
					end
				end
			end
			if attached fd.string_item ("title") as l_title then
				if l_node = Void then
					l_node := content_type.new_node (Void)
					l_node.set_title (l_title)
				else
					l_node.set_title (l_title)
				end
			else
				if l_node = Void then
					l_node := content_type.new_node_with_title ("...", Void)
				end
			end
			l_node.set_author (response.user)

			--Summary
			if attached fd.string_item ("summary") as l_summary then
				s := l_summary
			end

			--Content
			if attached fd.string_item ("body") as l_body then
				b := l_body
			end

			if attached fd.string_item ("format") as s_format and then attached response.api.format (s_format) as f_format then
				f := f_format
			elseif a_node /= Void and then attached a_node.format as s_format and then attached response.api.format (s_format) as f_format then
				f := f_format
			else
				f := response.formats.default_format
			end

			-- Update node with summary and content
			if b /= Void then
				l_node.set_content (b, s, f.name)
			end
			Result := l_node
		end

feature -- Output

	append_html_output_to (a_node: CMS_NODE; a_response: NODE_RESPONSE)
			-- <Precursor>
		local
			lnk: CMS_LOCAL_LINK
			hdate: HTTP_DATE
			s: STRING
			node_api: CMS_NODE_API
		do
			node_api := a_response.node_api

			a_response.add_variable (a_node, "node")
			lnk := a_response.node_local_link (a_node, a_response.translation ("View", Void))
			lnk.set_weight (1)
			a_response.add_to_primary_tabs (lnk)

			if a_node.status = {CMS_NODE_API}.trashed then
				create lnk.make ("Trash", node_api.node_path (a_node) + "/trash")
				lnk.set_weight (2)
				a_response.add_to_primary_tabs (lnk)
			else
					-- Node in {{CMS_NODE_API}.published} or {CMS_NODE_API}.not_published} status.
				create lnk.make ("Edit", node_api.node_path (a_node) + "/edit")
				lnk.set_weight (2)
				a_response.add_to_primary_tabs (lnk)

				if
					a_node /= Void and then
					a_node.id > 0 and then
					attached node_api.node_type_for (a_node) as l_type and then
					node_api.has_permission_for_action_on_node ("delete", a_node, a_response.current_user (a_response.request))
				then
					create lnk.make ("Delete", node_api.node_path (a_node) + "/delete")
					lnk.set_weight (3)
					a_response.add_to_primary_tabs (lnk)
				end
			end

			create s.make_empty
			s.append ("<div class=%"info%"> ")
			if attached a_node.author as l_author then
				s.append (" by ")
				s.append (l_author.name)
			end
			if attached a_node.modification_date as l_modified then
				s.append (" (modified: ")
				create hdate.make_from_date_time (l_modified)
				s.append (hdate.yyyy_mmm_dd_string)
				s.append (")")
			end
			s.append ("</div>")


			-- We don't show the summary on the detail page, since its just a short view of the full content. Otherwise we would write the same thing twice.
			-- The usage of the summary is to give a short overview in the list of nodes or for the meta tag "description"

--			if attached a_node.summary as l_summary then
--				s.append ("<p class=%"summary%">")
--				if attached node_api.cms_api.format (a_node.format) as f then
--					s.append (f.formatted_output (l_summary))
--				else
--					s.append (a_response.formats.default_format.formatted_output (l_summary))
--				end

--				s.append ("</p>")

--			end

			if attached a_node.content as l_content then
				s.append ("<p class=%"content%">")
				if attached node_api.cms_api.format (a_node.format) as f then
					s.append (f.formatted_output (l_content))
				else
					s.append (a_response.formats.default_format.formatted_output (l_content))
				end

				s.append ("</p>")
			end

			a_response.set_title (a_node.title)
			a_response.set_main_content (s)
		end

end

