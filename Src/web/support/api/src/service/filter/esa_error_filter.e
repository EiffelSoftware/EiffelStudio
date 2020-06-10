note
	description: "Error filter"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ERROR_FILTER

inherit
	WSF_URI_TEMPLATE_HANDLER

	ESA_ABSTRACT_HANDLER
		rename
			set_esa_config as make
		end
	WSF_FILTER



create
	make

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter

		local
				media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
				l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			if esa_config.is_successful and then esa_config.api_service.successful then
				debug
					log.write_information (generator + ".execute")
				end
				execute_next (req, res)
			else
				log.write_critical (generator + ".execute" + esa_config.api_service.last_error_message.to_string_8 )
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
			end
		end


note
	copyright: "2011-2012, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
