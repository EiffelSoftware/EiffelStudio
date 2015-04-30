note
	description: "CMS Response handling node editing workflow using Web forms."
	revision: "$Revision$"

class
	NODE_FORM_RESPONSE

inherit
	NODE_RESPONSE
		redefine
			make,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api; a_node_api: like node_api)
		do
			create {WSF_NULL_THEME} wsf_theme.make
			Precursor (req, res, a_api, a_node_api)
		end

	initialize
		do
			Precursor
			create {WSF_CMS_THEME} wsf_theme.make (Current, theme)
		end

	wsf_theme: WSF_THEME

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
			f: like edit_form
			fd: detachable WSF_FORM_DATA
			nid: INTEGER_64
		do
			create b.make_empty
			nid := node_id_path_parameter (request)
			if
				nid > 0 and then
				attached node_api.node (nid) as l_node
			then
				if attached node_api.node_type_for (l_node) as l_type then
					if has_permission ("edit " + l_type.name) then
						f := edit_form (l_node, url (request.path_info, Void), "edit-" + l_type.name, l_type)
						if request.is_post_request_method then
							f.validation_actions.extend (agent edit_form_validate (?, b))
							f.submit_actions.extend (agent edit_form_submit (?, l_node, l_type, b))
							f.process (Current)
							fd := f.last_data
						end

						if attached redirection as l_location then
								-- FIXME: Hack for now
							set_title (l_node.title)
							add_to_menu (create {CMS_LOCAL_LINK}.make ("View", node_url (l_node)), primary_tabs)
							add_to_menu (create {CMS_LOCAL_LINK}.make ("Edit", "/node/" + l_node.id.out + "/edit"), primary_tabs)

							b.append (html_encoded (l_type.title) + " saved")
						else
							set_title ("Edit " + html_encoded (l_type.title) + " #" + l_node.id.out)

							add_to_menu (create {CMS_LOCAL_LINK}.make ("View", node_url (l_node)), primary_tabs)
							add_to_menu (create {CMS_LOCAL_LINK}.make ("Edit", "/node/" + l_node.id.out + "/edit"), primary_tabs)

							f.append_to_html (wsf_theme, b)
						end
					else
						b.append ("<h1>Access denied</h1>")
					end
				else
					set_title ("Unknown node")
				end
			elseif
				attached {WSF_STRING} request.path_parameter ("type") as p_type and then
				attached node_api.node_type (p_type.value) as l_type
			then
				if has_permission ("create " + l_type.name) then
					if attached l_type.new_node (Void) as l_node then
						f := edit_form (l_node, url (request.path_info, Void), "edit-" + l_type.name, l_type)
						if request.is_post_request_method then
							f.validation_actions.extend (agent edit_form_validate (?, b))
							f.submit_actions.extend (agent edit_form_submit (?, l_node, l_type, b))
							f.process (Current)
							fd := f.last_data
						end

						set_title ("Edit " + html_encoded (l_type.title) + " #" + l_node.id.out)

						add_to_menu (create {CMS_LOCAL_LINK}.make ("View", node_url (l_node)), primary_tabs)
						add_to_menu (create {CMS_LOCAL_LINK}.make ("Edit", "/node/" + l_node.id.out + "/edit"), primary_tabs)

						f.append_to_html (wsf_theme, b)
					else
						b.append ("<h1>Server error</h1>")
					end
				else
					b.append ("<h1>Access denied</h1>")
				end
			else
				set_title ("Create new content ...")
				b.append ("<ul id=%"content-types%">")
				across
					node_api.node_types as ic
				loop
					if
						attached ic.item as l_node_type and then
						(has_permission ("create any") or has_permission ("create " + l_node_type.name))
					then
						b.append ("<li>" + link (l_node_type.name, "/node/add/" + l_node_type.name, Void))
						if attached l_node_type.description as d then
							b.append ("<div class=%"description%">" + d + "</div>")
						end
						b.append ("</li>")
					end
				end
				b.append ("</ul>")
			end
			set_main_content (b)
		end

