note
	description: "Objects that represent a deferred version of a included assembly"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_PHYSICAL_ASSEMBLY_INTERFACE

inherit
	CONF_PHYSICAL_GROUP
		redefine
			process
		end

feature -- Access, in compiled only

	assemblies: ARRAYED_LIST [CONF_ASSEMBLY]
			-- Configuration assemblies that represent this assembly.

	dependencies: HASH_TABLE [CONF_PHYSICAL_ASSEMBLY_INTERFACE, INTEGER];
			-- Dependencies on other assemblies indexed by their assembly ID.

	guid: STRING
			-- A unique id.
		deferred
		ensure
			Result_valid: Result /= Void and then not Result.is_empty
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR)
			-- Process `a_visitor'.
		do
			Precursor (a_visitor)
			a_visitor.process_physical_assembly (Current)
		end

feature {CONF_ACCESS} -- Update, in compiled only

	add_assembly (a_assembly: CONF_ASSEMBLY)
			-- Add `a_assembly' to the list of assemblies that represent this assembly.
		require
			a_assembly_not_void: a_assembly /= Void
		do
			assemblies.extend (a_assembly)
		ensure
			assembly_added: assemblies.has (a_assembly)
		end

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
end
