note
	description: "Summary description for {ITERABLE_JSON_SERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ITERABLE_JSON_SERIALIZER [G -> detachable ANY]

inherit
	JSON_SERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
			-- JSON value representing the JSON serialization of Eiffel value `obj', in the eventual context `ctx'.	
		local
			i: INTEGER
			j_array: JSON_ARRAY
		do
			if attached {ITERABLE [G]} obj as arr then
					-- Is this a good idea?
					-- what about object exporting an ITERABLE interface, but containing other attributes
					-- unrelated to that iterable nature!
				create j_array.make_empty
				i := 0
				across
					arr as ic
				loop
					i := i + 1
					ctx.on_field_start (i.out)
					if
						attached ic.item as l_item and then
						attached ctx.to_json (l_item, Current) as j_value
					then
						j_array.extend (j_value)
					else
						j_array.extend (create {JSON_NULL})
					end
					ctx.on_field_end (i.out)
				end
				Result := j_array
			else
				create {JSON_NULL} Result
			end
		end

note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
