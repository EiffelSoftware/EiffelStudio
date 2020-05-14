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
						if
							attached {WSF_STRING} request.query_parameter ("revision") as p_rev and then
							p_rev.value.is_integer_64 and then
							attached node_api.revision_node (l_node.id, p_rev.value.to_integer_64) as l_rev_node
						then
							edit_node (l_rev_node, l_type, l_rev_node.revision < l_node.revision, b)
						else
							edit_node (l_node, l_type, False, b)
						end
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
						b.append (html_translation ("Access denied", Void))
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
					b.append (html_translation ("Access denied", Void))
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
							b.append ("<div class=%"description%">" + html_encoded (d) + "</div>")
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
				f := new_edit_form (l_node, request_url (Void), "edit-" + a_type.name, a_type)
				api.hooks.invoke_form_alter (f, fd, Current)
				if request.is_post_request_method then
					f.validation_actions.extend (agent edit_form_validate (?, b))
					f.submit_actions.put_front (agent edit_form_submit (?, l_node, a_type, b))
					f.process (Current)
					fd := f.last_data
				end

				if l_node.has_id then
					set_title ("Edit " + html_encoded (a_type.title) + " item #" + l_node.id.out)
					add_to_menu (node_local_link (l_node, translation ("View", Void)), primary_tabs)
					add_to_menu (create {CMS_LOCAL_LINK}.make (translation ("Edit", Void), node_api.node_path (l_node) + "/edit"), primary_tabs)
				else
					set_title ("Create a new " + html_encoded (a_type.title) + " item")
				end
				if attached a_type.description as desc then
					f.prepend (create {WSF_WIDGET_TEXT}.make_with_text ("<span class=%"description%">" + api.html_encoded (desc) + "</span>"))
				end

				f.append_to_html (wsf_theme, b)
			else
				b.append ("<h1>")
				b.append (html_translation ("Server error", Void))
				b.append ("</h1>")
			end
		end


	edit_node (a_node: CMS_NODE; a_type: CMS_NODE_TYPE [CMS_NODE]; is_old_revision: BOOLEAN; b: STRING_8)
		local
			f: like new_edit_form
			fd: detachable WSF_FORM_DATA
		do
			f := new_edit_form (a_node, request_url (Void), "edit-" + a_type.name, a_type)
			if is_old_revision then
				add_warning_message ("You are editing old revision #" + a_node.revision.out + " !")
			end
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
				add_to_menu (create {CMS_LOCAL_LINK}.make ("Revisions", node_api.node_path (a_node) + "/revision"), primary_tabs)
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
				f := new_delete_form (a_node, request_url (Void), "delete-" + a_type.name, a_type)
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
				b.append ("ERROR: node is not in the trash!")
			end
		end


	trash_node (a_node: CMS_NODE; a_type: CMS_NODE_TYPE [CMS_NODE]; b: STRING_8)
		local
			f: like new_edit_form
			fd: detachable WSF_FORM_DATA
		do
			f := new_trash_form (a_node, request_url (Void), "trash-" + a_type.name, a_type)
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
				b.append ("<div class=%"preview-container%"><strong>Preview</strong><div class=%"preview%">")
				if attached fd.string_item ("format") as s_format and then attached api.format (s_format) as f_format then
					l_format := f_format
					if
						l_format /= Void and then
						not api.has_permission_to_use_format (l_format)
					then
						fd.report_invalid_field ("format", "You are not allowed to use format [" + l_format.title + "]")
					end
				end
				if attached fd.string_item ("title") as l_title then
					b.append ("<strong>Title:</strong><div class=%"title%">" + html_encoded (l_title) + "</div>")
				end
				if attached fd.string_item ("content") as l_content then
					b.append ("<strong>Content:</strong><div class=%"content%">")
					if l_format /= Void then
						if l_content.is_valid_as_string_8 then
							b.append (l_format.formatted_output (l_content.to_string_8))
						else
							b.append (l_format.formatted_output (api.utf_8_encoded (l_content)))
						end
					else
						b.append (html_encoded (l_content))
					end
					b.append ("</div>")
				end
				b.append ("</div>")
				b.append ("</div>")
			end
		end

	edit_form_submit (fd: WSF_FORM_DATA; a_node: detachable CMS_NODE; a_type: CMS_NODE_TYPE [CMS_NODE]; b: STRING)
		local
			l_preview, l_op_save, l_op_publish, l_op_unpublish: BOOLEAN
			l_node: detachable CMS_NODE
			s: STRING
			l_node_path: READABLE_STRING_8
			l_path_alias, l_existing_path_alias, l_auto_path_alias: detachable READABLE_STRING_8
		do
			-- Potential operations : Preview, Save/Publish/UnPublish")
			l_preview := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string (preview_submit_label)
			if not l_preview then
				l_op_save := True
				if attached {WSF_STRING} fd.item ("op") as l_op then
					if l_op.same_string (publish_submit_label) then
						l_op_publish := True
					elseif l_op.same_string (unpublish_submit_label) then
						l_op_unpublish := True
					else
						check l_op.same_string (save_submit_label) end
					end
				end
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
				if l_op_publish then
					l_node.mark_published
				elseif l_op_unpublish then
					l_node.mark_not_published
				else
						-- Default status
				end
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

					-- Path aliase
				l_node_path := node_api.node_path (l_node)
				l_existing_path_alias := api.location_alias (l_node_path)
				l_auto_path_alias := node_api.path_alias_uri_suggestion (l_node, a_type)
				if attached fd.string_item ("path_alias") as f_path_alias then
					l_path_alias := percent_encoder.partial_encoded_string (f_path_alias, <<'/'>>)
					if
						l_existing_path_alias /= Void and then
						l_path_alias.same_string (l_existing_path_alias)
					then
							-- Same path alias
						l_node.set_link (create {CMS_LOCAL_LINK}.make (l_node.title, l_path_alias))
					elseif l_existing_path_alias /= Void and then l_path_alias.is_whitespace then
							-- Reset to builtin alias.
						if api.has_permission ("edit path_alias") then
							api.set_path_alias (l_node_path, l_auto_path_alias, True)
						elseif l_existing_path_alias.same_string (l_node_path) then
								-- not aliased! Use default.
							if a_type.is_path_alias_required then
								api.set_path_alias (l_node_path, l_auto_path_alias, True)
							end
						else
							add_error_message ("Permission denied to reset path alias on node #" + l_node.id.out + "!")
						end
						l_node.set_link (node_api.node_link (l_node))
					else
						if api.has_permission ("edit path_alias") then
								-- Path alias, are always from the root of the cms.
							api.set_path_alias (l_node_path, l_path_alias, True)
							l_node.set_link (create {CMS_LOCAL_LINK}.make (l_node.title, l_path_alias))
						else
							add_error_message ("Permission denied to set path alias on node #" + l_node.id.out + "!")
							l_node.set_link (node_api.node_link (l_node))
						end
					end
				elseif l_existing_path_alias /= Void and then not l_existing_path_alias.same_string (l_node_path) then
					l_node.set_link (create {CMS_LOCAL_LINK}.make (l_node.title, l_existing_path_alias))
				elseif a_type.is_path_alias_required and l_auto_path_alias /= Void then
						-- Use auto path alias
					api.set_path_alias (l_node_path, l_auto_path_alias, True)
					l_node.set_link (create {CMS_LOCAL_LINK}.make (l_node.title, l_auto_path_alias))
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
			div: WSF_WIDGET_DIV
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

			create div.make
			div.add_css_class ("css-editing-buttons")
			f.extend (div)

			create ts.make ("op")
			ts.set_default_value (preview_submit_label)
			ts.set_description ("Preview without saving.")
			div.extend (ts)

			if a_node = Void then
				create ts.make ("op")
				ts.set_default_value (save_submit_label)
				div.extend (ts)

				create ts.make ("op")
				ts.set_default_value (publish_submit_label)
				ts.set_description ("Save and mark published.")
				div.extend (ts)
			else
				if a_node.is_published then
					create ts.make ("op")
					ts.set_default_value (save_submit_label)
					ts.set_description ("Save and keep published.")
					div.extend (ts)

					create ts.make ("op")
					ts.set_default_value (unpublish_submit_label)
					ts.set_description ("Save and mark unpublished.")
					div.extend (ts)
				else
					create ts.make ("op")
					ts.set_default_value (save_submit_label)
					div.extend (ts)

					create ts.make ("op")
					ts.set_default_value (publish_submit_label)
					ts.set_description ("Save and mark published.")
					div.extend (ts)
				end
			end
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
			f.extend_html_text ("<legend>Are you sure you want to delete? (impossible to undo)</legend>")

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
			Result := f
		end

	new_trash_form (a_node: CMS_NODE; a_url: READABLE_STRING_8; a_name: STRING; a_node_type: CMS_NODE_TYPE [CMS_NODE]): CMS_FORM
			-- Create a web form named `a_name' for node `a_node', using form action url `a_url', and for type of node `a_node_type'.
		local
			f: CMS_FORM
			ts: WSF_FORM_SUBMIT_INPUT
		do
			create f.make (a_url, a_name)
			f.set_method_post

			f.extend_html_text ("<br/>")
			if a_node.is_trashed then
				f.extend_html_text ("<legend>Are you sure you want to restore the current node?</legend>")
				create ts.make ("op")
				ts.set_default_value ("Restore")
				ts.set_formaction ("/node/" + a_node.id.out + "/trash")
				ts.set_formmethod ("POST")
				fixme ("[
					ts.set_default_value (translation ("Trash"))
					]")
			else
				f.extend_html_text ("<legend>Are you sure you want to trash the current node?</legend>")
				create ts.make ("op")
				ts.set_default_value ("Trash")
				ts.set_formaction ("/node/" + a_node.id.out + "/trash")
				ts.set_formmethod ("POST")

				fixme ("[
					ts.set_default_value (translation ("Trash"))
					]")

			end

			f.extend (ts)
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
			Result.set_editor (user)
		end

	apply_form_data_to_node (a_content_type: CMS_NODE_TYPE [CMS_NODE]; a_form_data: WSF_FORM_DATA; a_node: CMS_NODE)
			-- Update node `a_node' with form_data `a_form_data' for the given content type `a_content_type'.
		do
			if attached node_api.node_type_webform_manager (a_content_type) as wf then
				wf.update_node (Current, a_form_data, a_node)
			end
		end

feature -- Labels

	save_submit_label: STRING = "Save"
	publish_submit_label: STRING = "Publish"
	unpublish_submit_label: STRING = "Unpublish"
	preview_submit_label: STRING = "Preview"

end
