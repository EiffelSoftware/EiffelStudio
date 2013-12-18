note
	description: "A default handler for any kind of object except SPECIAL and TUPLE."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_DEFAULT_OBJECT_HANDLER

inherit

	PS_OBJECT_HANDLER

	REFLECTOR_CONSTANTS
		undefine
			default_create
		end

create
	make, default_create

feature {NONE} -- Implementation

	internal_can_handle_type (type: PS_TYPE_METADATA): BOOLEAN
			-- Can `Current' handle objects of type `type'?
		do
			Result := not attached {TYPE [detachable SPECIAL [detachable ANY]]} type.type and not attached {TYPE [detachable TUPLE]} type.type
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_mapping_to_value_type: BOOLEAN = False
			-- Does `Current' map objects to a value type (i.e. STRING)?


feature {PS_ABEL_EXPORT} -- Read functions

	initialize (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- Try to initialize the `object' as much as possible.
			-- For any referenced object not yet loaded, tell the `read_manager'
			-- to retrieve it in the next iteration.
		local
			reflector: REFLECTED_OBJECT

			retrieved: PS_BACKEND_OBJECT
			field_type: INTEGER
			field_name: STRING
			i: INTEGER
			field_count: INTEGER

			pos: INTEGER

			field: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]
			dynamic_field_type: PS_TYPE_METADATA
			managed: MANAGED_POINTER

			dynamic_type: INTEGER
		do
			reflector := object.reflector
			retrieved := object.backend_object

			from
				i := 1
				field_count := retrieved.metadata.attribute_count
			until
				i > field_count
			loop
				field_type := retrieved.metadata.builtin_type [i]
				field_name := retrieved.metadata.attributes [i]

				if attached retrieved.value_lookup (field_name) as f then
					field := f

					inspect
						field_type

						-- Integers
					when integer_8_type then
						reflector.set_integer_8_field (i, field.value.to_integer_8)
					when integer_16_type then
						reflector.set_integer_16_field (i, field.value.to_integer_16)
					when integer_32_type then
						reflector.set_integer_32_field (i, field.value.to_integer_32)
					when integer_64_type then
						reflector.set_integer_64_field (i, field.value.to_integer_64)

						-- Naturals
					when natural_8_type then
						reflector.set_natural_8_field (i, field.value.to_natural_8)
					when natural_16_type then
						reflector.set_natural_16_field (i, field.value.to_natural_16)
					when natural_32_type then
						reflector.set_natural_32_field (i, field.value.to_natural_32)
					when natural_64_type then
						reflector.set_natural_64_field (i, field.value.to_natural_64)

						-- Reals
					when real_32_type then
						create managed.make ({PLATFORM}.real_32_bytes)
						managed.put_integer_32_be (field.value.to_integer_32, 0)
						reflector.set_real_32_field (i, managed.read_real_32_be (0))
					when real_64_type then
						create managed.make ({PLATFORM}.real_64_bytes)
						managed.put_integer_64_be (field.value.to_integer_64, 0)
						reflector.set_real_64_field (i, managed.read_real_64_be (0))

						-- Characters
					when character_8_type then
						reflector.set_character_8_field (i, field.value.to_natural_8.to_character_8)
					when character_32_type then
						reflector.set_character_32_field (i, field.value.to_natural_32.to_character_32)

						-- Booleans
					when boolean_type then
						reflector.set_boolean_field (i, field.value.to_boolean)

						-- None, Pointer, Expanded and References
					when none_type then
							-- Do nothing

					when pointer_type then
						fixme ("Should we give the user some warning?")
						reflector.set_pointer_field (i, default_pointer)

					when expanded_type then

						check value_is_primary_key: field.value.is_integer end
						dynamic_field_type := read_manager.metadata_factory.create_metadata_from_string (field.type)
						read_manager.process_next (field.value.to_integer, dynamic_field_type, object)

					when reference_type then

						dynamic_field_type := read_manager.metadata_factory.create_metadata_from_string (field.type)

						if not dynamic_field_type.is_none then

							if attached read_manager.try_build_attribute (field.value, dynamic_field_type, object) as val then
								reflector.set_reference_field (i, val)
							end
						end

					else
						check unknown_basic_type: False end
					end
				end
				i := i + 1
			variant
				reflector.field_count + 1 - i
			end
		end

	finish_initialize (object: PS_OBJECT_READ_DATA; read_manager: PS_READ_MANAGER)
			-- Finish initialization of `object'.
		local
			index: INTEGER
			reflector: REFLECTED_OBJECT
			field_type: PS_TYPE_METADATA

			ref_item: INTEGER

			retrieved: PS_BACKEND_OBJECT
			i: INTEGER
			count: INTEGER
		do
			index := object.index

			reflector := object.reflector
			retrieved := object.backend_object

			from
				i := 1
				count := object.type.attribute_count
			until
				i > count

			loop
				inspect
					object.type.builtin_type [i]

				when expanded_type then
					if attached retrieved.value_lookup (retrieved.metadata.attributes [i]) as field then
						field_type := read_manager.metadata_factory.create_metadata_from_string (field.type)
						ref_item := read_manager.cache_lookup (field.value.to_integer, field_type)
						read_manager.item (ref_item).set_object (reflector.expanded_field (i))
					end

				when reference_type then
					if reflector.reference_field (i) = Void and then attached retrieved.value_lookup (retrieved.metadata.attributes [i]) as field then
						if not field.value.is_empty then

							field_type := read_manager.metadata_factory.create_metadata_from_string (field.type)
								-- This check is safe because of {PS_BACKEND_OBJECT}.is_consistent
							check not_none: not field_type.is_none end

							reflector.set_reference_field (i, read_manager.build_attribute (field.value.to_integer, field_type, object))

							if reflector.is_copy_semantics_field (i) then
									-- Update the reflector of the referenced item.
								ref_item := read_manager.cache_lookup (field.value.to_integer, field_type)
								read_manager.item (ref_item).set_object (reflector.copy_semantics_field (i))
							end
						end
					end
				else
					-- Do nothing
				end
				i := i + 1
			variant
				count - i + 1
			end
		end

