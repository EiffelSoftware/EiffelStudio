indexing

	description: 
		"Export status for features.";
	date: "$Date$";
	revision: "$Revision $"

class
	S_EXPORT_SET_I

inherit

	ARRAY [STRING]

	S_EXPORT_I
		undefine
			is_equal, copy, consistent, setup
		redefine
			is_all, is_none, is_set
		end

creation
	make

feature -- Properties

	is_all: BOOLEAN is
			-- Is Current exported to none?
		do
			Result := (count = 0) or else 
					((count = 1) and then Any_string.is_equal(item(1)))
		end

	is_none: BOOLEAN is
			-- Is Current exported to none?
		do
			Result := (count = 1) and then None_string.is_equal(item(1))
		end

	is_set: BOOLEAN is True;
			-- Is the current object an instance of S_EXPORT_SET_I ?
			--| Kept for compatibility.

feature -- Comparison

	same_as (other: S_EXPORT_I): BOOLEAN is
			-- Is `other' the same as Current ?
		local
			other_set: S_EXPORT_SET_I
			index: INTEGER
		do
			if other.is_all then
				Result := is_all
			elseif other.is_none then
				Result := is_none
			else
				other_set ?= other
				if other_set /= Void and then count = other_set.count then
					from
						Result := True
						index := 1
					variant
						remaining_elements: count - index
					until
						not Result or else index > count
					loop
						Result :=  other_set.has (item (index))
						index := index + 1
					end
				end
			end
		end

feature {NONE} -- Implementation properties

	Any_string: STRING is "ANY"

	None_string: STRING is "NONE"

end -- class S_EXPORT_SET_I
