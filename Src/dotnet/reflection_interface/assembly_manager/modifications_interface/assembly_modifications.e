indexing
	description: "Assembly modifications"
	external_name: "ISE.AssemblyManager.AssemblyModifications"

class
	ASSEMBLY_MODIFICATIONS
	
create
	make,
	make_from_info

feature {NONE} -- Initialization

	make is
			-- Initialize `type_modifications'.
		indexing
			external_name: "TypeModifications"
		do
			create types_modifications.make
		ensure
			non_void_types_modifications: types_modifications /= Void
		end
	
	make_from_info (a_descriptor: like assembly_descriptor) is
			-- Set `assembly_descriptor' with `a_descriptor'.
			-- Initialize `type_modifications'.
		indexing
			external_name: "MakeFromInfo"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		do
			set_assembly_descriptor (a_descriptor)
			create types_modifications.make
		ensure
			assembly_descriptor_set: assembly_descriptor = a_descriptor
			non_void_type_modifications: types_modifications /= Void
		end
	
feature -- Access

	assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			-- Assembly descriptor
		indexing
			external_name: "AssemblyDescriptor"
		end

	types_modifications: SYSTEM_COLLECTIONS_HASHTABLE
			-- Types modifications
			-- | Key: Type .NET fullname
			-- | Value: Instance of `TYPE_MODIFICATIONS'
		indexing
			external_name: "TypesModifications"
		end

feature -- Status Setting

	set_assembly_descriptor (a_descriptor: like assembly_descriptor) is
			-- Set `assembly_descriptor' with `a_descriptor'.
		indexing
			external_name: "SetAssemblyDescriptor"
		require
			non_void_descriptor: a_descriptor /= Void
		do
			assembly_descriptor := a_descriptor
		ensure
			assembly_descriptor_set: assembly_descriptor = a_descriptor
		end

feature -- Basic Operations

	add_type_modification (a_type_fullname: STRING; a_type_modification: TYPE_MODIFICATIONS) is
			-- Add `a_type_modification' to `types_modifications' with key `a_type_fullname'.
			-- If `a_type_fullname' already exists, the existing value will be replaced by `a_type_modification'.
		indexing
			external_name: "AddTypeModification"
		require
			non_void_type_modification: a_type_modification /= Void
		do
			if not types_modifications.containskey (a_type_fullname) then
				types_modifications.add (a_type_fullname, a_type_modification)
			else
				types_modifications.remove (a_type_fullname)
				types_modifications.add (a_type_fullname, a_type_modification)
			end
		ensure
			type_modification_added: types_modifications.containsvalue (a_type_modification)
		end
	
invariant
	non_void_types_modifications: types_modifications /= Void

end -- class ASSEMBLY_MODIFICATIONS