note
	description: "Forwarded type from an assembly to another"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_FORWARDED_TYPE

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (dn, en: STRING; aid: INTEGER)
			-- Set `name' with `a_name'.
			-- Set `assembly_id' with `aid'.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			valid_assembly_id: aid > 0
		do
			dotnet_name := dn
			eiffel_name := en
			assembly_id := aid
		ensure
			dotnet_name_set: dotnet_name = dn
			eiffel_name_set: eiffel_name = en
			id_set: assembly_id = aid
		end

feature -- Access

	dotnet_name: STRING
			-- Type full name


	eiffel_name: STRING
			-- Eiffel class name

	assembly_id: INTEGER
			-- ID of the assembly when current type is declared (see Forwarded types).
			-- The id is the index of the assembly in the `referenced_assemblies.info` data file.

	assembly: detachable CONSUMED_ASSEMBLY assign set_assembly
			-- Consumed assembly that contains the forward type declaration.
			-- It is set in a second step in `{CONF_CONSUMER_MANAGER}.build_assemblies`.

feature -- Status report

	debug_output: STRING_32
			-- <Precursor>
		do
			create Result.make (10)
			Result.append_string (dotnet_name)
			Result.append_string_general (" {")
			Result.append_string (eiffel_name)
			Result.append_string_general ("} @")
			if attached assembly as a then
				Result.append_string (a.name)
			else
				Result.append_integer (assembly_id)
			end
		end

feature -- Element change

	set_assembly (a: like assembly)
			-- Set `assembly` to `a`.
		do
			assembly := a
		end

feature -- Comparison

	same_as (other: CONSUMED_FORWARDED_TYPE): BOOLEAN
			-- Only compare forwarded types from same assembly as ids may change for other assemblies!
		do
			Result := other.assembly_id = assembly_id and other.dotnet_name.same_string (dotnet_name)
		end

invariant
	non_void_eiffel_name: eiffel_name /= Void
	valid_eiffel_name: not eiffel_name.is_empty
	non_void_dotnet_name: dotnet_name /= Void
	valid_dotnet_name: not dotnet_name.is_empty
	valid_assembly_id: assembly_id > 0

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


end -- class CONSUMED_REFERENCE_TYPE
