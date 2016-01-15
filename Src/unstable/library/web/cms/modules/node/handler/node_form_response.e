note
	description: "CMS Response handling node editing workflow using Web forms."
	revision: "$Revision$"

class
	NODE_FORM_RESPONSE

inherit
	NODE_RESPONSE

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
			nid: INTEGER_64
		do
			create b.make_empty
			nid := node_id_path_parameter
			if
				nid > 0 and then
				attached node_api.node (nid) as l_node
			then
				if attached node_api.node_type_for (l_node) as l_type then
 					if
						location.ends_with_general ("/edit") and then
						node_api.has_permission_for_action_on_node ("edit", l_node, user)
					then
						edit_node (l_node, l_type, b)
					elseif
						location.ends_with_general ("/delete") and then
						node_api.has_permission_for_action_on_node ("delete", l_node, user)
					then
						delete_node (l_node, l_type, b)
					elseif
						location.ends_with_general ("/trash") and then
						node_api.has_permission_for_action_on_node ("trash", l_node, user)
					then
						trash_node (l_node, l_type, b)
					else
						b.append ("<h1>")
						b.append (translation ("Access denied", Void))
						b.append ("</h1>")
					end
				else
					set_title (translation ("Unknown node", Void))
				end
			elseif
				attached {WSF_STRING} request.path_parameter ("type") as p_type and then
				attached node_api.node_type (p_type.value) as l_type
			then
				if has_permissions (<<"create any", "create " +  l_type.name>>) then
						-- create new node
					create_new_node (l_type, b)
				else
					b.append ("<h1>")
					b.append (translation ("Access denied", Void))
					b.append ("</h1>")
				end
			else
				set_title (translation ("Create new content ...", Void))
				b.append ("<ul id=%"content-types%">")
				across
					node_api.node_types as ic
				loop
					if
						attached ic.item as l_node_type and then
						has_permissions (<<"create any", "create " + l_node_type.name>>)
					then
						b.append ("<li>" + link (l_node_type.name, "node/add/" + l_node_type.name, Void))
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


