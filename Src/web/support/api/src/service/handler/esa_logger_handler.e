note
	description: "Summary description for {ESA_LOGGER_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_LOGGER_HANDLER

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
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			if
				attached {STRING_32} current_user_name (req) as l_user and then
		  	    api_service.role (l_user).is_administrator
			then
				compute_response_get_txt (req, res, read_log_file)
			else -- Not an admin user
				create l_rhf
				l_rhf.new_representation_handler (esa_config, "text/html", media_type_variants (req)).new_response_unauthorized (req, res)
			end
		end

feature -- Response	

	compute_response_get_txt (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
			--Simple response to download content.
		local
			h: HTTP_HEADER
			l_msg: STRING
		do
			fixme ("Find a better way to handle this!!!")
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_plain
			h.put_content_length (l_msg.count)
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end

	read_log_file: STRING
			-- Read the log file.
		local
			f: RAW_FILE
			l_path : PATH
		do
			create Result.make_empty
			l_path := esa_config.layout.path.extended ("..").appended ("\esa_api.log")
			create f.make_with_path (l_path)
			f.open_read
			if f.exists and then f.is_readable then
				f.read_stream (f.count)
				f.close
				Result := f.last_string
			end
		end
end
