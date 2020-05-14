note
	description: "Preview response handling node."
	revision: "$Revision$"

class
	NODE_PREVIEW_RESPONSE

inherit
	CMS_RESPONSE_I
		rename
			make as make_response
		end

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api; a_node_api: like node_api)
		do
			node_api := a_node_api
			make_response (req, res, a_api)
		end

feature -- Access

	node_api: CMS_NODE_API
			-- Associated node API.

feature -- Helpers

	node_id_path_parameter: INTEGER_64
			-- Node id passed as path parameter for request `request'.
		local
			s: READABLE_STRING_GENERAL
		do
			if attached {WSF_STRING} request.path_parameter ("id") as p_nid then
				s := p_nid.value
				if s.is_integer_64 then
					Result := s.to_integer_64
				end
			end
		end

feature -- Execution

	execute
			-- Computed response message.
		local
			html: CMS_HTML_PAGE_RESPONSE
			nid: INTEGER_64
			fd: detachable WSF_FORM_DATA
			l_ct_name: READABLE_STRING_GENERAL
		do
			if
				location.ends_with_general ("/preview")
				or else location.starts_with_general ("node/preview/")
			then
				if attached {WSF_STRING} request.path_parameter ("type") as p_type then
					l_ct_name := p_type.value
				else
					nid := node_id_path_parameter
					if
						nid > 0 and then
						attached node_api.node (nid) as l_node
					then
						l_ct_name := l_node.content_type
					end
				end
				if l_ct_name /= Void and then attached node_api.node_type (l_ct_name) as l_type then
					if
						attached new_edit_form (Void, request.request_uri, "preview_form", l_type) as f
					then
						f.process (Current)
						fd := f.last_data
					end
					if
						fd /= Void and then
						fd.is_valid and then
						attached fd.string_item ("content") as l_content and then
						attached fd.string_item ("format") as l_format and then
						attached previewed_content (l_format, l_content) as l_preview
					then
						create html.make (l_preview)
						response.send (html)
					else
						api.response_api.send_bad_request ("Invalid preview request!", request, response)
					end
				else
					api.response_api.send_bad_request ("Invalid preview request!", request, response)
				end
			else
				api.response_api.send_bad_request ("Invalid preview request!", request, response)
			end
		end

feature {NONE} -- Preview

	previewed_content (a_format: READABLE_STRING_GENERAL; a_content: READABLE_STRING_GENERAL): detachable STRING
		local
			l_format: detachable CONTENT_FORMAT
		do
			if attached api.format (a_format) as f_format then
				l_format := f_format
				if
					l_format /= Void and then
					not api.has_permission_to_use_format (l_format)
				then
					l_format := Void
				end
			end
			if l_format /= Void then
				if a_content.is_valid_as_string_8 then
					Result := l_format.formatted_output (a_content.to_string_8)
				else
					Result := l_format.formatted_output (api.utf_8_encoded (a_content))
				end
			else
				Result := html_encoded (a_content)
			end
		end

	new_edit_form (a_node: detachable CMS_NODE; a_url: READABLE_STRING_8; a_name: STRING; a_node_type: CMS_NODE_TYPE [CMS_NODE]): CMS_FORM
			-- Create a web form named `a_name' for node `a_node' (if set), using form action url `a_url', and for type of node `a_node_type'.
		local
			n: NODE_FORM_RESPONSE
		do
			create n.make (request, response, api, node_api)
			Result := n.new_edit_form (a_node, a_url, a_name, a_node_type)
		end

end
