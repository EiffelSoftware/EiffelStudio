note
	description: "Download files from wish items and interactions"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_FILE_DOWNLOAD_HANDER

inherit

	CMS_MOTION_LIST_ABSTRACT_HANDLER

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

feature -- GET

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_found: BOOLEAN
		do
			to_implement ("Download all--depend on a zipper library like 7zip")
			if
				attached {WSF_STRING} req.path_parameter ("wish_id") as l_wid and then
				attached {WSF_STRING} req.path_parameter ("id") as l_id and then
				attached {WSF_STRING} req.path_parameter ("filename") as l_name
			then
				if attached motion_api.motion_interactions_attachments (l_wid.integer_value, l_id.integer_value) as l_attachments then
					across
						l_attachments as c
					until
						l_found
					loop
						if c.item.name.is_case_insensitive_equal (l_name.value) then
							l_found := True
							compute_response_get_download (req, res, c.item.name, c.item.content)
						end
					end
				end
			elseif
				attached {WSF_STRING} req.path_parameter ("wish_id") as l_wid and then
				attached {WSF_STRING} req.path_parameter ("filename") as l_name
			then
				if attached motion_api.motion_attachments (l_wid.integer_value) as l_attachments then
					across
						l_attachments as c
					until
						l_found
					loop
						if c.item.name.is_case_insensitive_equal (l_name.value) then
							l_found := True
							compute_response_get_download (req, res, c.item.name, c.item.content)
						end
					end
				end
			end
		end

feature -- Response

	compute_response_get_download (req: WSF_REQUEST; res: WSF_RESPONSE; a_file_name: READABLE_STRING_GENERAL; a_message: READABLE_STRING_8)
			--Simple response to download content
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type (content_type_from_name (a_file_name))
			h.put_content_length (a_message.count)
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (a_message)
		end
	

	content_type_from_name (a_file_name: READABLE_STRING_GENERAL): READABLE_STRING_8
		local
			m_map: HTTP_FILE_EXTENSION_MIME_MAPPING
			p: PATH
		do
			create p.make_from_string (a_file_name)
			if attached p.extension as ext then
				create m_map.make_default
				Result := m_map.mime_type (ext.as_lower)
			end
			if Result = Void then
				Result := {HTTP_MIME_TYPES}.application_octet_stream
			end
		end

end
