indexing

	description:
		"Abstract notion of a class containing profile information."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PROFILE_DATA

inherit
	ANY
		undefine
			copy
		redefine
			out, is_equal
		end;

feature -- Creation feature

	make(num_call : INTEGER; feature_percentage, feature_total, feature_descendants: REAL) is
			-- Create profile data for a single function
		do
			calls := num_call
			total := feature_total
			descendants := feature_descendants
			percentage := feature_percentage
			self := ((total - descendants) * 100.0).rounded / 100.0
		end;

feature -- Output

	out : STRING is
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

	is_equal (other: like Current): BOOLEAN is
			-- is `Current' equal to `other'?
		do
			Result := calls = other.calls and then
					self = other.self and then
					descendants = other.descendants and then
					percentage = other.percentage and then
					int_function.is_equal (other.int_function)
		end

feature -- copy features

	copy (other: like Current) is
			-- Reinitialize by copying the attributes of `other'.
			-- (This is also used by `clone'.)
		deferred
		end

feature -- Status report

	function: LANGUAGE_FUNCTION is
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

	percentage: REAL
		-- Percentage of time spent in the function and the descendants.

	int_function: LANGUAGE_FUNCTION
		-- The function where all is about.

feature {PROFILE_SET} -- Spit Information (for debugging)

	spit_info is
		-- Spits all kinds of information about Current.
		do
			io.error.put_string (out);
			io.error.put_new_line
		end

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

end -- class PROFILE_DATA
