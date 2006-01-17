indexing
	description: "Encapsulation of an IL enum extension."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ENUM_EXTENSION_I

inherit
	IL_EXTENSION_I
		redefine
			generate_call, default_create
		end

create
	default_create
	
feature {NONE} -- Initialization

	default_create is
			-- 
		do
			type := Enum_field_type
		end

feature -- Access

	value: INTEGER
			-- Value for enum.

feature -- Settings

	set_value (v: like value) is
			-- Set `value' with `v'.
		do
			value := v
		ensure
			value_set: value = v
		end
		
feature -- IL code generation

	generate_call (is_polymorphic: BOOLEAN) is
			-- Generate external feature call on Current.
		do
			il_generator.put_integer_32_constant (value)
		end

invariant
	type_is_enum: type = Enum_field_type

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

end -- class IL_ENUM_EXTENSION_I
