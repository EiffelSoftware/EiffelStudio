note
	description: "Summary description for {PERSON_JSON_SERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON_JSON_SERIALIZER

inherit
	JSON_SERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			j_object: JSON_OBJECT
			j_array: JSON_ARRAY
			j_value: detachable JSON_VALUE
			i: INTEGER
		do
			if attached {PERSON} obj as per then
				create j_object.make_with_capacity (3)

				ctx.on_object_serialization_start (per)
					-- "first_name"
				j_object.put_string (per.first_name, "first_name")
					-- "last_name"
				j_object.put_string (per.last_name, "last_name")

					-- "details"
				if attached per.details as d then
					ctx.on_field_start ("details")
					j_value := ctx.to_json (d, Current)
					if j_value = Void then
						check type_serializable: False end
						j_value := create {JSON_NULL}
					end
					j_object.put (j_value, "details")
					ctx.on_field_end ("details")
				end
					-- "co_workers"
				if attached per.co_workers as l_co_workers and then not l_co_workers.is_empty then
					create j_array.make_empty
					i := 1
					across
						l_co_workers as ic
					loop
						ctx.on_field_start (i.out)
						j_value := ctx.to_json (ic.item, Current)
						if j_value = Void then
							check type_serializable: False end
							j_value := create {JSON_NULL}
						end
						j_array.extend (j_value)
						ctx.on_field_end (i.out)
						i := i + 1
					end
					j_object.put (j_array, "co_workers")
				end

				Result := j_object
				ctx.on_object_serialization_end (j_object, per)
			else
				create {JSON_NULL} Result
			end
		end

end
