indexing
	description: "Compiler description of REAL_REF class"
	date: "$Date$"
	revision: "$Revision$"

class REAL_REF_B 

inherit
	CLASS_REF_B

create
	make
	
feature -- Status report

	valid (desc: ATTR_DESC): BOOLEAN is
			-- Valididty test for unique attribute of class
		local
			l_real_desc: REAL_DESC
		do
			l_real_desc ?= desc
			Result := l_real_desc /= Void
		end

end
