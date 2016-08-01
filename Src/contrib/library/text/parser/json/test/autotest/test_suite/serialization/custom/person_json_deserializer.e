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

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable PERSON
		local
--			p_conv, t_conv: detachable JSON_DESERIALIZER
		do
			if attached {JSON_OBJECT} a_json as j_person then
				if
					attached {JSON_STRING} j_person.item ("first_name") as j_first_name and
					attached {JSON_STRING} j_person.item ("last_name") as j_last_name
				then
					create Result.make (j_first_name.unescaped_string_32, j_last_name.unescaped_string_32)

					if attached {JSON_OBJECT} j_person.item ("details") as j_details then
						if attached {PERSON_DETAILS} ctx.value_from_json (j_details, {PERSON_DETAILS}) as l_details then
							Result.set_details (l_details)
						end
--						if attached ctx.deserializer ({PERSON_DETAILS}) as conv then
--							if attached {PERSON_DETAILS} conv.from_json (j_details, ctx, {PERSON_DETAILS}) as l_details then
--								Result.set_details (l_details)
--							end
--						end
					end
					if attached {JSON_ARRAY} j_person.item ("co_workers") as j_coworkers then
--						p_conv := ctx.deserializer ({PERSON})
--						t_conv := ctx.deserializer ({TEAM})
						across
							j_coworkers as ic
						loop
							if attached {ENTITY} ctx.value_from_json (ic.item, {PERSON}) as p then
								Result.add_co_worker (p)
							elseif attached {ENTITY} ctx.value_from_json (ic.item, {TEAM}) as t then
								Result.add_co_worker (t)
							end
--							if p_conv /= Void and then attached {ENTITY} p_conv.from_json (ic.item, ctx, {PERSON}) as e then
--								Result.add_co_worker (e)
--							elseif t_conv /= Void and then attached {ENTITY} t_conv.from_json (ic.item, ctx, {TEAM}) as e then
--								Result.add_co_worker (e)
--							end
						end
					end
				end
			end
		end

end
