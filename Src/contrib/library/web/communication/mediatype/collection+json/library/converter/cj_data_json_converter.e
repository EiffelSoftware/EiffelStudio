note
	description: "A JSON converter for CJ_DATA"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_DATA_JSON_CONVERTER

inherit
	CJ_JSON_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		do
			create object.make
		end

feature -- Access

	object: CJ_DATA

feature -- Conversion

	from_json (j: like to_json): detachable like object
		do
			create Result.make
			if attached {STRING_32} json_to_object (j.item (name_key), Void) as l_name then
				Result.set_name (l_name)
			end
			if attached {STRING_32} json_to_object (j.item (prompt_key), Void) as l_prompt then
				Result.set_prompt (l_prompt)
			end
			if attached json_to_object (j.item (value_key), Void) as l_value then
				if attached {STRING_32} l_value as l_string then
					Result.set_value (l_string)
				elseif	attached {BOOLEAN} l_value as l_boolean then
					Result.set_value (l_boolean.out)
				end
			end
			--|TODO improve this code
			--|is there a better way to write this?
			--|is a good idea create the Result object at the first line and then set the value
			--|if it is attached?
		end

	to_json (o: like object): JSON_OBJECT
		do
			create Result.make
			Result.put (json.value (o.name), name_key)
			if attached o.prompt as o_prompt then
				Result.put (json.value (o_prompt), prompt_key)
			end
			if attached o.value as o_value then
				Result.put (json.value (o_value), value_key)
			end
		end

feature {NONE} -- Implementation

	prompt_key: JSON_STRING
		once
			create Result.make_from_string ("prompt")
		end

	name_key: JSON_STRING
		once
			create Result.make_from_string ("name")
		end

	value_key: JSON_STRING
		once
			create Result.make_from_string ("value")
		end

note
	copyright: "2011-2017, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end -- class JSON_DATA_CONVERTER
