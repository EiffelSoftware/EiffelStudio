indexing
	description: "Dispinterface"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	EOLE_DISPINTERFACE

inherit
	EOLE_DISPATCH
		redefine 
			interface_identifier_list
		end
	EOLE_SERVER_CONFIGURATION

	WEL_MAIN_ARGUMENTS
		export
			{NONE} all
		end

creation
	make

feature -- Access

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := Precursor
			Result.extend (dispinterface_id)
		end

end -- class EOLE_DISPINTERFACE
