indexing
	description: "Compiler representation of DOUBLE_REF class"
	date: "$Date$"
	revision: "$Revision$"
	
class DOUBLE_REF_B 

inherit
	CLASS_REF_B

create
	make
	
feature -- Status report

	valid (desc: ATTR_DESC): BOOLEAN is
			-- Valididty test for unique attribute of class
		local
			l_double_desc: DOUBLE_DESC
		do
			l_double_desc ?= desc
			Result := l_double_desc /= Void
		end

end
