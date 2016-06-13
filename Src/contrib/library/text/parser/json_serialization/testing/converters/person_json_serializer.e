note
	description: "Summary description for {APP_PERSON_TO_JSON_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON_JSON_SERIALIZER

inherit
	JSON_SERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: detachable JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			j_object: JSON_OBJECT
			j_array: JSON_ARRAY
			j_value: detachable JSON_VALUE
		do
			if attached {PERSON} obj as per then
				create j_object.make_with_capacity (3)
				j_object.put_string (per.first_name, "first_name")
				j_object.put_string (per.last_name, "last_name")
				if attached per.details as d then
					if ctx /= Void and then attached ctx.serializer (d) as conv then
						j_value := conv.to_json (d, ctx)
					else
						check type_serializable: False end
						j_value := create {JSON_NULL}
					end
					j_object.put (j_value, "details")
				end
				Result := j_object
			else
				create {JSON_NULL} Result
			end
		end

--	append_to_json_string (obj: detachable ANY; ctx: detachable JSON_SERIALIZER_CONTEXT; a_json: STRING)
--		do
--			a_json.append_character ('{')
--			if attached {PERSON} obj as per then
--				a_json.append_string ("%"first_name%":")
--				a_json.append_character ('"')
--				a_json.append ((create {JSON_STRING}.make_from_string_32 (per.first_name)).item)
--				a_json.append_character ('"')
--				a_json.append_character (',')

--				a_json.append_string ("%"last_name%":")
--				a_json.append_character ('"')
--				a_json.append ((create {JSON_STRING}.make_from_string_32 (per.last_name)).item)
--				a_json.append_character ('"')

--				if attached per.details as l_details then
--					a_json.append_character (',')
--					a_json.append ("%"details%":")
--					if ctx /= Void and then attached ctx.serializer (l_details) as conv then
--						conv.append_to_json_string (l_details, ctx, a_json)
--					else
--						check has_converter: False end
--						a_json.append ("null")
--					end
--				end
--			end
--			a_json.append_character ('}')
--		end

end
