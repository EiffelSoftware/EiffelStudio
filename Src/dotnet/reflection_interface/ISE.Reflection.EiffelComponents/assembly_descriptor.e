indexing
	description: "Assembly descriptor: version, culture and public key"
	external_name: "ISE.Reflection.AssemblyDescriptor"

class
	ASSEMBLY_DESCRIPTOR

create 
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_version: like version; a_culture: like culture; a_public_key: like public_key) is
			-- Set `name' with `a_name'.
			-- Set `version' with `a_version'.
			-- Set `culture' with `a_culture'.
			-- Set `public_key' with `a_public_key'.
		indexing
			external_name: "Make"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.Length > 0
			non_void_version: a_version /= Void
			not_empty_version: a_version.Length > 0
			non_void_culture: a_culture /= Void
			not_empty_culture: a_culture.Length > 0			
			non_void_public_key: a_public_key /= Void
			not_empty_public_key: a_public_key.Length > 0
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

feature -- Access

	name: STRING 
			-- Assembly name
		indexing
			external_name: "Name"
		end
		
	version: STRING
			-- Assembly version
		indexing
			external_name: "Version"
		end

	culture: STRING
			-- Assembly culture
		indexing
			external_name: "Culture"
		end

	public_key: STRING
			-- Assembly public key
		indexing
			external_name: "PublicKey"
		end

invariant
	non_void_name: name /= Void
	not_empty_name: name.Length > 0
	non_void_version: version /= Void
	not_empty_version: version.Length > 0
	non_void_culture: culture /= Void
	not_empty_culture: culture.Length > 0			
	non_void_public_key: public_key /= Void
	not_empty_public_key: public_key.Length > 0

end -- class ASSEMBLY_DESCRIPTOR