indexing
	description: "Representation of an Eiffel type."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE [G]

inherit
	ANY
		redefine
			is_equal
		end

create {NONE}

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		local
			l_internal :INTERNAL
		do
			create l_internal
			Result := l_internal.generic_dynamic_type (Current, 1) =
				l_internal.generic_dynamic_type (other, 1)
		end
		
end
