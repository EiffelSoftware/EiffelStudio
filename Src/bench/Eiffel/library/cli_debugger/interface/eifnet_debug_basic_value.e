indexing
	description: "Dotnet debug value associated with Basic type"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_BASIC_VALUE [G]

inherit
	DEBUG_VALUE [G]
	
create {DEBUG_VALUE_EXPORTER}
	make, make_attribute
	
end -- class EIFNET_DEBUG_VALUE
