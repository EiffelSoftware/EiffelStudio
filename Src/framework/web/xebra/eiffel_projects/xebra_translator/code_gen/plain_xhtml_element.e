note
	description: "Summary description for {PLAIN_XHTML_ELEMENT}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	PLAIN_XHTML_ELEMENT

inherit
	OUTPUT_ELEMENT

create
	make

feature -- Access

		html_text: STRING

		make (a_html_text: STRING)
			do
				html_text := a_html_text
			end

		serialize (buf: INDENDATION_STREAM)
			-- <Precursor>			
		do
			buf.put_string ("buffer.append (")
			buf.put_new_line
			buf.put_string ("%"[")
			buf.put_new_line
			buf.put_string (html_text)
			buf.put_new_line
			buf.put_string ("]%"")
			buf.put_new_line
			buf.put_string (")")
		end

end
