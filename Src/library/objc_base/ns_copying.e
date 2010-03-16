note
	description: "Wrapper for the NSCopying Protocol. Wrapper classes for classes that support NSCopying inherit from this class in Eiffel."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COPYING

inherit
	NS_OBJECT
		redefine
			copy
		end

feature -- Duplication

	copy (other: like Current)
			-- Make a copy of the underlying Objective-C object
		do
			make_from_pointer ({NS_OBJECT_API}.copy (other.item))
		end

end
