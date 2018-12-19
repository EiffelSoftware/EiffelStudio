note
	description: "JSON Serialization for basic types."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_CORE_SERIALIZER

inherit
	JSON_SERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		do
			if obj = Void then
				create {JSON_NULL} Result
			else
				if attached {BOOLEAN} obj as bool then
					create {JSON_BOOLEAN} Result.make (bool)
				elseif attached {NUMERIC} obj as num then
					if 	   attached {INTEGER_64} num as i64 then
						create {JSON_NUMBER} Result.make_integer (i64)
					elseif attached {INTEGER_32} num as i32 then
						create {JSON_NUMBER} Result.make_integer (i32)
					elseif attached {INTEGER_16} num as i16 then
						create {JSON_NUMBER} Result.make_integer (i16)
					elseif attached {INTEGER_8} num as i8 then
						create {JSON_NUMBER} Result.make_integer (i8)
					elseif attached {NATURAL_64} num as n64 then
						create {JSON_NUMBER} Result.make_natural (n64)
					elseif attached {NATURAL_32} num as n32 then
						create {JSON_NUMBER} Result.make_natural (n32)
					elseif attached {NATURAL_16} num as n16 then
						create {JSON_NUMBER} Result.make_natural (n16)
					elseif attached {NATURAL_8} num as n8 then
						create {JSON_NUMBER} Result.make_natural (n8)
					elseif attached {REAL_64} num as r64 then
						create {JSON_NUMBER} Result.make_real (r64)
					elseif attached {REAL_32} num as r32 then
						create {JSON_NUMBER} Result.make_real (r32)
					else
						check is_basic_numeric_type: False end
						create {JSON_NUMBER} Result.make_integer (num.out.to_integer_64)
					end
				elseif attached {CHARACTER_8} obj as ch8 then
					create {JSON_STRING} Result.make_from_string (create {STRING_8}.make_filled (ch8, 1))
				elseif attached {CHARACTER_32} obj as ch32 then
					create {JSON_STRING} Result.make_from_string_32 (create {STRING_32}.make_filled (ch32, 1))
				elseif attached {POINTER} obj as ptr then
					create {JSON_NUMBER} Result.make_integer (ptr.to_integer_32)
				else
					Result := reference_to_json (obj, ctx)
				end
			end
		end

feature {NONE} -- Implementation		

	reference_to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		do
			if obj = Void then
				create {JSON_NULL} Result
			elseif attached {READABLE_STRING_GENERAL} obj as str then
					-- Never reuse string value ... as reference.
					-- CHECK: or maybe for big string ?
				create {JSON_STRING} Result.make_from_string_general (str)
			else
				create {JSON_NULL} Result
			end
		end

note
	copyright: "2010-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
