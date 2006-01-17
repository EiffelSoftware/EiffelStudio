indexing
 
	description:
		"A resource value for color resources."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"
 
class COLOR_RESOURCE
 
inherit
	STRING_RESOURCE
		redefine
			set_value, make, make_with_values
		end
 
create
	make,
	make_with_values

feature {NONE} -- Initialization

	make_with_values (a_name: STRING; a_value: STRING) is
			-- Initialie Current
		do
			name := a_name;
			value := a_value;
			if a_value /= Void then
				set_value (a_value)
			end
		end;
 
	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: STRING) is
			-- Initialize Current
		do
			default_value := def_value;
			make_with_values (a_name, rt.get_string (a_name, def_value));
		end

feature -- Access

	actual_value: COLOR
			-- Color value of resource

	valid_actual_value: COLOR is
			-- Non void color value
		do
			Result := actual_value;	
			if Result = Void then
				Result := default_color
			end
		ensure
			valid_result: Result /= Void
		end;

	default_color: COLOR is
			-- Default color
		once
			create Result.make
			Result.set_name ("black")
		end;

feature -- Status setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			value := new_value;
			if new_value.is_empty then
				actual_value := Void
			else
				create actual_value.make;
				actual_value.set_name (new_value)
			end
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

end -- class COLOR_RESOURCE
