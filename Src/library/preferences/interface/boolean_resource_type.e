indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOOLEAN_RESOURCE_TYPE

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

	xml_name: STRING is "BOOLEAN"
			-- String that represents this type in XML representations.

	registry_name: STRING is "EIFBOL"
			-- String that represents this type in registry keys.

feature -- Basic operations

	load_resource (name, value: STRING): BOOLEAN_RESOURCE is
			-- Take a string representation and create the associated resource.
		do
			if value /= Void and then value.is_boolean then
				create Result.make (name, value.to_boolean, Current)
			end
		end

end -- class BOOLEAN_RESOURCE_TYPE
