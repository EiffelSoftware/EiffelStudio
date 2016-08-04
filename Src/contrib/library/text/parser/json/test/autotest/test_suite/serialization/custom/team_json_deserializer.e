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

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable TEAM
		do
			if attached {JSON_OBJECT} a_json as j_team then
				if
					attached {JSON_STRING} j_team.item ("name") as j_name
				then
					create Result.make (j_name.unescaped_string_32)
					if attached {JSON_OBJECT} j_team.item ("owner") as j_owner then
						if attached {PERSON} ctx.value_from_json (a_json, {PERSON}) as p then
							Result.set_owner (p)
						end
					end
					if attached {JSON_ARRAY} j_team.item ("persons") as j_persons then
						if attached ctx.deserializer ({PERSON}) as conv then
							across
								j_persons as ic
							loop
								if attached {PERSON} ctx.value_from_json (ic.item, {PERSON}) as l_person then
									Result.put (l_person)
								end
							end
						end
					end
					if attached {JSON_ARRAY} j_team.item ("vectors") as j_vectors then
						Result.vectors.wipe_out
						across
							j_vectors as ic
						loop
							if attached {JSON_STRING} ic.item as j_string then
								Result.add_vector (j_string.item)
							end
						end
					end

					if attached {JSON_OBJECT} j_team.item ("dico") as j_dico then
						Result.dico.wipe_out
						across
							j_dico as ic
						loop
							if attached {JSON_STRING} ic.item as j_string then
								Result.dico.force (j_string.unescaped_string_32, ic.key.unescaped_string_32)
							end
						end
					end
				end
			end
		end

end
