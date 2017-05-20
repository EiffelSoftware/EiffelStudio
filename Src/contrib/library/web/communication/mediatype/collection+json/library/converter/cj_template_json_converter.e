note
	description: "Summary description for {JSON_TEMPLATE_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_TEMPLATE_JSON_CONVERTER

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

	object: CJ_TEMPLATE

feature -- Conversion

	from_json (j: like to_json): detachable like object
		local
			i: INTEGER
		do
			create Result.make
			if attached {JSON_ARRAY} j.item (data_key) as ja then
				from
					i := 1
				until
					i > ja.count
				loop
					if attached {CJ_DATA} json_to_object (ja [i], {CJ_DATA}) as b then
						Result.add_data (b)
					end
					i := i + 1
				end
			end
		end

	to_json (o: like object): JSON_OBJECT
		do
			create Result.make
			Result.put (json.value (o.data), data_key)
		end

feature {NONE} -- Implementation


	data_key: JSON_STRING
		once
			create Result.make_from_string ("data")
		end
note
	copyright: "2011-2017, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
