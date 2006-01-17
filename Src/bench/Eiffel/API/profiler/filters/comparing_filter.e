indexing

	description:
		"Profile filter the check whether the stored information is equal %
		%to the information specified by the user."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class COMPARING_FILTER

inherit
	PROFILE_FILTER
		redefine
			filtering_is_allowed
		end

feature -- Checking

	copy_value (item: PROFILE_DATA) is
		deferred
		end

	check_item (item: PROFILE_DATA): BOOLEAN is
		do
			copy_value (item)
			if operator.is_equal(">") then
				Result := greater_than
			elseif operator.is_equal(">=") then
				Result := greater_than_or_equal_to
			elseif operator.is_equal("<") then
				Result := less_than
			elseif operator.is_equal("<=") then
				Result := less_than_or_equal_to
			elseif operator.is_equal("=") then
				Result := equal_to
			elseif operator.is_equal("/=") then
				Result := not_equal_to
			elseif operator.is_equal ("in") then
				Result := in_interval
			end
		end

	filter (input_set: PROFILE_SET): PROFILE_SET is
			-- Check all items
		do
			from
				create Result.make
				input_set.start
			until
				input_set.after
			loop
				if check_item (input_set.item) then
					Result.insert_unknown_profile_data (input_set.item)
				end
				input_set.forth
			end
			Result.stop_computation;
		end

	filtering_is_allowed: BOOLEAN is
			-- May `filter' be called?
		do
			Result := ((operator /= Void) and then 
						((value /= Void)))
		end

feature -- Comparing

	less_than: BOOLEAN is
			-- Is value less than specified value?
		deferred
		end

	less_than_or_equal_to: BOOLEAN is
			-- Is value less than or equal to specified value?
		do
			Result := less_than or else equal_to
		end

	greater_than: BOOLEAN is
			-- Is value greater than specified value?
		do
			Result := not less_than_or_equal_to
		end

	greater_than_or_equal_to: BOOLEAN is
			-- Is value greater than or equal to specified value?
		do
			Result := not less_than
		end

	equal_to: BOOLEAN is
			-- Is value equal to specified value?
		deferred
		end

	not_equal_to: BOOLEAN is
			-- Is value not equal to specified value?
		do
			Result := not equal_to
		end

	avg: BOOLEAN is
			-- Is value equal to the average value?
		deferred
		end

	min: BOOLEAN is
			-- Is value equal to the minimum value?
		deferred
		end

	max: BOOLEAN is
			-- Is value equal to the maximum value?
		deferred
		end

	in_interval: BOOLEAN is
			-- Is value in the specified interval ?
		deferred
		end;

feature -- Value setting

	set_operator (new_operator: STRING) is
			-- Operator `new_operator' with which the comparisons
			-- are to be done
		do
			operator := new_operator
		end

feature {NONE} -- Attributes

	operator: STRING
		-- Operator for the comparisons

	value: COMPARABLE
		-- Value as specified by user. Must be redefined in
		-- descendants of this class.

	item_value: COMPARABLE
		-- Value as specified in PROFILE_DATA. Must be redefined in
		-- descendants of this class.

	lower_interval, upper_interval: COMPARABLE
		-- Interval values, as specified by the user.
		-- Must by redefined in descendants of this class.

feature {NONE} -- Hidden features

	extend (new_filter: PROFILE_FILTER) is
		do
		end

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

end -- class COMPARING_FILTER
