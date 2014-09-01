note
	description: "Summary description for {CMS_URL_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_URL_FILTER

inherit
	CMS_FILTER
		redefine
			help
		end

feature -- Access

	name: STRING_8 = "url"

	title: STRING_8 = "URL filter"

	description: STRING_8 = "Turns web and e-mail addresses into clickable links."

	help: STRING = "Web page addresses and e-mail addresses turn into links automatically."

feature -- Conversion

	filter (a_text: STRING_8)
		do
			--| FIXME jfiat [2012/09/12] : todo
		end

end