feature -- Form	

	edit_form_validate (fd: WSF_FORM_DATA; b: STRING)
		local
			l_preview: BOOLEAN
			l_format: detachable CONTENT_FORMAT
		do
			l_preview := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string ("Preview")
			if l_preview then
				b.append ("<strong>Preview</strong><div class=%"preview%">")
				if attached fd.string_item ("format") as s_format and then attached api.format (s_format) as f_format then
					l_format := f_format
				end
				if attached fd.string_item ("title") as l_title then
					b.append ("<strong>Title:</strong><div class=%"title%">" + html_encoded (l_title) + "</div>")
				end
				if attached fd.string_item ("body") as l_body then
					b.append ("<strong>Body:</strong><div class=%"body%">")
					if l_format /= Void then
						b.append (l_format.formatted_output (l_body))
					else
						b.append (html_encoded (l_body))
					end
					b.append ("</div>")
				end
				b.append ("</div>")
			end
		end

	edit_form_submit (fd: WSF_FORM_DATA; a_node: detachable CMS_NODE; a_type: CMS_NODE_TYPE [CMS_NODE]; b: STRING)
		local
			l_preview: BOOLEAN
			l_node: detachable CMS_NODE
			s: STRING
		do
			l_preview := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string ("Preview")
			if not l_preview then
				debug ("cms")
					across
						fd as c
					loop
						b.append ("<li>" +  html_encoded (c.key) + "=")
						if attached c.item as v then
							b.append (html_encoded (v.string_representation))
						end
						b.append ("</li>")
					end
				end
				if a_node /= Void then
					l_node := a_node
					if l_node.has_id then
						change_node (a_type, fd, a_node)
						s := "modified"
					else
						change_node (a_type, fd, a_node)
						l_node.set_author (user)
						s := "created"
					end
				else
					l_node := new_node (a_type, fd, Void)
					l_node.set_author (user)
					s := "created"
				end
				node_api.save_node (l_node)
				if attached current_user (request) as u then
					api.log ("node", "User %"" + user_link (u) + "%" " + s + " node " + link (a_type.name +" #" + l_node.id.out, "/node/" + l_node.id.out , Void), 0, node_local_link (l_node))
				else
					api.log ("node", "Anonymous " + s + " node " + a_type.name +" #" + l_node.id.out, 0, node_local_link (l_node))
				end
				add_success_message ("Node #" + l_node.id.out + " saved.")
				set_redirection (node_url (l_node))
			end
		end

	edit_form (a_node: detachable CMS_NODE; a_url: READABLE_STRING_8; a_name: STRING; a_type: CMS_NODE_TYPE [CMS_NODE]): CMS_FORM
		local
			f: CMS_FORM
			ts: WSF_FORM_SUBMIT_INPUT
			th: WSF_FORM_HIDDEN_INPUT
		do
			create f.make (a_url, a_name)

			create th.make ("node-id")
			if a_node /= Void then
				th.set_text_value (a_node.id.out)
			else
				th.set_text_value ("0")
			end
			f.extend (th)

			fill_edit_form (a_type, f, a_node)

			f.extend_html_text ("<br/>")

			create ts.make ("op")
			ts.set_default_value ("Save")
			f.extend (ts)

			create ts.make ("op")
			ts.set_default_value ("Preview")
			f.extend (ts)

			Result := f
		end

	new_node (a_content_type: CMS_NODE_TYPE [CMS_NODE]; a_form_data: WSF_FORM_DATA; a_node: detachable CMS_NODE): CMS_NODE
			--
		do
			if attached node_api.node_type_webform_manager (a_content_type) as wf then
				Result := wf.new_node (Current, a_form_data, a_node)
			else
				Result := a_content_type.new_node (a_node)
			end
		end

	change_node (a_content_type: CMS_NODE_TYPE [CMS_NODE]; a_form_data: WSF_FORM_DATA; a_node: CMS_NODE)
			-- Update node `a_node' with form_data `a_form_data' for the given content type `a_content_type'.
		do
			if attached node_api.node_type_webform_manager (a_content_type) as wf then
				wf.update_node (Current, a_form_data, a_node)
			end
		end

	fill_edit_form (a_content_type: CMS_NODE_TYPE [CMS_NODE]; a_form: WSF_FORM; a_node: detachable CMS_NODE)
		do
			if attached node_api.node_type_webform_manager (a_content_type) as wf then
				wf.populate_form (Current, a_form, a_node)
			end
		end

end
