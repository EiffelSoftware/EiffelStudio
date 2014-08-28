note
	description: "Summary description for {CMS_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_FILTER

feature -- Access

	name: READABLE_STRING_8
		deferred
		end

	title: READABLE_STRING_8
		deferred
		end

	description: READABLE_STRING_8
		deferred
		end

	help: READABLE_STRING_8
		do
			Result := description
		end

feature -- Conversion

	filter (s: STRING_8)
		deferred
		end

end
