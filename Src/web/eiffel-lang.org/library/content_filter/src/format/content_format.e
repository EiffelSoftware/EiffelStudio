note
	description: "Summary description for {CONTENT_FORMAT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTENT_FORMAT

feature -- Access

	name: STRING
		deferred
		end

	title: READABLE_STRING_8
		deferred
		end

	html_help: STRING
		do
			create Result.make (0)
			across
				filters as c
			loop
				if attached c.item.html_help as h and then not h.is_empty then
						-- FIXME: maybe use plain text ...
					Result.append ("<li>" + h + "</li>")
				end
			end
		end

	help: STRING
		do
			create Result.make (0)
			across
				filters as c
			loop
				if attached c.item.help as h and then not h.is_empty then
					Result.append (h + "%N")
				end
			end
		end

	filters: LIST [CONTENT_FILTER]
		deferred
		end

feature -- Convertion

	formatted_output (a_text: READABLE_STRING_8): STRING_8
		do
			create Result.make_from_string (a_text)
			across
				filters as c
			loop
				c.item.filter (Result)
			end
		end

end
