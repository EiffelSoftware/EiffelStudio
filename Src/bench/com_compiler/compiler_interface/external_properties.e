indexing
	description: "Retrieves and sets the External properties of the ace file"

class
	EXTERNAL_PROPERTIES

create
	make

feature {NONE} -- Implementation

	make is
		do
			create assemblies_list.make
			create object_files_list.make
			create include_paths_list.make
		end
		

feature -- Access

	assemblies: IMPORTED_ASSEMBLIES_ENUMERATOR is
			-- retieve tje list of assemblies
		do
		end

	object_files: IMPORTED_ASSEMBLIES_ENUMERATOR is
			-- retieve tje list of assemblies
		do
		end
		
	include_paths: IMPORTED_ASSEMBLIES_ENUMERATOR is
			-- retieve tje list of assemblies
		do
		end
		
feature {NONE} -- Access

	externals (external_name: STRING): ARRAYED_LIST [STRING] is
			-- retieve a list of externals by name
		do
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	add_assembly (assembly_name: STRING) is
			-- adds and assembly to the list of assemblies
		require
			valid_name: assembly_name /= Void
			non_empty_name: assembly_name.count > 0
		do
			
		ensure
			added: assemblies_list.has (assembly_name)
		end
		
	remove_assembly (assembly_name: STRING) is
			-- removes and assembly from the list of assemblies
		require
			valid_name: assembly_name /= Void
			non_empty_name: assembly_name.count > 0
		do
		ensure
			added: not assemblies_list.has (assembly_name)
		end
		
	add_object_file (object_file: STRING) is
			-- adds and object file to the list of object files
		require
			valid_name: object_file /= Void
			non_empty_name: object_file.count > 0
		do
			
		ensure
			added: object_files_list.has (object_file)
		end
		
	remove_object_file (object_file: STRING) is
			-- removes and object file from the list of object files
		require
			valid_name: object_file /= Void
			non_empty_name: object_file.count > 0
		do
		ensure
			added: not object_files_list.has (object_file)
		end
		
	add_include_path (include_path: STRING) is
			-- adds and include path to the list of include paths 
		require
			valid_name: include_path /= Void
			non_empty_name: include_path.count > 0
		do
			
		ensure
			added: include_paths_list.has (assembly_name)
		end
		
	remove_assembly (include_path: STRING) is
			-- removes and include path from the list of include paths
		require
			valid_name: include_path /= Void
			non_empty_name: include_path.count > 0
		do
		ensure
			added: not include_paths_list.has (assembly_name)
		end
		
		

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE}

	assemblies_list: LINKED_LIST [STRING]
	object_files_list: LINKED_LIST [STRING]
	include_paths_list: LINKED_LIST [STRING]

invariant
	invariant_clause: True -- Your invariant here

end -- class EXTERNAL_PROPERTIES
