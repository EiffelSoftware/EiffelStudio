indexing
	description: "Registry settings key paths and names"
	date: "$Date$"
	revision: "$Revision$"

class
	NM_REGISTRY_KEYS

feature -- Access

	Saved_settings_key: STRING is "Software\ISE\Name Mapper"
			-- Path to key containing saved information

	Assemblies_key_name: STRING is "Assemblies"
			-- Name of key containing saved information


end -- class NM_REGISTRY_KEYS
