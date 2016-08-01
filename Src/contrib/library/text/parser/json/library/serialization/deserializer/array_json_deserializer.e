note
	description: "Summary description for {ARRAY_JSON_DESERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAY_JSON_DESERIALIZER [G -> detachable ANY]

inherit
	JSON_DESERIALIZER

	JSON_TYPE_UTILITIES

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable ARRAY [G]
			-- Eiffel value deserialized from `a_json' value, in the eventual context `ctx'.
		local
			inf: JSON_DESERIALIZER_CREATION_INFORMATION
			l_item_type: detachable TYPE [detachable ANY]
			i: INTEGER
		do
			if attached {JSON_ARRAY} a_json as j_array then
				create inf.make (a_type, a_json)
				ctx.on_value_creation (inf)
				if attached {like from_json} inf.object as lst then
					Result := lst
				elseif a_type = Void then
					ctx.on_value_skipped (j_array, a_type, "Could not instantiate array object.")
				else
					ctx.on_value_skipped (j_array, a_type, "Could not instantiate array {" + a_type.name + "}.")
				end
				if Result /= Void and not ctx.has_error then
					if a_type /= Void and then a_type.generic_parameter_count = 1 then
						l_item_type := a_type.generic_parameter_type (1)
					end
					if l_item_type = Void then
						l_item_type := {G}
					end
					i := Result.lower
					across
						j_array as ic
					loop
						if attached {G} ctx.value_from_json (ic.item, l_item_type) as g then
							Result.force (g, i)
							i := i + 1
						end
					end
				end
			end
		end

note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
