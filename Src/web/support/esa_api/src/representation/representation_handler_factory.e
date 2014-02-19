note
	description: "Factory class to create a concreate REPRESENTATION_HANDLER, {HTML,CJ}"
	date: "$Date$"
	revision: "$Revision$"

class
	REPRESENTATION_HANDLER_FACTORY

feature -- Factory

	new_representation_handler (a_media_type: STRING): REPRESENTATION_HANDLER
			-- New representation hanlder based on `a_media_type'
		do
			if a_media_type.same_string("text/html") then
				check
						html: a_media_type.same_string("text/html")
				end
				create {HTML_REPRESENTATION_HANDLER} Result
			else
				check
					collection_json: a_media_type.same_string("application/vnd.collection+json")
				end
				create {CJ_REPRESENTATION_HANDLER} Result
			end
		end

end
