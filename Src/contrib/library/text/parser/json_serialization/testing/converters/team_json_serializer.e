note
	description: "Summary description for {TEAM_JSON_SERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEAM_JSON_SERIALIZER

inherit
	JSON_SERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: detachable JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			j_object: JSON_OBJECT
			j_array: JSON_ARRAY
			j_value: detachable JSON_VALUE
		do
			if attached {TEAM} obj as grp then
				create j_object.make_with_capacity (2)
				j_object.put_string (grp.name, "name")
				if attached grp.persons as lst then
					create j_array.make (lst.count)
					across
						lst as ic
					loop
						if ctx /= Void and then attached ctx.serializer (ic.item) as conv then
							j_value := conv.to_json (ic.item, ctx)
							j_array.extend (j_value)
						else
							check type_serializable: False end
							j_array.extend (create {JSON_NULL})
						end
					end
					j_object.put (j_array, "persons")
				end
				Result := j_object
			else
				create {JSON_NULL} Result
			end
		end

end
