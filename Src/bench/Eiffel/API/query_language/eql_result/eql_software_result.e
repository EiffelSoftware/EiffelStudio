indexing
	description: "Object that represents a software item in resultset of EQL"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_SOFTWARE_ITEM

inherit
	EQL_RESULT_ITEM
		redefine
			is_equal
		end

feature -- Data

	data: ANY is
			-- Data stored in current item
		deferred
		end

feature -- Equality

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			if Precursor (other) then
				Result := equal (data, other.data)
			end
		end

end
