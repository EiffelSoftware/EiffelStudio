indexing

	description:
		"Profile filter to check whether the number of calls to a specific %
		%function matches the number of calls specified by the user.";
	date: "$Date$";
	revision: "$Revision$"

class CALLS_FILTER

inherit
	COMPARING_FILTER
		rename
			value as c_f_value,
			item_value as c_f_item_value,
			lower_interval as c_f_lower,
			upper_interval as c_f_upper
		redefine
			filtering_is_allowed
		end

create
	make

feature -- Creation is

	make is
		do
			value := -1;
			lower_interval := -1;
			upper_interval := -1;
		end

feature -- Checking

	copy_value (item: PROFILE_DATA) is
		do
			item_value := item.calls
		end

	filtering_is_allowed: BOOLEAN is
			-- May `filter' be called?
		do
			Result := operator /= Void and then
						(value >= 0 or else
						(lower_interval >= 0 and upper_interval >= 0))
		end

feature -- Value setting

	set_value_range (lower, upper: COMPARABLE) is
			-- Value range as used in the Comparing-features
		local
			int_ref: INTEGER_REF
		do
			int_ref ?= lower;
			check
				lower_must_be_an_INTEGER: int_ref /= Void;
			end;
			lower_interval := int_ref.item;
			int_ref ?= upper;
			check
				upper_must_be_an_INTEGER: int_ref /= Void;
			end;
			upper_interval := int_ref.item;
		end

	set_value (new_value: COMPARABLE) is
			-- Value as used in Comparing-features
		local
			int_ref: INTEGER_REF
		do
			int_ref ?= new_value
			check
				new_value_must_be_an_INTEGER: int_ref /= Void
			end
			value := int_ref.item
		end

feature -- Comparing

	equal_to: BOOLEAN is
			-- Is value equal to the specified value?
		do
			Result := item_value = value
		end

	min: BOOLEAN is
			-- Is value equal to the minimum value?
		do
		end

	max: BOOLEAN is
			-- Is value equal to the maximum value?
		do
		end

	avg: BOOLEAN is
			-- Is value equal to average value?
		do
		end

	less_than: BOOLEAN is
			-- Is value less than the specified value?
		do
			Result := item_value < value
		end

	in_interval: BOOLEAN is
			-- Is value in specified interval?
		do
			Result := lower_interval <= item_value and
						item_value <= upper_interval
		end;

feature {NONE} -- Attributes

	value: INTEGER

	item_value: INTEGER

	lower_interval, upper_interval: INTEGER

end -- class CALLS_FILTER
