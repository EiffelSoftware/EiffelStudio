note
	description: "Factory class to create a concreate REPRESENTATION_HANDLER, {HTML,CJ,NULL}"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPRESENTATION_HANDLER_FACTORY

feature -- Factory

	new_representation_handler (a_esa_config: ESA_CONFIG; a_media_type: READABLE_STRING_GENERAL; a_media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS): ESA_REPRESENTATION_HANDLER
			-- New representation handler based on `a_media_type'
		do
			if a_media_type.same_string({HTTP_MIME_TYPES}.text_html) then
				create {ESA_HTML_REPRESENTATION_HANDLER} Result.make (a_esa_config,a_media_variants)
			elseif a_media_type.same_string("application/vnd.collection+json") then
				create {ESA_CJ_REPRESENTATION_HANDLER} Result.make (a_esa_config,a_media_variants)
			else
				create {ESA_NULL_REPRESENTATION_HANDLER} Result.make (a_esa_config,a_media_variants)
			end
		end

end
