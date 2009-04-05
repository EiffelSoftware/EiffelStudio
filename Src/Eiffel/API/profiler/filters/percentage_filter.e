note

	description:
		"Profile filter used to check whether the percentage of time spent in a function %
		%is equal to the value specified by the user."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class PERCENTAGE_FILTER

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

	make
		do
			value := -1
			lower_interval := -1;
			upper_interval := -1;
		end

feature -- Checking

	copy_value (item: PROFILE_DATA)
		do
			item_value := item.percentage
		end

	filtering_is_allowed: BOOLEAN
			-- May `filter' be called?
		do
			Result := operator /= Void and then
					(value >= 0.0 or else
					(lower_interval >= 0 or else upper_interval >= 0))
		end

feature -- Value setting

	set_value_range (lower, upper: COMPARABLE)
			-- Value range as used in the Comparing-features 
		local
			real_ref: REAL_64_REF
		do
			real_ref ?= lower
			check
				new_value_must_be_real_64: real_ref /= Void
			end
			lower_interval := real_ref.item
			real_ref ?= upper
			check
				new_value_must_be_real_64: real_ref /= Void
			end
			upper_interval := real_ref.item
		end

	set_value (new_value: COMPARABLE)
			-- Value as used in Comparing-features
		local
			real_ref: REAL_64_REF
		do
			real_ref ?= new_value
			check
				new_value_must_be_real_64: real_ref /= Void
			end
			value := real_ref.item
		end

feature -- Comparing

	equal_to: BOOLEAN
			-- Is value equal to the specified value?
		do
			Result := item_value = value
		end

	min: BOOLEAN
			-- Is value equal to the minimum value?
		do
		end

	max: BOOLEAN
			-- Is value equal to the maximum value?
		do
		end

	avg: BOOLEAN
			-- Is value equal to average value?
		do
		end

	less_than: BOOLEAN
			-- Is value less than the specified value?
		do
			Result := item_value < value
		end

	in_interval: BOOLEAN
			-- Is value in specified value?
		do
			Result := lower_interval <= item_value and
						item_value <= upper_interval;
		end;

feature {NONE} -- Attributes

	value: REAL_64

	item_value: REAL_64

	lower_interval, upper_interval: REAL_64;

note
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

end -- class PERCENTAGE_FILTER
