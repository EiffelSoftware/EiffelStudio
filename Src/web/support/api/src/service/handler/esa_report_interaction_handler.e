note
	description: "Summary description for {REPORT_INTERACTION_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_INTERACTION_HANDLER

inherit

	ESA_ABSTRACT_HANDLER
		rename
			set_esa_config as make
		end

	WSF_FILTER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			execute as uri_template_execute,
			new_mapping as new_uri_template_mapping
		select
			new_uri_template_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
			execute_next (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached current_media_type (req) as l_type then
					-- Logged in users will have access to their reports interactions
					-- and if they have a responsible or admin role they will be able to see
					-- all the interactions/attachments
					-- Anonynomus Users
					-- They only have access to public interactions and attachments.
				process_report_interaction (req, res, l_type,  current_user_name (req))
			end
		end

feature -- Report Interaction

	process_report_interaction (req: WSF_REQUEST; res: WSF_RESPONSE; a_type: READABLE_STRING_8; a_user: detachable READABLE_STRING_32)
			-- Compute the report interaction `comment' or `attachment' if any.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			utf: UTF_CONVERTER
		do
			create l_rhf
			if
				attached req.http_host as l_host and then
				attached req.path_parameter ("id") as l_id and then
				attached {WSF_STRING} req.path_parameter ("name") as l_name
			then
				if api_service.is_attachment_visible (a_user, l_id.as_string.integer_value) then
					debug
						log.write_information (generator+".do_get Processing request download file:" + utf.utf_32_string_to_utf_8_string_8 (l_name.value))
					end
					compute_response_get_file_download (req, res, api_service.attachments_content (l_id.as_string.integer_value), l_name.value)
				else
					-- 401
					l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			elseif
				attached {WSF_STRING} req.path_parameter ("id") as l_id and then
					retrieve_id (l_id) > 0
			then
				if api_service.is_interaction_visible (a_user, retrieve_id (l_id) ) then
					debug
						log.write_information (generator+".do_get Processing request download content for interaction :" + l_id.out)
					end
					compute_response_get_interaction_text (req, res, api_service.interaction_content (retrieve_id (l_id) ))
				else
					-- 401
					l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			end
		end

feature -- Response	

	compute_response_get_file_download (req: WSF_REQUEST; res: WSF_RESPONSE; a_message: READABLE_STRING_8; a_file_name: READABLE_STRING_GENERAL)
			-- Simple response to download content
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type ({HTTP_MIME_TYPES}.application_octet_stream)
			h.put_cache_control ("no-store, no-cache")
			h.put_content_length (a_message.count)
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h)
			res.put_string (a_message)
		end

	compute_response_get_interaction_text (req: WSF_REQUEST; res: WSF_RESPONSE; a_interaction_text: READABLE_STRING_32)
			--Simple response to download interaction text content
		local
			h: HTTP_HEADER
			l_msg: STRING_8
		do
			debug ("refactor_fixme")
				fixme ("Find a better way to handle this!!!")
			end
			create h.make
			create l_msg.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_interaction_text))
			h.put_content_type_utf_8_text_plain
			h.put_cache_control ("no-store, no-cache")
			h.put_content_length (l_msg.count)
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h)
			res.put_string (l_msg)
		end

	  retrieve_id (a_id: READABLE_STRING_32):INTEGER
	  		local
	  			l_result: STRING_32
	  			i: INTEGER
	  		do
	  			from
	  				i := 1
	  				create l_result.make_empty
	  			until
	  				i > a_id.count or a_id.at (i).is_equal ('.')
	  			loop
	  				l_result.append_character (a_id.at (i))
	  				i := i + 1
	  			end
	  			if l_result.is_integer then
	  				Result := l_result.to_integer
	  			end
	  		end
end
