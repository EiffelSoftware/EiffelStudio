note
	description: "[
				Html builder for content type `content_type'.
				This is used to build webform and html output for a specific node, or node content type.
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_CONTENT_TYPE_WEBFORM_MANAGER

inherit
	CMS_API_ACCESS

feature {NONE} -- Initialization

	make (a_type: like content_type)
		do
			content_type := a_type
		end

feature -- Access

	content_type: CMS_CONTENT_TYPE
			-- Associated content type.

	name: READABLE_STRING_8
			-- Associated content type name.
		do
			Result := content_type.name
		end

end
