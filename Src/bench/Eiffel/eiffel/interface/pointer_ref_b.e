indexing
	description: "Compriler representation of POINTER_REF class"
	date: "$Date$"
	revision: "$Revision$"

class POINTER_REF_B 

inherit
	CLASS_REF_B

create
	make
	
feature -- Status report

	valid (desc: ATTR_DESC): BOOLEAN is
			-- Valididty test for unique attribute of class
		local
			l_pointer_desc: POINTER_DESC
		do
			l_pointer_desc ?= desc
			Result := l_pointer_desc /= Void
		end

end
