indexing
	description: "Information on an assembly in Ace file"
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_PROPERTIES
	
inherit
	LACE_AST_FACTORY
		export
			{NONE} all
		end
	
	IEIFFEL_ASSEMBLY_PROPERTIES_IMPL_STUB
		redefine
 			is_local,
			is_signed,
			assembly_prefix,
			assembly_name,
			assembly_version,
			assembly_culture,
			assembly_cluster_name,
			assembly_public_key_token,
			set_assembly_prefix
		end
			
	
create
	make,
	make_with_assembly_sd
	
feature {NONE} -- initalization

	make (a_cluster_name, a_assembly_name, a_prefix, a_version, a_culture, a_public_key_token: STRING) is
			-- create a new instance 
		local
			asm_cluster_name: ID_SD
			asm_name: ID_SD
			asm_version: ID_SD
			asm_culture: ID_SD
			asm_public_key_token: ID_SD
			asm_prefix: ID_SD
		do
			asm_prefix := new_id_sd(a_prefix, false);
			asm_cluster_name := new_id_sd(a_cluster_name, false)
			asm_name := new_id_sd(a_assembly_name, true)
			
			if a_version /= Void and a_version.count > 0 then
				asm_version := new_id_sd(a_version, true)
			end
			if a_culture /= Void and a_culture.count > 0 then
				asm_culture := new_id_sd(a_culture, true)	
			end
			if a_public_key_token /= Void and a_public_key_token.count > 0 then
				asm_public_key_token := new_id_sd(a_public_key_token, true)	
			end
			
			create assembly_sd.initialize (asm_cluster_name, asm_name, asm_prefix, asm_version, asm_culture, asm_public_key_token)
			set_assembly_type
		end
		
	make_with_assembly_sd (a_assembly: ASSEMBLY_SD) is
			-- Make with ASSEMBLY_SD and ACE_FILE_ACCESSER.
		require
			non_void_assembly: a_assembly /= Void
		do
			assembly_sd := a_assembly
			set_assembly_type
		ensure
			non_void_assembly_sd: assembly_sd /= Void
		end
		
	set_assembly_type is
			-- set the is_signed and is_local features corresponding to the acutal the assembly declaration
		local
			assembly_name_copy: STRING
		do
			-- if 'a_public_key' is Void then the assembly is not signed
			if assembly_public_key_token = Void or assembly_public_key_token.count = 0 then
				is_signed := false
				is_local := true
			else
				if (assembly_name.count > 5) then
					assembly_name_copy := assembly_name.clone(assembly_name)
					assembly_name_copy.to_lower
					
					-- if the assembly name ends in either a .dll or .exe then it is a local assembly					
					if assembly_name_copy.substring_index(".dll", assembly_name_copy.count - 4) > 0 then
						is_local := true
					else
						if assembly_name_copy.substring_index(".exe", assembly_name_copy.count - 4) > 0 then
							is_local := true
						else
							is_local := false
							is_signed := true
						end
					end
				end
			end
		end
		
feature -- Status setting

	set_assembly_prefix (a_prefix: STRING) is
			-- set the assembly prefix
		local
			asm_prefix: ID_SD
		do
			asm_prefix := new_id_sd(a_prefix.clone(a_prefix), FALSE)
			asm_prefix.to_upper
		end
		
feature -- Access

	assembly_prefix: STRING is
			-- the prefix assigned to all classes in the system
		local
			a_prefix: ID_SD
		do
			a_prefix := assembly_sd.prefix_name
			if a_prefix = Void then
				Result := ""
			else
				Result := a_prefix
			end
		end
		
	assembly_cluster_name: STRING is
			-- the cluster name for the assembly
		do
			Result := assembly_sd.cluster_name
		end
		
	assembly_name: STRING is
				-- the name/path for the assembly
		do
			Result := assembly_sd.assembly_name
		end
		
	assembly_version: STRING is
				-- the version for the assembly
		do
			Result := assembly_sd.version
		end
		
	assembly_culture: STRING is
			-- the culture for the assembly
		do
			Result := assembly_sd.culture
		end
		
	assembly_public_key_token: STRING is
				-- the public key token of the assembly
		do
			Result := assembly_sd.public_key_token
		end
	
	is_local: BOOLEAN
	is_signed: BOOLEAN
	assembly_sd: ASSEMBLY_SD	
	
end -- class ASSEMBLY_PROPERTIES
