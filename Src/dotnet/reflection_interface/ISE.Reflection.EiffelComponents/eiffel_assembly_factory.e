indexing
	description: "Include all the information needed to generate xml assembly description file"
	external_name: "ISE.Reflection.EiffelAssemblyFactory"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class 
	EIFFEL_ASSEMBLY_FACTORY
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `types'.
		indexing
			external_name: "Make"
		do
			create types.make
		ensure
			non_void_types: types /= Void
		end

feature -- Access

	assembly_name: STRING
			-- Assembly name
		indexing
			external_name: "AssemblyName"
		end
		
	assembly_version: STRING	
			-- Assembly version
		indexing
			external_name: "AssemblyVersion"
		end
	
	assembly_culture: STRING
			-- Assembly culture
		indexing
			external_name: "AssemblyCulture"
		end
		
	assembly_public_key: STRING
			-- Assembly public key
		indexing
			external_name: "AssemblyPublicKey"
		end
		
	eiffel_cluster_path: STRING
			-- Path to cluster where Eiffel classes will be generated
		indexing
			external_name: "EiffelClusterPath"
		end
		
	emitter_version_number: STRING
			-- Emitter version number
		indexing
			external_name: "EmitterVersionNumber"
		end
	
	types: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Assembly types
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_CLASS]
		indexing
			external_name: "Types"
		end
		
feature -- Status Setting

	set_assembly_name (a_name: like assembly_name) is
			-- Set `assembly_name' with `a_name'.
		indexing
			external_name: "SetAssemblyName"
		require
			non_void_assembly_name: a_name /= Void
			not_empty_assembly_name: a_name.Length > 0
		do
			assembly_name := a_name
		ensure
			assembly_name_set: assembly_name.Equals_String (a_name)
		end
	
	set_assembly_version (a_version: like assembly_version) is
			-- Set `assembly_version' with `a_version'.
		indexing
			external_name: "SetAssemblyVersion"
		require
			non_void_assembly_version: a_version /= Void
			not_empty_assembly_version: a_version.Length > 0
		do
			assembly_version := a_version
		ensure
			assembly_version_set: assembly_version.Equals_String (a_version)
		end
		
	set_assembly_culture (a_culture: like assembly_culture) is
			-- Set `assembly_culture' with `a_culture'.
		indexing
			external_name: "SetAssemblyCulture"
		require
			non_void_assembly_culture: a_culture /= Void
			not_empty_assembly_culture: a_culture.Length > 0
		do
			assembly_culture := a_culture
		ensure
			assembly_culture_set: assembly_culture.Equals_String (a_culture)
		end
		
	set_assembly_public_key (a_public_key: like assembly_public_key) is
			-- Set `assembly_public_key' with `a_public_key'.
		indexing
			external_name: "SetAssemblyPublicKey"
		require
			non_void_assembly_public_key: a_public_key /= Void
			not_empty_assembly_public_key: a_public_key.Length > 0
		do
			assembly_public_key := a_public_key
		ensure
			assembly_public_key_set: assembly_public_key.Equals_String (a_public_key)
		end
		
	set_eiffel_cluster_path (a_path: like eiffel_cluster_path) is
			-- Set `eiffel_cluster_path' with `a_path'.
		indexing
			external_name: "SetEiffelClusterPath"
		require
			non_void_eiffel_cluster_path: a_path /= Void
			not_empty_eiffel_cluster_path: a_path.Length > 0
		do
			eiffel_cluster_path := a_path
		ensure
			eiffel_cluster_path_set: eiffel_cluster_path.Equals_String (a_path)
		end

	set_emitter_version_number (a_value: like emitter_version_number) is
			-- Set `emitter_version_number' with `a_value'.
		indexing
			external_name: "SetEmitterVersionNumber"
		require
			non_void_emitter_version_number: a_value /= Void
			not_empty_emitter_version_number: a_value.Length > 0
		do
			emitter_version_number := a_value
		ensure
			emitter_version_number_set: emitter_version_number.Equals_String (a_value)
		end

feature -- Basic Operations

	add_type (a_type: EIFFEL_CLASS) is
			-- Add `a_type' to `types'.
		indexing
			external_name: "AddType"
		require
			non_void_type: a_type /= Void
		local
			added: INTEGER
		do
			added := types.Add (a_type)
		ensure
			type_added: types.Contains (a_type)
		end

invariant
	non_void_types: types /= Void
	
end -- class EIFFEL_ASSEMBLY_FACTORY
