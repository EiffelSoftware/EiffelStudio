indexing
	description: "Structure which receives the data contained in a XML file."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_STRUCTURE

create
	make

feature {NONE} -- Initialization

	make is
		local
			imp: RESOURCE_STRUCTURE_IMP
		do
			create imp.make (Current)
			implementation := imp
			imp.initialize ("D:\46dev\bench.xml")
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
		local
			child_list_i: LINKED_LIST [RESOURCE_FOLDER_I]
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

feature -- Saving

	save is
			-- Save all changes in appropriate storing device
		do
			implementation.save
		end

	save_resource (res: RESOURCE) is
			-- Save all changes in appropriate storing device
		do
			implementation.save_resource (res)
		end

feature -- Implementation

	root_folder: RESOURCE_FOLDER is
		do
			Result := implementation.root_folder
		end

feature {NONE} -- Implementation

	implementation: RESOURCE_STRUCTURE_I

end -- class RESOURCE_STRUCTURE
