note
	description: "[
			]"

class
	NODE_EDIT_CMS_EXECUTION

inherit
	NODE_CMS_EXECUTION

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
			f: like edit_form
			fd: detachable WSF_FORM_DATA
		do
			create b.make_empty
			if
				attached {WSF_STRING} request.path_parameter ("nid") as p_nid and then
				p_nid.is_integer and then
				attached service.storage.node (p_nid.integer_value) as l_node
			then
				if attached service.content_type (l_node.content_type_name) as l_type then
					if has_permission ("edit " + l_type.name) then
						f := edit_form (l_node, url (request.path_info, Void), "edit-" + l_type.name, l_type)
						if request.is_post_request_method then
							f.validation_actions.extend (agent edit_form_validate (?, b))
							f.submit_actions.extend (agent edit_form_submit (?, l_node, l_type, b))
							f.process (Current)
							fd := f.last_data
						end

						set_title ("Edit #" + l_node.id.out)

						add_to_menu (create {CMS_LOCAL_LINK}.make ("View", node_url (l_node)), primary_tabs)
						add_to_menu (create {CMS_LOCAL_LINK}.make ("Edit", "/node/" + l_node.id.out + "/edit"), primary_tabs)

						f.append_to_html (theme, b)
					else
						b.append ("<h1>Access denied</h1>")
					end
				else
					set_title ("Unknown node")
				end
			else
				set_title ("Create new content ...")
				b.append ("<ul id=%"content-types%">")
				across
					service.content_types as c
				loop
					if has_permission ("create " + c.item.name) then
						b.append ("<li>" + link (c.item.name, "/node/add/" + c.item.name, Void))
						if attached c.item.description as d then
							b.append ("<div class=%"description%">" + d + "</div>")
						end
						b.append ("</li>")
					end
				end
				b.append ("</ul>")
			end
			set_main_content (b)
		end

--	edit_form_validate (fd: CMS_FORM_DATA; b: STRING)
--		local
--			l_preview: BOOLEAN
--			l_format: detachable CMS_FORMAT
--		do
--			l_preview := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string ("Preview")
--			if l_preview then
--				b.append ("<strong>Preview</strong><div class=%"preview%">")
--				if attached fd.string_item ("format") as s_format and then attached formats.format (s_format) as f_format then
--					l_format := f_format
--				end
--				if attached fd.string_item ("title") as l_title then
--					b.append ("<strong>Title:</strong><div class=%"title%">" + html_encoded (l_title) + "</div>")
--				end
--				if attached fd.string_item ("body") as l_body then
--					b.append ("<strong>Body:</strong><div class=%"body%">")
--					if l_format /= Void then
--						b.append (l_format.to_html (l_body))
--					else
--						b.append (html_encoded (l_body))
--					end
--					b.append ("</div>")
--				end
--				b.append ("</div>")
--			end
--		end

--	edit_form_submit (fd: CMS_FORM_DATA; a_node: detachable CMS_NODE; a_type: CMS_CONTENT_TYPE; b: STRING)
--		local
--			l_preview: BOOLEAN
--			l_node: detachable CMS_NODE
--			s: STRING
--		do
--			l_preview := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string ("Preview")
--			if not l_preview then
--				debug ("cms")
--					across
--						fd as c
--					loop
--						b.append ("<li>" +  html_encoded (c.key) + "=")
--						if attached c.item as v then
--							b.append (html_encoded (v.string_representation))
--						end
--						b.append ("</li>")
--					end
--				end
--				if a_node /= Void then
--					l_node := a_node
--					a_type.change_node (Current, fd, a_node)
--					s := "modified"
--				else
--					l_node := a_type.new_node (Current, fd, Void)
--					s := "created"
--				end
--				service.storage.save_node (l_node)
--				if attached user as u then
--					service.log ("node", "User %"" + user_link (u) + "%" " + s + " node " + link (a_type.name +" #" + l_node.id.out, "/node/" + l_node.id.out , Void), 0, node_local_link (l_node))
--				else
--					service.log ("node", "Anonymous " + s + " node " + a_type.name +" #" + l_node.id.out, 0, node_local_link (l_node))
--				end
--				add_success_message ("Node #" + l_node.id.out + " saved.")
--				set_redirection (node_url (l_node))
--			end
--		end

--	edit_form (a_node: detachable CMS_NODE; a_url: READABLE_STRING_8; a_name: STRING; a_type: CMS_CONTENT_TYPE): CMS_FORM
--		local
--			f: CMS_FORM
--			ts: CMS_FORM_SUBMIT_INPUT
--			th: CMS_FORM_HIDDEN_INPUT
--		do
--			create f.make (a_url, a_name)

--			create th.make ("node-id")
--			if a_node /= Void then
--				th.set_text_value (a_node.id.out)
--			else
--				th.set_text_value ("0")
--			end
--			f.extend (th)

--			a_type.fill_edit_form (f, a_node)

--			f.extend_text ("<br/>")

--			create ts.make ("op")
--			ts.set_default_value ("Save")
--			f.extend (ts)

--			create ts.make ("op")
--			ts.set_default_value ("Preview")
--			f.extend (ts)

--			Result := f
--		end

end
