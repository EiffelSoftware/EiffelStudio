indexing
	description: "Information on an assembly in Ace file"
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_PROPERTIES
	
inherit
	IEIFFEL_ASSEMBLY_PROPERTIES_IMPL_STUB
		redefine
 			is_local,
			is_signed,
			assembly_prefix,
			assembly_identifier,
			assembly_name,
			assembly_version,
			assembly_culture,
			assembly_public_key,
			assembly_path,
			set_assembly_prefix,
			set_assembly_path
		end
			
	
create
	make_signed,
	make_local_signed,
	make_local
	
feature {NONE} -- initalization

	make_signed (a_prefix, a_identifier, a_name, a_version, a_culture, a_public_key: STRING) is
			-- create a new instance 
		do
			set_assembly_prefix(a_prefix)
			set_assembly_identifier(a_identifier)
			
			assembly_name := a_name.clone(a_name)
			assembly_version := a_version.clone(a_version)
			assembly_culture := a_culture.clone(a_culture)
			assembly_public_key := a_public_key.clone(a_public_key)
			assembly_path := ""
			
			is_local := false
			is_signed := true
		end
		
	make_local_signed (a_prefix, a_identifier, a_path, a_version, a_culture, a_public_key: STRING) is
			-- create a new instance 
		do
			set_assembly_prefix(a_prefix)
			set_assembly_identifier(a_identifier)

			assembly_name := ""
			assembly_version := a_version.clone(a_version)
			assembly_culture := a_culture.clone(a_culture)
			assembly_public_key := a_public_key.clone(a_public_key)
			assembly_path := a_path.clone(a_path)
			
			is_local := true
			is_signed := true
		end
		
	make_local (a_prefix, a_identifier, a_path: STRING) is
			-- create a new instance
		do
			set_assembly_prefix(a_prefix)
			set_assembly_identifier(a_identifier)
			
			assembly_name := ""
			assembly_version := ""
			assembly_culture := ""
			assembly_public_key := ""
			assembly_path := a_path.clone(a_path)
			
			is_local := true
			is_signed := false
		end
		
feature -- Status setting

	set_assembly_identifier (identifier: STRING) is
			-- set the assemblies identifier name
		require else
			non_void_identifier: identifier /= Void
			valid_identifier: not identifier.is_empty
		do
			assembly_identifier := identifier.clone(identifier)
		end
		
	set_assembly_prefix (a_prefix: STRING) is
			-- set the assembly prefix
		do
			assembly_prefix := a_prefix.clone(a_prefix)
			assembly_prefix.to_upper
		end
		
	set_assembly_path (a_path: STRING) is
			-- set the assembly path
		do
			assembly_path := a_path.clone(a_path)
		end
		

feature -- Access

	assembly_prefix: STRING
	assembly_identifier: STRING
	assembly_name: STRING
	assembly_version: STRING
	assembly_culture: STRING
	assembly_public_key: STRING
	
	assembly_path: STRING
	
	is_local: BOOLEAN
	is_signed: BOOLEAN
	
end -- class ASSEMBLY_PROPERTIES
