note
	description: "Summary description for {CMS_BLOCK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_BLOCK

feature -- Access

	name: READABLE_STRING_8
		deferred
		end

	title: detachable READABLE_STRING_32
		deferred
		end

feature -- status report

	is_enabled: BOOLEAN

feature -- Conversion

	to_html (a_theme: CMS_THEME): STRING_8
		deferred
		end

invariant

end
