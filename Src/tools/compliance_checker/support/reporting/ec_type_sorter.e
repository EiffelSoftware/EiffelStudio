indexing
	description: "ICOMPARER implementation for sorting SYSTEM_TYPEs"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_TYPE_SORTER
	
inherit
	ICOMPARER

feature -- Comparison

	compare (x, y: SYSTEM_OBJECT): INTEGER is
			-- Compares `x' and `y'
		local
			l_x: SYSTEM_TYPE
			l_y: SYSTEM_TYPE
		do
			l_x ?= x
			l_y ?= y
			if l_x /= Void and l_y /= Void then
				Result := l_x.full_name.compare_to (l_y.full_name)
			end
		end

end -- class EC_TYPE_SORTER
