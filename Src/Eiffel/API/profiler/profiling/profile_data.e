note

	description:
		"Abstract notion of a class containing profile information."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PROFILE_DATA

inherit
	ANY
		redefine
			out, is_equal, copy
		end;

feature -- Creation feature

	make(num_call : INTEGER; feature_percentage, feature_total, feature_descendants: REAL_64)
			-- Create profile data for a single function
		do
			calls := num_call
			total := feature_total
			descendants := feature_descendants
			percentage := feature_percentage
			self := total - descendants
		end;

feature -- Output

	out : STRING
			-- Representation for output.
		do
			create Result.make (0);
			Result.append_string ("|%T")
			Result.append_string (calls.out)
			Result.append_string ("%T|%T")
			Result.append_string (self.out)
			Result.append_string ("%T|%T")
			Result.append_string (descendants.out)
			Result.append_string ("%T|%T")
			Result.append_string (percentage.out)
			Result.append_string ("%T|%T")
			Result.append_string (int_function.name)
		end

feature -- Compare

	is_equal (other: like Current): BOOLEAN
			-- is `Current' equal to `other'?
		do
			Result := calls = other.calls and then
					self = other.self and then
					descendants = other.descendants and then
					percentage = other.percentage and then
					int_function.is_equal (other.int_function)
		end

feature -- copy features

	copy (other: like Current)
			-- <Precursor>
		do
			if other /= Current then
				standard_copy (other)
				int_function := other.int_function.twin
			end
		end

feature -- Status report

	function: LANGUAGE_FUNCTION
			-- The function where all is about.
		deferred
		end

feature -- attributes

	calls: INTEGER
		-- Number of calls made to the function

	total,
		-- Total amount of seconds spent in the function.

	self,
		-- Total amount of seconds spent in the function itself.

	descendants,
		-- Total amount of seconds spent in the descendants of the function.

	percentage: REAL_64
		-- Percentage of time spent in the function and the descendants.

	int_function: LANGUAGE_FUNCTION
		-- The function where all is about.

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class PROFILE_DATA
