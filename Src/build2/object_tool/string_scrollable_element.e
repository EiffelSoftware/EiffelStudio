indexing
	description: "A scrollable list element that represents %
			% only a string";
	date: "$Date$";
	revision: "$Revision$"

class
	STRING_SCROLLABLE_ELEMENT
	
	--| FIXME extracted form build
	--| main modification inheritance from `EV_LIST_ITEM'.

inherit

	EV_LIST_ITEM
		rename
			is_equal as ev_list_item_is_equal
		undefine
			out
		end
	
	STRING
		undefine
			default_create, copy, is_equal
		redefine
			make
		select
			is_equal
		end

creation
	make

feature -- Initialization is

	make (n: INTEGER) is
			-- Create `Current' with space for `n' characters.
		do
			default_create
			Precursor {STRING} (n)
		end

feature -- Implementation

	value: STRING is
			-- `Result' is `STRING' representing value of `Current'.
		do
			create Result.make (count)
			Result.append (Current)
		end

	is_equal (other: like Current): BOOLEAN is
			-- Test equality based on values of each `value'.
		do
			Result := value.is_equal (other.value)
		end

end -- class STRING_SCROLLABLE_ELEMENT
