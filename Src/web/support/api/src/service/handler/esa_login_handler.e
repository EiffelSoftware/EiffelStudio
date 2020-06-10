note
	description: "Handle Login using Basic Authentication"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_LOGIN_HANDLER

inherit
	ESA_ABSTRACT_HANDLER
		rename
			set_esa_config as make
		end

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_FILTER


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
			if attached current_media_type (req) as l_type then
				if attached {READABLE_STRING_32} current_user_name (req) as l_user and then api_service.is_active (l_user) then
					debug
						log.write_information (generator + ".do_get Processing Login request using media_type: "+ l_type +" User: " + l_user.to_string_8)
					end
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).login_page (req, res)
				else
					log.write_alert (generator + ".do_get Processing Login request using media_type: "+ l_type + " Could not login, the user does not exist or is not active!")
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_authenticate (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).login_page (req, res)
			end
		end

end
