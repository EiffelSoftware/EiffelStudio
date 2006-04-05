indexing

	description:
		"Profile filter to check whether the number of calls to a specific %
		%function matches the number of calls specified by the user."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

	lower_interval, upper_interval: INTEGER;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CALLS_FILTER
