indexing
	description	: "Objects that map a networking path to a local drive (Dead version for Unix)"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	UNC_PATH_MAPPER

create
	make

feature {NONE} -- Initialization

	make (a_path: STRING) is
			-- Map the networking path `a_path' to a temporary path
		do
		end
		
feature -- Access
	
	access_name: STRING
			-- Local access to the mapped path.
			-- Example: "I:"
		
feature -- Removal
	
	destroy is
			-- Unmap the network path
		do
		end
	
end -- class UNC_PATH_MAPPER
