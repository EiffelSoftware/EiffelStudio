indexing
	description: "Type of basic integer resources."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_RESOURCE_TYPE

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

	xml_name: STRING is "INTEGER"
			-- String that represents this type in XML representations.

	registry_name: STRING is "EIFINT"
			-- String that represents this type in registry keys.

feature -- Basic operations

	load_resource (name, value: STRING): INTEGER_RESOURCE is
			-- Take a string representation and create the associated resource.
		do
			if value /= Void and then value.is_integer then
				create Result.make (name, value.to_integer, Current)
			end
		end

end -- class INTEGER_RESOURCE_TYPE
