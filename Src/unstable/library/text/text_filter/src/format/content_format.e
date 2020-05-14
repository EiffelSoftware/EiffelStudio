note
	description: "Summary description for {CONTENT_FORMAT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTENT_FORMAT

feature -- Access

	name: READABLE_STRING_8
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

	append_formatted_to (a_text: READABLE_STRING_GENERAL; a_output: STRING_GENERAL)
			-- Append formatted representation of `a_text' to `a_output'.
			-- Note: adapt encoding according to type of `a_output' using UTF-8
			-- 		 when conversion from STRING_32 to STRING_8 is needed.
		local
			s: STRING_GENERAL
			utf: UTF_CONVERTER
		do
			if attached {READABLE_STRING_8} a_text as s8 then
				create {STRING_8} s.make_from_string (s8)
			else
				create {STRING_32} s.make_from_string_general (a_text)
			end
			across
				filters as c
			loop
				c.item.filter (s)
			end
			if attached {STRING_8} a_output as l_output_s8 then
				a_output.append (utf.utf_32_string_to_utf_8_string_8 (s))
			else
				a_output.append (s)
			end
		end

	formatted_output (a_text: READABLE_STRING_8): STRING_8
			-- ASCII formatted output from text `a_text'.
		do
			create Result.make_from_string (a_text)
			across
				filters as c
			loop
				c.item.filter (Result)
			end
		end

end
