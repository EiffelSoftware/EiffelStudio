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
			-- Execute request handler
		do
			execute_methods (req, res)
			execute_next (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if
				attached req.http_host as l_host and then
				attached req.path_parameter ("id") as l_id and then
				attached req.path_parameter ("name") as l_name
			then
				log.write_information (generator+".do_get Processing request download file:" + l_name.as_string.value )
				compute_response_get_txt (req, res, api_service.attachments_content (l_id.as_string.integer_value))
			elseif
				attached {WSF_STRING} req.path_parameter ("id") as l_id and then
				retrieve_id (l_id) > 0
			then
				log.write_information (generator+".do_get Processing request download content for interaction :" + l_id.out)
				compute_response_get_txt (req, res, api_service.interaction_content (retrieve_id (l_id) ))
			end
		end

feature -- Response	

	compute_response_get_txt (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
			--Simple response to download content
		local
			h: HTTP_HEADER
			l_msg: STRING
		do
			fixme ("Find a better way to handle this!!!")
			create h.make
			create l_msg.make_from_string (output)
			h.put_header_key_value ("Content-type", "application/octet-stream")
			h.put_cache_control ("no-store, no-cache")
			h.put_content_length (l_msg.count)
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
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
