indexing
	description: "Structure which receives the data contained in a XML file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_STRUCTURE

create
	make_from_location, make_from_file

feature {NONE} -- Initialization

	make_from_location (default_file_name: STRING; location: STRING) is
		local
			imp: RESOURCE_STRUCTURE_IMP
		do
			defaults_file_name := default_file_name
			create imp.make (Current)
			implementation := imp
			imp.initialize (default_file_name, location)
		end

	make_from_file (default_file_name: STRING; normal_file_name: STRING) is
		local
			imp: RESOURCE_STRUCTURE_IMP
		do
			create imp.make (Current)
			implementation := imp
			imp.initialize_from_file (default_file_name, normal_file_name)
		end

feature  -- Access

	item, resource (resource_name: STRING): RESOURCE is
			-- Resource named `resource_name'.
			-- Name includes path.
		require
			resource_name_valid: resource_name /= Void
		do
			Result := implementation.resource (resource_name)		
		end

	child_list (path: STRING): LINKED_LIST [like folder] is
			-- List of children of `path' folder.
		do
			Result := implementation.child_list (path)
		end

	resource_list (path: STRING): LINKED_LIST [RESOURCE] is
			-- List of resources of `path' folder.
		do
			Result := implementation.resource_list (path)
		end

	folder (path: STRING): like root_folder is
			-- Find the category corresponding to 's'.
			-- return Void if not found.
		require
			path_not_void: path /= Void
		do
			Result := implementation.folder (path)
		end

feature -- Status Report

	has_folder (s: STRING): BOOLEAN is
			-- Does Current has category pointed by 's'.
		require
			s_not_void: s /= Void
		do
			Result := implementation.has_folder (s)
		end

feature -- Modification

	put_resource (res : RESOURCE) is
			-- Put `res' in Current.
		do
			implementation.put_resource (res)
		end

	replace_resource (res : RESOURCE) is
			-- Put `res' in Current.
		do
			implementation.replace_resource (res)
		end
		
	load_defaults is
			-- Wipe out the contents of `Current' and load preferences in the default file instead.
		do
			implementation.make_default (defaults_file_name)
		end

feature -- Saving

	save is
			-- Save all changes in appropriate storing device
		do
			implementation.save
		end

feature -- Implementation

	root_folder: RESOURCE_FOLDER is
		do
			Result := implementation.root_folder_i.interface
		end

feature {NONE} -- Implementation

	implementation: RESOURCE_STRUCTURE_I
	
	defaults_file_name: STRING;
			-- Name of the file in which the defaults are stored.

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

end -- class RESOURCE_STRUCTURE
