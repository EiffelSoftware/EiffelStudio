note
	description: "Summary description for {LINKED_LIST_JSON_DESERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LINKED_LIST_JSON_DESERIALIZER [G -> detachable ANY]

inherit
	JSON_DESERIALIZER

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable LINKED_LIST [G]
			-- Eiffel value deserialized from `a_json' value, in the eventual context `ctx'.
		do
			if attached {JSON_ARRAY} a_json as j_array then
				create Result.make (j_array.count)
				across
					j_array as ic
				loop
					if attached ctx.deserializer ({G}) as d then
						if attached {G} d.from_json (ic.item, ctx, {G}) as g then
							Result.force (g)
						end
					end
				end
			end
		end

end
