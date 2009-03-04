note
	description: "Summary description for {CALL_ELEMENT}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT_CALL_ELEMENT

inherit
	OUTPUT_ELEMENT

create
	make

feature -- Access

	feature_name: STRING

	make (a_feature_name: STRING)
		do
			feature_name := a_feature_name
		end

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>			
		do
			buf.put_string (buffer_var + ".put_string (" + controller_var + "." + feature_name + ")")
		end

end
