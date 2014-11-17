note
	description: "Core factory class for creating JSON objects and corresponding Eiffel objects."
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	file: "$HeadURL: $"

class
	EJSON

obsolete
	"This JSON converter design has issues [Sept/2014]."

inherit

	EXCEPTIONS

feature -- Access

	value (an_object: detachable ANY): detachable JSON_VALUE
			-- JSON value from Eiffel object. Raises an "eJSON exception" if
			-- unable to convert value.
		local
			i: INTEGER
			ja: JSON_ARRAY
		do
				-- Try to convert from basic Eiffel types. Note that we check with
				-- `conforms_to' since the client may have subclassed the base class
				-- that these basic types are derived from.
			if an_object = Void then
				create {JSON_NULL} Result
			elseif attached {BOOLEAN} an_object as b then
				create {JSON_BOOLEAN} Result.make (b)
			elseif attached {INTEGER_8} an_object as i8 then
				create {JSON_NUMBER} Result.make_integer (i8)
			elseif attached {INTEGER_16} an_object as i16 then
				create {JSON_NUMBER} Result.make_integer (i16)
			elseif attached {INTEGER_32} an_object as i32 then
				create {JSON_NUMBER} Result.make_integer (i32)
			elseif attached {INTEGER_64} an_object as i64 then
				create {JSON_NUMBER} Result.make_integer (i64)
			elseif attached {NATURAL_8} an_object as n8 then
				create {JSON_NUMBER} Result.make_natural (n8)
			elseif attached {NATURAL_16} an_object as n16 then
				create {JSON_NUMBER} Result.make_natural (n16)
			elseif attached {NATURAL_32} an_object as n32 then
				create {JSON_NUMBER} Result.make_natural (n32)
			elseif attached {NATURAL_64} an_object as n64 then
				create {JSON_NUMBER} Result.make_natural (n64)
			elseif attached {REAL_32} an_object as r32 then
				create {JSON_NUMBER} Result.make_real (r32)
			elseif attached {REAL_64} an_object as r64 then
				create {JSON_NUMBER} Result.make_real (r64)
			elseif attached {ARRAY [detachable ANY]} an_object as a then
				create ja.make (a.count)
				from
					i := a.lower
				until
					i > a.upper
				loop
					if attached value (a @ i) as v then
						ja.add (v)
					else
						check
							value_attached: False
						end
					end
					i := i + 1
				end
				Result := ja
			elseif attached {CHARACTER_8} an_object as c8 then
				create {JSON_STRING} Result.make_from_string (c8.out)
			elseif attached {CHARACTER_32} an_object as c32 then
				create {JSON_STRING} Result.make_from_string_32 (create {STRING_32}.make_filled (c32, 1))
			elseif attached {STRING_8} an_object as s8 then
				create {JSON_STRING} Result.make_from_string (s8)
			elseif attached {STRING_32} an_object as s32 then
				create {JSON_STRING} Result.make_from_string_32 (s32)
			end
			if Result = Void then
					-- Now check the converters
				if an_object /= Void and then attached converter_for (an_object) as jc then
					Result := jc.to_json (an_object)
				else
					raise (exception_failed_to_convert_to_json (an_object))
				end
			end
		end

	object (a_value: detachable JSON_VALUE; base_class: detachable STRING): detachable ANY
			-- Eiffel object from JSON value. If `base_class' /= Void an eiffel
			-- object based on `base_class' will be returned. Raises an "eJSON
			-- exception" if unable to convert value.
		local
			i: INTEGER
			ll: LINKED_LIST [detachable ANY]
			t: HASH_TABLE [detachable ANY, STRING_GENERAL]
			keys: ARRAY [JSON_STRING]
		do
			if a_value = Void then
				Result := Void
			else
				if base_class = Void then
					if a_value = Void then
						Result := Void
					elseif attached {JSON_NULL} a_value then
						Result := Void
					elseif attached {JSON_BOOLEAN} a_value as jb then
						Result := jb.item
					elseif attached {JSON_NUMBER} a_value as jn then
						if jn.item.is_integer_8 then
							Result := jn.item.to_integer_8
						elseif jn.item.is_integer_16 then
							Result := jn.item.to_integer_16
						elseif jn.item.is_integer_32 then
							Result := jn.item.to_integer_32
						elseif jn.item.is_integer_64 then
							Result := jn.item.to_integer_64
						elseif jn.item.is_natural_64 then
							Result := jn.item.to_natural_64
						elseif jn.item.is_double then
							Result := jn.item.to_double
						end
					elseif attached {JSON_STRING} a_value as js then
						create {STRING_32} Result.make_from_string (js.unescaped_string_32)
					elseif attached {JSON_ARRAY} a_value as ja then
						from
							create ll.make
							i := 1
						until
							i > ja.count
						loop
							ll.extend (object (ja [i], Void))
							i := i + 1
						end
						Result := ll
					elseif attached {JSON_OBJECT} a_value as jo then
						keys := jo.current_keys
						create t.make (keys.count)
						from
							i := keys.lower
						until
							i > keys.upper
						loop
							if attached {STRING_GENERAL} object (keys [i], Void) as s then
								t.put (object (jo.item (keys [i]), Void), s)
							end
							i := i + 1
						end
						Result := t
					end
				else
					if converters.has_key (base_class) and then attached converters.found_item as jc then
						Result := jc.from_json (a_value)
					else
						raise (exception_failed_to_convert_to_eiffel (a_value, base_class))
					end
				end
			end
		end

	object_from_json (json: STRING; base_class: detachable STRING): detachable ANY
			-- Eiffel object from JSON representation. If `base_class' /= Void an
			-- Eiffel object based on `base_class' will be returned. Raises an
			-- "eJSON exception" if unable to convert value.
		require
			json_not_void: json /= Void
		do
			json_parser.set_representation (json)
			json_parser.parse_content
			if json_parser.is_valid and then attached json_parser.parsed_json_value as jv then
				Result := object (jv, base_class)
			end
		end

	converter_for (an_object: ANY): detachable JSON_CONVERTER
			-- Converter for objects. Returns Void if none found.
		require
			an_object_not_void: an_object /= Void
		do
			if converters.has_key (an_object.generator) then
				Result := converters.found_item
			end
		end

	json_reference (s: STRING): JSON_OBJECT
			-- A JSON (Dojo style) reference object using `s' as the
			-- reference value. The caller is responsable for ensuring
			-- the validity of `s' as a json reference.
		require
			s_not_void: s /= Void
		local
			js_key, js_value: JSON_STRING
		do
			create Result.make
			create js_key.make_from_string ("$ref")
			create js_value.make_from_string (s)
			Result.put (js_value, js_key)
		end

	json_references (l: LIST [STRING]): JSON_ARRAY
			-- A JSON array of JSON (Dojo style) reference objects using the
			-- strings in `l' as reference values. The caller is responsable
			-- for ensuring the validity of all strings in `l' as json
			-- references.
		require
			l_not_void: l /= Void
		local
			c: ITERATION_CURSOR [STRING]
		do
			create Result.make (l.count)
			from
				c := l.new_cursor
			until
				c.after
			loop
				Result.add (json_reference (c.item))
				c.forth
			end
		end

feature -- Change

	add_converter (jc: JSON_CONVERTER)
			-- Add the converter `jc'.
		require
			jc_not_void: jc /= Void
		do
			converters.force (jc, jc.object.generator)
		ensure
			has_converter: converter_for (jc.object) /= Void
		end

feature {NONE} -- Implementation

	converters: HASH_TABLE [JSON_CONVERTER, STRING]
			-- Converters hashed by generator (base class)
		once
			create Result.make (10)
		end

feature {NONE} -- Implementation (Exceptions)

	exception_prefix: STRING = "eJSON exception: "

	exception_failed_to_convert_to_eiffel (a_value: JSON_VALUE; base_class: detachable STRING): STRING
			-- Exception message for failing to convert a JSON_VALUE to an instance of `a'.
		do
			Result := exception_prefix + "Failed to convert JSON_VALUE to an Eiffel object: " + a_value.generator
			if base_class /= Void then
				Result.append (" -> {" + base_class + "}")
			end
		end

	exception_failed_to_convert_to_json (an_object: detachable ANY): STRING
			-- Exception message for failing to convert `a' to a JSON_VALUE.
		do
			Result := exception_prefix + "Failed to convert Eiffel object to a JSON_VALUE"
			if an_object /= Void then
				Result.append (" : {" + an_object.generator + "}")
			end
		end

feature {NONE} -- Implementation (JSON parser)

	json_parser: JSON_PARSER
		once
			create Result.make_with_string ("{}")
		end

note
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end -- class EJSON
