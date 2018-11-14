note
	description: "JSON deserializer based on reflection mechanism."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_BASIC_DESERIALIZER [G -> detachable ANY]

inherit
	JSON_CORE_DESERIALIZER
		redefine
			from_json,
			reset
		end

	JSON_TYPE_UTILITIES

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable ANY
		local
			obj_conv: TABLE_JSON_DESERIALIZER [G]
			arr_conv: ARRAYED_LIST_JSON_DESERIALIZER [G]
		do
			if attached {JSON_OBJECT} a_json as j_object then
				create obj_conv
				Result := obj_conv.from_json (a_json, ctx, Void)
			elseif attached {JSON_ARRAY} a_json as j_array then
				create arr_conv
				Result := arr_conv.from_json (a_json, ctx, Void)
			else
				Result := Precursor (a_json, ctx, a_type)
			end
			if ctx.has_error then
				Result := Void
			end
		end

feature -- Cleaning

	reset
			-- <Precursor>
		do
		end

note
	copyright: "2010-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
