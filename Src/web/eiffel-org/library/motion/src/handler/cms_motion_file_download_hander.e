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
							compute_response_get_txt (req, res, c.item.content)
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
							compute_response_get_txt (req, res, c.item.content)
						end
					end
				end
			end
		end

feature -- Response

	compute_response_get_txt (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
			--Simple response to download content
		local
			h: HTTP_HEADER
			l_msg: STRING
		do
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_plain
			h.put_content_length (l_msg.count)
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end

end
