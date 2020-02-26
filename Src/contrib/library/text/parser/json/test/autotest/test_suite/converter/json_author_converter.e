note
	description: "A JSON converter for AUTHOR"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_AUTHOR_CONVERTER

inherit

	JSON_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		local
			ucs: STRING_32
		do
			create ucs.make_from_string ("")
			create object.make (ucs)
		end

feature -- Access

	object: AUTHOR

feature -- Conversion

	from_json (j: like to_json): detachable like object
		do
			if attached {STRING_32} json.object (j.item (name_key), Void) as l_name then
				create Result.make (l_name)
			end
		end

	to_json (o: like object): JSON_OBJECT
		do
			create Result.make
			Result.put (json.value (o.name), name_key)
		end

feature {NONE} -- Implementation

	name_key: JSON_STRING
			-- Author's name label.
		once
			create Result.make_from_string ("name")
		end

end -- class JSON_AUTHOR_CONVERTER
