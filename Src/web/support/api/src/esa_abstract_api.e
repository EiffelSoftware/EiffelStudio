note
	description: "Abstract API service"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_ABSTRACT_API

inherit
	WSF_ROUTED_SKELETON_EXECUTION
		rename
			make as make_execution
		undefine
			requires_proxy
		redefine
			execute_default
		end

	WSF_NO_PROXY_POLICY

	WSF_URI_HELPER_FOR_ROUTED_EXECUTION

	WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_EXECUTION

	SHARED_CONNEG_HELPER

	SHARED_LOGGER

feature {NONE} -- Initialization

	make (a_esa_config: ESA_CONFIG; a_server: ESA_SERVICE_EXECUTION)
		do
			esa_config := a_esa_config
			server := a_server
			make_from_execution  (a_server)
		end

feature -- ESA

	esa_config: ESA_CONFIG
		-- Configuration

	server: ESA_SERVICE_EXECUTION
		-- Server

feature -- Router setup

	setup_router
			-- Setup `router'
		deferred
		end

	layout: APPLICATION_LAYOUT
		do
			Result := esa_config.layout
		end

feature -- Access

	handle_debug (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			s: STRING_8
			h: HTTP_HEADER
		do
			if req.is_get_request_method then
				s := "debug"
				create h.make_with_count (1)
				h.put_content_type_text_html
				h.put_content_length (s.count)
				res.put_header_lines (h)
				res.put_string (s)
			else
				create s.make (30_000)
				across
					req.form_parameters as c
				loop
					s.append (c.item.url_encoded_name)
					s.append ("=")
					s.append (c.item.string_representation.to_string_8)
					s.append ("<br/>")
				end
				if s.is_empty then
					req.read_input_data_into (s)
				end
				create h.make_with_count (1)
				h.put_content_type_text_html
				h.put_content_length (s.count)
				res.put_header_lines (h)
				res.put_string (s)
			end
		end

feature -- Handler

	not_yet_implemented_uri_template_handler (msg: READABLE_STRING_8): WSF_URI_TEMPLATE_HANDLER
		do
			create {WSF_URI_TEMPLATE_AGENT_HANDLER} Result.make (agent not_yet_implemented(?, ?, msg))
		end

	not_yet_implemented (req: WSF_REQUEST; res: WSF_RESPONSE; msg: detachable READABLE_STRING_8)
		local
			m: WSF_NOT_IMPLEMENTED_RESPONSE
		do
			create m.make (req)
			if msg /= Void then
				m.set_body (msg)
			end
			res.send (m)
		end


feature -- Default Execution

	execute_default (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Dispatch requests without a matching handler.
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			if not esa_config.api_service.successful then
				log.write_critical (generator.to_string_8 + ".execute_default " + esa_config.api_service.last_error_message.to_string_8)
				create l_rhf
				media_variants := media_type_variants (req)
				if media_variants.is_acceptable then
					if attached media_variants.media_type as l_type then
						l_rhf.new_representation_handler (esa_config, l_type, media_variants).internal_server_error (req, res)
					else
						l_rhf.new_representation_handler (esa_config, "", media_variants).internal_server_error (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, "", media_variants).internal_server_error (req, res)
				end
			else
				media_variants := media_type_variants (req)
				if media_variants.is_acceptable then
					if attached media_variants.media_type as l_type then
						create l_rhf
						l_rhf.new_representation_handler (esa_config,l_type, media_variants).not_found_page (req, res)
					end
				else
					create l_rhf
					l_rhf.new_representation_handler (esa_config,"", media_variants).not_found_page (req, res)
				end
			end
		end

end
