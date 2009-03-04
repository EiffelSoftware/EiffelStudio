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

		make (a_code: STRING)
			do
				code := a_code
			end

		serialize (buf: INDENDATION_STREAM)
			-- <Precursor>			
		do
			buf.put_string (code)
		end

end
