note
	description: "JSON deserializer for basic type."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_CORE_DESERIALIZER

inherit
	JSON_DESERIALIZER

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable ANY
		do
			if attached {JSON_STRING} a_json as s then
				Result := string_from_json (s, a_type)
			elseif attached {JSON_BOOLEAN} a_json as b then
				Result := boolean_from_json (b)
			elseif attached {JSON_NULL} a_json then
				Result := Void
			elseif attached {JSON_NUMBER} a_json as n then
				Result := number_from_json (n, a_type)
			end
			if ctx.has_error then
				Result := Void
			end
		end

feature {NONE} -- Helpers: Basic values		

	boolean_from_json (v: JSON_VALUE): BOOLEAN
		do
			if attached {JSON_BOOLEAN} v as b then
				Result := b.item
			elseif attached {JSON_STRING} v as s then
				Result := s.item.is_case_insensitive_equal_general ("true")
			else
				check is_boolean: False end
			end
		end

	number_from_json (v: JSON_VALUE; a_type: detachable TYPE [detachable ANY]): detachable ANY
		local
			i64: INTEGER_64
			n64: NATURAL_64
		do
			if attached {JSON_NUMBER} v as l_number then
				if a_type = Void or else not a_type.conforms_to ({detachable NUMERIC})  then
					if l_number.is_integer then
						i64 := l_number.integer_64_item
						if     {INTEGER_8}.min_value <= i64 and i64 <= {INTEGER_8}.max_value then
							Result := i64.as_integer_8
						elseif {INTEGER_16}.min_value <= i64 and i64 <= {INTEGER_16}.max_value then
							Result := i64.as_integer_16
						elseif {INTEGER_32}.min_value <= i64 and i64 <= {INTEGER_32}.max_value then
							Result := i64.as_integer_32
						else
							Result := i64
						end
					elseif l_number.is_natural then
						n64 := l_number.natural_64_item
						if     n64 <= {NATURAL_8}.max_value then
							Result := n64.as_natural_8
						elseif n64 <= {NATURAL_16}.max_value then
							Result := n64.as_natural_16
						elseif n64 <= {NATURAL_32}.max_value then
							Result := n64.as_natural_32
						else
							Result := n64
						end
					elseif l_number.is_real then
							-- Do not truncate!
						Result := l_number.real_64_item
					else
						Result := l_number.integer_64_item
					end
				elseif a_type = {INTEGER_8} then
					Result := l_number.integer_64_item.to_integer_8
				elseif a_type = {INTEGER_16} then
					Result := l_number.integer_64_item.to_integer_16
				elseif a_type = {INTEGER_32} then
					Result := l_number.integer_64_item.to_integer_32
				elseif a_type = {INTEGER_64} then
					Result := l_number.integer_64_item
				elseif a_type = {NATURAL_8} then
					Result := l_number.natural_64_item.to_natural_8
				elseif a_type = {NATURAL_16} then
					Result := l_number.natural_64_item.to_natural_16
				elseif a_type = {NATURAL_32} then
					Result := l_number.natural_64_item.to_natural_32
				elseif a_type = {NATURAL_64} then
					Result := l_number.natural_64_item
				elseif a_type = {REAL_32} then
					Result := l_number.natural_64_item.to_real_32
				elseif a_type = {REAL_64} then
					Result := l_number.natural_64_item
				else
					Result := l_number.integer_64_item
				end
			end
		end

	integer_from_json (v: JSON_VALUE): INTEGER_64
		do
			if attached {JSON_NUMBER} v as n then
				Result := n.integer_64_item
			elseif attached {JSON_STRING} v as s then
				if s.item.is_integer_64 then
					Result := s.item.to_integer_64
				end
			else
				check is_integer: False end
			end
		end

	natural_from_json (v: JSON_VALUE): NATURAL_64
		do
			if attached {JSON_NUMBER} v as n then
				Result := n.natural_64_item
			elseif attached {JSON_STRING} v as s then
				if s.item.is_natural_64 then
					Result := s.item.to_natural_64
				end
			else
				check is_natural: False end
			end
		end

	real_from_json (v: JSON_VALUE): REAL_64
		do
			if attached {JSON_NUMBER} v as n then
				Result := n.real_64_item
			else
				check is_real: False end
			end
		end

	string_from_json (v: JSON_VALUE; a_static_type: detachable TYPE [detachable ANY]): detachable READABLE_STRING_GENERAL
		do
			if attached {JSON_STRING} v as s then
				if a_static_type /= Void then
					Result := string_converted_to_type (s.unescaped_string_32, a_static_type)
				else
					Result := s.unescaped_string_32
				end
			else
				check is_string: False end
			end
		end

feature {NONE} -- Implementation

	string_converted_to_type (str: READABLE_STRING_GENERAL; a_static_type: TYPE [detachable ANY]): detachable READABLE_STRING_GENERAL
		local
			utf_conv: UTF_CONVERTER
		do
			if a_static_type.conforms_to (str.generating_type) then
				Result := str
			elseif
				a_static_type = {STRING_32} or a_static_type = {detachable STRING_32}
				or a_static_type = {READABLE_STRING_32} or a_static_type = {detachable READABLE_STRING_32}
			then
				create {STRING_32} Result.make_from_string_general (str)
			elseif
				a_static_type = {STRING_8} or a_static_type = {detachable STRING_8}
				or a_static_type = {READABLE_STRING_8} or a_static_type = {detachable READABLE_STRING_8}
			then
				create {STRING_8} Result.make_from_string (utf_conv.utf_32_string_to_utf_8_string_8 (str))

			elseif a_static_type = {IMMUTABLE_STRING_32} or a_static_type = {detachable IMMUTABLE_STRING_32} then
				create {IMMUTABLE_STRING_32} Result.make_from_string_general (str)
			elseif a_static_type = {IMMUTABLE_STRING_8} or a_static_type = {detachable IMMUTABLE_STRING_8} then
				create {IMMUTABLE_STRING_8} Result.make_from_string (utf_conv.utf_32_string_to_utf_8_string_8 (str))

			else
				check known_type: False end
				Result := str
			end
		end

note
	copyright: "2010-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
