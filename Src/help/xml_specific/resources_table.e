indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCES_TABLE

inherit
	HASH_TABLE[RESOURCE,STRING]
		
creation

	make

feature -- Access

	get_value(s: STRING): ANY is
			-- Used for font, color, and array.
		do
			if has(s) then
				Result := item(s).get_value
			else
				io.put_string("%NValue of ")
				io.put_string(s)
				io.put_string(" not supplied, default applied.")
			end
		end

end -- class RESOURCES_TABLE
