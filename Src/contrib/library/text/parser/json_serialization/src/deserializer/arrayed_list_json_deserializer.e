note
	description: "Summary description for {ARRAYED_LIST_JSON_DESERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAYED_LIST_JSON_DESERIALIZER [G -> detachable ANY]

inherit
	JSON_DESERIALIZER

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable ARRAYED_LIST [G]
			-- Eiffel value deserialized from `a_json' value, in the eventual context `ctx'.
		do
			if attached {JSON_ARRAY} a_json as j_array then
				create Result.make (j_array.count)
				across
					j_array as ic
				loop
					if attached {G} ctx.value_from_json (ic.item, {G}) as g then
						Result.force (g)
					end
--					if attached ctx.deserializer ({G}) as conv then
--						if attached {G} conv.from_json (ic.item, ctx, {G}) as g then
--							Result.force (g)
--						end
--					end
				end
			end
		end

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
