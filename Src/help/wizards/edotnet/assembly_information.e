indexing
	description: "Assembly information (name, version, culture, public key and path to Eiffel sources)"

class
	ASSEMBLY_INFORMATION

create 
	make,
	make_from_info

feature {NONE} -- Initialization

	make (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			set_name (a_name)
		ensure
			name_set: name.is_equal (a_name)
		end
		
	make_from_info (a_name: like name; a_version: like version; a_culture: like culture; a_public_key: like public_key; a_path: like eiffel_cluster_path) is
			-- Set `name' with `a_name'.
			-- Set `version' with `a_version'.
			-- Set `culture' with `a_culture'.
			-- Set `public_key' with `a_public_key'.
			-- Set `eiffel_cluster_path' with `a_path'.
		require
			non_void_name: a_name /= Void
			non_void_version: a_version /= Void
			non_void_culture: a_culture /= Void
			non_void_public_key: a_public_key /= Void
			non_void_path: a_path /= Void
			not_empty_name: not a_name.is_empty
			not_empty_version: not a_version.is_empty
			not_empty_culture: not a_culture.is_empty
			not_empty_public_key: not a_public_key.is_empty
			not_empty_path: not a_path.is_empty
		do
			set_name (a_name)
			set_version (a_version)
			set_culture (a_culture)
			set_public_key (a_public_key)
			set_path (a_path)
		ensure
			name_set: name.is_equal (a_name)
			version_set: version.is_equal (a_version)
			culture_set: culture.is_equal (a_culture)
			public_key_set: public_key.is_equal (a_public_key)
			eiffel_cluster_path_set: eiffel_cluster_path.is_equal (a_path)
		end
	
feature -- Access

	name: STRING
			-- Assembly name
	
	version: STRING
			-- Assembly version
		
	culture: STRING
			-- Assembly culture
	
	public_key: STRING
			-- Assembly public key
	
	eiffel_cluster_path: STRING
			-- Path to Eiffel sources
			
feature -- Status Report

	valid_assembly: BOOLEAN is
			-- Is assembly valid?
		do
			Result := name /= Void and not name.is_empty and
					version /= Void and not version.is_empty and
					culture /= Void and not culture.is_empty and
					public_key /= Void and not public_key.is_empty	and
					eiffel_cluster_path /= Void and not eiffel_cluster_path.is_empty
		end
		
feature -- Status Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name.is_equal (a_name)
		end

	set_version (a_version: like version) is
			-- Set `version' with `a_version'.
		require
			non_void_version: a_version /= Void
			not_empty_version: not a_version.is_empty
		do
			version := a_version
		ensure
			version_set: version.is_equal (a_version)
		end

	set_culture (a_culture: like culture) is
			-- Set `culture' with `a_culture'.
		require
			non_void_culture: a_culture /= Void
			not_empty_culture: not a_culture.is_empty
		do
			culture := a_culture
		ensure
			culture_set: culture.is_equal (a_culture)
		end

	set_public_key (a_public_key: like public_key) is
			-- Set `public_key' with `a_public_key'.
		require
			non_void_public_key: a_public_key /= Void
			not_empty_public_key: not a_public_key.is_empty
		do
			public_key := a_public_key
		ensure
			public_key_set: public_key.is_equal (a_public_key)
		end

	set_path (a_path: like eiffel_cluster_path) is
			-- Set `eiffel_cluster_path' with `a_public_key'.
		require
			non_void_path: a_path /= Void
			not_empty_path: not a_path.is_empty
		do
			eiffel_cluster_path := a_path
		ensure
			path_set: eiffel_cluster_path.is_equal (a_path)
		end
		
end -- class ASSEMBLY_INFORMATION