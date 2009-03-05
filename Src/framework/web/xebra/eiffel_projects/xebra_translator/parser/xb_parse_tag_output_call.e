note
	description: "Summary description for {XB_PARSE_TAG_OUTPUT_CALL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XB_PARSE_TAG_OUTPUT_CALL

inherit
	XB_PARSE_TAG

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Access

	start_tag: STRING
			-- The starting tag
		do
			Result := "<%%="
		end


	end_tag: STRING
			-- The ending tag
		do
			Result := "%%>"
		end

feature -- Process

	process_inner (an_inner_string: STRING; a_root: ROOT_SERVLET_ELEMENT)
			--knows what to do with the string inside a tag.
		do
			a_root.put_xhtml_elements (create {OUTPUT_CALL_ELEMENT}.make (an_inner_string))
		end


end
