indexing
	description: "Graphical settings for Name Mapper"
	date: "$Date$"
	revision: "$Revision$"

class
	NM_SAVED_SETTINGS

inherit
	NM_REGISTRY_KEYS
		export
			{NONE} all
		end

	CODE_GRAPHICAL_SETTINGS_MANAGER
		rename
			make as settings_make
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `registry_path'.
		do
			settings_make (Saved_settings_key)
			Default_values.put (500, Height_key)
			Default_values.put (500, Width_key)
		end
		
feature -- Access

	saved_types: LIST [STRING] is
			-- List of saved types for input types combo
		do
			Result := saved_list (Types_key)
		end

feature {NONE} -- Private Access

	Types_key: STRING is "types_key"
			-- Types key name

end -- class NM_SAVED_SETTINGS

--+--------------------------------------------------------------------
--| Name Mapper
--| Copyright (C) Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------