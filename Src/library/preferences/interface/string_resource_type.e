indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_RESOURCE_TYPE

inherit
	RESOURCE_TYPE

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			
		end

feature -- Access

	xml_name: STRING is "STRING"
			-- String that represents this type in XML representations.

	registry_name: STRING is "EIFSTR"
			-- String that represents this type in registry keys.

feature -- Basic operations

	load_resource (name, value: STRING): STRING_RESOURCE is
			-- Take a string representation and create the associated resource.
		do
			if value = Void then
				create Result.make (name, "", Current)
			else
				create Result.make (name, value, Current)
			end
		end

end -- class STRING_RESOURCE_TYPE
