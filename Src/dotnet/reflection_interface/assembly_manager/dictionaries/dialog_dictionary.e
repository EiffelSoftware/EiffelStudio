indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.DialogDictionary"

class
	DIALOG_DICTIONARY

inherit
	DICTIONARY
	
feature -- Access

	Comma_separator: STRING is ", "
		indexing
			description: "Comma separator"
			external_name: "CommaSeparator"
		end
		
	Culture_string: STRING is "Culture: " 
		indexing
			description: "Assembly culture label"
			external_name: "CultureString"
		end
		
	Public_key_string: STRING is "Public Key: " 
		indexing
			description: "Assembly public key label"
			external_name: "PublicKeyString"
		end

	Version_string: STRING is "Version: " 
		indexing
			description: "Assembly version label"
			external_name: "VersionString"
		end
		
end -- class DIALOG_DICTIONARY