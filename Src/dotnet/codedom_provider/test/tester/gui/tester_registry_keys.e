indexing
	description: "Keys that hold graphical settings saved in between sessions."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_REGISTRY_KEYS

feature -- Access

	Tester_hive_path: STRING is "Software\ISE\Eiffel Codedom Provider\Tester"
			-- Key containing serializer information

	Codedom_provider_key: STRING is "CodedomProvider"
			-- Key containing default codedom provider

	Generated_file_folder_key: STRING is "GeneratedFileFolder"
			-- Key containing generated file folder

	Saved_serialized_folder_key: STRING is "SavedSerializedFileFolder"
			-- Key containing serialized file folder

	X_key: STRING is "X"
			-- Key containing default x

	Y_key: STRING is "Y"
			-- Key containing default y

	Width_key: STRING is "Width"
			-- Key containing default width
			
	Height_key: STRING is "Height"
			-- Key containing default Height

end -- class TESTER_REGISTRY_KEYS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------