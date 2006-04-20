indexing

	description:
		"A resource value for integer resources."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class INTEGER_RESOURCE

inherit
	RESOURCE

create
	make,
	make_with_values

feature {NONE} -- Initialization

	make_with_values (a_name: STRING; a_value: INTEGER) is
			-- Initialie Current
		do
			name := a_name;
			actual_value := a_value
		end;

	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: INTEGER) is
			-- Initialize Current
		do
			actual_value := rt.get_integer (a_name, def_value);
			default_value := def_value;
			name := a_name
		end

feature -- Access

	default_value, actual_value: INTEGER;
			-- Value represented by Current

	value: STRING is
			-- Value as a `STRING' as represented by Current
		do
			Result := actual_value.out
		end;

	has_changed: BOOLEAN is
			-- Has the resource changed from the default value?
		do
			Result := default_value /= actual_value
		end;

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		do
			Result := a_value.is_integer
		end

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value' and update `actual_value'.
		do
			actual_value := new_value.to_integer;
		end;

	set_actual_value (an_int: INTEGER) is
			-- Set `actual_value' to `an_int' and update `value'.
		do
			actual_value := an_int
		end;

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

end -- class INTEGER_RESOURCE
