indexing
	description: "Assembly descriptor: version, culture and public key"
	external_name: "ISE.Reflection.AssemblyDescriptor"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	ASSEMBLY_DESCRIPTOR

inherit
	ANY
		redefine
			get_hash_code
		end	

create 
	make,
	make_from_assembly

feature {NONE} -- Initialization

	make (a_name: like name; a_version: like version; a_culture: like culture; a_public_key: like public_key) is
		indexing
			description: "[
						Set `name' with `a_name'.
						Set `version' with `a_version'.
						Set `culture' with `a_culture'.
						Set `public_key' with `a_public_key'.
					  ]"
			external_name: "Make"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.get_length > 0
			non_void_version: a_version /= Void
			not_empty_version: a_version.get_length > 0
			non_void_culture: a_culture /= Void
			not_empty_culture: a_culture.get_length > 0			
			non_void_public_key: a_public_key /= Void
			not_empty_public_key: a_public_key.get_length > 0
		do
			name := a_name
			version := a_version
			culture := a_culture
			public_key := a_public_key
		ensure
			name_set: name.Equals_String (a_name)
			version_set: version.Equals_String (a_version)
			culture_set: culture.Equals_String (a_culture)
			public_key_set: public_key.Equals_String (a_public_key)
		end

	make_from_assembly (a_dot_net_assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		indexing
			description: "Create an instance of `ASSEMBLY_DESCRIPTOR' from `a_dot_net_assembly'."
			external_name: "MakeFromAssembly"
		require
			non_void_assembly: a_dot_net_assembly /= Void
		local
			an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			convert: CONVERT
			assembly_info: ARRAY [STRING]
			retried: BOOLEAN
		do
			an_assembly_name := a_dot_net_assembly.get_name 
			create convert
			if not retried then
				assembly_info := convert.assembly_info_from_name (an_assembly_name)
				if assembly_info /= Void and then assembly_info.count = 4 then
					make (assembly_info.item (0), assembly_info.item (1), assembly_info.item (2), assembly_info.item (3))
				end
			end
		rescue
			retried := True
			retry
		end
		
feature -- Access

	name: STRING 
		indexing
			description: "Assembly name"
			external_name: "Name"
		end
		
	version: STRING
		indexing
			description: "Assembly version"
			external_name: "Version"
		end

	culture: STRING
		indexing
			description: "Assembly culture"
			external_name: "Culture"
		end

	public_key: STRING
		indexing
			description: "Assembly public key"
			external_name: "PublicKey"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		indexing
			description: "Hash code for an assembly descriptor"
			external_name: "GetHashCode"
		local
			string_to_code: STRING
		do
			string_to_code ?= name.clone
			string_to_code := string_to_code.concat_string_string_string_string (string_to_code, version, culture, public_key)
			Result := string_to_code.get_hash_code
		end
		
invariant
	non_void_name: name /= Void
	not_empty_name: name.get_length > 0
	non_void_version: version /= Void
	not_empty_version: version.get_length > 0
	non_void_culture: culture /= Void
	not_empty_culture: culture.get_length > 0			
	non_void_public_key: public_key /= Void
	not_empty_public_key: public_key.get_length > 0

end -- class ASSEMBLY_DESCRIPTOR
