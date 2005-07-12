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
		do
			Result := internal.generic_dynamic_type (Current, 1) =
				internal.generic_dynamic_type (other, 1)
		end
		
feature {NONE} -- Implementation

	internal: INTERNAL is
			-- Quick access to INTERNAL features
		once
			create Result
		ensure
			internal_not_void: Result /= Void
		end
		

end
