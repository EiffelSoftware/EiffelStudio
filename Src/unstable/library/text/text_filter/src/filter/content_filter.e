note
	description: "Summary description for {CONTENT_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTENT_FILTER

feature -- Access

	name: READABLE_STRING_8
			-- Identifier of Current filter.
		deferred
		end

	title: READABLE_STRING_8
			-- Human readable title for Current filter.
		deferred
		end

	description: READABLE_STRING_8
			-- Description of Current filter.
		deferred
		end

	help: READABLE_STRING_8
			-- Help text.
		do
			Result := description
		end

	html_help: READABLE_STRING_8
			-- Help in html text.
		local
			s: STRING_8
		do
			create s.make_from_string (help)
			s.prepend ("<pre>")
			s.append ("<pre>")
			Result := s
		end

feature -- Conversion

	filter (s: STRING_GENERAL)
			-- Filter `s' and alter string `s'.
		deferred
		end

end
