note
	description: "Summary description for {JSON_ITEM_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_ITEM_JSON_CONVERTER

inherit
	CJ_JSON_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		do
			create object.make_empty
		end

feature -- Access

	object: CJ_ITEM

feature -- Conversion

	from_json (j: like to_json): detachable like object
		local
			i: INTEGER
		do
			if attached {STRING_32} json_to_object (j.item (href_key), Void) as l_ucs then
				create Result.make (l_ucs.to_string_8)
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
				if attached {JSON_ARRAY} j.item (links_key) as ja then
					from
						i := 1
					until
						i > ja.count
					loop
						if attached {CJ_LINK} json_to_object (ja [i], {CJ_LINK}) as b then
							Result.add_link (b)
						end
						i := i + 1
					end
				end
			else
				-- invalid content for CJ_ITEM, missing "href"

			end
		end

	to_json (o: like object): JSON_OBJECT
		do
			create Result.make
			Result.put (json.value (o.href), href_key)
			if attached o.data as o_data then
				Result.put (json.value (o_data), data_key)
			end
			if attached o.links as o_links then
				Result.put (json.value (o_links), links_key)
			end
		end

feature {NONE} -- Implementation

	href_key: JSON_STRING
		once
			create Result.make_from_string ("href")
		end

	data_key: JSON_STRING
		once
			create Result.make_from_string ("data")
		end

	links_key: JSON_STRING
		once
			create Result.make_from_string ("links")
		end

note
	copyright: "2011-2021, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
