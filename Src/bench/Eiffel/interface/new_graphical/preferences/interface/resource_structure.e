indexing
	description: "Structure which receives the data contained in a XML file."
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
	
	defaults_file_name: STRING
			-- Name of the file in which the defaults are stored.

end -- class RESOURCE_STRUCTURE
