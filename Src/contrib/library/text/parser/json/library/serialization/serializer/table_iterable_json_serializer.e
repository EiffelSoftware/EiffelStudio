note
	description: "Summary description for {TABLE_ITERABLE_JSON_SERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_ITERABLE_JSON_SERIALIZER [G -> detachable ANY, K -> READABLE_STRING_GENERAL]

inherit
	JSON_SERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
			-- JSON value representing the JSON serialization of Eiffel value `obj', in the eventual context `ctx'.	
		local
			j_tb: JSON_OBJECT
			k: JSON_STRING
		do
			if attached {TABLE_ITERABLE [G, K]} obj as tb then
					-- Is this a good idea?
					-- what about object exporting an ITERABLE interface,
					-- but containing other attributes unrelated to that iterable nature!
					-- up to the dev to use or not this serializer!
				if attached {HASH_TABLE [G, K]} tb as htb then
					create j_tb.make_with_capacity (htb.count)
				else
					create j_tb.make_empty
				end
				across
					tb as ic
				loop
					ctx.on_field_start (ic.key)
					create k.make_from_string_general (ic.key)
					if
						attached ic.item as l_item and then
						attached ctx.to_json (l_item, Current) as j_value
					then
						j_tb.put (j_value, k)
					else
						j_tb.put (create {JSON_NULL}, k)
					end
					ctx.on_field_end (ic.key)
				end
				Result := j_tb
			else
				create {JSON_NULL} Result
			end
		end

note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
