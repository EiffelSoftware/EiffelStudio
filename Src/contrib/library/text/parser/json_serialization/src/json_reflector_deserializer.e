note
	description: "JSON deserializer based on reflection mechanism."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_REFLECTOR_DESERIALIZER

inherit
	JSON_DESERIALIZER

	REFLECTOR

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: detachable JSON_DESERIALIZER_CONTEXT): detachable ANY
		local
			l_type_id: INTEGER
			l_static_type_id: INTEGER
			ref: REFLECTED_REFERENCE_OBJECT
			i: INTEGER
			l_check: BOOLEAN
		do
			if attached {JSON_BOOLEAN} a_json as b then
				Result := b.item
			elseif attached {JSON_NULL} a_json then
				Result := Void
			elseif attached {JSON_NUMBER} a_json as n then
				Result := n.integer_64_item
			elseif attached {JSON_STRING} a_json as s then
				Result := s.unescaped_string_32
			elseif attached {JSON_ARRAY} a_json as a then
			elseif attached {JSON_OBJECT} a_json as o then
				if attached {JSON_STRING} o.item ("_type_name") as s_type_name then
					l_type_id := dynamic_type_from_string (s_type_name.item)
					if l_type_id >= 0 then
						l_check := {ISE_RUNTIME}.check_assert (False)
						Result := new_instance_of (l_type_id)
						create ref.make (Result)
						i := 0
						across
							o as ic
						loop
							if not ic.key.item.starts_with ("_") then
								i := i + 1
								if attached from_json (ic.item, ctx) as f_o then
									if attached {INTEGER_64} f_o as i64 then
										ref.set_integer_64_field (i, i64)
									elseif attached {INTEGER_32} f_o as i32 then
										ref.set_integer_32_field (i, i32)
									elseif attached {BOOLEAN} f_o as b then
										ref.set_boolean_field (i, b)
									elseif attached {READABLE_STRING_GENERAL} f_o as str then
										l_static_type_id := ref.field_static_type (i)
										if str.generating_type.type_id = l_static_type_id then
											ref.set_reference_field (i, str)
										else
											ref.set_reference_field (i, string_converted_to_type (str, l_static_type_id))
										end
									else
										ref.set_reference_field (i, f_o)
									end
								else
									ref.set_reference_field (i, Void)
								end
							end
						end
						l_check := {ISE_RUNTIME}.check_assert (l_check)
					end
				end
			end
		end

feature {NONE} -- Implementation

	string_converted_to_type (str: READABLE_STRING_GENERAL; l_static_type_id: INTEGER): detachable READABLE_STRING_GENERAL
		local
			st: TYPE [detachable ANY]
			utf_conv: UTF_CONVERTER
		do
			st := type_of_type (l_static_type_id)
			if {ISE_RUNTIME}.type_conforms_to (str.generating_type.type_id, l_static_type_id) then
				Result := str
			elseif st = {READABLE_STRING_32} or st = {STRING_32} then
				create {STRING_32} Result.make_from_string_general (str)
			elseif st = {IMMUTABLE_STRING_32} then
				create {IMMUTABLE_STRING_32} Result.make_from_string_general (str)
			elseif st = {READABLE_STRING_8} or st = {STRING_8} then
				create {STRING_8} Result.make_from_string (utf_conv.utf_32_string_to_utf_8_string_8 (str))
			elseif st = {IMMUTABLE_STRING_8} then
				create {IMMUTABLE_STRING_8} Result.make_from_string (utf_conv.utf_32_string_to_utf_8_string_8 (str))
			else
				check known_type: False end
				Result := str
			end
		end

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
