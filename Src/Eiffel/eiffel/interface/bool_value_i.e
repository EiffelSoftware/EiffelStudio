note
	description: "Description of a boolean value."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BOOL_VALUE_I

inherit
	VALUE_I
		redefine
			generate, is_boolean, boolean_value
		end;

create
	make

feature {NONE} -- Initialization

	make (v: BOOLEAN)
			-- Create current with value `v'.
		do
			boolean_value := v
		ensure
			boolean_value_set: boolean_value = v
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := boolean_value = other.boolean_value
		end

feature -- Access

	boolean_value: BOOLEAN;
			-- Integer constant value

	is_boolean: BOOLEAN = True
			-- Is the constant value a boolean one ?

	valid_type (t: TYPE_A): BOOLEAN
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_boolean;
		end;

	generate (buffer: GENERATION_BUFFER)
			-- Generate value in `file'.
		do
			if boolean_value then
				buffer.put_string ("'\01'");
			else
				buffer.put_string ("'\0'");
			end;
		end;

	generate_il
			-- Generate IL code for boolean constant value.
		do
			il_generator.put_boolean_constant (boolean_value)
		end

	make_byte_code (ba: BYTE_ARRAY)
			-- Generate byte code for a boolean constant value.
		do
			ba.append (Bc_bool);
			ba.append_boolean (boolean_value)
		end;

	dump: STRING
		do
			Result := boolean_value.out
		end;

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end