feature {PS_ABEL_EXPORT} -- Write functions

	initialize_backend_representation (object: PS_OBJECT_WRITE_DATA)
			-- Initialize all attributes or items in `object.backend_representation'
		local
			i, k: INTEGER
			tuple: TUPLE [value: STRING; type: IMMUTABLE_STRING_8]

			backend_object: PS_BACKEND_OBJECT
			field_type: PS_TYPE_METADATA

			det_field: detachable ANY

			found: BOOLEAN
			is_expanded: BOOLEAN
			ref_item: PS_OBJECT_DATA
			field_count: INTEGER

			reflector: REFLECTED_OBJECT
			static_field_type: INTEGER
			attribute_name: STRING

			managed: MANAGED_POINTER
			real: REAL_32
			double: REAL_64

			expanded_reflector: REFLECTED_OBJECT
		do
			backend_object := object.backend_object
			field_count := object.type.attribute_count
			reflector := object.reflector

			from
				i := 1
			until
				i > field_count
			loop
				static_field_type := object.type.builtin_type [i]
				attribute_name := object.type.attributes [i]
				inspect
					static_field_type

					-- Integers
				when integer_8_type then
					backend_object.add_attribute (attribute_name, reflector.integer_8_field (i).out, basic_type_names [static_field_type])
				when integer_16_type then
					backend_object.add_attribute (attribute_name, reflector.integer_16_field (i).out, basic_type_names [static_field_type])
				when integer_32_type then
					backend_object.add_attribute (attribute_name, reflector.integer_32_field (i).out, basic_type_names [static_field_type])
				when integer_64_type then
					backend_object.add_attribute (attribute_name, reflector.integer_64_field (i).out, basic_type_names [static_field_type])

					-- Naturals
				when natural_8_type then
					backend_object.add_attribute (attribute_name, reflector.natural_8_field (i).out, basic_type_names [static_field_type])
				when natural_16_type then
					backend_object.add_attribute (attribute_name, reflector.natural_16_field (i).out, basic_type_names [static_field_type])
				when natural_32_type then
					backend_object.add_attribute (attribute_name, reflector.natural_32_field (i).out, basic_type_names [static_field_type])
				when natural_64_type then
					backend_object.add_attribute (attribute_name, reflector.natural_64_field (i).out, basic_type_names [static_field_type])

					-- Reals
				when real_32_type then
					real := reflector.real_32_field (i)
					create managed.make ({PLATFORM}.real_32_bytes)
					managed.put_real_32_be (real, 0)
					backend_object.add_attribute (attribute_name, managed.read_integer_32_be (0).out, basic_type_names [static_field_type])

				when real_64_type then
					double := reflector.real_64_field (i)
					create managed.make ({PLATFORM}.real_64_bytes)
					managed.put_real_64_be (double, 0)
					backend_object.add_attribute (attribute_name, managed.read_integer_64_be (0).out, basic_type_names [static_field_type])

					-- Characters
				when character_8_type then
					fixme ("natural_32_code ?")
					backend_object.add_attribute (attribute_name, reflector.character_8_field (i).natural_32_code.out, basic_type_names [static_field_type])
				when character_32_type then
					backend_object.add_attribute (attribute_name, reflector.character_32_field (i).natural_32_code.out, basic_type_names [static_field_type])

					-- Booleans
				when boolean_type then
					backend_object.add_attribute (attribute_name, reflector.boolean_field (i).out, basic_type_names [static_field_type])

					-- None, Pointer, Expanded and References
				when none_type then
						-- Do nothing

				when pointer_type then
					fixme ("Should we give the user some warning?")
					backend_object.add_attribute (attribute_name, default_pointer.out, basic_type_names [static_field_type])

				when expanded_type then
					expanded_reflector := object.reflector.expanded_field (i)

					from
						k := 0
						found := False
					until
						k >= object.references.count or found
					loop
						k := k + 1
						found :=  write_manager.item (object.references [k]).reflector ~ expanded_reflector
					end

					check reference_found: k <= object.references.count end

					ref_item := write_manager.item (object.references [k])
					tuple := ref_item.handler.as_string_pair (ref_item)
					backend_object.add_attribute (object.type.attributes [i], tuple.value, tuple.type)

				when reference_type then

					if attached object.reflector.field (i) as field then

						if basic_expanded_types.has (field.generating_type.type_id) then
								-- Basic type, disguised in a copy-semantics object.
							field_type := write_manager.metadata_factory.create_metadata_from_object (field)
							backend_object.add_attribute (object.type.attributes [i], basic_attribute_value (field), field_type.name)
						else
								-- Reference type
							from
								k := 0
								found := False
							until
								k >= object.references.count or found
							loop
								k := k + 1
								found :=  write_manager.item (object.references [k]).reflector.object = field
							end

							check reference_found: k <= object.references.count end
							ref_item := write_manager.item (object.references [k])
							tuple := ref_item.handler.as_string_pair (ref_item)
							backend_object.add_attribute (object.type.attributes [i], tuple.value, tuple.type)
						end
					else
							-- Void reference
						backend_object.add_attribute (object.type.attributes [i], "", create {IMMUTABLE_STRING_8}.make_from_string ("NONE"))
					end
				else
					check unknown_static_type: False end
				end
				i := i + 1
			end

		end

end
