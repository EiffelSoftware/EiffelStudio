note
	description: "SD_ZONE that contains only one SD_CONTENT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_SINGLE_CONTENT_ZONE

inherit
	SD_ZONE


feature -- Content issues.

	content: SD_CONTENT
			-- <Precursor>
		do
			Result := internal_content
		end

	extend (a_content: SD_CONTENT)
			-- <Precursor>
		do
			internal_content := a_content
		end

	has (a_content: SD_CONTENT): BOOLEAN
			-- <Precursor>
		do
			Result := internal_content = a_content
		end

feature {SD_OPEN_CONFIG_MEDIATOR} -- Save config

	save_content_title (a_config_data: SD_INNER_CONTAINER_DATA)
			-- <Precursor>
		do
			a_config_data.add_title (internal_content.unique_title)
		end

feature {NONE} -- Implementation

	internal_content: SD_CONTENT;
			-- Content which current held
note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
