indexing
	description: "method entry for constant pool"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CPE_METHOD_REF

inherit
	
	CPE_FEATURE_REF
		redefine
			out
		end
			
create
	make
			
feature {ANY}
	
	tag_id: INTEGER is 10
	
	out: STRING is
		do
			Result := "MethodRef= " + Precursor;
		end
end


