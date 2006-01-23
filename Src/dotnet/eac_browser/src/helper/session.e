indexing
	description: "Keep session parameter."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	SESSION

feature -- Access

	current_assembly: CONSUMED_ASSEMBLY is
			-- Current assembly.
		do
			Result := internal_current_assembly.item
		end

	current_type: CONSUMED_TYPE is
			-- Current type.
		do
			Result := internal_current_type.item
		end


feature -- Status Setting

	set_current_assembly (an_assembly: CONSUMED_ASSEMBLY) is
			-- Put `an_assembly' in `internal_current_assembly'.
			-- Set `current_type' to void.
		require
			non_void_an_assembly: an_assembly /= Void
		do
			internal_current_assembly.put (an_assembly)
			Internal_current_type.put (Void)
		ensure
			current_assembly_set: current_assembly = an_assembly
			current_type_void: current_type = Void
		end

	set_current_type (an_type: CONSUMED_TYPE) is
			-- Put `an_type' in `internal_current_type'.
		require
			non_void_an_type: an_type /= Void
		do
			internal_current_type.put (an_type)
		ensure
			current_type_set: current_type = an_type
		end


feature {NONE} -- Implementation
	
	internal_current_assembly: CELL [CONSUMED_ASSEMBLY] is
			-- Internal representation of `current_assembly'.
		once
			Create Result.put (Void)
		ensure
			non_void_result: Result /= Void
		end
		
	internal_current_type: CELL [CONSUMED_TYPE] is
			-- Internal representation of `current_type'.
		once
			Create Result.put (Void)
		ensure
			non_void_result: Result /= Void
		end
		

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


end -- class SESSION

