note
	description: "JSON user converter."
	author: "Olivier Ligot"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_USER_CONVERTER

inherit
	JSON_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		do
			create object.make (0, "", "")
		end

feature	 -- Access

	 object: USER

	 value: detachable JSON_OBJECT

feature -- Conversion

	from_json (j: attached like value): detachable like object
            -- Convert from JSON value.
        do
	    end

    to_json (o: like object): like value
            -- Convert to JSON value.
        do
        	create Result.make
            Result.put (json.value (o.id), id_key)
            Result.put (json.value (o.name), name_key)
        end

 feature {NONE} -- Implementation

	id_key: STRING = "id"
	name_key: STRING = "name"

note
	copyright: "2011-2012, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
