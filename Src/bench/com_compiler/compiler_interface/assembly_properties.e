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
			assembly_identifier,
			assembly_name,
			assembly_version,
			assembly_culture,
			assembly_public_key,
			assembly_path
		end
			
	
create
	make,
	make_local
	
feature {NONE} -- initalization

	make (a_identifier, a_name, a_version, a_culture, a_public_key: STRING) is
			-- create a new instance
		do
			assembly_identifier := a_identifier
			assembly_name := a_name
			assembly_version := a_version
			assembly_culture := a_culture
			assembly_public_key := a_public_key
			
			is_local := false
		end
		
	make_local (a_identifier, a_path: STRING) is
			-- create a new instance
		do
			assembly_identifier := a_identifier
			assembly_path := a_path
			
			is_local := true
		end
		
feature -- Status setting

	set_identifier (identifier: STRING) is
			-- set the assemblies identifier name
		require
			non_void_identifier: identifier /= Void
			valid_identifier: not identifier.is_empty
		do
			assembly_identifier := identifier
		end

feature -- Access

	assembly_identifier: STRING
	assembly_name: STRING
	assembly_version: STRING
	assembly_culture: STRING
	assembly_public_key: STRING
	
	assembly_path: STRING
	
	is_local: BOOLEAN
	
end -- class ASSEMBLY_PROPERTIES
