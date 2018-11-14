note
	description: "Summary description for {PERSON_DETAILS_JSON_SERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON_DETAILS_JSON_SERIALIZER

inherit
	JSON_SERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			j_object: JSON_OBJECT
		do
			if attached {PERSON_DETAILS} obj as details then
				create j_object.make_with_capacity (3)

				ctx.on_object_serialization_start (details)
					-- "city_name"
				if attached details.city_name as l_city_name then
					j_object.put_string (l_city_name, "city_name")
				end
					-- "zip"
				j_object.put_integer (details.zip, "zip")

					-- "country"
				if attached details.country as l_country then
					j_object.put_string (l_country, "country")
				end
				Result := j_object
				ctx.on_object_serialization_end (j_object, details)
			else
				create {JSON_NULL} Result
			end
		end

end
