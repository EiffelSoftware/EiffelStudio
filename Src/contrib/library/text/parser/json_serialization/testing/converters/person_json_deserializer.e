note
	description: "Summary description for {PERSON_JSON_DESERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON_JSON_DESERIALIZER

inherit
	JSON_DESERIALIZER

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: detachable JSON_DESERIALIZER_CONTEXT): detachable PERSON
		do
			if attached {JSON_OBJECT} a_json as j_person then
				if
					attached {JSON_STRING} j_person.item ("first_name") as j_first_name and
					attached {JSON_STRING} j_person.item ("last_name") as j_last_name
				then
					create Result.make (j_first_name.unescaped_string_32, j_last_name.unescaped_string_32)

					if attached {JSON_OBJECT} j_person.item ("details") as j_details then
						if ctx /= Void and then attached ctx.deserializer ({PERSON_DETAILS}) as conv then
							if attached {PERSON_DETAILS} conv.from_json (j_details, ctx) as l_details then
								Result.set_details (l_details)
							end
						end
					end
				end
			end
		end

end
