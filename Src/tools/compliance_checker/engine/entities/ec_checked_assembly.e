note
	description: "[
		Checked entity that describes and examines an assembly.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKED_ASSEMBLY

inherit		
	EC_CACHABLE_CHECKED_ENTITY

create
	make
	
feature {NONE} -- Initialization

	make (a_assembly: like assembly)
			-- Create an initialize CLS-compliant checked assembly.
		require
			a_assembly_not_void: a_assembly /= Void
		do
			assembly := a_assembly
		end
		
feature -- Access
		
	assembly: ASSEMBLY
			-- Assembly that was examined.
		
feature {NONE} -- Query {EC_CHECKED_ENTITY}

	custom_attribute_provider: ICUSTOM_ATTRIBUTE_PROVIDER
			-- Retrieve custom attribute provider for entity.
		do
			Result := assembly
		end
			
invariant
	assembly_not_void: assembly /= Void
			
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
end -- class EC_CHECKED_ASSEMBLY
