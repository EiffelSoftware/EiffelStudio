note
	description: "JSON Serialization based on reflection mechanism."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_REFLECTOR_SERIALIZER

inherit
	JSON_CORE_SERIALIZER
		redefine
			reference_to_json
		end

	JSON_TYPE_UTILITIES

feature {NONE} -- Implementation		

	reference_to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			i: INTEGER
			l_fields_count: INTEGER
			l_type_name: READABLE_STRING_8
			refl_obj: REFLECTED_REFERENCE_OBJECT
			j_object: JSON_OBJECT
			j_array: JSON_ARRAY
			fn: STRING_32
		do
			Result := Precursor (obj, ctx)
			if Result.is_null and obj /= Void then
				check
					is_accepted_object: ctx.is_accepted_object (obj)
				end
				if attached ctx.to_json (obj, Current) as j then
					Result := j
				else
					create refl_obj.make (obj)
					ctx.on_object_serialization_start (obj) -- To declare this object is being processed.
					if refl_obj.is_special and then attached {SPECIAL [detachable ANY]} obj as l_special then
							-- Handle SPECIAL classes
						create j_array.make (l_special.count)
						Result := j_array
						i := 1
						across
							l_special as ic
						loop
							fn := i.out
							ctx.on_field_start (fn)
							j_array.add (to_json (ic.item, ctx))
							ctx.on_field_end (fn)
							i := i + 1
						end
					else
							-- Eiffel object.
						l_type_name := refl_obj.type_name

						l_fields_count := refl_obj.field_count

						if ctx.is_type_name_included then
							create j_object.make_with_capacity (1 + l_fields_count)
							j_object.put_string (l_type_name, ctx.type_field_name)
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
					ctx.on_object_serialization_end (Result, obj)
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
				ctx.on_field_start (a_field_name)
				Result := reference_to_json (l_field_value, ctx)
				ctx.on_field_end (a_field_name)
			when {REFLECTOR_CONSTANTS}.expanded_type then
				if attached a_reflected_object.expanded_field (i) as exp_ref_object then
					ctx.on_field_start (a_field_name)
						-- FIXME: check how to best handle expanded!
					Result := reference_to_json (exp_ref_object.object, ctx)
					ctx.on_field_end (a_field_name)
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
	copyright: "2010-2024, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
