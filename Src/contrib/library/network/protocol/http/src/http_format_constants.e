note
	description: "Various constants implied in http format."
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_FORMAT_CONSTANTS

feature -- Id

	json: INTEGER = 0x1

	xml: INTEGER = 0x2

	text: INTEGER = 0x4

	html: INTEGER = 0x8

	rss: INTEGER = 0x10

	atom: INTEGER = 0x20

feature -- Name

	json_name: STRING = "json"

	xml_name: STRING = "xml"

	text_name: STRING = "text"

	html_name: STRING = "html"

	rss_name: STRING = "rss"

	atom_name: STRING = "atom"

	empty_name: STRING = ""

feature -- Query

	format_id (a_id: READABLE_STRING_GENERAL): INTEGER
		local
			s: STRING
		do
			s := a_id.as_string_8.as_lower
			if s.same_string (json_name) then
				Result := json
			elseif s.same_string (xml_name) then
				Result := xml
			elseif s.same_string (text_name) then
				Result := text
			elseif s.same_string (html_name) then
				Result := html
			elseif s.same_string (rss_name) then
				Result := rss
			elseif s.same_string (atom_name) then
				Result := atom
			end
		end

	format_name (a_id: INTEGER): READABLE_STRING_8
		do
			inspect a_id
			when json then Result := json_name
			when xml then Result := xml_name
			when text then Result := text_name
			when html then Result := html_name
			when rss then Result := rss_name
			when atom then Result := atom_name
			else Result := empty_name
			end
		ensure
			result_is_lower_case: Result /= Void and then Result.as_lower ~ Result
		end

note
	copyright: "2011-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