feature {NONE} -- Create a new node

	create_new_node (a_type: CMS_NODE_TYPE [CMS_NODE]; b: STRING_8)
		local
			f: like new_edit_form
			fd: detachable WSF_FORM_DATA
		do
			if attached a_type.new_node (Void) as l_node then
					-- create new node
				f := new_edit_form (l_node, url (location, Void), "edit-" + a_type.name, a_type)
				api.hooks.invoke_form_alter (f, fd, Current)
				if request.is_post_request_method then
					f.validation_actions.extend (agent edit_form_validate (?, b))
					f.submit_actions.put_front (agent edit_form_submit (?, l_node, a_type, b))
					f.process (Current)
					fd := f.last_data
				end

				if l_node.has_id then
					set_title ("Edit " + html_encoded (a_type.title) + " #" + l_node.id.out)
					add_to_menu (node_local_link (l_node, translation ("View", Void)), primary_tabs)
					add_to_menu (create {CMS_LOCAL_LINK}.make (translation ("Edit", Void), node_api.node_path (l_node) + "/edit"), primary_tabs)
				else
					set_title ("New " + html_encoded (a_type.title))
				end
				f.append_to_html (wsf_theme, b)
			else
				b.append ("<h1>")
				b.append (translation ("Server error", Void))
				b.append ("</h1>")
			end
		end


	edit_node (a_node: CMS_NODE; a_type: CMS_NODE_TYPE [CMS_NODE]; b: STRING_8)
		local
			f: like new_edit_form
			fd: detachable WSF_FORM_DATA
		do
			f := new_edit_form (A_node, url (location, Void), "edit-" + a_type.name, a_type)
			api.hooks.invoke_form_alter (f, fd, Current)
			if request.is_post_request_method then
				f.validation_actions.extend (agent edit_form_validate (?, b))
				f.submit_actions.put_front (agent edit_form_submit (?, a_node, a_type, b))
				f.process (Current)
				fd := f.last_data
			end
			if a_node.has_id then
				add_to_menu (node_local_link (a_node, translation ("View", Void)), primary_tabs)
				add_to_menu (create {CMS_LOCAL_LINK}.make (translation ("Edit", Void), node_api.node_path (a_node) + "/edit"), primary_tabs)
				add_to_menu (create {CMS_LOCAL_LINK}.make ("Delete", node_api.node_path (a_node) + "/delete"), primary_tabs)
			end

			if attached redirection as l_location then
					-- FIXME: Hack for now
				set_title (a_node.title)
				b.append (html_encoded (a_type.title) + " saved")
			else
				set_title (formatted_string (translation ("Edit $1 #$2", Void), [a_type.title, a_node.id]))
				f.append_to_html (wsf_theme, b)
			end
		end


	delete_node (a_node: CMS_NODE; a_type: CMS_NODE_TYPE [CMS_NODE]; b: STRING_8)
		local
			f: like new_edit_form
			fd: detachable WSF_FORM_DATA
		do
			if a_node.is_trashed then
				f := new_delete_form (a_node, url (location, Void), "delete-" + a_type.name, a_type)
				api.hooks.invoke_form_alter (f, fd, Current)
				if request.is_post_request_method then
					f.process (Current)
					fd := f.last_data
				end
				if a_node.has_id then
					add_to_menu (node_local_link (a_node, translation ("View", Void)), primary_tabs)
					add_to_menu (create {CMS_LOCAL_LINK}.make (translation ("Edit", Void), node_api.node_path (a_node) + "/edit"), primary_tabs)
					add_to_menu (create {CMS_LOCAL_LINK}.make ("Delete", node_api.node_path (a_node) + "/delete"), primary_tabs)
				end

				if attached redirection as l_location then
						-- FIXME: Hack for now
					set_title (a_node.title)
					b.append (html_encoded (a_type.title) + " deleted")
				else
					set_title (formatted_string (translation ("Delete $1 #$2", Void), [a_type.title, a_node.id]))
					f.append_to_html (wsf_theme, b)
				end
			else
				--
			end
		end


	trash_node (a_node: CMS_NODE; a_type: CMS_NODE_TYPE [CMS_NODE]; b: STRING_8)
		local
			f: like new_edit_form
			fd: detachable WSF_FORM_DATA
		do
			f := new_trash_form (a_node, url (location, Void), "trash-" + a_type.name, a_type)
			api.hooks.invoke_form_alter (f, fd, Current)
			if request.is_post_request_method then
				f.process (Current)
				fd := f.last_data
			end
			if a_node.has_id then
				add_to_menu (node_local_link (a_node, translation ("View", Void)), primary_tabs)
				add_to_menu (create {CMS_LOCAL_LINK}.make ("Trash", node_api.node_path (a_node) + "/Trash"), primary_tabs)
			end

			if attached redirection as l_location then
					-- FIXME: Hack for now
				set_title (a_node.title)
				b.append (html_encoded (a_type.title) + " trashed")
			else
				set_title (formatted_string (translation ("Trash $1 #$2", Void), [a_type.title, a_node.id]))
				f.append_to_html (wsf_theme, b)
			end
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
			l_path_alias: detachable READABLE_STRING_8
		do
			fixme ("Refactor code per operacion: Preview, Save")
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
					apply_form_data_to_node (a_type, fd, a_node)

					if l_node.has_id then
						s := "modified"
					else
						s := "created"
					end
				else
					l_node := new_node (a_type, fd, Void)
					s := "created"
				end

				fixme ("for now, publishing is not implemented, so let's assume any node saved is published.") -- FIXME
				l_node.mark_published

				node_api.save_node (l_node)
				if attached user as u then
					api.log ("node",
							"User %"" + user_html_link (u) + "%" " + s + " node " + node_html_link (l_node, a_type.name + " #" + l_node.id.out),
							{CMS_LOG}.level_notice, node_local_link (l_node, Void)
						)
				else
					api.log ("node", "Anonymous " + s + " node " + a_type.name +" #" + l_node.id.out, {CMS_LOG}.level_notice, node_local_link (l_node, Void))
				end
				if node_api.has_error then
					add_error_message ("Node #" + l_node.id.out + " failed to save.")
				else
					add_success_message ("Node #" + l_node.id.out + " saved.")
				end

				if
					attached fd.string_item ("path_alias") as f_path_alias and then
					not f_path_alias.is_empty
				then
					l_path_alias := percent_encoder.partial_encoded_string (f_path_alias, <<'/'>>)
						-- Path alias, are always from the root of the cms.
					api.set_path_alias (node_api.node_path (l_node), l_path_alias, False)
					l_node.set_link (create {CMS_LOCAL_LINK}.make (l_node.title, l_path_alias))
				else
					l_node.set_link (node_api.node_link (l_node))
				end
				if attached l_node.link as lnk then
					set_redirection (lnk.location)
				end
			end
		end

	new_edit_form (a_node: detachable CMS_NODE; a_url: READABLE_STRING_8; a_name: STRING; a_node_type: CMS_NODE_TYPE [CMS_NODE]): CMS_FORM
			-- Create a web form named `a_name' for node `a_node' (if set), using form action url `a_url', and for type of node `a_node_type'.
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

			populate_form (a_node_type, f, a_node)

			f.extend_html_text ("<br/>")
			create ts.make ("op")
			ts.set_default_value ("Save")
			f.extend (ts)

			create ts.make ("op")
			ts.set_default_value ("Preview")
			f.extend (ts)

			Result := f
		end


	new_delete_form (a_node: detachable CMS_NODE; a_url: READABLE_STRING_8; a_name: STRING; a_node_type: CMS_NODE_TYPE [CMS_NODE]): CMS_FORM
			-- Create a web form named `a_name' for node `a_node' (if set), using form action url `a_url', and for type of node `a_node_type'.
		require
				is_trashed: attached a_node as l_node and then a_node.is_trashed
		local
			f: CMS_FORM
			ts: WSF_FORM_SUBMIT_INPUT
		do
			create f.make (a_url, a_name)

			f.extend_html_text ("<br/>")
			f.extend_html_text ("<legend>Are you sure you want to delete?</legend>")

				-- TODO check if we need to check for has_permissions!!
			if
				a_node /= Void and then
				a_node.id > 0
			then
				create ts.make ("op")
				ts.set_default_value ("Delete")
				fixme ("[
					ts.set_default_value (translation ("Delete"))
					]")
				f.extend (ts)
				create ts.make ("op")
				ts.set_default_value ("Cancel")
				ts.set_formaction ("/node/"+a_node.id.out)
				ts.set_formmethod ("GET")
				f.extend (ts)
			end
			f.extend_html_text ("<br/>")
			f.extend_html_text ("<legend>Do you want to restore the current node?</legend>")
			if
				a_node /= Void and then
				a_node.id > 0
			then
				create ts.make ("op")
				ts.set_default_value ("Restore")
				ts.set_formaction ("/node/"+a_node.id.out+"/delete")
				ts.set_formmethod ("POST")
				fixme ("[
					ts.set_default_value (translation ("Restore"))
					]")
				f.extend (ts)
			end
			Result := f
		end


	new_trash_form (a_node: detachable CMS_NODE; a_url: READABLE_STRING_8; a_name: STRING; a_node_type: CMS_NODE_TYPE [CMS_NODE]): CMS_FORM
			-- Create a web form named `a_name' for node `a_node' (if set), using form action url `a_url', and for type of node `a_node_type'.
		local
			f: CMS_FORM
			ts: WSF_FORM_SUBMIT_INPUT
		do
			create f.make (a_url, a_name)

			f.extend_html_text ("<br/>")
			f.extend_html_text ("<legend>Are you sure you want to trash the current node?</legend>")
			if
				a_node /= Void and then
				a_node.id > 0
			then
				create ts.make ("op")
				ts.set_default_value ("Trash")
				fixme ("[
					ts.set_default_value (translation ("Trash"))
					]")
				f.extend (ts)
			end
			Result := f
		end


	populate_form (a_content_type: CMS_NODE_TYPE [CMS_NODE]; a_form: WSF_FORM; a_node: detachable CMS_NODE)
			-- Fill the web form `a_form' with data from `a_node' if set,
			-- and apply this to content type `a_content_type'.
		do
			if attached node_api.node_type_webform_manager (a_content_type) as wf then
				wf.populate_form (Current, a_form, a_node)
			end
		end

	new_node (a_content_type: CMS_NODE_TYPE [CMS_NODE]; a_form_data: WSF_FORM_DATA; a_node: detachable CMS_NODE): CMS_NODE
			-- Node creation with form_data `a_form_data' for the given content type `a_content_type'
			-- using optional `a_node' to get extra node data.
		do
			if attached node_api.node_type_webform_manager (a_content_type) as wf then
				Result := wf.new_node (Current, a_form_data, a_node)
			else
				Result := a_content_type.new_node (a_node)
			end
			Result.set_author (user)
		end

	apply_form_data_to_node (a_content_type: CMS_NODE_TYPE [CMS_NODE]; a_form_data: WSF_FORM_DATA; a_node: CMS_NODE)
			-- Update node `a_node' with form_data `a_form_data' for the given content type `a_content_type'.
		do
			if attached node_api.node_type_webform_manager (a_content_type) as wf then
				wf.update_node (Current, a_form_data, a_node)
			end
		end

end
