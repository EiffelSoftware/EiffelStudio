indexing
	description: "ICOMPARER implementation for sorting MEMBER_INFOs"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_MEMBER_SORTER
	
inherit
	ICOMPARER

feature -- Comparison

	compare (x, y: SYSTEM_OBJECT): INTEGER is
			-- Compares `x' and `y'
		local
			l_x: MEMBER_INFO
			l_y: MEMBER_INFO
		do
			l_x ?= x
			l_y ?= y
			if l_x /= Void and l_y /= Void then
				Result := l_x.name.compare_to (l_y.name)
			end
		end

end -- class EC_MEMBER_SORTER
