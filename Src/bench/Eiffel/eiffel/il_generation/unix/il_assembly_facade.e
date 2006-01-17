indexing
	description: "Provides access to IL assembly information, i.e the GAC and local assemblies"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ASSEMBLY_FACADE
	
create
	make

feature	-- Initialization

	make is
			-- Initialize the assembly interface information
		do
			check 
				False
			end
		end
		
	initialize is
			-- Initialization
		do
			check 
				False
			end
		end

feature -- Access

	exists: BOOLEAN is
			-- Does interface exist?
		do
			check
				False
			end
		end

	is_valid: BOOLEAN is
			-- Find out if some calls can be made.
		do
		end

	assembly_name: STRING is
			-- Name of assembly at 'item'
		require
			is_valid: is_valid
		do
			check
				False
			end
		end
	
	assembly_version: STRING is
			-- Version number of assembly at 'item'
		require
			is_valid: is_valid
		do
			check
				False
			end
		end
	
	assembly_culture: STRING is
			-- Culture/locale of assembly at 'item'
		require
			is_valid: is_valid
		do
			check
				False
			end
		end
	
	assembly_public_key_token: STRING is
			-- Public key of assembly at 'item'
		require
			is_valid: is_valid
		do
			check
				False
			end
		end

feature -- Cursor Movement

	go_i_th (i_th: INTEGER) is
			-- Move cursor to 'i_th' position
		require
			exists: exists
		do 
			check 
				False
			end
		end

	start is
			-- Move cursor to start of assembly list
		require
			exists: exists
		do
			check 
				False
			end
		end
		
	forth is
			-- Move cursor to next assembly
		require
			exists: exists
		do
			check 
				False
			end
		end
		
feature -- Status Report

	after: BOOLEAN is
			-- Is there no valid position to the right of the cursor
		require
			exists: exists
		do
			check 
				False
			end
		end
		
	signed (a_loc: STRING): BOOLEAN is
			-- Is assembly at 'a_loc' signed?
		require
			location_not_void: a_loc /= Void
			location_not_empty: not a_loc.string.is_empty
			exists: exists
		do
			check 
				False
			end
		end
		
	get_assembly_info_from_assembly (a_loc: STRING) is
			-- Retrieve assembly information structure for assembly at
			-- location 'a_loc' and make 'item' result
		require
			location_not_void: a_loc /= Void
			location_not_empty: not a_loc.string.is_empty
			exists: exists
		do
			check 
				False
			end
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

end -- class IL_ASSEMBLY_FACADE

