note
	description: "Summary description for RIBBON."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	RIBBON

inherit
	ER_RIBBON

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create_interface_objects
		end

	create_interface_objects
			-- Create objects
		do
$TAB_CREATION
			create tabs.make (1)
$TAB_REGISTRY
		end

feature -- Query
$TAB_DECLARATION

end
