note
	description: "Summary description for {PLAIN_CODE_ELEMENT}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	PLAIN_CODE_ELEMENT

inherit
	OUTPUT_ELEMENT

create
	make

feature -- Access

		code: STRING
				-- Plain code that is inserted as is

feature -- Initialization

		make (a_code: STRING)
				-- `a_code': The plain code that should be inserted
			do
				code := a_code
			end

feature -- Processing

		serialize (buf: INDENDATION_STREAM)
			-- <Precursor>			
		do
			buf.put_string (code)
		end

end
