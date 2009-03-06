note
	description: "Summary description for {XB_PARSE_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XB_PARSE_HANDLER_TAG_TEST

inherit
	XB_PARSE_HANDLER_TAG

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
			Result := "(!"
		end


	end_tag: STRING
			-- The ending tag
		do
			Result := "!)"
		end

	name: STRING
		do
			Result := "HTML"
		end


feature -- Process

	process_inner (an_inner_string: STRING; output_elements: DS_HASH_TABLE [OUTPUT_ELEMENT, INTEGER];
			a_position: INTEGER )
			-- Knows what to do with the string inside a tag.
		do
			print ("-processing inner string '" + an_inner_string + "' at pos " + a_position.out + "%N")
			output_elements.force (create {PLAIN_XHTML_ELEMENT}.make (an_inner_string), a_position)
		end
end
