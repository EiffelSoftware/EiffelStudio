note
	description: "Literal fields as seen in Eiffel"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_LITERAL_FIELD

inherit
	CONSUMED_FIELD
		rename
			make as field_make
		redefine
			is_literal
		end

create
	make

feature {NONE} -- Initialization

	make (en, dn: STRING; rt: CONSUMED_REFERENCED_TYPE; static, pub: BOOLEAN;
			val: STRING; a_type: CONSUMED_REFERENCED_TYPE)
		
			-- Initialize field.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_return_type: rt /= Void
			non_void_value: val /= Void
			a_type_not_void: a_type /= Void
		do
			field_make (en, dn, rt, static, pub, True, a_type)
			v := val
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			return_type_set: return_type = rt
			is_static_set: is_static = static
			is_public_set: is_public = pub
			value_set: value = val
			declared_type_set: declared_type = a_type
		end

feature -- Access

	value: STRING
			-- Literal value
		do
			Result := v
		end

feature -- Status report

	is_literal: BOOLEAN = True
			-- Current is literal.

feature {NONE} -- Access

	v: like value
			-- Internal data for `value'.

invariant
	is_static: is_static

note
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


end -- class CONSUMED_LITERAL_FIELD
