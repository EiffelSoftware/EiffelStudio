indexing
	description: "Eiffel Codedom Provider registry key entries"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_REGISTRY_KEYS

feature -- Access

	Configurations_key: STRING is "Software\ISE\EiffelCodeDomProvider\Configs"
			-- Key holding configuration path values
	
	Setup_key: STRING is "Software\ISE\EiffelCodeDomProvider\Setup"
			-- Key holding installation path value
	
	Installation_dir_value: STRING is "InstallDir"
			-- Name of string value that holds installation path
			-- This value is found under the setup key

end -- class ECDP_REGISTRY_KEYS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
