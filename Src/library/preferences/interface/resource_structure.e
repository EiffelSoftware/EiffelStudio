indexing
	description: "Structure which receives the data contained in an XML file."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_STRUCTURE

inherit
	EXCEPTIONS
		redefine
			default_create
		end

feature {NONE} -- Initialization
	
	default_create is
			-- Initialize `Current'.
		do
			Precursor {EXCEPTIONS}
			create internal_registered_types.make (10)
		end

feature -- Initialization
	
	register_basic_types is
			-- Append basic resource types to the list of known resource types.
		require
			no_registered_type: registered_types.is_empty
		do
			register_type (create {BOOLEAN_RESOURCE_TYPE}.make)
			register_type (create {INTEGER_RESOURCE_TYPE}.make)
			register_type (create {STRING_RESOURCE_TYPE}.make)
			register_type (create {ARRAY_RESOURCE_TYPE}.make)
		ensure
			basic_types_registered: basic_types_registered
		end

	register_type (t: RESOURCE_TYPE) is
			-- Add `t' to the list of known types.
		require
			valid_type: t /= Void
		do
			internal_registered_types.extend (t)
		ensure
			type_registered: registered_types.has (t)
		end

	make_from_location (default_file_name: STRING; location: STRING) is
			-- Initialize `Current'.
			-- Read the default values (and resource properties) in `default_file_name'.
			-- Read the current values in `location'.
		require
			basic_types_registered: basic_types_registered
			not_already_initialized: not initialized
		local
			imp: RESOURCE_STRUCTURE_IMP
			retried: BOOLEAN
		do
			if not retried then
				error_message := Void
				initialized := True
				defaults_file_name := default_file_name
				create imp.make (Current)
				implementation := imp
				imp.initialize (default_file_name, location)
			else
				initialized := False
				error_message := developer_exception_name
			end
		ensure
			initialized_if_no_error: error_message = Void implies initialized
		rescue
			if is_developer_exception then
				retried := True
				retry
			end
		end

feature -- Access

	item, resource (resource_name: STRING): RESOURCE is
			-- Resource named `resource_name'.
			-- Name includes path.
		require
			resource_name_valid: resource_name /= Void
			initialized: initialized
		do
			Result := implementation.resource (resource_name)		
		end

	child_list (path: STRING): LIST [like folder] is
			-- List of children of `path' folder.
		require
			valid_path: path /= Void
			initialized: initialized
		do
			Result := implementation.child_list (path)
		end

	resource_list (path: STRING): LIST [RESOURCE] is
			-- List of resources of `path' folder.
		require
			valid_path: path /= Void
			initialized: initialized
		do
			Result := implementation.resource_list (path)
		end

	folder (path: STRING): like root_folder is
			-- Find the category corresponding to 's'.
			-- return Void if not found.
		require
			path_not_void: path /= Void
			initialized: initialized
		do
			Result := implementation.folder (path)
		end

	type_of_index (ind: INTEGER): RESOURCE_TYPE is
			-- Type of resource located at index `ind' in `registered_types'.
		require
			valid_index: ind > 0 and number_of_registered_types >= ind
		do
			Result := internal_registered_types.i_th (ind)
		end

feature -- Access: Type constants

	boolean_type_index: INTEGER is 1
	integer_type_index: INTEGER is 2
	string_type_index: INTEGER is 3
	array_type_index: INTEGER is 4
	color_type_index: INTEGER is 5
	font_type_index: INTEGER is 6

feature -- Status Report

	has_folder (s: STRING): BOOLEAN is
			-- Does Current have category pointed by 's'?
		require
			s_not_void: s /= Void
			initialized: initialized
		do
			Result := implementation.has_folder (s)
		end

	initialized: BOOLEAN
			-- Has `Current' been correctly initialized?

	error_message: STRING
			-- Message explaining why `Current' could not be initialized.

	number_of_registered_types: INTEGER is
			-- Number of known resource types.
		do
			Result := internal_registered_types.count
		end

	basic_types_registered: BOOLEAN is
			-- Are the basic types of resource (integer, string, etc.) known?
		do
			if internal_registered_types.count >= array_type_index then
				Result :=	(internal_registered_types @ boolean_type_index).xml_name.is_equal ("BOOLEAN")
						and (internal_registered_types @ integer_type_index).xml_name.is_equal ("INTEGER")
						and (internal_registered_types @ string_type_index).xml_name.is_equal ("STRING")
						and (internal_registered_types @ array_type_index).xml_name.is_equal ("LIST_STRING")
			end
		end

	registered_types: LIST [RESOURCE_TYPE] is
			-- Known resource types.
		do
			Result := internal_registered_types
		ensure
			not_void: Result /= Void
		end

feature -- Modification

	put_resource (res: RESOURCE) is
			-- Put `res' in `Current'.
		require
			valid_resource: res /= Void
			initialized: initialized
		do
			implementation.put_resource (res)
		ensure
			has_resource: item (res.name) = res
		end

	replace_resource (res: RESOURCE) is
			-- Replace resource with name `res.name' with `res' in `Current'.
		require
			initialized: initialized
			valid_resource: res /= Void
			has_resource: item (res.name) /= Void
		do
			implementation.replace_resource (res)
		ensure
			has_resource: item (res.name) = res
		end
		
	load_defaults is
			-- Wipe out the contents of `Current' and load preferences of the default file instead.
		require
			initialized: initialized
		do
			implementation.make_default (defaults_file_name)
		end

feature -- Saving

	save is
			-- Save all changes in appropriate storing device.
		require
			initialized: initialized
		do
			implementation.save
		end

feature -- Implementation

	root_folder: RESOURCE_FOLDER is
			-- Root folder of the preferences structure.
		require
			initialized: initialized
		do
			Result := implementation.root_folder_i.interface
		end

feature {NONE} -- Implementation

	implementation: RESOURCE_STRUCTURE_I
			-- Actual container for the resources.
	
	defaults_file_name: STRING
			-- Name of the file in which the defaults are stored.

	internal_registered_types: ARRAYED_LIST [RESOURCE_TYPE]
			-- Known resource types.

end -- class RESOURCE_STRUCTURE
