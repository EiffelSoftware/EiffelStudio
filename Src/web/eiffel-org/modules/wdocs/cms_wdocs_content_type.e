note
	description: "[
			Interface defining a CMS wdoc type.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_WDOCS_CONTENT_TYPE

inherit
	CMS_CONTENT_TYPE

feature -- Access

	name: STRING_8 = "wdoc"

	title: STRING_32 = "Wiki Doc"

	description: detachable READABLE_STRING_32
		do
		end

feature -- Access

	available_formats: LIST [CONTENT_FORMAT]
			-- Available formats for Current type.
		do
			create {ARRAYED_LIST [CONTENT_FORMAT]} Result.make (0)
		end

end
