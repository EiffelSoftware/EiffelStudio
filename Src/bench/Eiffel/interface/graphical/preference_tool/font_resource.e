indexing

	description:
		"A resource value for string resouorces."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class FONT_RESOURCE

inherit
	STRING_RESOURCE
		redefine
			make, set_value, is_valid, make_with_values
		end

create
	make,
	make_with_values

feature {NONE} -- Initialization

    make_with_values (a_name: STRING; a_value: STRING) is
            -- Initialie Current
        do
            name := a_name;
            value := a_value
        end;

	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: STRING) is
			-- Initialize Current
		do
			name := a_name
			default_value := def_value;
			value := rt.get_string (a_name, def_value);
			if value /= Void and then not value.is_empty then
				create actual_value.make
				actual_value.set_name (value);
				if not actual_value.is_font_valid then
					io.error.put_string ("Warning: Could not allocate font ")
					io.error.put_string (value)
					io.error.put_string (" for resource ")
					io.error.put_string (name)
					io.error.put_new_line
					actual_value := default_font;
				end;
				value := actual_value.name
			end
		end

feature -- Access

	actual_value: FONT
			-- Font value

	valid_actual_value: FONT is
			-- A non void font value
		do
			Result := actual_value;
			if Result = Void then
				Result := default_font
			end
		ensure
			valid_result: Result /= Void
		end;

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
			--| Always `True'.
		local
			font: FONT
		do
			if not a_value.is_empty then
				create font.make;
				font.set_name (a_value);
				Result := font.is_font_valid
			else
				Result := True
			end
		end

	default_font: FONT is
			-- Default value if resource not found in a resource file
		once
			create Result.make
			Result.set_name ("fixed")
		end

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			if not new_value.is_empty then	
				create actual_value.make;
				actual_value.set_name (new_value)
			else
				actual_value := Void
			end
			value := new_value
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

end -- class FONT_RESOURCE
