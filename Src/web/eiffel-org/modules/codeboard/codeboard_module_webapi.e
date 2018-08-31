note
	description: "Summary description for {CODEBOARD_MODULE_WEBAPI}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODEBOARD_MODULE_WEBAPI

inherit
	CMS_MODULE_WEBAPI [CODEBOARD_MODULE]
		redefine
			permissions
		end

create
	make

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force (manage_snippet_permission)
			Result.force (edit_snippet_permission)
		end

	manage_snippet_permission: STRING = "manage codeboard snippet"
	edit_snippet_permission: STRING = "edit codeboard snippet"

feature -- Router/webapi

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached module.codeboard_api as l_codeboard_api then
				a_router.handle ("/" + codeboard_code_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_codeboard_code (l_codeboard_api, ?, ?)), a_router.methods_head_get)
				a_router.handle ("/" + codeboard_code_location, create {WSF_URI_AGENT_HANDLER}.make (agent handle_codeboard_code_update (l_codeboard_api, ?, ?)), a_router.methods_post)
				a_router.handle ("/" + codeboard_code_location + "{code_id}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_codeboard_code (l_codeboard_api, ?, ?)), a_router.methods_head_get)
				a_router.handle ("/" + codeboard_code_location + "{code_id}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_codeboard_code_update (l_codeboard_api, ?, ?)), a_router.methods_put_post + a_router.methods_delete)
			end
		end

	codeboard_code_location: STRING = "codeboard/code/"

feature -- Handlers	

	handle_codeboard_code (a_codeboard_api: CODEBOARD_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: JSON_WEBAPI_RESPONSE
			i, l_code_count, l_code_id: INTEGER_32
		do
			create r.make (req, res, a_codeboard_api.cms_api)
			l_code_count := a_codeboard_api.code_count
			if
				attached {WSF_STRING} req.path_parameter ("code_id") as p_code_id and then
				p_code_id.is_integer
			then
				l_code_id := p_code_id.integer_value
				r.add_integer_64_field ("code_id", l_code_id)
				if attached a_codeboard_api.code (l_code_id) as l_code then
					r.add_self (req.percent_encoded_path_info)
					if attached l_code.lang as l_lang then
						r.add_string_field ("lang", l_lang)
					else
						r.add_string_field ("lang", "eiffel") -- Default
					end

					if l_code.is_locked then
						r.add_boolean_field ("is_locked", True)
					end
					if attached l_code.link as l_link then
						r.add_string_field ("link", l_link)
					end
					if attached l_code.caption as l_caption then
						r.add_string_field ("caption", l_caption)
					end
					r.add_string_field ("code", l_code.text)
					if l_code_id = l_code_count then
						l_code_id := 0
					end
					if l_code_id < l_code_count then
						r.add_link ("next", "code#" + (l_code_id + 1).out, a_codeboard_api.cms_api.webapi_path (codeboard_code_location + (l_code_id + 1).out))
					else
						r.add_link ("next", "code#1", a_codeboard_api.cms_api.webapi_path (codeboard_code_location + "1"))
					end
				else
					r.add_string_field ("code", "Code #" + l_code_id.out + ": not found!")
					r.add_link ("next", "code#" + (l_code_id + 1).out, a_codeboard_api.cms_api.webapi_path (codeboard_code_location + "1"))
				end
			else
				r.add_integer_64_field ("code_count", l_code_count)
				if l_code_count > 0 then
					from
						i := 1
					until
						i > l_code_count
					loop
						if attached a_codeboard_api.code (i) as l_code then
							r.add_link ("code-" + i.out, "view-code-" + i.out, a_codeboard_api.cms_api.webapi_path (codeboard_code_location + i.out))
						end
						i := i + 1
					end
				end

			end
			r.execute
		end

	handle_codeboard_code_update (a_codeboard_api: CODEBOARD_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			resp: JSON_WEBAPI_RESPONSE
			l_code_id: INTEGER
			l_json_text: STRING
			utf: UTF_CONVERTER
			l_change_allowed, l_perm_denied: BOOLEAN
		do
			create resp.make (req, res, a_codeboard_api.cms_api)
			if a_codeboard_api.cms_api.has_permissions (<<manage_snippet_permission, edit_snippet_permission>>) then

				if req.is_put_post_request_method or req.is_delete_request_method then
					if
						attached {WSF_STRING} req.path_parameter ("code_id") as p_codeid and then
						p_codeid.is_integer
					then
						l_code_id := p_codeid.integer_value
					end

					if l_code_id > 0 then
						resp.add_integer_64_field ("code_id", l_code_id)
						if
							False and then -- Comment to be strict!
							req.is_post_request_method
						then
							resp.set_status_code ({HTTP_STATUS_CODE}.method_not_allowed)
							resp.add_string_field ("error", "POST method not allowed!")
						elseif req.is_delete_request_method then
							if a_codeboard_api.is_code_locked (l_code_id) then
								resp.set_status_code ({HTTP_STATUS_CODE}.precondition_failed)
								resp.add_string_field ("error", "Code " + l_code_id.out + " is locked!")
							elseif a_codeboard_api.cms_api.has_permission (manage_snippet_permission) then
								a_codeboard_api.delete_code (l_code_id)
								if a_codeboard_api.has_error then
									resp.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
									resp.add_string_field ("error", "Deletion failed!")
								end
							else
								resp.set_status_code ({HTTP_STATUS_CODE}.user_access_denied)
								resp.add_string_field ("error", "Permission denied!")
							end
						elseif req.is_put_post_request_method then
							if attached req.content_type as ct and then ct.same_string ("application/json") then
								create l_json_text.make (req.content_length_value.to_integer_32)
								req.read_input_data_into (l_json_text)
								if req.has_error then
									resp.set_status_code ({HTTP_STATUS_CODE}.bad_request)
									resp.add_string_field ("error", "Missing data!")
								elseif attached json_to_snippet (utf.utf_8_string_8_to_string_32 (l_json_text)) as l_snippet then
									if a_codeboard_api.is_code_locked (l_code_id) then
											-- Check if this is a request to unlock the code.
										if
											not l_snippet.is_locked and then
											attached a_codeboard_api.code (l_code_id) as l_locked_code
										then
											if a_codeboard_api.cms_api.has_permission (manage_snippet_permission) then
													-- Check if `is_locked` is the only difference!
												l_locked_code.unlock
												l_change_allowed := l_locked_code.same_as (l_snippet)
												l_locked_code.lock -- restore previous state.
											else
												l_change_allowed := False
												l_perm_denied := True
											end
										end
									else
										l_change_allowed := True
									end
									if l_change_allowed then
										l_snippet.set_id (l_code_id)
										a_codeboard_api.update_code (l_snippet)
										if a_codeboard_api.has_error then
											resp.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
											resp.add_string_field ("error", "Update failed!")
										end
									elseif l_perm_denied then
										resp.set_status_code ({HTTP_STATUS_CODE}.user_access_denied)
										resp.add_string_field ("error", "Could not unlock code (permission denied)!")
									else
										resp.set_status_code ({HTTP_STATUS_CODE}.precondition_failed)
										resp.add_string_field ("error", "Code " + l_code_id.out + " is locked!")
									end
								else
									resp.set_status_code ({HTTP_STATUS_CODE}.bad_request)
									resp.add_string_field ("error", "Invalid data!")
								end
							else
								resp.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
								resp.add_string_field ("error", "Unsupported content type!")
							end
						end
						resp.add_self (req.request_uri)
					else -- No codeid
						if req.is_post_request_method then
							if attached req.content_type as ct and then ct.same_string ("application/json") then
								create l_json_text.make (req.content_length_value.to_integer_32)
								req.read_input_data_into (l_json_text)
								if req.has_error then
									resp.set_status_code ({HTTP_STATUS_CODE}.bad_request)
									resp.add_string_field ("error", "Missing data!")
								elseif attached json_to_snippet (utf.utf_8_string_8_to_string_32 (l_json_text)) as l_snippet then
									if l_snippet.has_id then
										a_codeboard_api.insert_code (l_snippet.id, l_snippet)
									else
										a_codeboard_api.create_code (l_snippet)
									end
									if a_codeboard_api.has_error then
										resp.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
										resp.add_string_field ("error", "Creation failed!")
									else
										resp.add_self (req.request_uri + a_codeboard_api.code_count.out)
									end
								else
									resp.set_status_code ({HTTP_STATUS_CODE}.bad_request)
									resp.add_string_field ("error", "Invalid data!")
								end
							else
								resp.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
								resp.add_string_field ("error", "Unsupported content type!")
							end
						else
							-- Missing `codeid` !
							resp.set_status_code ({HTTP_STATUS_CODE}.bad_request)
							resp.add_string_field ("error", "bad request: missing $codeid value!")
						end
					end
				else
					resp.set_status_code ({HTTP_STATUS_CODE}.method_not_allowed)
					resp.add_string_field ("error", "Method not allowed!")
					resp.add_self (req.request_uri)
				end
			else
				resp.set_status_code ({HTTP_STATUS_CODE}.user_access_denied)
				if a_codeboard_api.cms_api.user_is_authenticated then
					resp.add_string_field ("error", "Access denied!")
				else
					resp.add_string_field ("error", "Access denied (no user)!")
				end
				resp.add_self (req.request_uri)
			end

			resp.execute
		end

	json_to_snippet (a_json_text: READABLE_STRING_GENERAL): detachable CODEBOARD_SNIPPET
		local
			jp: JSON_PARSER
		do
			create jp.make_with_string (utf_8_encoded (a_json_text))
			jp.parse_content
			if jp.is_parsed and jp.is_valid and attached jp.parsed_json_object as jo then
				if attached {JSON_STRING} jo.item ("code") as l_code then
					create Result.make (l_code.unescaped_string_32)
					if attached {JSON_NUMBER} jo.item ("code_id") as l_code_id then
						Result.set_id (l_code_id.integer_64_item.to_integer_32)
					elseif attached {JSON_STRING} jo.item ("code_id") as s_code_id then
						Result.set_id (s_code_id.unescaped_string_32.to_integer_32)
					end
					if attached {JSON_STRING} jo.item ("caption") as l_caption then
						Result.set_caption (l_caption.unescaped_string_32)
					end
					if attached {JSON_STRING} jo.item ("lang") as l_lang then
						Result.set_lang (l_lang.unescaped_string_8)
					end
					if attached {JSON_BOOLEAN} jo.item ("is_locked") as l_is_locked then
						Result.set_is_locked (l_is_locked.item)
					end
					if attached {JSON_STRING} jo.item ("link") as js_link then
						Result.set_link (js_link.unescaped_string_8)
					elseif
						attached {JSON_OBJECT} jo.item ("link") as j_link and then
						attached {JSON_STRING} j_link.item ("href") as j_link_href
					then
						Result.set_link (j_link_href.unescaped_string_8)
					end
				end
			end
		end

end
