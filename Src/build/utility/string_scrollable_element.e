indexing
	description: "A scrollable list element that represents %
			% only a string";
	date: "$Date$";
	revision: "$Revision$"

class
	STRING_SCROLLABLE_ELEMENT

inherit
	SCROLLABLE_LIST_ELEMENT
		undefine
			out, 
			copy,
			consistent,
			setup
		redefine
			is_equal
		end
	STRING
		redefine
			is_equal
		end

creation
	make

feature -- Implementation

	value: STRING is
		do
			!! Result.make (count)
			Result.append (Current)
		end

	is_equal (other: like Current): BOOLEAN is
			-- Test equality based on values of each `value'.
		do
			Result := value.is_equal (other.value)
		end

end -- class STRING_SCROLLABLE_ELEMENT
