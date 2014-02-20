note
	description: "Factory class to create a concreate REPRESENTATION_HANDLER, {HTML,CJ,NULL}"
	date: "$Date$"
	revision: "$Revision$"

class
	REPRESENTATION_HANDLER_FACTORY

feature -- Factory

	new_representation_handler (a_media_type: STRING; a_media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS): REPRESENTATION_HANDLER
			-- New representation hanlder based on `a_media_type'
		do
			if a_media_type.same_string({HTTP_MIME_TYPES}.text_html) then
				create {HTML_REPRESENTATION_HANDLER} Result.make (a_media_variants)
			elseif a_media_type.same_string("application/vnd.collection+json") then

				create {CJ_REPRESENTATION_HANDLER} Result.make (a_media_variants)
			else
				create {NULL_REPRESENTATION_HANDLER} Result.make (a_media_variants)
			end
		end

end
