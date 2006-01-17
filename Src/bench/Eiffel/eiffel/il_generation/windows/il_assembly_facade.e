indexing
	description: "Provides access to IL assembly information, i.e the GAC and local assemblies,%
	%from FusionSupport.dll"
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
			-- Create the COM component to access assembly data
		do
			assembly_interface := (create {FUSION_FACTORY}).new_fusion_support
			initialize
		end
		
	initialize is
			-- Initilaization
		do
			if exists then
				assemblies := assembly_interface.assemblies
			end
		ensure
			assemblies_not_void: exists implies assemblies /= Void
		end

feature -- Access

	exists: BOOLEAN is
			-- Does interface exist?
		do
			Result := assembly_interface /= Void
		end

	is_valid: BOOLEAN is
			-- Find out if some calls can be made.
		do
			Result := item /= Void and then item.is_successful
		end
		
	assembly_name: STRING is
			-- Name of assembly at 'item'
		require
			is_valid: is_valid
		do
			Result := item.name
		end
	
	assembly_version: STRING is
			-- Version number of assembly at 'item'
		require
			is_valid: is_valid
		do
			Result := item.version
		end
	
	assembly_culture: STRING is
			-- Culture/locale of assembly at 'item'
		require
			is_valid: is_valid
		do
			Result := item.culture
		end
	
	assembly_public_key_token: STRING is
			-- Public key of assembly at 'item'
		require
			is_valid: is_valid
		do
			Result := item.public_key_token
		end

feature -- Cursor Movement

	start is
			-- Move cursor to start of assembly list
		require
			exists: exists
		do
			pos := 0
			item := assemblies.i_th (pos)
		end
		
	forth is
			-- Move cursor to next assembly
		require
			exists: exists
		do
			pos := pos + 1
			if not after then
				item := assemblies.i_th (pos)
			else
				item := Void
			end
		ensure
			moved: pos = old pos + 1
		end

	go_i_th (i_th: INTEGER) is
			-- Move cursor to 'i_th' position
		require
			exists: exists
		do
			item := assemblies.i_th (i_th)
		end	

feature -- Status Report

	after: BOOLEAN is
			-- Is there no valid position to the right of the cursor
		require
			exists: exists
		do
			Result := pos = assemblies.count
		end
		
	signed (a_loc: STRING): BOOLEAN is
			-- Is assembly at 'a_loc' signed?
		require
			location_not_void: a_loc /= Void
			location_not_empty: not a_loc.string.is_empty
			exists: exists
		do			
			Result := assembly_interface.signed (create {UNI_STRING}.make (a_loc))
		end
		
	get_assembly_info_from_assembly (a_loc: STRING) is
			-- Retrieve assembly information structure for assembly at
			-- location 'a_loc' and make 'item' result
		require
			location_not_void: a_loc /= Void
			location_not_empty: not a_loc.string.is_empty
			exists: exists
		do
			item := assembly_interface.get_assembly_info_from_assembly (
				create {UNI_STRING}.make (a_loc))
		end

feature {NONE} -- Implementation

	assembly_interface: FUSION_SUPPORT
			-- Interface to assembly data
		
	assemblies: FUSION_SUPPORT_ASSEMBLIES
			-- Assembly container
			
	item: FUSION_SUPPORT_ASSEMBLY_INFO
			-- Current assembly in focus
		
	pos: INTEGER
			-- Cursor position

invariant
	assemblies_not_void: exists implies (assembly_interface /= Void and then assemblies /= Void)

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
