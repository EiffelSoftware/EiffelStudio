note
	description: "JSON Serialization based on reflection mechanism."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_REFLECTOR_SERIALIZER

inherit
	JSON_SERIALIZER
		redefine
			default_create,
			to_json
		end

	REFLECTOR
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			type_name_included := True
		end

feature -- Settings

	type_name_included: BOOLEAN assign set_type_name_included
			-- Are type name included in JSON output.
			-- By default, yes.

feature -- Element change

	set_type_name_included (b: BOOLEAN)
			-- Set `type_name_included' to `b'.
		do
			type_name_included := b
		end

feature -- Conversion

	to_json (obj: detachable ANY; ctx: detachable JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			i: INTEGER
			l_fields_count: INTEGER
--			l_type_id: INTEGER
			l_type_name: READABLE_STRING_8
			l_field_obj: detachable ANY
			refl_obj: REFLECTED_REFERENCE_OBJECT
			js: JSON_STRING
			l_first: BOOLEAN
			j_object: JSON_OBJECT
			j_array: JSON_ARRAY
			j_value: detachable JSON_VALUE
			l_field_value: detachable ANY
		do
			check
				is_recursively_expanded: is_recursively_expanded (obj)
			end

			if obj = Void then
				create {JSON_NULL} Result
			elseif attached {BOOLEAN} obj as bool then
				create {JSON_BOOLEAN} Result.make (bool)
			elseif attached {NUMERIC} obj as num then
				if 	   attached {INTEGER_64} num as i64 then
					create {JSON_NUMBER} Result.make_integer (i64)
				elseif attached {INTEGER_32} num as i32 then
					create {JSON_NUMBER} Result.make_integer (i32.to_integer_64)
				elseif attached {INTEGER_16} num as i16 then
					create {JSON_NUMBER} Result.make_integer (i16.to_integer_64)
				elseif attached {INTEGER_8} num as i8 then
					create {JSON_NUMBER} Result.make_integer (i8.to_integer_64)
				elseif attached {NATURAL_64} num as n64 then
					create {JSON_NUMBER} Result.make_natural (n64)
				elseif attached {NATURAL_32} num as n32 then
					create {JSON_NUMBER} Result.make_natural (n32.to_natural_64)
				elseif attached {NATURAL_16} num as n16 then
					create {JSON_NUMBER} Result.make_natural (n16.to_natural_64)
				elseif attached {NATURAL_8} num as n8 then
					create {JSON_NUMBER} Result.make_natural (n8.to_natural_64)
				elseif attached {REAL_64} num as r64 then
					create {JSON_NUMBER} Result.make_real (r64)
				elseif attached {REAL_32} num as r32 then
					create {JSON_NUMBER} Result.make_real (r32.to_double)
				else
					check is_basic_numeric_type: False end
					create {JSON_NUMBER} Result.make_integer (num.out.to_integer_64)
				end
			elseif attached {READABLE_STRING_GENERAL} obj as str then
				create {JSON_STRING} Result.make_from_string_general (str)
			elseif ctx /= Void and then attached ctx.serializer (obj) as conv and then conv /= Current then
				Result := conv.to_json (obj, ctx)
			elseif attached {HASH_TABLE [detachable ANY, READABLE_STRING_GENERAL]} obj as tb then
				create j_object.make_with_capacity (tb.count)
				across
					tb as ic
				loop
					if ctx /= Void and then attached ctx.serializer (ic.item) as conv then
						j_value := conv.to_json (ic.item, ctx)
					else
						j_value := to_json (ic.item, ctx)
					end

					j_object.put (j_value, create {JSON_STRING}.make_from_string_general (ic.key))
				end
				Result := j_object
			elseif attached {ITERABLE [detachable ANY]} obj as arr then
				create j_array.make_empty
				across
					arr as ic
				loop
					if ctx /= Void and then attached ctx.serializer (ic.item) as conv then
						j_value := conv.to_json (ic.item, ctx)
					else
						j_value := to_json (ic.item, ctx)
					end
					j_array.extend (j_value)
				end
				Result := j_array
			else
				create refl_obj.make (obj)
				l_type_name := refl_obj.type_name
				l_fields_count := refl_obj.field_count

				create j_object.make_with_capacity (1 + l_fields_count)

				if type_name_included then
					j_object.put_string (l_type_name, "_type_name")
				end
				if l_fields_count > 0 then
					from
						i := 1
					until
						i > l_fields_count
					loop
						if
							attached refl_obj.field_name (i) as l_field_name
						then
							l_field_value := refl_obj.field (i)
							if ctx /= Void and then attached ctx.serializer (l_field_value) as conv then
								j_value := conv.to_json (l_field_value, ctx)
							else
								j_value := to_json (l_field_value, ctx)
							end
							j_object.put (j_value, l_field_name)
						end
						i := i + 1
					end
				end
				Result := j_object
			end
		end

--	append_to_json_string (obj: detachable ANY; ctx: detachable JSON_SERIALIZER_CONTEXT; a_string: STRING)
--		local
--			i: INTEGER
--			l_fields_count: INTEGER
----			l_type_id: INTEGER
--			l_type_name: READABLE_STRING_8
--			l_field_obj: detachable ANY
--			refl_obj: REFLECTED_REFERENCE_OBJECT
--			js: JSON_STRING
--			l_first: BOOLEAN
--		do
--			check
--				is_recursively_expanded: is_recursively_expanded (obj)
--			end

--			if obj = Void then
--				a_string.append ("null")
--			elseif attached {BOOLEAN} obj as b then
--				if b then
--					a_string.append ("true")
--				else
--					a_string.append ("false")
--				end
--			elseif attached {NUMERIC} obj as num then
--				a_string.append (num.out)
--			elseif attached {READABLE_STRING_GENERAL} obj as str then
--				a_string.append_character ('%"')
--				a_string.append ((create {JSON_STRING}.make_from_string_general (str)).item)
--				a_string.append_character ('%"')
--			elseif attached {HASH_TABLE [detachable ANY, READABLE_STRING_GENERAL]} obj as tb then
--				a_string.append_character ('{')
--				l_first := True
--				across
--					tb as ic
--				loop
--					if l_first then
--						l_first := False
--					else
--						a_string.append_character (',')
--					end
--					a_string.append_character ('"')
--					a_string.append ((create {JSON_STRING}.make_from_string_general (ic.key)).item)
--					a_string.append_character ('"')
--					a_string.append_character (':')
--					if ctx /= Void and then attached ctx.serializer (ic.item) as conv then
--						conv.append_to_json_string (ic.item, ctx, a_string)
--					else
--						append_to_json_string (ic.item, ctx, a_string)
--					end
--				end
--				a_string.append_character ('}')
--			elseif attached {ITERABLE [detachable ANY]} obj as arr then
--				a_string.append_character ('[')
--				l_first := True
--				across
--					arr as ic
--				loop
--					if l_first then
--						l_first := False
--					else
--						a_string.append_character (',')
--					end
--					append_to_json_string (ic.item, ctx, a_string)
--				end
--				a_string.append_character (']')
--			else
--				create refl_obj.make (obj)
----				l_type_id := obj.generating_type.type_id
--				l_type_name := refl_obj.type_name
--				l_fields_count := refl_obj.field_count
--				a_string.append_character ('{')
--				if type_name_included then
--					a_string.append ("%"_type_name%":%"")
--					a_string.append (l_type_name)
--					a_string.append_character ('"')
--					if l_fields_count > 0 then
--						a_string.append_character (',')
--					end
--				end
--				if l_fields_count > 0 then
--					from
--						i := 1
--					until
--						i > l_fields_count
--					loop
--						if
--							attached refl_obj.field_name (i) as l_field_name
--						then
--							if i > 1 then
--								a_string.append_character (',')
--							end
--							a_string.append_character ('%"')
--							a_string.append ((create {JSON_STRING}.make_from_string_general (l_field_name)).item)
--							a_string.append_character ('%"')
--							a_string.append_character (':')
--							append_to_json_string (refl_obj.field (i), ctx, a_string)
--						end
--						i := i + 1
--					end
--				end

--				a_string.append_character ('}')
--			end
--		end

feature -- Status		

	is_recursively_expanded (obj: detachable ANY): BOOLEAN
		local
			lst: ARRAYED_LIST [ANY]
		do
			if obj = Void then
				Result := True
			else
				create lst.make (1)
				lst.compare_references
				lst.force (obj)
				Result := is_recursively_expanded_in_context (obj, lst)
			end
		end

	is_recursively_expanded_in_context (obj: ANY; ctx: LIST [ANY]): BOOLEAN
		local
			refl_obj: REFLECTED_REFERENCE_OBJECT
			i, l_field_count: INTEGER
			l_field_type: INTEGER
			l_field_ref: detachable ANY
		do
			Result := True
			create refl_obj.make (obj)
			l_field_count := refl_obj.field_count
			from
				i := 1
			until
				i > l_field_count or not Result
			loop
				l_field_type := refl_obj.field_type (i)
				if l_field_type = reference_type then
					l_field_ref := refl_obj.reference_field (i)
					if l_field_ref /= Void then
						if ctx.has (l_field_ref) then
							Result := False
						else
							ctx.force (l_field_ref)
						end
						Result := is_recursively_expanded_in_context (l_field_ref, ctx)
					end
				elseif l_field_type = expanded_type then
					if l_field_ref /= Void then
						l_field_ref := refl_obj.expanded_field (i)
						Result := is_recursively_expanded_in_context (l_field_ref, ctx)
					end
				end
				i := i + 1
			end
		end

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
