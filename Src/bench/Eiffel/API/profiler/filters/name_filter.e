indexing

	description:
		"Profile filter used to check whether the name of a function matches %
		%the name specified by the user."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class NAME_FILTER

inherit
	COMPARING_FILTER
		rename
			value as c_f_value,
			item_value as c_f_item_value
		redefine
			filtering_is_allowed
		end

create
	make

feature -- Initialization

	make is
			-- Initialize Current.
		do
		end;

feature -- Checking

	copy_value (item: PROFILE_DATA) is
		do
			item_value := item.function.out;
			item_value.to_lower
		end;

	filtering_is_allowed: BOOLEAN is
			-- May `filter' be called?
		do
			Result := operator /= Void and then value /= Void
		end;

feature -- Value setting

	set_value (new_value: COMPARABLE) is
			-- Value as used in Comparing-features
		do
			value ?= new_value;
			check
				new_value_must_be_a_STRING: value /= Void
			end;
			value.to_lower
		end;

feature -- Comparing

	equal_to: BOOLEAN is
			-- Is value equal to the specified value?
		local
			wildcard_matcher: KMP_WILD
		do
			if has_wildcards (value) then
				create wildcard_matcher.make (value, item_value)
				Result := wildcard_matcher.pattern_matches
			else
				Result := item_value.is_equal (value)
			end
		end;

	min: BOOLEAN is
			-- Is value equal to the minimum value?
		do
		end;

	max: BOOLEAN is
			-- Is value equal to the maximum value?
		do
		end;

	avg: BOOLEAN is
			-- Is value equal to average value?
		do
		end;

	less_than: BOOLEAN is
			-- Is value less than the specified value?
		do
			if not has_wildcards (value) then
				Result := item_value < value
			else
				Result := false
			end
		end;

	in_interval: BOOLEAN is
			-- Is value in specified interval?
			-- Result: NO (intervals are not allowed here.)
		do
		end;

feature {NONE} -- Attributes

	value: STRING

	item_value: STRING

feature {NONE} -- Implementation

	set_value_range (first, second: COMPARABLE) is
			-- Value range as used in the Comparing-features 
		do
		end;

	has_wildcards (item: STRING): BOOLEAN is
		do
			Result := (item.index_of ('*', 1) > 0) or else
					(item.index_of ('?', 1) > 0)
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class NAME_FILTER
