note
	description: "JSON Serialization based on reflection mechanism."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_REFLECTOR_SERIALIZER

inherit
	JSON_SERIALIZER
		redefine
			to_json
		end

	REFLECTOR

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
		local
			i: INTEGER
			l_fields_count: INTEGER
			l_type_name: READABLE_STRING_8
			refl_obj: REFLECTED_REFERENCE_OBJECT
			j_object: JSON_OBJECT
			j_array: JSON_ARRAY
			j_value: detachable JSON_VALUE
			fn: STRING_32
		do
			if obj = Void then
				create {JSON_NULL} Result
			elseif attached {READABLE_STRING_GENERAL} obj as str then
					-- Never reuse string value ... as reference.
					-- CHECK: or maybe for big string ?
				create {JSON_STRING} Result.make_from_string_general (str)
			elseif attached ctx.json_value_for_recorded_reference (obj) as j_ref then
				Result := j_ref
			else
				check
					is_accepted_object: ctx.is_accepted_object (obj)
				end

				if attached ctx.to_json (obj, Current) as j then
					Result := j
				else
					ctx.on_reference_object_start (obj) -- To declare this object is being processed.
					if attached {HASH_TABLE [detachable ANY, READABLE_STRING_GENERAL]} obj as tb then
						create j_object.make_with_capacity (tb.count)
						across
							tb as ic
						loop
							ctx.on_reference_field_start (ic.key)
							if not attached ic.item as l_item then
								create {JSON_NULL} j_value
							elseif attached ctx.to_json (l_item, Void) as j then
								j_value := j
							else
								j_value := to_json (l_item, ctx)
							end

							j_object.put (j_value, create {JSON_STRING}.make_from_string_general (ic.key))
							ctx.on_reference_field_end (ic.key)
						end
						Result := j_object
	--				elseif attached {ITERABLE [detachable ANY]} obj as arr then
	--						-- Is this a good idea?
	--						-- what about object exporting an ITERABLE interface, but containing other attributes
	--						-- unrelated to that iterable nature!
	--					create j_array.make_empty
	--					across
	--						arr as ic
	--					loop
	--						ctx.on_reference_field_start ((1 + j_array.count).out)
	--						if attached ctx.serializer (ic.item) as conv then
	--							j_value := conv.to_json (ic.item, ctx)
	--						else
	--							j_value := to_json (ic.item, ctx)
	--						end
	--						j_array.extend (j_value)
	--						ctx.on_reference_field_end (j_array.count.out)
	--					end
	--					Result := j_array
					else
						create refl_obj.make (obj)
						l_type_name := refl_obj.type_name

						if refl_obj.is_special then
							if attached {SPECIAL [detachable ANY]} obj as l_special then
								create j_array.make (l_special.count)
								Result := j_array
								i := 1
								across
									l_special as ic
								loop
									fn := i.out
									ctx.on_reference_field_start (fn)
									j_array.add (to_json (ic.item, ctx))
									ctx.on_reference_field_end (fn)
									i := i + 1
								end
							else
								create {JSON_NULL} Result
							end
						else
							l_fields_count := refl_obj.field_count

							if ctx.is_type_name_included then
								create j_object.make_with_capacity (1 + l_fields_count)
								j_object.put_string (l_type_name, "_type")
							else
								create j_object.make_with_capacity (l_fields_count)
							end
							if l_fields_count > 0 then
								from
									i := 1
								until
									i > l_fields_count
								loop
									if
										not refl_obj.is_field_transient (i) and then
										attached refl_obj.field_name (i) as l_field_name
									then
										j_object.put (field_to_json (refl_obj, i, l_field_name, ctx), l_field_name)
									end
									i := i + 1
								end
							end
							Result := j_object
						end
					end
					ctx.on_reference_object_end (Result, obj)
				end
			end
		end

	field_to_json (a_reflected_object: REFLECTED_REFERENCE_OBJECT; i: INTEGER; a_field_name: READABLE_STRING_8; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			l_field_value: detachable ANY
		do
			inspect a_reflected_object.field_type (i)
			when {REFLECTOR_CONSTANTS}.boolean_type then
				create {JSON_BOOLEAN} Result.make (a_reflected_object.boolean_field (i))

			when {REFLECTOR_CONSTANTS}.character_8_type then
				create {JSON_STRING} Result.make_from_string (create {STRING_8}.make_filled (a_reflected_object.character_8_field (i), 1))
			when {REFLECTOR_CONSTANTS}.character_32_type then
				create {JSON_STRING} Result.make_from_string_32 (create {STRING_32}.make_filled (a_reflected_object.character_32_field (i), 1))

			when {REFLECTOR_CONSTANTS}.natural_8_type then
				create {JSON_NUMBER} Result.make_natural (a_reflected_object.natural_8_field (i))
			when {REFLECTOR_CONSTANTS}.natural_16_type then
				create {JSON_NUMBER} Result.make_natural (a_reflected_object.natural_16_field (i))
			when {REFLECTOR_CONSTANTS}.natural_32_type then
				create {JSON_NUMBER} Result.make_natural (a_reflected_object.natural_32_field (i))
			when {REFLECTOR_CONSTANTS}.natural_64_type then
				create {JSON_NUMBER} Result.make_natural (a_reflected_object.natural_64_field (i))

			when {REFLECTOR_CONSTANTS}.integer_8_type then
				create {JSON_NUMBER} Result.make_integer (a_reflected_object.integer_8_field (i))
			when {REFLECTOR_CONSTANTS}.integer_16_type then
				create {JSON_NUMBER} Result.make_integer (a_reflected_object.integer_16_field (i))
			when {REFLECTOR_CONSTANTS}.integer_32_type then
				create {JSON_NUMBER} Result.make_integer (a_reflected_object.integer_32_field (i))
			when {REFLECTOR_CONSTANTS}.integer_64_type then
				create {JSON_NUMBER} Result.make_integer (a_reflected_object.integer_64_field (i))

			when {REFLECTOR_CONSTANTS}.real_32_type then
				create {JSON_NUMBER} Result.make_real (a_reflected_object.real_32_field (i))

			when {REFLECTOR_CONSTANTS}.real_64_type then
				create {JSON_NUMBER} Result.make_real (a_reflected_object.real_64_field (i))

			when {REFLECTOR_CONSTANTS}.pointer_type then
					-- Check!
				create {JSON_NUMBER} Result.make_integer (a_reflected_object.pointer_field (i).to_integer_32)

			when {REFLECTOR_CONSTANTS}.reference_type then
				l_field_value := a_reflected_object.reference_field (i)
				ctx.on_reference_field_start (a_field_name)
				Result := reference_to_json (l_field_value, ctx)
				ctx.on_reference_field_end (a_field_name)
			when {REFLECTOR_CONSTANTS}.expanded_type then
				if attached a_reflected_object.expanded_field (i) as exp_ref_object then
					ctx.on_reference_field_start (a_field_name)
						-- FIXME: check how to best handle expanded!
					Result := reference_to_json (exp_ref_object.object, ctx)
					ctx.on_reference_field_end (a_field_name)
				else
					check is_exoanded: False end
					create {JSON_NULL} Result
				end
			else
				check known_field_type: False end
				Result := to_json (a_reflected_object.field (i), ctx)
			end
		end

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
