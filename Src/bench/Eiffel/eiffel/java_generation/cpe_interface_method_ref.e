indexing
	description: "interface method entry"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CPE_INTERFACE_METHOD_REF

inherit
	CPE_FEATURE_REF
		redefine
			out
		end
			
	create
	make
			
feature {ANY}
	tag_id: INTEGER is 11
	out: STRING is
		do
			Result := "InterfaceMethodRef= " + Precursor;
		end
end



