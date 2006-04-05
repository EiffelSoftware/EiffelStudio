indexing
	description: ".NET method argument"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ARGUMENT

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (dn, en: STRING; ct: CONSUMED_REFERENCED_TYPE) is
			-- Set `dotnet_name' with `dn'.
			-- Set `eiffel_name' with `en'.
			-- Set `type' with `ct'.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_type: ct /= Void
		do
			d := dn
			e := en
			t := ct
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			type_set: type = ct
		end
		
feature -- Access

	dotnet_name: STRING is
			-- .NET name
		do
			Result := d
		end
	
	eiffel_name: STRING is
			-- Eiffel name
		do
			Result := e
		end
	
	type: CONSUMED_REFERENCED_TYPE is
			-- Variable type
		do
			Result := t
		end

feature {NONE} -- Access

	d: like dotnet_name
			-- Internal data storage for `dotnet_name'.

	e: like eiffel_name
			-- Internal data storage for `eiffel_name'.
			
	t: like type
			-- Internal data storage for `type'.

feature {CONSUMED_ARGUMENT, OVERLOAD_SOLVER} -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
			-- Only compare arguments from same assembly as types are identified per assembly!
		do
			Result := other.dotnet_name.is_equal (dotnet_name) and
						other.type.is_equal (type)
		end

invariant
	non_void_dotnet_name: dotnet_name /= Void
	valid_dotnet_name: not dotnet_name.is_empty
	non_void_eiffel_name: eiffel_name /= Void
	valid_eiffel_name: not eiffel_name.is_empty
	non_void_type: type /= Void

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


end -- class CONSUMED_ARGUMENT
