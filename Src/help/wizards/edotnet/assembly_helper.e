indexing
	description	: "Objects to retrieve properties of an assembly"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	ASSEMBLY_HELPER

create
	make

feature -- Initialization

	make (a_filename: STRING) is
			-- Initialize
		local
			filename_ptr: ANY
			filename_for_c: STRING
		do
			filename_for_c := clone (a_filename)
			filename_ptr := filename_for_c.to_c
			c_get_assembly_properties ($Current, $filename_ptr, $update_assembly_properties)
		end

feature -- Access

	valid_assembly: BOOLEAN
			-- Is this assembly a valid assembly?

	version_major: INTEGER is
			-- Major version.
		require
			valid_assembly: valid_assembly
		do
			Result := internal_version_major
		end
			
	version_minor: INTEGER is
			-- Minor version.
		require
			valid_assembly: valid_assembly
		do
			Result := internal_version_minor
		end
			
	version_revision: INTEGER is
			-- Revision
		require
			valid_assembly: valid_assembly
		do
			Result := internal_version_revision
		end
			
	version_build: INTEGER is
			-- Build number
		require
			valid_assembly: valid_assembly
		do
			Result := internal_version_build
		end
			
	version: STRING is
			-- Full Version number
		require
			valid_assembly: valid_assembly
		do
			create Result.make (14)
			Result.append (version_major.out)
			Result.append_character ('.')
			Result.append (version_minor.out)
			Result.append_character ('.')
			Result.append (version_revision.out)
			Result.append_character ('.')
			Result.append (version_build.out)
		ensure
			Result_not_void: Result /= Void
		end
			
	name: STRING is
			-- Name for the assembly
		require
			valid_assembly: valid_assembly
		do
			Result := clone (internal_name)
		ensure
			Result_not_void: Result /= Void and then not Result.is_empty
		end
	
feature {NONE} -- Implementation

	update_assembly_properties (assembly_name_ptr: POINTER; major: INTEGER; minor: INTEGER; revision: INTEGER; build: INTEGER) is
			-- Update the attributes for the object.
			-- [Callback feature]
		do
			if assembly_name_ptr /= Default_pointer then
				internal_version_major := major
				internal_version_minor := minor
				internal_version_revision := revision
				internal_version_build := build

				create internal_name.make_from_c (assembly_name_ptr)
				valid_assembly := (internal_name /= Void and then not internal_name.is_empty)
			end
		end

	internal_version_major: INTEGER
			-- Major version.
			
	internal_version_minor: INTEGER
			-- Minor version.
			
	internal_version_revision: INTEGER
			-- Revision
			
	internal_version_build: INTEGER
			-- Build number
			
	internal_name: STRING
			-- Name for the assembly
	
feature {NONE} -- Externals

	c_get_assembly_properties(curr_object: POINTER; file_name: POINTER;	update_assembly_properties_ptr: POINTER) is
		external
			"C | %"assembly_helper.h%""
		alias
			"RetrieveAssemblyProperties"
		end

end -- class ASSEMBLY_HELPER
