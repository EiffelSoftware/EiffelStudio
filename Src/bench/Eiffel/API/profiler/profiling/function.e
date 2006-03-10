indexing

	description:
			"Information about the name of a certain function %
			%  or feature."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class LANGUAGE_FUNCTION

inherit
	ANY
		undefine
			out
		end;

feature -- Name of the function

	name: STRING is
			-- The name of the function.
		deferred
		end

feature -- Cyclic

	set_member_of_cycle (cyc_num: INTEGER) is
			-- Makes `Current' member of cycle with number `cyc_num'.
		do
			cycle_num := cyc_num;
		end;

feature -- Status report

	is_member_of_cycle: BOOLEAN is
			-- Is `Current' member of any cycle?
		do
			Result := (not (cycle_number = 0));
		end;

	cycle_number: INTEGER is
			-- Number of the cycle `Current' is member of.
		require
			member: is_member_of_cycle;
		do
			Result := cycle_num;
		end;

feature -- Output

	append_to (st: TEXT_FORMATTER) is
			-- Append Current function to `st'.
		require
			valid_st: st /= Void
		do
			st.add (out)
		end;

	out: STRING is
			-- Representation for output.
		do
			Result := name;
		end;

feature {NONE} -- Attributes

	cycle_num: INTEGER;
			-- Number of the cycle of which this function is a member.

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

end -- class LANGUAGE_FUNCTION
