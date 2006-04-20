indexing

	description:
		"A resource value for string resources."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class STRING_RESOURCE

inherit
	RESOURCE

create
	make,
	make_with_values

feature {NONE} -- Initialization

	make_with_values (a_name: STRING; a_value: STRING) is
			-- Initialie Current
		require
			valid_name: a_name /= Void;
			valid_value: a_value /= Void
		do
			name := a_name;
			value := a_value
		end;

	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: STRING) is
			-- Initialize Current
		require
			valid_name: a_name /= Void;
			valid_value: def_value /= Void
		do
			name := a_name
			value := rt.get_string (a_name, def_value);
			default_value := def_value;
		end

feature -- Access

	default_value, value: STRING
			-- Value as a `STRING' as represented by Current

	has_changed: BOOLEAN is
			-- Has the resource changed from the default value?
		do
			Result := not equal (default_value, value)
		end;

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			value := new_value;
		end;

feature -- Access

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		local
			lexer: RESOURCE_STRING_LEX;
			str: STRING
		do
			if not a_value.is_empty then
				if a_value @ 1 /= '%"' then
					create str.make (0);
					str.extend ('%"');
					str.append (a_value)
				else
					str := value.twin
				end
				if str @ str.count /= '%"' then
					str.extend ('%"')
				end;
				create lexer;
				Result := lexer.is_value_valid (str)
			else
				Result := True
			end
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

end -- class STRING_RESOURCE
