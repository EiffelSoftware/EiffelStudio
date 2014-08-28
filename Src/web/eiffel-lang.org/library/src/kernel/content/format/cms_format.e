note
	description: "Summary description for {WSF_CMS_FORMAT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_FORMAT

feature -- Access

	name: STRING
		deferred
		end

	title: READABLE_STRING_8
		deferred
		end

	help: STRING
		do
			create Result.make (0)
			across
				filters as c
			loop
				if attached c.item.help as h and then not h.is_empty then
					Result.append ("<li>" + h + "</li>")
				end
			end
		end

	filters: LIST [CMS_FILTER]
		deferred
		end

	to_html (a_text: READABLE_STRING_8): STRING_8
		do
			create Result.make_from_string (a_text)
			across
				filters as c
			loop
				c.item.filter (Result)
			end
		end

end
