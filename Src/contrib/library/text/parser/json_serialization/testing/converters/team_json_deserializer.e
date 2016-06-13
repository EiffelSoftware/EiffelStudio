note
	description: "Summary description for {APP_GROUP_FROM_JSON_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEAM_JSON_DESERIALIZER

inherit
	JSON_DESERIALIZER

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: detachable JSON_DESERIALIZER_CONTEXT): detachable TEAM
		do
			if attached {JSON_OBJECT} a_json as j_team then
				if
					attached {JSON_STRING} j_team.item ("name") as j_name
				then
					create Result.make (j_name.unescaped_string_32)

					if attached {JSON_ARRAY} j_team.item ("persons") as j_persons then
						if ctx /= Void and then attached ctx.deserializer ({PERSON}) as conv then
							across
								j_persons as ic
							loop
								if attached {PERSON} conv.from_json (ic.item, ctx) as l_person then
									Result.put (l_person)
								end
							end
						end
					end
				end
			end
		end

end
