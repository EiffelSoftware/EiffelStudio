indexing
		description: "field entry"
		author: ""
		date: "$Date$"
		revision: "$Revision$"

class
		CPE_FIELD_REF

inherit
		CPE_FEATURE_REF
				redefine
				out
				end
			
create
		make
			
feature {ANY}
		tag_id: INTEGER is 9
			
		out: STRING is
				do
				Result := "FieldRef= " + Precursor;
				end
end


