indexing
	description: "Assembly descriptor: version, culture and public key"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

class
	ASSEMBLY_DESCRIPTOR

inherit
	ANY
		redefine
			get_hash_code
		end	
	HASHABLE
		rename
			hash_code as get_hash_code
		redefine
			get_hash_code
		end

create 
	make,
	make_empty,
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
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.count > 0
			non_void_version: a_version /= Void
			not_empty_version: a_version.count > 0
			non_void_culture: a_culture /= Void
			not_empty_culture: a_culture.count > 0			
			non_void_public_key: a_public_key /= Void
			not_empty_public_key: a_public_key.count > 0
		do
			name := a_name
			version := a_version
			culture := a_culture
			public_key := a_public_key
		ensure
			name_set: name.is_equal ( a_name )
			version_set: version.is_equal ( a_version )
			culture_set: culture.is_equal ( a_culture )
			public_key_set: public_key.is_equal ( a_public_key )
		end

	make_empty is
		indexing
			description: "Create an empty instace of `ASSEMBLY_DESCRIPTOR'."
		do
			
		end
		

	make_from_assembly (a_dot_net_assembly: ASSEMBLY) is
		indexing
			description: "Create an instance of `ASSEMBLY_DESCRIPTOR' from `a_dot_net_assembly'."
		require
			non_void_assembly: a_dot_net_assembly /= Void
			non_void_assembly_name: a_dot_net_assembly.get_name /= Void
			non_void_name: a_dot_net_assembly.get_name.get_name /= Void
			non_void_version: a_dot_net_assembly.get_name.get_version /= Void
			non_void_public_key: a_dot_net_assembly.get_name.get_public_key_token /= Void
		local
			an_assembly_name: ASSEMBLY_NAME
			convert: ASSEMBLY_NAME_DECODER
			assembly_info: ARRAY [STRING]
			retried: BOOLEAN
		do
			an_assembly_name := a_dot_net_assembly.get_name 
			create convert
			if not retried then
				assembly_info := convert.assembly_info_from_name ( an_assembly_name )
				if assembly_info /= Void and then assembly_info.count = 4 then
					make ( assembly_info.item ( 0 ), assembly_info.item ( 1 ), assembly_info.item ( 2 ), assembly_info.item ( 3 ) )
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
		end
		
	version: STRING
		indexing
			description: "Assembly version"
		end

	culture: STRING
		indexing
			description: "Assembly culture"
		end

	public_key: STRING
		indexing
			description: "Assembly public key"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		indexing
			description: "Hash code for an assembly descriptor"
		local
			string_to_code: STRING
		do
			string_to_code ?= name.clone ( name )
			string_to_code.append ( string_to_code )
			string_to_code.append ( version )
			string_to_code.append ( culture )
			string_to_code.append ( public_key )
			Result := string_to_code.hash_code
		end
		

invariant
	non_void_name: name /= Void
	not_empty_name: name.count > 0
	non_void_version: version /= Void
	not_empty_version: version.count > 0
	non_void_culture: culture /= Void
	not_empty_culture: culture.count > 0			
	non_void_public_key: public_key /= Void
	not_empty_public_key: public_key.count > 0

end -- class ASSEMBLY_DESCRIPTOR
