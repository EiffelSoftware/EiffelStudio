indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.DialogDictionary"

class
	DIALOG_DICTIONARY

inherit
	DICTIONARY
	
feature -- Access

	Assembly_descriptor_text (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is 
			-- Text representing `a_descriptor'.
		indexing
			external_name: "AssemblyDescriptorText"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			non_void_assembly_name: a_descriptor.name /= Void
			not_empty_assembly_name: a_descriptor.name.Length > 0
		once
			Result := Name_string
			Result := Result.concat_string_string_string (Result, Comma_separator, description (a_descriptor))	
		ensure
			text_created: Result /= Void
			not_empty_text: Result.length > 0
		end
		
--	Bold_style: INTEGER is 1
--			-- Bold style
--		indexing
--			external_name: "BoldStyle"
--		end

	Comma_separator: STRING is ", "
			-- Comma separator
		indexing
			external_name: "CommaSeparator"
		end
		
	Culture_string: STRING is "Culture: " 
			-- Assembly culture label
		indexing
			external_name: "CultureString"
		end

	Description (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is 
			-- Text representing `a_descriptor' (without assembly name).
		indexing
			external_name: "Descripton"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
			non_void_assembly_name: a_descriptor.name /= Void
			not_empty_assembly_name: a_descriptor.name.Length > 0
		once
			create Result.make_2 ('%U', 0)
			if a_descriptor.version /= Void and then a_descriptor.version.Length > 0 then
				Result := Result.concat_string_string_string (Result, Version_string, a_descriptor.version)
			end
			if a_descriptor.culture /= Void and then a_descriptor.culture.Length > 0 then
				Result := Result.concat_string_string_string_string (Result, Comma_separator, Culture_string, a_descriptor.culture)
			end
			if a_descriptor.publickey /= Void and then a_descriptor.publickey.Length > 0 then
				Result := Result.concat_string_string_string_string (Result, Comma_separator, Public_key_string, a_descriptor.publickey)
			end		
		ensure
			text_created: Result /= Void
			not_empty_text: Result.length > 0
		end
		
	Name_string: STRING is "Name: " 
			-- Assembly name label
		indexing
			external_name: "NameString"
		end
		
	Public_key_string: STRING is "Public Key: " 
			-- Assembly public key label
		indexing
			external_name: "PublicKeyString"
		end

	Version_string: STRING is "Version: " 
			-- Assembly version label
		indexing
			external_name: "VersionString"
		end
		
end -- class DIALOG_DICTIONARY