note
	description: "Summary description for {CMS_PAGE_NODE_TYPE_WEBFORM_MANAGER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PAGE_NODE_TYPE_WEBFORM_MANAGER

inherit
	CMS_NODE_TYPE_WEBFORM_MANAGER [CMS_PAGE]
		redefine
			content_type,
			append_html_output_to,
			populate_form,
			new_node,
			update_node
		end

create
	make

feature -- Access

	content_type: CMS_PAGE_NODE_TYPE
			-- Associated content type.	

feature -- Forms ...

	populate_form (response: NODE_RESPONSE; f: CMS_FORM; a_node: detachable CMS_NODE)
		local
			ti: WSF_FORM_NUMBER_INPUT
			fs: WSF_FORM_FIELD_SET
			l_parent_id: INTEGER_64
		do
			Precursor (response, f, a_node)

			if attached {CMS_PAGE} a_node as l_page then
				create fs.make
				fs.set_legend ("Pages structure")
				fs.set_collapsible (True)
				f.extend (fs)
				create ti.make ("select_parent_node")
				ti.set_label ("Parent page")
				ti.set_description ("The parent page is the book structure.")
				if attached l_page.parent as l_parent_node then
					l_parent_id := l_parent_node.id
					fs.extend_html_text ("<div><strong>Currently, the parent page is </strong> ")
					fs.extend_html_text (response.node_html_link (l_parent_node,  l_parent_node.title))
					fs.extend_html_text ("</div>")
				end
				ti.set_validation_action (agent parent_validation (response, ?))
				fs.extend (ti)

				-- FIXME: add notion of "weight"

				if
					attached {WSF_STRING} response.request.query_parameter ("parent") as p_parent and then
					p_parent.is_integer
				then
					l_parent_id := p_parent.integer_value.to_integer_64
				end
				if l_parent_id > 0 then
					ti.set_default_value (l_parent_id.out)
				end
			end
		end

	update_node	(a_response: NODE_RESPONSE; fd: WSF_FORM_DATA; a_node: CMS_NODE)
			-- <Precursor>
		local
			l_parent_id: INTEGER_64
		do
			Precursor (a_response, fd, a_node)
			if attached {CMS_PAGE} a_node as l_page then
				if attached fd.integer_item ("select_parent_node") as i_parent_node then
					l_parent_id := i_parent_node.to_integer_64
				end
				if
					l_parent_id > 0 and then
					attached {CMS_PAGE} a_response.node_api.node (l_parent_id) as l_parent_page
				then
					l_page.set_parent (l_parent_page)
				elseif l_parent_id = -1	then
						-- Set parent to Void
					l_page.set_parent (Void)
				end
			end
		end

	new_node (response: NODE_RESPONSE; fd: WSF_FORM_DATA; a_node: detachable like new_node): like content_type.new_node
			-- <Precursor>
		do
			Result := Precursor (response, fd, a_node)
			if attached fd.integer_item ("select_parent_node") as l_parent_id then
				if l_parent_id = -1 then
					Result.set_parent (Void)
				elseif attached {CMS_PAGE} response.node_api.node (l_parent_id) as l_parent then
					Result.set_parent (l_parent)
				end
			end
		end

	parent_validation (a_response: NODE_RESPONSE; fd: WSF_FORM_DATA)
		local
			node_api: CMS_NODE_API
			l_parent_id: INTEGER_64
			nid: INTEGER_64
			l_parent_node: detachable CMS_NODE
		do
			node_api := a_response.node_api
			if attached fd.integer_item ("select_parent_node") as s_parent_node then
				l_parent_id := s_parent_node.to_integer_64
			else
				l_parent_id := 0
			end
			if l_parent_id > 0 then
				l_parent_node := node_api.node (l_parent_id)
				if l_parent_node = Void then
					fd.report_invalid_field ("select_parent_node", "Invalid parent, not found id #" + l_parent_id.out)
				else
					nid := a_response.node_id_path_parameter
					if
						nid > 0 and then
						attached node_api.node (nid) as l_node and then
						node_api.is_node_a_parent_of (l_node, l_parent_node)
					then
						fd.report_invalid_field ("select_parent_node", "Invalid parent due to cycle (node #" + nid.out + " is already a parent of node #" + l_parent_id.out)
					end
				end
			elseif l_parent_id = -1 or else l_parent_id = 0 then
					-- -1 is Used to unassign a parent node
					-- 0 is not taken into account, any other input value is considered invalid.
			else
				fd.report_invalid_field ("select_parent_node", "Invalid node id")
			end
		end

feature -- Output

	append_html_output_to (a_node: CMS_NODE; a_response: NODE_RESPONSE)
			-- <Precursor>
		local
			s: STRING
			node_api: CMS_NODE_API
			lnk: CMS_LOCAL_LINK
		do
			node_api := a_response.node_api
			Precursor (a_node, a_response)

			if a_node.has_id and then not a_node.is_trashed then
				if node_api.has_permission_for_action_on_node ("create", a_node, a_response.user) then
					create lnk.make ("Add Child", "node/add/page?parent=" + a_node.id.out)
					lnk.set_weight (3)
					a_response.add_to_primary_tabs (lnk)
				end
			end

			if attached a_response.main_content as l_main_content then
				s := l_main_content
			else
				create s.make_empty
			end

			if attached {CMS_PAGE} a_node as l_node_page then
				s.append ("<ul class=%"page-navigation%">")
				if attached l_node_page.parent as l_parent_node then
					s.append ("<li class=%"page-parent%">Go to parent page ")
					s.append (a_response.link (l_parent_node.title, a_response.node_api.node_path (l_parent_node), Void))
					s.append ("</li>")
				end
				if attached node_api.children (a_node) as l_children then
					across
						l_children as ic
					loop
						s.append ("<li>")
						s.append (a_response.link (ic.item.title, a_response.node_api.node_path (ic.item), Void))
						s.append ("</li>")
					end
				end
				s.append ("</ul>")
			end

			a_response.set_main_content (s)
		end

end
