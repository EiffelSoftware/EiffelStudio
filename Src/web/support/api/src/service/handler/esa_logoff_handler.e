note
	description: "Handle Logoff for Basic Authentication"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_LOGOFF_HANDLER

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
				log.write_information(generator + ".do_get Processing logoff")
				l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).logout_page (req, res)
			else
				log.write_alert (generator +".do_get Processing not acceptable")
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).logout_page (req, res)
			end
		end

end
