indexing
	description: "eSplitter registry hive location"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ES_REGISTRY_KEYS

feature -- Access

	Saved_settings_key: STRING is "Software\ISE\eSplitter"
			-- Key holding graphical interface settings values

end -- class CODE_ES_REGISTRY_KEYS

--+--------------------------------------------------------------------
--| eSplitter
--| Copyright (C) Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------