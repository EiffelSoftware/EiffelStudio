indexing
	description: "Structure which receives the data contained in a XML file."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RESOURCE_STRUCTURE

feature  -- Access

	item, resource (resource_name: STRING): RESOURCE is
			-- Resource named `resource_name'.
			-- Name includes path.
		require
			resource_name_valid: resource_name /= Void
		deferred		
		end

	child_list (path: STRING): LINKED_LIST [RESOURCE_FOLDER] is
			-- List of children of `path' folder.
		deferred
		end

	resource_list (path: STRING): LINKED_LIST [RESOURCE] is
			-- List of resources of `path' folder.
		deferred
		end

	has_folder (s: STRING): BOOLEAN is
			-- Does Current has category pointed by 's'.
		require
			s_not_void: s /= Void
		deferred
		end

	folder (path: STRING): RESOURCE_FOLDER is
			-- Find the category corresponding to 's'.
			-- return Void if not found.
		require
			path_not_void: path /= Void
		deferred
		end

	location: STRING

feature -- Modification

	put (res : RESOURCE) is
			-- Put `res' in Current.
		do
		end

feature -- Saving

	save is
			-- Save all changes in appropriate storing device
		deferred
		end

feature -- Implementation

	table: RESOURCES_TABLE
		-- Hash Table of Resources.
		-- The key used is their "long" name.

	root_folder: RESOURCE_FOLDER

	error_message: STRING
		-- Message containing possibly the error(s) encountered during the 
		-- parsing.

end -- class RESOURCE_STRUCTURE
