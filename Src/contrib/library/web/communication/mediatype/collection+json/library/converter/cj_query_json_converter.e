note
	description: "A JSON CONVERTER for CJ_QUERY"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_QUERY_JSON_CONVERTER

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

	object: CJ_QUERY

feature -- Conversion

	from_json (j: like to_json): detachable like object
		local
			i: INTEGER
			l_href: detachable READABLE_STRING_8
			l_rel: detachable STRING_32
		do
			if attached {STRING_32} json_to_object (j.item (href_key), Void) as l_ucs then
				l_href := l_ucs.to_string_8
			end
			if attached {STRING_32} json_to_object (j.item (rel_key), Void) as l_ucs then
				l_rel := l_ucs
			end
			if l_href /= Void and l_rel /= Void then
				create Result.make (l_href, l_rel)
				if attached {STRING_32} json_to_object (j.item (name_key), Void) as l_ucs then
					Result.set_name (l_ucs)
				end
				if attached {STRING_32} json_to_object (j.item (prompt_key), Void) as l_ucs then
					Result.set_prompt (l_ucs)
				end
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
			else
				-- error
			end
		end

	to_json (o: like object): JSON_OBJECT
		do
			create Result.make
			Result.put (json.value (o.href), href_key)
			Result.put (json.value (o.rel), rel_key)
			if attached o.prompt as o_prompt then
				Result.put (json.value (o_prompt), prompt_key)
			end
			if attached o.name as o_name then
				Result.put (json.value (o_name), name_key)
			end
			if attached o.data as o_data then
				Result.put (json.value (o_data), data_key)
			end
		end

feature {NONE} -- Implementation

	href_key: JSON_STRING
		once
			create Result.make_from_string ("href")
		end

	rel_key: JSON_STRING
		once
			create Result.make_from_string ("rel")
		end

	prompt_key: JSON_STRING
		once
			create Result.make_from_string ("prompt")
		end

	name_key: JSON_STRING
		once
			create Result.make_from_string ("name")
		end

	data_key: JSON_STRING
		once
			create Result.make_from_string ("data")
		end

note
	copyright: "2011-2021, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
