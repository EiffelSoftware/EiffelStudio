indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.DialogDictionary"

class
	DIALOG_DICTIONARY

inherit
	DICTIONARY
	
feature -- Access

	Bold_style: INTEGER is 1
			-- Bold style
		indexing
			external_name: "BoldStyle"
		end
		
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

--	Name_string: STRING is "Name: " 
--			-- Assembly name label
--		indexing
--			external_name: "NameString"
--		end
		
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