note
	description: "Summary description for {NODE_CMS_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NODE_CMS_EXECUTION

inherit
	CMS_EXECUTION

feature -- Form	

	edit_form_validate (fd: WSF_FORM_DATA; b: STRING)
		local
			l_preview: BOOLEAN
			l_format: detachable CMS_FORMAT
		do
			l_preview := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string ("Preview")
			if l_preview then
				b.append ("<strong>Preview</strong><div class=%"preview%">")
				if attached fd.string_item ("format") as s_format and then attached formats.format (s_format) as f_format then
					l_format := f_format
				end
				if attached fd.string_item ("title") as l_title then
					b.append ("<strong>Title:</strong><div class=%"title%">" + html_encoded (l_title) + "</div>")
				end
				if attached fd.string_item ("body") as l_body then
					b.append ("<strong>Body:</strong><div class=%"body%">")
					if l_format /= Void then
						b.append (l_format.to_html (l_body))
					else
						b.append (html_encoded (l_body))
					end
					b.append ("</div>")
				end
				b.append ("</div>")
			end
		end

	edit_form_submit (fd: WSF_FORM_DATA; a_node: detachable CMS_NODE; a_type: CMS_CONTENT_TYPE; b: STRING)
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
					a_type.change_node (Current, fd, a_node)
					s := "modified"
				else
					l_node := a_type.new_node (Current, fd, Void)
					s := "created"
				end
				service.storage.save_node (l_node)
				if attached user as u then
					service.log ("node", "User %"" + user_link (u) + "%" " + s + " node " + link (a_type.name +" #" + l_node.id.out, "/node/" + l_node.id.out , Void), 0, node_local_link (l_node))
				else
					service.log ("node", "Anonymous " + s + " node " + a_type.name +" #" + l_node.id.out, 0, node_local_link (l_node))
				end
				add_success_message ("Node #" + l_node.id.out + " saved.")
				set_redirection (node_url (l_node))
			end
		end

--	edit_form_submit (fd: WSF_FORM_DATA; a_type: CMS_CONTENT_TYPE; b: STRING)
--		local
--			l_preview: BOOLEAN
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
--				if attached a_type.new_node (Current, fd, Void) as l_node then
--					service.storage.save_node (l_node)
--					if attached user as u then
--						service.log ("node", "User %"" + user_link (u) + "%" created node " + link (a_type.name +" #" + l_node.id.out, "/node/" + l_node.id.out , Void), 0, node_local_link (l_node))
--					else
--						service.log ("node", "Anonymous created node "+ a_type.name +" #" + l_node.id.out, 0, node_local_link (l_node))
--					end
--					add_success_message ("Node #" + l_node.id.out + " saved.")
--					set_redirection (node_url (l_node))
--				end
--			end
--		end

	edit_form (a_node: detachable CMS_NODE; a_url: READABLE_STRING_8; a_name: STRING; a_type: CMS_CONTENT_TYPE): CMS_FORM
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

			a_type.fill_edit_form (f, a_node)

			f.extend_html_text ("<br/>")

			create ts.make ("op")
			ts.set_default_value ("Save")
			f.extend (ts)

			create ts.make ("op")
			ts.set_default_value ("Preview")
			f.extend (ts)

			Result := f
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
