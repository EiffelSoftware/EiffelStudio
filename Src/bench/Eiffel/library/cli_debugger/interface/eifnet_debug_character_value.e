indexing
	description: "Dotnet debug value associated with Character type"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_CHARACTER_VALUE

inherit
	CHARACTER_VALUE
		rename
			make as dv_make
		end
	
	EIFNET_DEBUG_BASIC_VALUE [CHARACTER]
		undefine
			append_type_and_value, append_value, type_and_value, dump_value
		end
	
create {DEBUG_VALUE_EXPORTER}
	make --, make_attribute
	
end
