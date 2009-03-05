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
			-- Name of the feature that should be called on the controller

feature -- Initialization

	make (a_feature_name: STRING)
			-- `a_feature_name' Name of the feature that should be called on the controller
		require
			feature_name_valid: not a_feature_name.is_empty
		do
			feature_name := a_feature_name
		end

feature -- Processing

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>			
		do
			buf.put_string (response_var + ".put_string (" + controller_var + "." + feature_name + ")")
		end

end
