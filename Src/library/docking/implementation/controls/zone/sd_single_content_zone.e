indexing
	description: "SD_ZONE that contains only one SD_CONTENT."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_SINGLE_CONTENT_ZONE

inherit
	SD_ZONE


feature -- Content issues.

	content: SD_CONTENT is
			-- Redefine.
		do
			Result := internal_content
		end

	extend (a_content: SD_CONTENT) is
			-- Redefine.
		do
			internal_content := a_content
		end

	has (a_content: SD_CONTENT): BOOLEAN is
			-- Redefine.
		do
			Result := internal_content = a_content
		end

feature {SD_CONFIG_MEDIATOR} -- Save config.

	save_content_title (a_config_data: SD_INNER_CONTAINER_DATA) is
			-- Redefine.
		do
			a_config_data.add_title (internal_content.title)
		end

feature {NONE} -- Implementation

	internal_content: SD_CONTENT
			-- Content which current holded.
end
