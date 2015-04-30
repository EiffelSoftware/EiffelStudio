note
	description: "Summary description for {CMS_NODE_TYPE_WEBFORM_MANAGER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_NODE_TYPE_WEBFORM_MANAGER [G -> CMS_NODE]

inherit
	CMS_NODE_TYPE_WEBFORM_MANAGER_I [G]

feature -- Forms ...		

	populate_form (response: NODE_RESPONSE; f: CMS_FORM; a_node: detachable CMS_NODE)
		local
			ti: WSF_FORM_TEXT_INPUT
			fset: WSF_FORM_FIELD_SET
			ta: WSF_FORM_TEXTAREA
			tselect: WSF_FORM_SELECT
			opt: WSF_FORM_SELECT_OPTION
		do
			create ti.make ("title")
			ti.set_label ("Title")
			ti.set_size (70)
			if a_node /= Void then
				ti.set_text_value (a_node.title)
			end
			ti.set_is_required (True)
			f.extend (ti)

			f.extend_html_text ("<br/>")

			create ta.make ("body")
			ta.set_rows (10)
			ta.set_cols (70)
			if a_node /= Void then
				ta.set_text_value (a_node.content)
			end
--			ta.set_label ("Body")
			ta.set_description ("This is the main content")
			ta.set_is_required (False)

			create fset.make
			fset.set_legend ("Body")
			fset.extend (ta)

			fset.extend_html_text ("<br/>")

			create tselect.make ("format")
			tselect.set_label ("Body's format")
			tselect.set_is_required (True)
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
		end

	update_node	(response: NODE_RESPONSE; fd: WSF_FORM_DATA; a_node: CMS_NODE)
		local
			b: detachable READABLE_STRING_8
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
			if attached fd.string_item ("format") as s_format and then attached response.api.format (s_format) as f_format then
				f := f_format
			elseif a_node /= Void and then attached a_node.format as s_format and then attached response.api.format (s_format) as f_format then
				f := f_format
			else
				f := response.formats.default_format
			end
			if b /= Void then
				a_node.set_content (b, Void, f.name) -- FIXME: summary
			end
		end

	new_node (response: NODE_RESPONSE; fd: WSF_FORM_DATA; a_node: detachable CMS_NODE): G
			-- <Precursor>
		local
			b: detachable READABLE_STRING_8
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
			if b /= Void then
				l_node.set_content (b, Void, f.name)
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
			create lnk.make ("View", node_api.node_path (a_node))
			lnk.set_weight (1)
			a_response.add_to_primary_tabs (lnk)
			create lnk.make ("Edit", node_api.node_path (a_node) + "/edit")
			lnk.set_weight (2)
			a_response.add_to_primary_tabs (lnk)

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

