indexing
	description: "Keys used to store initialization values"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDS_REGISTRY_KEYS

feature -- Access

	Serializer_hive_path: STRING is "Software\ISE\Eiffel Codedom Provider\Serializer"
			-- Key containing serializer information

	Start_destination_folder_path_key: STRING is "StartDestinationFolder"
			-- Key containing default destination folder

	Wsdl_start_directory_key: STRING is "WSDLStartDirectory"
			-- Key containing default WSDL file folder

	Last_file_title_key: STRING is "LastFileTitle"
			-- Key containing last serialized file title

	Last_wsdl_url_key: STRING is "LastWSDLURL"
			-- Last wsdl URL

	Last_aspnet_url_key: STRING is "LastASPNETURL"
			-- Last ASP.NET URL

	X_key: STRING is "StartingX"
			-- Key containing default x

	Y_key: STRING is "StartingY"
			-- Key containing default y

end -- class ECDS_REGISTRY_KEYS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Serializer
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
