indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_SINGLE_CONTENT_ZONE

inherit
	SD_ZONE
		

feature

	content: SD_CONTENT is
			-- The content which current holded.
		do
			Result := internal_content
		end
	
	set_content (a_content: SD_CONTENT) is
		do
			internal_content := a_content
		end

feature {NONE} -- Implementation
	internal_content: SD_CONTENT 
			-- The content which current holded.
end
