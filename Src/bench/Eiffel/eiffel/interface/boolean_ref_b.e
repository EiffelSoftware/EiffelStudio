indexing
	description: "Compiler representation of BOOLEAN_REF class"
	date: "$Date$"
	revision: "$Revision$"

class BOOLEAN_REF_B 

inherit
	CLASS_REF_B

create
	make
	
feature -- Status report

	valid (desc: ATTR_DESC): BOOLEAN is
			-- Valididty test for unique attribute of class
		local
			l_bool_desc: BOOLEAN_DESC
		do
			l_bool_desc ?= desc
			Result := l_bool_desc /= Void
		end

end
