note
	description: "Summary description for {JSON_LINK_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_LINK_JSON_CONVERTER

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

	object: CJ_LINK

feature -- Conversion

	from_json (j: like to_json): detachable like object
		do
			create Result.make_empty
			if attached {STRING_32} json_to_object (j.item (href_key), Void) as l_ucs then
				Result.set_href (l_ucs.to_string_8)
			end
			if attached {STRING_32} json_to_object (j.item (rel_key), Void) as l_ucs then
				Result.set_rel (l_ucs)
			end
			if attached {STRING_32} json_to_object (j.item (name_key), Void) as l_ucs then
				Result.set_name (l_ucs)
			end
			if attached {STRING_32} json_to_object (j.item (prompt_key), Void) as l_ucs then
				Result.set_prompt (l_ucs)
			end
			if attached {STRING_32} json_to_object (j.item (render_key), Void) as l_ucs then
				Result.set_render (l_ucs)
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
			if attached o.render as o_render then
				Result.put (json.value (o_render), render_key)
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

	render_key: JSON_STRING
		once
			create Result.make_from_string ("render")
		end

note
	copyright: "2011-2021, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
