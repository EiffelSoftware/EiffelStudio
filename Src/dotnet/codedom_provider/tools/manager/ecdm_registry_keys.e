indexing
	description: "Manager registry hive location"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDM_REGISTRY_KEYS

feature -- Access

	Saved_settings_key: STRING is "Software\ISE\Eiffel Codedom Provider\Manager\Settings"
			-- Key holding graphical interface settings values

end -- class ECDM_REGISTRY_KEYS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Manager
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------