note
	description: "Object that handle report details resources, for guest and registered users."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_DETAIL_HANDLER

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
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				if attached media_variants.media_type as l_type then
					create l_rhf
					l_rhf.new_representation_handler (esa_config,l_type,media_variants).problem_report (req, res)
				end
			else
				create l_rhf
				l_rhf.new_representation_handler (esa_config,"",media_variants).problem_report (req, res)
			end
		end


end
