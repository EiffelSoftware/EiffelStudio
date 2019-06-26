note
	description: "Summary description for {ESA_RESPONSIBLE_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_RESPONSIBLE_HANDLER

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

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if
				attached current_user_name (req) as l_user and then
			  	attached  api_service.role (l_user) as l_role and then
				(l_role.is_administrator or else l_role.is_responsible)
			then
					-- Logged in user
				if attached current_media_type (req) as l_type then
					debug
						log.write_information (generator+".do_get Processing request media_type:" + l_type)
					end
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).responsible_page (req, res, api_service.responsibles)
				else
					log.write_information (generator+".do_get Processing request not acceptable" )
					l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).responsible_page (req, res, Void)
				end
			else
					-- Guest user
				log.write_information (generator+".do_get Processing request unauthorized" )
				l_rhf.new_representation_handler (esa_config, {HTTP_MIME_TYPES}.text_html, media_type_variants (req)).new_response_unauthorized (req, res)
			end
		end

end


