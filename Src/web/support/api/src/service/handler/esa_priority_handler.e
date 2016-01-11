note
	description: "Summary description for {ESA_PRIORITY_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_PRIORITY_HANDLER

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
			if attached current_media_type (req) as l_type then
				log.write_information (generator +".do_get Processing Request")
				l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).priority_page (req, res, api_service.priorities)
			else
				log.write_information (generator +".do_get Processing Request, not acceptable")
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).priority_page (req, res, Void)
			end
		end

end
