indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAY_RESOURCE_TYPE

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

	xml_name: STRING is "LIST_STRING"
			-- String that represents this type in XML representations.

	registry_name: STRING is "EIFARR"
			-- String that represents this type in registry keys.

feature -- Basic operations

	load_resource (name, value: STRING): ARRAY_RESOURCE is
			-- Take a string representation and create the associated resource.
		do
			if value /= Void then
				create Result.make_from_string (name, value, Current)
			else
				create Result.make_from_string (name, "", Current)
			end
		end

end -- class ARRAY_RESOURCE_TYPE
