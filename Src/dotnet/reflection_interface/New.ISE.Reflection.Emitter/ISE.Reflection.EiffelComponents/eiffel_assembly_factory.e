indexing
	description: "Include all the information needed to generate xml assembly description file"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

class 
	EIFFEL_ASSEMBLY_FACTORY
		
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize `types'."
		do
		end

feature -- Access

	assembly_name: STRING
		indexing
			description: "Assembly name"
		end
		
	assembly_version: STRING	
		indexing
			description: "Assembly version"
		end
	
	assembly_culture: STRING
		indexing
			description: "Assembly culture"
		end
		
	assembly_public_key: STRING
		indexing
			description: "Assembly public key"
		end
		
	eiffel_cluster_path: STRING
		indexing
			description: "Path to cluster where Eiffel classes will be generated"
		end
		
	emitter_version_number: STRING
		indexing	
			description: "Emitter version number"
		end
		
feature -- Status Setting

	set_assembly_name (a_name: like assembly_name) is
		indexing
			description: "Set `assembly_name' with `a_name'."
		require
			non_void_assembly_name: a_name /= Void
			not_empty_assembly_name: a_name.count > 0
		do
			assembly_name := a_name
		ensure
			assembly_name_set: assembly_name.is_equal (a_name)
		end
	
	set_assembly_version (a_version: like assembly_version) is
		indexing
			description: "Set `assembly_version' with `a_version'."
		require
			non_void_assembly_version: a_version /= Void
			not_empty_assembly_version: a_version.count > 0
		do
			assembly_version := a_version
		ensure
			assembly_version_set: assembly_version.is_equal (a_version)
		end
		
	set_assembly_culture (a_culture: like assembly_culture) is
		indexing
			description: "Set `assembly_culture' with `a_culture'."
		require
			non_void_assembly_culture: a_culture /= Void
			not_empty_assembly_culture: a_culture.count > 0
		do
			assembly_culture := a_culture
		ensure
			assembly_culture_set: assembly_culture.is_equal (a_culture)
		end
		
	set_assembly_public_key (a_public_key: like assembly_public_key) is
		indexing
			description: "Set `assembly_public_key' with `a_public_key'."
		require
			non_void_assembly_public_key: a_public_key /= Void
			not_empty_assembly_public_key: a_public_key.count > 0
		do
			assembly_public_key := a_public_key
		ensure
			assembly_public_key_set: assembly_public_key.is_equal (a_public_key)
		end
		
	set_eiffel_cluster_path (a_path: like eiffel_cluster_path) is
		indexing
			description: "Set `eiffel_cluster_path' with `a_path'."
		require
			non_void_eiffel_cluster_path: a_path /= Void
			not_empty_eiffel_cluster_path: a_path.count > 0
		do
			eiffel_cluster_path := a_path
		ensure
			eiffel_cluster_path_set: eiffel_cluster_path.is_equal (a_path)
		end

	set_emitter_version_number (a_value: like emitter_version_number) is
		indexing
			description: "Set `emitter_version_number' with `a_value'."
		require
			non_void_emitter_version_number: a_value /= Void
			not_empty_emitter_version_number: a_value.count > 0
		do
			emitter_version_number := a_value
		ensure
			emitter_version_number_set: emitter_version_number.is_equal (a_value)
		end

end -- class EIFFEL_ASSEMBLY_FACTORY
